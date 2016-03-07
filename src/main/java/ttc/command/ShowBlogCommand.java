package ttc.command;

import ttc.context.RequestContext;
import ttc.context.ResponseContext;

import ttc.util.MySqlConnectionManager;

import ttc.exception.business.BusinessLogicException;
import ttc.exception.integration.IntegrationException;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import ttc.util.factory.AbstractDaoFactory;
import ttc.dao.AbstractDao;
import ttc.bean.ArticleBean;
import ttc.bean.BlogBean;
import ttc.exception.business.ParameterInvalidException;

public class ShowBlogCommand extends AbstractCommand{
    public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{
            RequestContext reqc = getRequestContext();

            Map result = new HashMap();
            String userId = reqc.getParameter("bloguserId")[0];
            System.out.println();
            Map params = new HashMap();
            params.put("userId",userId);

            MySqlConnectionManager.getInstance().beginTransaction();

            //ブログ情報取得----------------------------------------------------
            AbstractDaoFactory factory = AbstractDaoFactory.getFactory("blog");
            AbstractDao dao = factory.getAbstractDao();
            BlogBean bb = (BlogBean)dao.read(params);
            result.put("blog", bb);
            //----------------------------------------------------------------
            //記事一覧取得----------------------------------------------------
            params.put("flag","0");
            factory = AbstractDaoFactory.getFactory("article");
            dao = factory.getAbstractDao();
            List results = dao.readAll(params);
            result.put("articleList", results);
            //----------------------------------------------------------------


            MySqlConnectionManager.getInstance().commit();
            MySqlConnectionManager.getInstance().closeConnection();

            resc.setResult(result);

/*            //編集だったらターゲットを変える
            boolean editFlag = false;
			try{
				//editパラメータがあるかのチェック
				String edit = reqc.getParameter("edit")[0];

				if(edit.length() > 0){
					editFlag=true;
			}
			}catch(NullPointerException e){}

            if(editFlag){
                resc.setTarget("editArticle");
            }else{
                resc.setTarget("showArticleResult");
            }
*/
            resc.setTarget("blogTop");
            return resc;


        }catch(NullPointerException e){
			throw new ParameterInvalidException("入力内容が足りません", e);
		}catch(IntegrationException e){
            throw new BusinessLogicException(e.getMessage(), e);
        }
    }
}
