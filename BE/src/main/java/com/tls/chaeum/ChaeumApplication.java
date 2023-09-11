package com.tls.chaeum;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(scanBasePackages = "com.tls")
@EnableJpaRepositories(basePackages = {"com.tls"})
@EntityScan(basePackages = {"com.tls"})
public class ChaeumApplication {

	public static void main(String[] args) {
		SpringApplication.run(ChaeumApplication.class, args);
	}

}
