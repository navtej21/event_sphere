package com.example.eventsphere.user_module;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class UserAuthController {

    private final UserService userService;
    private final AuthenticationManager authenticationManager;
    private final CustomUserDetailsService userDetailsService;



    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequest request)
    {
        userService.register(request);
        return ResponseEntity.ok("user created successfully");
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {

        String token = userService.login(request);
        return ResponseEntity.ok(token);
    }



    @GetMapping("/getprofileinfo")
    public ResponseEntity<?> getProfileBio(@AuthenticationPrincipal UserDetails userDetails){

        UserEntity user= userService.getProfileBio(userDetails);
        return ResponseEntity.ok(Map.of(
                "name",user.getName(),
                "email",user.getEmail()
        ));
    }


    @PutMapping("/updateprofile")
    public ResponseEntity<?> UpdateProfileBio(@RequestBody ProfileUpdateBio bio,@AuthenticationPrincipal UserDetails userdetails)
    {

        UserEntity user=userService.updateProfileBio(bio,userdetails);
        return ResponseEntity.ok("Updated");
    }

    @GetMapping("/exists")
    public ResponseEntity<?> checkIfExists(@RequestParam String email)
    {
        boolean exists= userService.checkIfExists(email);
        return ResponseEntity.ok(exists);
    }

}
