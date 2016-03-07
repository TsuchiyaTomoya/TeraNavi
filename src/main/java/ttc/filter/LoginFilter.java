import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import ttc.bean.UserBean;

public class LoginFilter implements Filter{
  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain){
    try{
           

           // セッションが存在しない場合NULLを返す
           HttpSession session = ((HttpServletRequest)req).getSession();

           if(session.getAttribute("loginUser") != null){
               // セッションがNULLでなければ、通常どおりの遷移
               chain.doFilter(req, res);
           }else{
               // セッションがNullならば、ログイン画面へ飛ばす
               RequestDispatcher dispatcher = req.getRequestDispatcher("/login");
               dispatcher.forward(req,res);
           }


    }catch (ServletException se){
    }catch (IOException e){
    }

  }
  public void init(FilterConfig config) throws ServletException{}
  public void destroy(){}
}
