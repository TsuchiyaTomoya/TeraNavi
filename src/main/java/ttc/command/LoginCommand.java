package ttc.command;

import ttc.context.RequestContext;
import ttc.context.ResponseContext;

import ttc.util.MySqlConnectionManager;

import ttc.exception.integration.IntegrationException;
import ttc.exception.business.BusinessLogicException;
import ttc.exception.business.PasswordInvalidException;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import ttc.util.factory.AbstractDaoFactory;
import ttc.dao.AbstractDao;
import ttc.bean.UserBean;

import ttc.exception.business.ParameterInvalidException;

public class LoginCommand extends AbstractCommand{


    public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{
            RequestContext reqc = getRequestContext();

            String loginId=reqc.getParameter("loginId")[0];
            String password=reqc.getParameter("password")[0];



            Map params = new HashMap();
            params.put("value",loginId);
            params.put("where","where login_id=?");


            MySqlConnectionManager.getInstance().beginTransaction();
            AbstractDaoFactory factory = AbstractDaoFactory.getFactory("users");
            AbstractDao dao = factory.getAbstractDao();
            UserBean ub = (UserBean)dao.read(params);

            if(password.equals(ub.getPassword())){
                ub.setPassword("dummy");
                ub.setSecretAnswer("dummy");
				
				factory = AbstractDaoFactory.getFactory("community");
				dao = factory.getAbstractDao();
				
				params.clear();
				params.put("where","where community_members_list.fk_user_id=?");
				params.put("value", ub.getId());
				List communities = dao.readAll(params);
				
				Map result = new HashMap();
				result.put("user", ub);
				result.put("community", communities);
				
                resc.setResult(result);
                resc.setTarget("LoginResult");

            }else{
                throw new PasswordInvalidException("パスワードが違います",null);
            }
			
            MySqlConnectionManager.getInstance().commit();
            MySqlConnectionManager.getInstance().closeConnection();



            return resc;


        }catch(NullPointerException e){
			throw new ParameterInvalidException("入力内容が足りません", e);
		}catch(IntegrationException e){
            throw new BusinessLogicException(e.getMessage(),e);
        }
    }
}
