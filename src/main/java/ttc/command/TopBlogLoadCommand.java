/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ttc.command;



import ttc.context.RequestContext;
import ttc.context.ResponseContext;

import ttc.util.MySqlConnectionManager;

import ttc.exception.business.BusinessLogicException;
import ttc.exception.integration.IntegrationException;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

import ttc.bean.Bean;
import ttc.bean.ArticleBean;
import ttc.bean.UserBean;
import ttc.bean.TagBean;

import ttc.util.factory.AbstractDaoFactory;
import ttc.dao.AbstractDao;
import ttc.exception.business.ParameterInvalidException;
/**
 *
 * @author Masaki
 */
public class TopBlogLoadCommand extends AbstractCommand{
	public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{
            RequestContext reqc = getRequestContext();

			Map result = new HashMap();

			MySqlConnectionManager.getInstance().beginTransaction();

	
			AbstractDaoFactory factory = AbstractDaoFactory.getFactory("blog");
			AbstractDao dao = factory.getAbstractDao();
			List blogs = dao.readAll(new HashMap());

			if(blogs.size() <= 3){
				result.put("blog", blogs);
			}else{
				List nBlogs = new ArrayList();
				for(int i = 0;i < 3;i++){
					nBlogs.add(blogs.get(i));
				}

				result.put("blog",nBlogs);
			}

			//ブログタブで表示する学科ごとの新着記事の取得
			factory = AbstractDaoFactory.getFactory("users");
			dao = factory.getAbstractDao();
			Map param3 = new HashMap();
			param3.put("userStatus","0");
			param3.put("where"," and admin_flag > ?");
			param3.put("value","1");
			List users = dao.readAll(param3);
			factory = AbstractDaoFactory.getFactory("article");
			dao = factory.getAbstractDao();
			List departmentArticles = new ArrayList();
			for(int i=0; i<users.size(); i++){
				UserBean ub = (UserBean)users.get(i);
				Map param = new HashMap();
				param.put( "userId", ub.getId() );
				param.put( "flag", "0" );
				param.put( "option", "limit 1 " );
				List departmentArticle = dao.readAll(param);
				if( departmentArticle.size() > 0 ){
					departmentArticles.add( (ArticleBean)departmentArticle.get(0) );
				}
			}
			result.put( "department", departmentArticles );

			//MySqlConnectionManager.getInstance().commit();
            


			resc.setResult(result);
            resc.setTarget("top");

            return resc;

        }catch(NullPointerException e){
			throw new ParameterInvalidException("入力内容が足りません", e);
		}catch(IntegrationException e){
            throw new BusinessLogicException(e.getMessage(), e);
        }finally{
			//MySqlConnectionManager.getInstance().commit();
            MySqlConnectionManager.getInstance().closeConnection();
		}
    }

}
