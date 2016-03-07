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

import ttc.bean.ArticleBean;
import ttc.bean.UserBean;

import ttc.util.factory.AbstractDaoFactory;
import ttc.dao.AbstractDao;
import ttc.exception.business.ParameterInvalidException;
/**
 *
 * @author Masaki
 */
public class TopLoadCommand extends AbstractCommand{
	public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{
            RequestContext reqc = getRequestContext();

			Map result = new HashMap();

			MySqlConnectionManager.getInstance().beginTransaction();

			//TOPで表示する新着記事の取得
			AbstractDaoFactory factory = AbstractDaoFactory.getFactory("sort");
			AbstractDao dao = factory.getAbstractDao();
			Map param1 = new HashMap();
			param1.put("sortType","0");
			List articles = dao.readAll(param1);
			Iterator itr = articles.iterator();
			
			while(itr.hasNext()){
				ArticleBean ab = (ArticleBean)itr.next();
				param1.clear();
				param1.put("articleId", ab.getArticleId());
				factory = AbstractDaoFactory.getFactory("tag");
				dao = factory.getAbstractDao();

				ab.setTags(dao.readAll(param1));

				factory = AbstractDaoFactory.getFactory("comment");
				dao = factory.getAbstractDao();
				ab.setComments(dao.readAll(param1));
			}

			if(articles.size() <= 6){
				result.put("article", sliceArticleBody(articles));
			}else{
				List nArticles = new ArrayList();
				for(int i = 0;i < 6;i++){
					nArticles.add(articles.get(i));
				}
				result.put("article",sliceArticleBody(nArticles));
			}


			factory = AbstractDaoFactory.getFactory("blog");
			dao = factory.getAbstractDao();
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

			factory = AbstractDaoFactory.getFactory("community");
			dao = factory.getAbstractDao();

			Map param2 = new HashMap();
			param2.put("where","Where community_delete_flag=0 ");
			param2.put("sort", " order by communities.community_created_date desc ");
			List communities = dao.readAll(param2);

			if(communities.size() <= 5){
				result.put("community",communities);
			}else{
				List nCommunities = new ArrayList();
				for(int i = 0;i < 5;i++){
					nCommunities.add(communities.get(i));
				}

				result.put("community",nCommunities);
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
				departmentArticles.add( (ArticleBean)departmentArticle.get(0) );
			}
			result.put( "department", sliceArticleBody(departmentArticles) );


			MySqlConnectionManager.getInstance().commit();
            MySqlConnectionManager.getInstance().closeConnection();


			resc.setResult(result);
            resc.setTarget("top");

            return resc;

        }catch(NullPointerException e){
			throw new ParameterInvalidException("入力内容が足りません", e);
		}catch(IntegrationException e){
            throw new BusinessLogicException(e.getMessage(), e);
        }
    }

	//記事本文を30文字で切る
	private static List sliceArticleBody(List articles){
		List newArticles = new ArrayList();
		for(int i=0; i<articles.size(); i++){
			ArticleBean ab = (ArticleBean)articles.get(i);
			String articleBody = ab.getArticleBody();
			if(articleBody.length() > 30){
				ab.setArticleBody( articleBody.substring(0,30) );
				
			}
			newArticles.add(ab);
		}
		return newArticles;
	}
}
