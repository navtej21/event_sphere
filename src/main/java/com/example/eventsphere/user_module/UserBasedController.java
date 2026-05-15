package com.example.eventsphere.user_module;

import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.Map;


@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
public class UserBasedController {

    private final UserService userService;
    @GetMapping("/me")
    public ResponseEntity<?> getProfileBio(@AuthenticationPrincipal UserDetails userDetails){

        UserProfileResponse user= userService.getProfileBio(userDetails);
        return ResponseEntity.ok(Map.of(
                "name",user.getName(),
                "email",user.getEmail()
        ));
    }


    @PutMapping("/me")
    public ResponseEntity<?> UpdateProfileBio(@NotNull  @RequestBody ProfileUpdateBio bio, @AuthenticationPrincipal UserDetails userdetails)
    {

        UserProfileResponse user=userService.updateProfileBio(bio,userdetails);
        return ResponseEntity.ok("Updated");
    }

    @GetMapping("/exists")
    public ResponseEntity<?> checkIfExists(@RequestParam String email)
    {
        boolean exists= userService.checkIfExists(email);
        return ResponseEntity.ok(exists);
    }
}
