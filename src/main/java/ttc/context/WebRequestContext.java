package ttc.context;


import java.util.Map;
import java.util.HashMap;
import java.util.Set;
import java.util.Iterator;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ttc.bean.UserBean;
import ttc.exception.PresentationException;

public class WebRequestContext implements RequestContext{
	private Map parameters = new HashMap();
	private HttpServletRequest request;

	public WebRequestContext(){}

	public String getCommandPath(){
		String pathInfo = request.getPathInfo();

		String commandPath = pathInfo.substring(1);

		return commandPath;
	}

	public String[] getParameter(String key){
		return (String[])parameters.get(key);
	}

	public Object getRequest(){
		return request;
	}

	public void setRequest(Object request)throws PresentationException{
		this.request = (HttpServletRequest) request;


		Map requestParameters = this.request.getParameterMap();
		Set keys = requestParameters.keySet();
		Iterator ite = keys.iterator();
		while(ite.hasNext()){
			String key = (String)ite.next();
			parameters.put(key, requestParameters.get(key));
		}

		HttpSession session = this.request.getSession();

		if(session.getAttribute("loginUser") != null){
			UserBean ub = (UserBean)session.getAttribute("loginUser");
			
			String[] userId = new String[1];
			try{
				userId[0] = ub.getId();
				
				parameters.put("userId", userId);
			}catch(NullPointerException e){
			 	throw new PresentationException(e.getMessage(), e);
			}
		}

	}
}
