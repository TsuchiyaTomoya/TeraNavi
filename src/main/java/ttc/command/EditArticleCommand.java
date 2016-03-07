package ttc.command;

import ttc.context.RequestContext;
import ttc.context.ResponseContext;

import ttc.util.MySqlConnectionManager;

import ttc.exception.business.BusinessLogicException;
import ttc.exception.integration.IntegrationException;

import java.util.Map;
import java.util.HashMap;

import java.util.Calendar;
import java.text.SimpleDateFormat;

import ttc.util.factory.AbstractDaoFactory;
import ttc.dao.AbstractDao;

import ttc.bean.ArticleBean;
import ttc.exception.business.ParameterInvalidException;

public class EditArticleCommand extends AbstractCommand{
    public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{
            RequestContext reqc = getRequestContext();

            String articleId = reqc.getParameter("articleId")[0];
            String title = reqc.getParameter("title")[0];

            String body = reqc.getParameter("body")[0];
            String status = reqc.getParameter("status")[0];

            String[] tags = null;
			//タグはチェックボックス等で複数来る事を想定してます

			boolean tagFlag = false;
			try{
				//tagパラメータがあるかのチェック、jsp変更前の例外防止
				tags =reqc.getParameter("tag[]");

				if(tags.length > 0){
					tagFlag=true;
				}
			}catch(NullPointerException e){

			}

            Calendar cal = Calendar.getInstance();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
            String date = formatter.format(cal.getTime());


            Map params = new HashMap();
            params.put("articleId", articleId);
            params.put("title", title);
            params.put("body", body);
            params.put("status", status);
            params.put("date", date);

            MySqlConnectionManager.getInstance().beginTransaction();

            AbstractDaoFactory factory = AbstractDaoFactory.getFactory("article");
            AbstractDao dao = factory.getAbstractDao();
            ArticleBean ab = (ArticleBean)dao.read(params);

			params.put("articlebean",ab);
            dao.update(params);

            params.clear();

            if(tagFlag){
                //さっきインサートした記事情報を取得したいとき
				params.put("lastInsert","true");
				ArticleBean article = (ArticleBean)dao.read(params);

                params.clear();

				factory = AbstractDaoFactory.getFactory("tag");
				dao = factory.getAbstractDao();

				for(int i = 0;i < tags.length;i++){
					params.put("articleId", article.getArticleId());
					params.put("tag", tags[i]);
					dao.insert(params);
					params.clear();
				}

			}

            MySqlConnectionManager.getInstance().commit();
            MySqlConnectionManager.getInstance().closeConnection();

            return resc;

        }catch(NullPointerException e){
			throw new ParameterInvalidException("入力内容が足りません", e);
		}catch(IntegrationException e){
            throw new BusinessLogicException(e.getMessage(), e);
        }
    }
}
