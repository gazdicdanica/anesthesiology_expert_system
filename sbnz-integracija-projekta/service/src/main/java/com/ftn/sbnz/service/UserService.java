package com.ftn.sbnz.service;

import com.ftn.sbnz.exception.BadRequestException;
import com.ftn.sbnz.model.dto.RegisterDTO;
import com.ftn.sbnz.model.user.User;
import com.ftn.sbnz.repository.UserRepository;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ftn.sbnz.service.iservice.IUserService;

@Service
public class UserService implements IUserService{

	private static Logger log = LoggerFactory.getLogger(UserService.class);

	private final KieContainer kieContainer;
	private final UserRepository userRepository;

	@Autowired
	public UserService(KieContainer kieContainer, UserRepository userRepository) {
		log.info("Initialising a new example session.");
		this.kieContainer = kieContainer;
		this.userRepository = userRepository;
	}

	@Override
	public void register(RegisterDTO registerDTO) {
		if(userRepository.findByEmail(registerDTO.getEmail()).isPresent()){
			throw new BadRequestException("Email adresa je povezana sa postojećim nalogom.");
		}
		User user = new User();
		user.setEmail(registerDTO.getEmail());
		user.setPassword(registerDTO.getPassword());
		user.setFullname(registerDTO.getFullname());
		user.setRole(registerDTO.getRole());
		this.userRepository.save(user);
	}
}
