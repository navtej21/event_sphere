package com.example.eventsphere;

import com.example.eventsphere.user.LoginRequest;
import com.example.eventsphere.user.RegisterRequest;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.boot.test.context.SpringBootTest;

import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class UserAuthControllerTest {

	@Autowired
	private MockMvc mockMvc;

	private final ObjectMapper objectMapper = new ObjectMapper();


	@Test
	void testRegisterUser() throws Exception {

		RegisterRequest request = new RegisterRequest();
		request.setEmail("testuser@gmail.com");
		request.setName("Navtej");
		request.setPassword("password123");

		mockMvc.perform(post("/auth/register")
						.contentType(MediaType.APPLICATION_JSON)
						.content(objectMapper.writeValueAsString(request)))
				.andExpect(status().isOk());
	}


	@Test
	void testLoginUser() throws Exception {

		LoginRequest request = new LoginRequest();
		request.setEmail("testuser@gmail.com");
		request.setPassword("password123");

		mockMvc.perform(post("/auth/login")
						.contentType(MediaType.APPLICATION_JSON)
						.content(objectMapper.writeValueAsString(request)))
				.andExpect(status().isOk());
	}


	@Test
	void testEmailExists() throws Exception {

		mockMvc.perform(get("/auth/exists")
						.param("email", "testuser@gmail.com"))
				.andExpect(status().isOk());
	}

}