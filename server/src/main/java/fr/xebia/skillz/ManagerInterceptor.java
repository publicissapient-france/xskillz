package fr.xebia.skillz;

import fr.xebia.skillz.annotation.ManagerOnly;
import fr.xebia.skillz.controller.SignInController;
import fr.xebia.skillz.model.User;
import fr.xebia.skillz.repository.UserRepository;
import fr.xebia.skillz.technical.UnauthorizedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class ManagerInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private UserRepository userRepository;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (handler != null && handler instanceof HandlerMethod) {
            ManagerOnly annotation = ((HandlerMethod) handler).getMethodAnnotation(ManagerOnly.class);
            if (annotation != null) {
                User user = userRepository.findById(SignInController.TOKENS.get(request.getHeader("token")));
                if (!user.isManager()) {
                    throw new UnauthorizedException();
                }
            }
        }
        return super.preHandle(request, response, handler);
    }
}
