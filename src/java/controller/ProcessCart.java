package Servlet;

import model.*;
import dao.CartDAO;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


@WebServlet("/cart")
public class ProcessCart extends HttpServlet {
    private CartDAO cartDAO;
    
    @Override
    public void init() throws ServletException{
        cartDAO = new CartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        int userId = 1;
        Cart cart = (Cart) session.getAttribute("cart");
        if(cart == null){ 
            cart = cartDAO.getCartByUserId(userId);
            session.setAttribute("cart", cart);
        }
        req.setAttribute("cart", cart);
        req.getRequestDispatcher("cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        int userId = 1;
        String action = req.getParameter("action");
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = cartDAO.getCartByUserId(userId);
            session.setAttribute("cart", cart);
        }
        
        try{
            int productId = Integer.parseInt(req.getParameter("product_id"));
            if("delete".equals(action)){ 
                cart.removeItem(productId);
                cartDAO.removeItem(userId, productId);
            }
            else if("update".equals(action)){ 
                int quantity = Integer.parseInt(req.getParameter("quantity"));
                if(quantity < 1) quantity = 1;
                cart.updateQuantity(productId, quantity);
                cartDAO.updateQuantity(userId, productId, quantity);
            }
            else if("increase".equals(action)){ 
                cart.increaseQuantity(productId);
                cartDAO.updateQuantity(userId, productId, cart.getItem(productId).getQuantity());
            }
            else if("decrease".equals(action)){ 
                cart.decreaseQuantity(productId);
                cartDAO.updateQuantity(userId, productId, cart.getItem(productId).getQuantity());
            }
            session.setAttribute("cart", cart); 
            session.setMaxInactiveInterval(10);
            resp.sendRedirect("cart");
        }
        catch(Exception e){
            e.printStackTrace();
            resp.getWriter().println("Lỗi khi cập nhật giỏ hàng!");
        }
    }
}
