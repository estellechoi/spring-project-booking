package com.youjin.booking.config;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.TransactionManagementConfigurer;

@Configuration
@EnableTransactionManagement // 트랜젝션 관련 기본 설정을 한다.
public class DBConfig implements TransactionManagementConfigurer {
	
	private String driverClassName = "com.mysql.cj.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/youjin?useSSL=false&serverTimezone=UTC";
	private String user = "estellechoi";
	private String pwd = "yk0425";
	
	// dataSource 빈 등록
	@Bean
	public DataSource dataSource() {
		BasicDataSource dataSource = new BasicDataSource();
		dataSource.setDriverClassName(driverClassName);
		dataSource.setUrl(url);
		dataSource.setUsername(user);
		dataSource.setPassword(pwd);
		return dataSource;
	}
	
	// 사용자간의 트랜젝션 처리를 위한 PlatformTransactionManager 설정하기 위해
	// TransactionManagementConfigurer 인터페이스를 구현한다.
	@Override
	public PlatformTransactionManager annotationDrivenTransactionManager() {
		return transactionManager();
	}	
	
	// DataSource 를 인자로 하고, PlatformTransactionManager 를 리턴하는 메소드
	@Bean
	public PlatformTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}
	
}
