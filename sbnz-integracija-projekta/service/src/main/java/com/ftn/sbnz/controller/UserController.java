package com.ftn.sbnz.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ftn.sbnz.model.dto.RegisterDTO;
import com.ftn.sbnz.service.UserService;
import com.ftn.sbnz.service.iservice.IUserService;

@RestController
@RequestMapping(value = "/api/user", produces = MediaType.APPLICATION_JSON_VALUE)
public class UserController {
	private static Logger log = LoggerFactory.getLogger(UserController.class);

	private final IUserService userService;

	@Autowired
	public UserController(UserService sampleService) {
		this.userService = sampleService;
	}

	@PostMapping("/register")
	public ResponseEntity<?> register(@RequestBody RegisterDTO registerDTO){
		log.info("Registering user");
		userService.register(registerDTO);
		System.out.println(registerDTO);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@PostMapping("/login")
	public ResponseEntity<?> login(){
		log.info("Logging in user");
		return new ResponseEntity<>(HttpStatus.OK);
	}


}
