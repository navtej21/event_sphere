//package com.example.eventsphere.forgot_password;
//
//
//import com.example.eventsphere.user.UserEntity;
//import jakarta.persistence.*;
//import lombok.AllArgsConstructor;
//import lombok.Builder;
//import lombok.Data;
//import lombok.NoArgsConstructor;
//
//import java.time.LocalDate;
//
//@Entity
//@Table(name="token_table")
//@Data
//@NoArgsConstructor
//@AllArgsConstructor
//@Builder
//public class PasswordResetTokenEntity {
//
//    @Id
//    @GeneratedValue(strategy= GenerationType.AUTO)
//    private Long tokenid;
//    @Column
//    private String token;
//    @Column(nullable = false)
//    private LocalDate expiryDate;
//    @ManyToOne
//    @JoinColumn(name = "user_id")
//    private UserEntity user;
//}
