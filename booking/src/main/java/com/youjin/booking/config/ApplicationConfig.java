package com.youjin.booking.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@ComponentScan(basePackages = { "com.youjin.booking.dao", "com.youjin.booking.service" })
@Import({DBConfig.class})
public class ApplicationConfig {

}
