package com.example.eventsphere.user_module;

import com.example.eventsphere.enums.UserRole;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;

@Component
public class JwtUtil {

    private static final Logger logger = LoggerFactory.getLogger(JwtUtil.class);

    @Value("${jwt.secret}")
    private String SECRET_KEY;

    private final long EXPIRATION_TIME = 36000000;

    private SecretKey getSigningKey() {
        return Keys.hmacShaKeyFor(SECRET_KEY.getBytes());
    }


    // GENERATE TOKEN
    public String generateToken(String email, UserRole role) {
        return Jwts.builder()
                .setSubject(email)
                .claim("role", role.name())
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }


    // EXTRACT ALL CLAIMS
    private Claims extractAllClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }


    // EXTRACT USERNAME
    public String extractUsername(String token) {
        return extractAllClaims(token).getSubject();
    }


    // EXTRACT ROLE
    public String extractRole(String token) {
        return extractAllClaims(token).get("role", String.class);
    }


    // EXTRACT EXPIRATION
    public Date extractExpiration(String token) {
        return extractAllClaims(token).getExpiration();
    }


    // CHECK IF TOKEN EXPIRED
    public boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }


    // VALIDATE TOKEN
    public boolean validateToken(String token, String email) {
        try {
            final String extractedEmail = extractUsername(token);
            return extractedEmail.equals(email) && !isTokenExpired(token);
        } catch (ExpiredJwtException e) {
            logger.warn("JWT token is expired: {}", e.getMessage());
        } catch (Exception e) {
            logger.warn("Invalid JWT token: {}", e.getMessage());
        }
        return false;
    }
}
