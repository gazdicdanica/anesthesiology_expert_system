package com.ftn.sbnz.service;

import com.ftn.sbnz.config.JwtUtil;
import com.ftn.sbnz.dto.LoginDTO;
import com.ftn.sbnz.dto.RegisterDTO;
import com.ftn.sbnz.exception.BadRequestException;
import com.ftn.sbnz.model.user.User;
import com.ftn.sbnz.repository.UserRepository;

import java.util.Optional;

import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

	private static Logger log = LoggerFactory.getLogger(UserService.class);

	private final KieContainer kieContainer;
	private final UserRepository userRepository;
	private final AuthenticationManager authenticationManager;
	private final PasswordEncoder passwordEncoder;

	@Autowired
	public UserService(KieContainer kieContainer, UserRepository userRepository,
			AuthenticationManager authenticationManager, PasswordEncoder passwordEncoder) {
		log.info("Initialising a new example session.");
		this.kieContainer = kieContainer;
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
	
		String jwt = JwtUtil.generateToken(user.getUsername());

		return jwt;
	}

	@Override
	public Optional<User> findByUsername(String username) {
		return userRepository.findByUsername(username);
	}
}
