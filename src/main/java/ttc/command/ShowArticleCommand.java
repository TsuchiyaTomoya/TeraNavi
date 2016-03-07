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

public class ShowArticleCommand extends AbstractCommand{
    public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{
            RequestContext reqc = getRequestContext();

            Map result = new HashMap();

            //記事情報取得----------------------------------------------------------
            String articleId = reqc.getParameter("articleId")[0];

            Map params = new HashMap();
            params.put("articleId", articleId);

            MySqlConnectionManager.getInstance().beginTransaction();

            AbstractDaoFactory factory = AbstractDaoFactory.getFactory("article");
            AbstractDao dao = factory.getAbstractDao();
            ArticleBean ab = (ArticleBean)dao.read(params);

			factory = AbstractDaoFactory.getFactory("tag");
			dao = factory.getAbstractDao();

			ab.setTags(dao.readAll(params));

			factory = AbstractDaoFactory.getFactory("comment");
			dao = factory.getAbstractDao();
			ab.setComments(dao.readAll(params));


            result.put("article", ab);
            //----------------------------------------------------------------------

            params.clear();
            params.put("userId", ab.getUserId());
            params.put("flag", "0");


			factory = AbstractDaoFactory.getFactory("article");
			dao = factory.getAbstractDao();

            //前後の記事IDを調べる　なければ-1 ----------------------------------
            List articles = dao.readAll(params);
            int index = -1;
            for(int i=0; i<articles.size(); i++){
                ArticleBean article = (ArticleBean)articles.get(i);
                if( articleId.equals( article.getArticleId() ) ){
                    index = i;
                    break;
                }
            }
            int preArticleId = -1, nextArticleId =-1;
            if(index > 0){
                
                ArticleBean nextArticle = (ArticleBean)articles.get(index-1);
                nextArticleId = Integer.parseInt( nextArticle.getArticleId() );
            }
            if(index+1 <  articles.size() && index > -1 ){
                
                ArticleBean preArticle = (ArticleBean)articles.get(index+1);
                preArticleId = Integer.parseInt( preArticle.getArticleId() );
            }
            result.put("previous", preArticleId);
            result.put("next", nextArticleId);
            //----------------------------------------------------------------

            //月別アーカイブ用のリスト作成-----------------------------------------
            params.put("archive", "true");
            List archives = dao.readAll(params);
            result.put("archives", archives);
            //----------------------------------------------------------------

            //ブログ情報取得----------------------------------------------------
            factory = AbstractDaoFactory.getFactory("blog");
            dao = factory.getAbstractDao();
            BlogBean bb = (BlogBean)dao.read(params);
            result.put("blog", bb);
            //----------------------------------------------------------------


            MySqlConnectionManager.getInstance().commit();
            MySqlConnectionManager.getInstance().closeConnection();

            resc.setResult(result);

            //編集だったらターゲットを変える
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

            return resc;


        }catch(NullPointerException e){
			throw new ParameterInvalidException("入力内容が足りません", e);
		}catch(IntegrationException e){
            throw new BusinessLogicException(e.getMessage(), e);
        }
    }
}
