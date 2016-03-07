
package ttc.command;


import java.util.ArrayList;

import ttc.context.RequestContext;
import ttc.context.ResponseContext;

import ttc.util.MySqlConnectionManager;

import ttc.exception.business.BusinessLogicException;
import ttc.exception.integration.IntegrationException;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import ttc.bean.UserBean;

import ttc.util.factory.AbstractDaoFactory;
import ttc.dao.AbstractDao;
import ttc.exception.business.ParameterInvalidException;
/**
 *
 * @author Masaki
 */
public class MypageLoadCommand extends AbstractCommand{
	public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{
            RequestContext reqc = getRequestContext();

            String loginUserId = reqc.getParameter("userId")[0];
            String paramUserId = reqc.getParameter("paramUserId")[0];

			String userId = "-1";
			if( loginUserId.equals(paramUserId) ){
				userId = loginUserId;
			}else{
				userId = paramUserId;
			}

            Map result = new HashMap();

			MySqlConnectionManager.getInstance().beginTransaction();


			//ユーザー情報の取得
			AbstractDaoFactory factory = AbstractDaoFactory.getFactory("users");
			AbstractDao dao = factory.getAbstractDao();
			Map param = new HashMap();
			param.put("where", "where user_id = ?");
			param.put("value", userId);
			UserBean ub = (UserBean)dao.read(param);
			result.put("user", ub);

			param.remove("where");


			//新着記事の取得
			factory = AbstractDaoFactory.getFactory("article");
			dao = factory.getAbstractDao();
			param.put("userId", userId);
			param.put("flag", "0");
			List articles = dao.readAll(param);

			if(articles.size() <= 3){
				result.put("article", articles);
			}else{
				List nArticles = new ArrayList();
				for(int i = 0;i < 3;i++){
					nArticles.add(articles.get(i));
				}
				result.put("article",nArticles);
			}

			//コミュの取得
			factory = AbstractDaoFactory.getFactory("community");
			dao = factory.getAbstractDao();

			Map param2 = new HashMap();
			param2.put("where","Where community_delete_flag=0 and community_members_list.fk_user_id="+userId);
			param2.put("sort", " order by communities.community_created_date desc ");
			List communities = dao.readAll(param2);

			if(communities.size() <= 3){
				result.put("community",communities);
			}else{
				List nCommunities = new ArrayList();
				for(int i = 0;i < 3;i++){
					nCommunities.add(communities.get(i));
				}

				result.put("community",nCommunities);
			}


			resc.setResult(result);
            resc.setTarget("mypage");

            return resc;

        }catch(NullPointerException e){
			throw new ParameterInvalidException("入力内容が足りません", e);
		}catch(IntegrationException e){
            throw new BusinessLogicException(e.getMessage(), e);
        }
    }

}
