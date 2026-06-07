package org.learn.learningmanagementbackend.config;

import org.learn.learningmanagementbackend.security.JWTService;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.learn.learningmanagementbackend.security.MyUserDetailsService;

import java.util.List;

@Component
public class AuthChannelInterceptor implements ChannelInterceptor {

    private final JWTService jwtService;
    private final MyUserDetailsService userDetailsService;

    public AuthChannelInterceptor(JWTService jwtService, MyUserDetailsService userDetailsService) {
        this.jwtService = jwtService;
        this.userDetailsService = userDetailsService;
    }

    @Override
    public Message<?> preSend(Message<?> message, MessageChannel channel) {
        StompHeaderAccessor accessor = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);

        if (accessor != null && StompCommand.CONNECT.equals(accessor.getCommand())) {
            List<String> authorization = accessor.getNativeHeader("Authorization");

            if (authorization != null && !authorization.isEmpty()) {
                String bearerToken = authorization.get(0);

                if (bearerToken.startsWith("Bearer ")) {
                    String token = bearerToken.substring(7);

                    if (jwtService.isTokenValid(token)) {
                        String username = jwtService.extractUserName(token);

                        CustomUserDetails userDetails = (CustomUserDetails) userDetailsService.loadUserByUsername(username);

                        UsernamePasswordAuthenticationToken auth =
                                new UsernamePasswordAuthenticationToken(userDetails.getEmail(), null, userDetails.getAuthorities());

                        accessor.setUser(auth);
                        SecurityContextHolder.getContext().setAuthentication(auth);
                    } else {
                        throw new IllegalArgumentException("JWT Token is invalid or expired!");
                    }
                }
            } else {
                throw new IllegalArgumentException("Missing Authorization header in WebSocket connect!");
            }
        }

        return message;
    }
}
