package com.mindconnect.infrastructure;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "com.mindconnect")
public class MindConnectApplication {

    public static void main(String[] args) {
        SpringApplication.run(MindConnectApplication.class, args);
    }
}
