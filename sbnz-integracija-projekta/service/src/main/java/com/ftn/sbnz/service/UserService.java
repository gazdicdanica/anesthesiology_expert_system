package com.ftn.sbnz.service;

import com.ftn.sbnz.config.JwtUtil;
import com.ftn.sbnz.dto.LoginDTO;
import com.ftn.sbnz.dto.RegisterDTO;
import com.ftn.sbnz.exception.BadRequestException;
import com.ftn.sbnz.exception.EntityNotFoundException;
import com.ftn.sbnz.model.user.User;
import com.ftn.sbnz.repository.UserRepository;

import java.security.Principal;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.ftn.sbnz.service.iservice.IUserService;

@Service
public class UserService implements IUserService {

	private final UserRepository userRepository;
	private final AuthenticationManager authenticationManager;
	private final PasswordEncoder passwordEncoder;

	@Autowired
	public UserService(UserRepository userRepository,
			AuthenticationManager authenticationManager, PasswordEncoder passwordEncoder) {
		this.userRepository = userRepository;
		this.authenticationManager = authenticationManager;
		this.passwordEncoder = passwordEncoder;
	}

	@Override
	public void register(RegisterDTO registerDTO) {
		if (userRepository.findByEmail(registerDTO.getEmail()).isPresent()) {
			throw new BadRequestException("Email adresa je povezana sa postojećim nalogom.");
		}
		User user = new User();
		user.setEmail(registerDTO.getEmail());
		user.setUsername(registerDTO.getEmail());
		user.setPassword(passwordEncoder.encode(registerDTO.getPassword()));
		user.setFullname(registerDTO.getFullname());
		user.setRole(registerDTO.getRole());
		user.setLicenseNumber(registerDTO.getLicenseNumber());
		this.userRepository.save(user);
	}

	@Override
	public String login(LoginDTO loginDTO) {
		User user = userRepository.findByEmail(loginDTO.getEmail())
				.orElseThrow(() -> new BadRequestException("Pogrešna email adresa ili lozinka."));
		try{
			Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
				loginDTO.getEmail(), loginDTO.getPassword()));
			SecurityContextHolder.getContext().setAuthentication(authentication);
		}catch(AuthenticationException e){
			throw new BadRequestException("Pogrešna email adresa ili lozinka.");
		}
	
		String jwt = JwtUtil.generateToken(user.getUsername(), user.getRole());

		return jwt;
	}

	@Override
	public Optional<User> findByUsername(String username) {
		return userRepository.findByUsername(username);
	}

	@Override
	public User get(String username) {
		return userRepository.findByUsername(username).orElseThrow(() -> new EntityNotFoundException("Korisnik nije pronađen."));
	}

	@Override
	public User updateFullname(String fullname, Principal u) {
		User user = userRepository.findByUsername(u.getName()).orElseThrow(() -> new EntityNotFoundException("Korisnik nije pronađen."));
		user.setFullname(fullname);
		return userRepository.save(user);
	}

	@Override
	public User updateLicenseNumber(String licenseNumber, Principal u) {
		User user = userRepository.findByUsername(u.getName()).orElseThrow(() -> new EntityNotFoundException("Korisnik nije pronađen."));
		user.setLicenseNumber(licenseNumber);
		return userRepository.save(user);
	}

	@Override
	public User updatePassword(String oldPassword, String newPassword, Principal u) {
		User user = userRepository.findByUsername(u.getName()).orElseThrow(() -> new EntityNotFoundException("Korisnik nije pronađen."));
		if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
			throw new BadRequestException("Lozinka je netačna.");
		}
		user.setPassword(passwordEncoder.encode(newPassword));
		return userRepository.save(user);
	}

	@Override 
	public List<User> getStaff(Principal u) {
		User user = userRepository.findByUsername(u.getName()).orElseThrow(() -> new EntityNotFoundException("Korisnik nije pronađen."));
		if (user.getRole() == User.Role.DOCTOR){
			return userRepository.findByRole(User.Role.NURSE);
		}
		return userRepository.findByRole(User.Role.DOCTOR);
	}

	@Override
	public Optional<User> findById(Long id) {
		return userRepository.findById(id);
	}
}
