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
public class ShowTagCommand extends AbstractCommand{
	public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{
            RequestContext reqc = getRequestContext();

			Map result = new HashMap();

			MySqlConnectionManager.getInstance().beginTransaction();

			// //TOPで表示する新着記事の取得
			// AbstractDaoFactory factory = AbstractDaoFactory.getFactory("sort");
			// AbstractDao dao = factory.getAbstractDao();
			Map param1 = new HashMap();
			// param1.put("sortType","0");
			// List articles = dao.readAll(param1);
			// Iterator itr = articles.iterator();
			//
			// while(itr.hasNext()){
			// 	//取得したarticleに対してコメントとタグをセットする
			//
			// 	ArticleBean ab = (ArticleBean)itr.next();
			// 	param1.clear();
			//
			//
			// 	param1.put("articleId", ab.getArticleId());
			// 	factory = AbstractDaoFactory.getFactory("tag");
			// 	dao = factory.getAbstractDao();
			//
			// 	ab.setTags(dao.readAll(param1));
			//
			// 	factory = AbstractDaoFactory.getFactory("comment");
			// 	dao = factory.getAbstractDao();
			// 	ab.setComments(dao.readAll(param1));
			// }
			//
			// if(articles.size() <= 6){
			// 	result.put("article", articles);
			// }else{
			// 	List nArticles = new ArrayList();
			// 	for(int i = 0;i < 6;i++){
			// 		nArticles.add(articles.get(i));
			// 	}
			// 	result.put("article",nArticles);
			// }
			//
			//
			// factory = AbstractDaoFactory.getFactory("blog");
			// dao = factory.getAbstractDao();
			// List blogs = dao.readAll(new HashMap());
			//
			// if(blogs.size() <= 3){
			// 	result.put("blog", blogs);
			// }else{
			// 	List nBlogs = new ArrayList();
			// 	for(int i = 0;i < 3;i++){
			// 		nBlogs.add(blogs.get(i));
			// 	}
			//
			// 	result.put("blog",nBlogs);
			// }
			//
			// // コミュニティの取得
			// factory = AbstractDaoFactory.getFactory("community");
			// dao = factory.getAbstractDao();
			//
			// Map param2 = new HashMap();
			// // 新規コミュニティの取得処理
			// param2.put("where","Where community_delete_flag = 0");
			// param2.put("sort", " order by communities.community_created_date desc ");
			// List communities = dao.readAll(param2);
			//
			// if(communities.size() <= 5){
			// 	result.put("hotCommunity",communities);
			// }else{
			// 	List nCommunities = new ArrayList();
			// 	for(int i = 0;i < 5;i++){
			// 		nCommunities.add(communities.get(i));
			// 	}
			//
			// 	result.put("hotCommunity",nCommunities);
			// }
			//
			// //人気コミュニティの取得処理
			// param2.clear();
			// param2.put("where","where community_delete_flag = 0");
			// param2.put("sort", " order by membercount limit 5 offset 0");
			// List popularCommunity = dao.readAll(param2);
			// result.put("popularCommunity", popularCommunity);
			//
			//
			// //ブログタブで表示する学科ごとの新着記事の取得
			// factory = AbstractDaoFactory.getFactory("users");
			// dao = factory.getAbstractDao();
			// Map param3 = new HashMap();
			// param3.put("userStatus","0");
			// param3.put("where"," and admin_flag > ?");
			// param3.put("value","1");
			// List users = dao.readAll(param3);
			// factory = AbstractDaoFactory.getFactory("article");
			// dao = factory.getAbstractDao();
			// List departmentArticles = new ArrayList();
			// for(int i=0; i<users.size(); i++){
			// 	UserBean ub = (UserBean)users.get(i);
			// 	Map param = new HashMap();
			// 	param.put( "userId", ub.getId() );
			// 	param.put( "flag", "0" );
			// 	param.put( "option", "limit 1 " );
			// 	List departmentArticle = dao.readAll(param);
			// 	if( departmentArticle.size() > 0 ){
			// 		departmentArticles.add( (ArticleBean)departmentArticle.get(0) );
			// 	}
			// }
			// result.put( "department", departmentArticles );
			//
			//
			// param1.clear();
			//
			//人気タグ取得
			AbstractDaoFactory factory = AbstractDaoFactory.getFactory("tag");
			AbstractDao dao = factory.getAbstractDao();

			param1.put("topFlg","true");
			//登録された記事の多い順にTagBeanを3件まで取得（なければ3件未満の可能性も）
			List tags = dao.readAll(param1);


			param1.clear();

			param1.put("whereTagIdFlg", "true");

			List tagArticleIdList = new ArrayList();
			for(int i=0; i<tags.size(); i++){
				TagBean tb = (TagBean)tags.get(i);
				param1.put("tagId",tb.getId() );
				//多い順でとったタグからそのタグに登録されている記事ID一覧を取得
				List list = dao.readAll(param1);

				tagArticleIdList.add(list);
			}

			param1.clear();

			factory = AbstractDaoFactory.getFactory("article");
			dao = factory.getAbstractDao();

			List tagArticles = new ArrayList();

			int tagDeleteCount = 0;
			for(int i=0; i<tagArticleIdList.size(); i++){
				List list = (List)tagArticleIdList.get(i);
				List oneTagArticles = new ArrayList();
				for(int j=0; j<list.size(); j++){
					String articleId = (String)list.get(j);
					param1.put("articleId", articleId);
					param1.put("flag", "0");
					Bean article = dao.read(param1);
					if(article!=null){
						oneTagArticles.add(article);
					}
					param1.clear();
				}
				if(oneTagArticles.isEmpty()){
					tags.remove(tagDeleteCount);
					System.out.println("tags.size="+tags.size());
				}else{
					tagDeleteCount++;
					tagArticles.add(oneTagArticles);
				}
			}

			result.put("tags",tags);
			result.put("tagArticles",tagArticles);

			//MySqlConnectionManager.getInstance().commit();

			resc.setResult(result);
            resc.setTarget("toptag");

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
