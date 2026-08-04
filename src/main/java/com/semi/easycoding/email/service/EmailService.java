package com.semi.easycoding.email.service;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import java.security.SecureRandom;
import org.springframework.mail.SimpleMailMessage;

@Service
public class EmailService {

    private final JavaMailSender mailSender;

    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    private String createCode() {
        SecureRandom random = new SecureRandom();
        int number = random.nextInt(1_000_000);
        //하는 일: 000000부터 999999 사이의 인증번호 제작
        return String.format("%06d", number);
        //%06d: 앞을 0으로 채워 항상 6자리로 만든다...
    }

    //인증번호 발송 메서드
    public String sendVerificationCode(String email) {
        String code = createCode();

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("이지코딩 이메일 인증번호");
        message.setText("인증번호는 " + code + "입니다.");

        mailSender.send(message);

        return code;
    }

}