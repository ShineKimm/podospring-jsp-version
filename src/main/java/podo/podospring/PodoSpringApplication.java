package podo.podospring;

import org.apache.ibatis.io.ResolverUtil.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class PodoSpringApplication extends SpringBootServletInitializer {


	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(PodoSpringApplication.class);
	}
	public static void main(String[] args) {
		SpringApplication.run(PodoSpringApplication.class, args);

		Logger logger = LoggerFactory.getLogger(Test.class);
		logger.debug("slf4j TEST TEST");
	}

}
