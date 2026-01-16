package com.example.eventsphere.user;

import com.example.eventsphere.enums.UserRole;
import io.jsonwebtoken.Jwt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/auth")
public class UserAuthController {


    @Autowired
    private UserRepo repo;

    @Autowired
    private  AuthenticationManager authenticationManager;

    @Autowired
    private  CustomUserDetailsService userDetailsService;
    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;




    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequest request)
    {
        if(repo.existsByEmail(request.getEmail())){
            return ResponseEntity.badRequest().body("Email already exists");
        }


        UserEntity user=new UserEntity();
        user.setEmail(request.getEmail());
        user.setName(request.getName());
        user.setRoles(
                request.getRole() != null
                        ? request.getRole()
                        : UserRole.ATTENDEE
        );
        user.setPassword(passwordEncoder.encode(request.getPassword()));


        repo.save(user);

        return ResponseEntity.ok("user created successfully");
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {

        UserEntity user = repo.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        String token = jwtUtil.generateToken(user.getEmail(), user.getRoles());
        return ResponseEntity.ok(token);
    }



    @GetMapping("/getprofileinfo")
    public ResponseEntity<?> getProfileBio(@AuthenticationPrincipal UserDetails userDetails){

        UserEntity user=repo.findByEmail(userDetails.getUsername()).orElseThrow(()->{
            return new IllegalArgumentException("user not found");
        });
        return ResponseEntity.ok(Map.of(
                "name",user.getName(),
                "email",user.getEmail()
        ));
    }


    @PutMapping("/updateprofile")
    public ResponseEntity<?> UpdateProfileBio(@RequestBody ProfileUpdateBio bio,@AuthenticationPrincipal UserDetails userdetails)
    {
        UserEntity user= repo.findByEmail(userdetails.getUsername()).orElseThrow(()->{
            return new IllegalArgumentException("No User Found");
        });
        user.setEmail(bio.getEmail());
        user.setName(bio.getName());
        repo.save(user);
        return ResponseEntity.ok("Updated");
    }

    @GetMapping("/exists")
    public ResponseEntity<?> checkifExists(@RequestParam String email)
    {
        boolean exists=repo.existsByEmail(email);

        return ResponseEntity.ok(exists);
    }

}
