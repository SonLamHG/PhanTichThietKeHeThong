package com.example.pttk_final.Servlet;

import com.example.pttk_final.DAO.MemberDAO;
import com.example.pttk_final.Entity.Member;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String name = request.getParameter("name");
        String dobRaw = request.getParameter("dob");
        Date dob = null;
        try {
            dob = Date.valueOf(dobRaw);
        } catch (Exception ex) {
            request.setAttribute("error", "Ngày sinh không hợp lệ. Định dạng phải là yyyy-MM-dd.");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
            return;
        }
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        Member member = new Member();
        member.setUsername(user);
        member.setPassword(pass);
        member.setName(name);
        member.setDateOfBirth(dob);
        member.setAddress(address);
        member.setPhoneNumber(phone);
        member.setEmail(email);

        MemberDAO memberDAO = new MemberDAO();
        boolean result = memberDAO.addMember(member);

        if (result) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
        } else {
            request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/view/register.jsp");
    }
}
