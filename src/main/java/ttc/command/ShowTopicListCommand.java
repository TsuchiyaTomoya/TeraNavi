package ttc.command;

import ttc.context.RequestContext;
import ttc.context.ResponseContext;

import ttc.util.MySqlConnectionManager;

import ttc.exception.business.BusinessLogicException;
import ttc.exception.integration.IntegrationException;

import java.util.Map;
import java.util.HashMap;
import ttc.bean.CommunityBean;

import ttc.util.factory.AbstractDaoFactory;
import ttc.dao.AbstractDao;
import ttc.exception.business.ParameterInvalidException;

public class ShowTopicListCommand extends AbstractCommand{
    public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{
            RequestContext reqc = getRequestContext();
            String communityId=reqc.getParameter("communityId")[0];
            Map params = new HashMap();

            // 削除されていないコミュニティを取得するための条件
            params.put("where","where community_id=? and community_delete_flag=0");
            params.put("communityId",reqc.getParameter("communityId")[0]);
            // DAOの中でキーの値が統一されていないため、同じ値を違うキーで入れています。
            // 犯人は土屋。
            params.put("commId",reqc.getParameter("communityId")[0]);

            MySqlConnectionManager.getInstance().beginTransaction();

            // コミュニティを取得
            AbstractDaoFactory factory = AbstractDaoFactory.getFactory("community");
            AbstractDao dao = factory.getAbstractDao();
            CommunityBean cb =(CommunityBean)dao.read(params);

            // コミュニティがもつトピックを取得
            factory = AbstractDaoFactory.getFactory("topic");
            dao = factory.getAbstractDao();
            cb.setTopics(dao.readAll(params));

            MySqlConnectionManager.getInstance().commit();
            MySqlConnectionManager.getInstance().closeConnection();

			resc.setResult(cb);
            resc.setTarget("topiclist");

            return resc;

        }catch(NullPointerException e){
			throw new ParameterInvalidException("入力内容が足りません", e);
		}catch(IntegrationException e){
            throw new BusinessLogicException(e.getMessage(), e);
        }
    }
}
