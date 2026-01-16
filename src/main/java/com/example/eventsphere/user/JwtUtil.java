package com.example.eventsphere.user;


import com.example.eventsphere.enums.UserRole;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class JwtUtil {

    private static final String SECRET_KEY="my-super-secret-key-for-jwt-signing-256bit!";
    private static final long EXPIRATION_TIME=36000000;
    private static final byte[] KEY=Keys.hmacShaKeyFor(SECRET_KEY.getBytes()).getEncoded();
    public static String generateToken(String email, UserRole role)
    {
        return Jwts.builder().setSubject(email).claim("role",role.name()).setIssuedAt(new Date()).setExpiration(new Date(System.currentTimeMillis()+EXPIRATION_TIME)).signWith(Keys.hmacShaKeyFor(SECRET_KEY.getBytes()),SignatureAlgorithm.HS256).compact();
    }


    public static String  extractUsername(String token){

        return Jwts.parserBuilder().setSigningKey(KEY).build().parseClaimsJws(token).getBody().getSubject();   }
}
