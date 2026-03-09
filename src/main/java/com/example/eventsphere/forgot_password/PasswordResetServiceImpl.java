//package com.example.eventsphere.forgot_password;
//
//
//import com.example.eventsphere.user.UserEntity;
//import com.example.eventsphere.user.UserRepo;
//import lombok.RequiredArgsConstructor;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.stereotype.Service;
//
//import java.util.UUID;
//
//@Service
//@RequiredArgsConstructor
//public class PasswordResetServiceImpl implements  PasswordResetService
//{
//
//    private final UserRepo userRepository;
//    private final PasswordResetRepo tokenRepo;
//    private final PasswordEncoder passwordEncoder;
//
//    private static final long expiry_minute=15;
//
//
//    @Override
//    public void createResetToken(String email) {
//
//        UserEntity user=userRepository.findByEmail(email).orElseThrow(()->
//                new RuntimeException("User not found"));
//
//        tokenRepo.deleteByUser_UserId(user.getUserId());
//
//
//        String token= UUID.randomUUID().toString();
//
//
//
//    }
//
//    @Override
//    public void resetPassword(String token, String newpassword) {
//
//    }
//}