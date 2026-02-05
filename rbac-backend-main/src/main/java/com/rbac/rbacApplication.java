package com.rbac;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class rbacApplication {

	public static void main(String[] args) {
		SpringApplication.run(rbacApplication.class, args);
		System.out.println("  Application Started successfully!     \n" +
				" ██████╗  ██████╗  █████╗  ██████╗                 \n" +
 				" ██╔══██╗ ██╔══██╗██╔══██╗██╔════╝                 \n" +
 				" ██████╔╝ ██████╔╝███████║██║                      \n" +
  				" ██╔══██╗ ██╔══██╗██╔══██║██║                      \n" +
  				" ██║  ██║ ██████╔╝██║  ██║╚██████╗                 \n" +
  				" ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝               ");
	}

}
