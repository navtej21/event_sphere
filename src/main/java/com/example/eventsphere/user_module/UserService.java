package com.example.eventsphere.user_module;


import com.example.eventsphere.enums.UserRole;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepo userRepo;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;


    public void register(RegisterRequest registerRequest){

        if(userRepo.existsByEmail(registerRequest.getEmail())){
            throw new IllegalArgumentException("User Already Exists");
        }


        UserEntity user=new UserEntity();
        user.setEmail(registerRequest.getEmail());
        user.setName(registerRequest.getName());
        user.setRoles(registerRequest.getRole()!=null?registerRequest.getRole(): UserRole.ATTENDEE);
        user.setPassword(passwordEncoder.encode(registerRequest.getPassword()));
        userRepo.save(user);
    }



    public String login(LoginRequest request){

        UserEntity user=userRepo.findByEmail(request.getEmail()).orElseThrow(()->{
            throw  new IllegalArgumentException("No User Found");
        });

        if(!passwordEncoder.matches(request.getPassword(), user.getPassword())){
            throw new IllegalArgumentException("Password Not Matching");
        }

        return jwtUtil.generateToken(request.getEmail(),user.getRoles());
    }


    public UserEntity getProfileBio(UserDetails userDetails){

        UserEntity user=userRepo.findByEmail(userDetails.getUsername()).orElseThrow(()->{
            throw new IllegalArgumentException("No User Found");
        });

        return user;
    }


    public UserEntity updateProfileBio(ProfileUpdateBio bio,UserDetails userDetails){
        UserEntity user=userRepo.findByEmail(userDetails.getUsername()).orElseThrow(()->{
            throw new IllegalArgumentException("No User Found");
        });

        user.setEmail(bio.getEmail());
        user.setName(bio.getName());
        return userRepo.save(user);
    }


    public boolean checkIfExists(String email){
        return userRepo.existsByEmail(email);
    }
}
