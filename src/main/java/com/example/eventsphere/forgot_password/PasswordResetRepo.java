//package com.example.eventsphere.forgot_password;
//
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;
//
//import java.util.Optional;
//
//
//@Repository
//public interface PasswordResetRepo extends JpaRepository<PasswordResetTokenEntity,Long> {
//
//
//    Optional<PasswordResetTokenEntity> findbyToken(String token);
//
//    void deleteByUser_UserId(Long userId);
//
//}
