package com.dawood.business_discovery.utils;

import java.time.Instant;
import java.time.temporal.ChronoUnit;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.interfaces.DecodedJWT;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class JwtUtils {

  @Value("${app.jwt.secret}")
  private String key;

  public String generateToken(String subject) {

    try {
      String token = JWT.create()
          .withSubject(subject)
          .withIssuer("Dawood")
          .withIssuedAt(Instant.now())
          .withExpiresAt(Instant.now().plus(1, ChronoUnit.DAYS))
          .sign(secretkey());

      return token;
    } catch (JWTCreationException e) {
      log.error("Error generating JWT token {}", e.getMessage());
      throw e;
    }

  }

  public DecodedJWT verifyToken(String token) {
    try {
      JWTVerifier verifier = JWT.require(secretkey())
          .withIssuer("Dawood")
          .build();

      return verifier.verify(token);

    } catch (JWTDecodeException e) {
      log.error("Error decoding token {}", e.getMessage());
      throw e;
    }
  }

  public String extractSubjectFromJWT(String token) {
    return verifyToken(token).getSubject();
  }

  private Algorithm secretkey() {
    Algorithm algorithm = Algorithm.HMAC256(key);
    return algorithm;
  }

}
