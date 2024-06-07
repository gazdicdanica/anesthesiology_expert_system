package com.ftn.sbnz.controller;

import java.security.Principal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ftn.sbnz.dto.LoginDTO;
import com.ftn.sbnz.dto.PasswordDTO;
import com.ftn.sbnz.dto.RegisterDTO;
import com.ftn.sbnz.service.UserService;
import com.ftn.sbnz.service.iservice.IUserService;

@RestController
@RequestMapping(value = "/api/user", produces = MediaType.APPLICATION_JSON_VALUE)
public class UserController {
	private static Logger log = LoggerFactory.getLogger(UserController.class);

	private final IUserService userService;

    @Autowired public SimpMessagingTemplate simpMessagingTemplate;
	@Autowired
	public UserController(UserService sampleService) {
		this.userService = sampleService;
	}

	@PostMapping("/register")
	public ResponseEntity<?> register(@RequestBody RegisterDTO registerDTO){
		log.info("Registering user");
		userService.register(registerDTO);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@PostMapping("/login")
	public ResponseEntity<?> login(@RequestBody LoginDTO loginDTO){
		log.info("Logging in user");
        simpMessagingTemplate.convertAndSend("/heartbeat", "Heartbeat");
		return new ResponseEntity<>(userService.login(loginDTO), HttpStatus.OK);
	}

	@GetMapping
	public ResponseEntity<?> get(Principal u){
		return new ResponseEntity<>(userService.get(u.getName()), HttpStatus.OK);
	}

	@PutMapping("/update/fullname")
	public ResponseEntity<?> updateName(@RequestBody String name, Principal u){
		return new ResponseEntity<>(userService.updateFullname(name, u), HttpStatus.OK);
	}


	@PutMapping("/update/license")
	public ResponseEntity<?> updateLicense(@RequestBody String licenseNumber, Principal u){
		return new ResponseEntity<>(userService.updateLicenseNumber(licenseNumber, u), HttpStatus.OK);
	}

	@PutMapping("/update/password")
	public ResponseEntity<?> updatePassword(@RequestBody PasswordDTO passwordDTO, Principal u){
		return new ResponseEntity<>(userService.updatePassword(passwordDTO.getOldPassword(), passwordDTO.getNewPassword(), u), HttpStatus.OK);
	}

}
