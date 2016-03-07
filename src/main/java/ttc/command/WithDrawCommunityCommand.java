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
import java.util.List;
import ttc.exception.business.ParameterInvalidException;

public class WithDrawCommunityCommand extends AbstractCommand{
    public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{
            RequestContext reqc = getRequestContext();

            Map params = new HashMap();
            Map result = new HashMap();

			String target = reqc.getParameter("target")[0];

			String userId = reqc.getParameter("userId")[0];

            params.put("userId",userId);
            params.put("commId",reqc.getParameter("commId")[0]);
			params.put("target",target);

            MySqlConnectionManager.getInstance().beginTransaction();

            AbstractDaoFactory factory = AbstractDaoFactory.getFactory("communitymember");
            AbstractDao dao = factory.getAbstractDao();
            dao.update(params);

            MySqlConnectionManager.getInstance().commit();
            
			factory = AbstractDaoFactory.getFactory("community");
			dao = factory.getAbstractDao();

			params.clear();
			params.put("where","where community_members_list.fk_user_id=?");
			params.put("value", userId);
			List communities = dao.readAll(params);

			result.put("community", communities);


            MySqlConnectionManager.getInstance().closeConnection();

            result.put("commName",reqc.getParameter("commName")[0]);
            resc.setResult(result);
            resc.setTarget("communityWithDrawResult");

            return resc;
        }catch(NullPointerException e){
			throw new ParameterInvalidException("入力内容が足りません", e);
		}catch(IntegrationException e){
            throw new BusinessLogicException(e.getMessage(),e);
        }
    }
}
