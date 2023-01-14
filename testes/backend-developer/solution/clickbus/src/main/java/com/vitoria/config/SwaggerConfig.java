package com.vitoria.config;

import java.util.Collections;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
public class SwaggerConfig {
	 @Bean
	    public Docket api() {
	        return new Docket(DocumentationType.SWAGGER_2)
	                .select()
	                .paths(PathSelectors.ant("/**"))
	                .apis(RequestHandlerSelectors.basePackage("com.vitoria"))
	                .build();
	 }

	    private ApiInfo apiInfo() {
	        return new ApiInfo(
	                "My REST API", //title
	                "Some custom description of API.", //description
	                "Version 1.0", //version
	                "Terms of service", //terms of service URL
	                new Contact("Vitória", "github.com/vitoriaacarvalho", "vitoriabcarvalhocorrea@gmail.com"),
	                "License of API", "API license URL", Collections.emptyList()); // contact info
	    }
	
}
