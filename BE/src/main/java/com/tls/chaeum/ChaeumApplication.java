package com.tls.chaeum;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "com.tls")
public class ChaeumApplication {

	public static void main(String[] args) {
		SpringApplication.run(ChaeumApplication.class, args);
	}

}
