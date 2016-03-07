package ttc.command;

import ttc.context.RequestContext;
import ttc.context.ResponseContext;

import ttc.util.MySqlConnectionManager;

import ttc.exception.business.BusinessLogicException;
import ttc.exception.integration.IntegrationException;

import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;

import ttc.util.factory.AbstractDaoFactory;
import ttc.dao.AbstractDao;

import ttc.bean.ArticleBean;
import ttc.exception.business.ParameterInvalidException;

public class DeleteArticleCommand extends AbstractCommand{
    public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{

            RequestContext reqc = getRequestContext();

            String[] articleId = reqc.getParameter("articleId[]");

            String loginUserId = reqc.getParameter("userId")[0];

            String status = "2";

            Map params = new HashMap();

            params.put("status", status);

            AbstractDaoFactory factory = AbstractDaoFactory.getFactory("article");
            AbstractDao dao = factory.getAbstractDao();

            for(int i = 0; i < articleId.length; i++){
                params.put("articleId", articleId[i]);


                MySqlConnectionManager.getInstance().beginTransaction();

                ArticleBean ab = (ArticleBean)dao.read(params);

    			params.put("articlebean",ab);
                dao.update(params);

                params.put("userId", loginUserId);
                params.put("flag", "0");
                List articles = dao.readAll( params );
                resc.setResult(articles);

                MySqlConnectionManager.getInstance().commit();
                MySqlConnectionManager.getInstance().closeConnection();
            }

            return resc;

        }catch(NullPointerException e){
			throw new ParameterInvalidException("入力内容が足りません", e);
		}catch(IntegrationException e){
            throw new BusinessLogicException(e.getMessage(), e);
        }
    }
}
