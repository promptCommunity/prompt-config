package com.prompt.config;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.config.server.EnableConfigServer;

@SpringBootApplication
@EnableConfigServer
public class PromptConfigApplication {

    public static void main(String[] args) {
        SpringApplication.run(PromptConfigApplication.class, args);
    }

}
