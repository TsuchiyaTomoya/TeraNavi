package ttc.command;

import ttc.context.RequestContext;
import ttc.context.ResponseContext;

import ttc.util.MySqlConnectionManager;

import ttc.exception.business.BusinessLogicException;
import ttc.exception.integration.IntegrationException;

import ttc.util.factory.AbstractDaoFactory;
import ttc.dao.AbstractDao;

import java.util.Map;
import java.util.HashMap;
import ttc.bean.UserBean;
import ttc.bean.CommunityBean;
import java.util.ArrayList;
import java.util.List;
import ttc.exception.business.ParameterInvalidException;

public class ShowCommunityCommand extends AbstractCommand{
    public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{
            RequestContext reqc = getRequestContext();

            HashMap params = new HashMap();

			String communityId = reqc.getParameter("commId")[0];
            params.put("where","where community_id=? and community_delete_flag=0");
            params.put("commId",communityId);

            MySqlConnectionManager.getInstance().beginTransaction();

            AbstractDaoFactory factory = AbstractDaoFactory.getFactory("community");
            AbstractDao dao = factory.getAbstractDao();
            CommunityBean cb =(CommunityBean)dao.read(params);
			
			factory=AbstractDaoFactory.getFactory("topic");
            dao= factory.getAbstractDao();
			
			params.clear();
			params.put("communityId", communityId);
			
            cb.setId(reqc.getParameter("commId")[0]);
            List listx = dao.readAll(params);
            List topicList = new ArrayList();
            if(listx.size()>5){
                for(int i = 0;i < 5;i++){
                    topicList.add(listx.get(i));
                }
            }else{
                topicList = listx;
            }

            cb.setTopics(topicList);



            factory=AbstractDaoFactory.getFactory("users");
            dao= factory.getAbstractDao();
            ArrayList memebers=new ArrayList();

            params.put("where"," and fk_community_id=?");
            params.put("join"," join community_members_list on users.user_id = fk_user_id ");

            params.put("value",communityId);
            params.put("userStatus","0");

			List list = (ArrayList)dao.readAll(params);
			List miniList = new ArrayList();
			if(list.size()>5){
				for(int i = 0;i < 5;i++){
					miniList.add(list.get(i));
				}
			}else{
				miniList = list;
			}



            cb.setMembers(miniList);


            MySqlConnectionManager.getInstance().commit();
            MySqlConnectionManager.getInstance().closeConnection();


			resc.setResult(cb);

            resc.setTarget("showCommunityResult");

            return resc;
        }catch(NullPointerException e){
			throw new ParameterInvalidException("入力内容が足りません", e);
		}catch(IntegrationException e){
            throw new BusinessLogicException(e.getMessage(),e);
        }
    }
}
