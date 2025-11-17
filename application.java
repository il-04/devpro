   DemoApplication.java 
package com.dp.demo;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@SpringBootApplication
public class DemoApplication {
	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}
}
Application.properties 
spring.application.name=demo
spring.datasource.url=jdbc:mysql://localhost:3306/dummy
spring.datasource.username=root
spring.datasource.password=licet@123
