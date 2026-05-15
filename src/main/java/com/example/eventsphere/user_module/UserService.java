package com.example.eventsphere.user_module;

import com.example.eventsphere.enums.UserRole;
import com.example.eventsphere.exception_folder.BadCredentialsException;
import com.example.eventsphere.exception_folder.DuplicateResourceException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepo userRepo;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;


    public void register(RegisterRequest registerRequest) {

        if (userRepo.existsByEmail(registerRequest.getEmail())) {
            throw new DuplicateResourceException("User Already Exists");
        }

        UserEntity user = UserEntity.builder()
                .email(registerRequest.getEmail())
                .name(registerRequest.getName())
                .password(passwordEncoder.encode(registerRequest.getPassword()))
                .roles(UserRole.ATTENDEE) // role is always ATTENDEE on public registration
                .build();

        userRepo.save(user);
    }


    public String login(LoginRequest request) {

        UserEntity user = userRepo.findByEmail(request.getEmail())
                .orElseThrow(() -> new UsernameNotFoundException("No User Found"));

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new BadCredentialsException("Password Not Matching");
        }

        return jwtUtil.generateToken(request.getEmail(), user.getRoles());
    }


    public UserProfileResponse getProfileBio(UserDetails userDetails) {

        UserEntity user = userRepo.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new UsernameNotFoundException("No User Found"));

        return toProfileResponse(user);
    }


    public UserProfileResponse updateProfileBio(ProfileUpdateBio bio, UserDetails userDetails) {

        UserEntity user = userRepo.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new UsernameNotFoundException("No User Found"));

        user.setName(bio.getName());
        UserEntity saved = userRepo.save(user);

        return toProfileResponse(saved);
    }


    public boolean checkIfExists(String email) {
        return userRepo.existsByEmail(email);
    }


    // ── private helpers ──────────────────────────────────────────────────────

    private UserProfileResponse toProfileResponse(UserEntity user) {
        return UserProfileResponse.builder()
                .userId(user.getUserId())
                .name(user.getName())
                .email(user.getEmail())
                .role(user.getRoles())
                .profileImage(user.getProfileImage())
                .createdAt(user.getCreatedAt())
                .build();
    }
}
