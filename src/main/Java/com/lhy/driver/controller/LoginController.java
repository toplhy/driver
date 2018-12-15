package com.lhy.driver.controller;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2017/3/4.
 */
@Controller
public class LoginController {

    /**
     * 登录页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/auth", method = RequestMethod.GET)
    public String authPage(HttpServletRequest request, Model model) {
        Object exception = request.getSession().getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
        if(exception != null){
            if(exception instanceof BadCredentialsException){
                model.addAttribute("message","用户名或密码错误!");
            }
        }
        return "login/auth";
    }

}
