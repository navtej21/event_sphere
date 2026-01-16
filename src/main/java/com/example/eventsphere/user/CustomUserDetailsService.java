package com.example.eventsphere.user;

import org.springframework.boot.web.server.servlet.context.ServletComponentScan;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;


@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepo repo;

    public CustomUserDetailsService(UserRepo repo)
    {
        this.repo=repo;
    }


    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        UserEntity user=repo.findByEmail(email).orElseThrow(()->{
            return new UsernameNotFoundException("User not found");
        });

        return new CustomUserDetails(user);
    }
}
