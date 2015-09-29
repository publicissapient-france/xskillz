package fr.xebia.skillz;

import fr.xebia.skillz.filter.CORSFilter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.embedded.EmbeddedServletContainerFactory;
import org.springframework.boot.context.embedded.tomcat.TomcatEmbeddedServletContainerFactory;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class SkillzApplication {

    public static void main(String[] args) {
        SpringApplication.run(SkillzApplication.class, args);
    }

    @Bean
    public EmbeddedServletContainerFactory getEmbeddedServletContainerFactory() {
        return new TomcatEmbeddedServletContainerFactory();
    }

    @Bean
    public CORSFilter getCORSFilter() {
        return new CORSFilter();
    }
}
