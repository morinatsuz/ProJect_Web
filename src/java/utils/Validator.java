/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Boom
 */
public class Validator {
    
    public static boolean authorize(HttpServletRequest request, String requireRole) {
        String role = (String)request.getSession().getAttribute("type");
        return role.equals(requireRole);
    }
    
}
