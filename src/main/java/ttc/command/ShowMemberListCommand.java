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
import ttc.bean.Bean;
import java.util.List;
import ttc.exception.business.ParameterInvalidException;

public class ShowMemberListCommand extends AbstractCommand{
    public ResponseContext execute(ResponseContext resc)throws BusinessLogicException{
        try{
            RequestContext reqc = getRequestContext();

            Map params = new HashMap();

            MySqlConnectionManager.getInstance().beginTransaction();

            AbstractDaoFactory fact=AbstractDaoFactory.getFactory("users");
            AbstractDao abdao= fact.getAbstractDao();

            // コミュニティ表とコミュニティ_メンバー関連表からコミュニティに所属するメンバーを取得
            params.put("where"," and fk_community_id=?");
            params.put("join"," join community_members_list on users.user_id = fk_user_id ");

            params.put("value",reqc.getParameter("commId")[0]);
            params.put("userStatus","0");

			List members= abdao.readAll(params);

			fact = AbstractDaoFactory.getFactory("community");
			abdao = fact.getAbstractDao();
			params = new HashMap();

			params.put("where","where community_id=? and community_members_list.fk_user_id=? and community_delete_flag=0");
            params.put("commId",reqc.getParameter("commId")[0]);
            params.put("targetUserId",reqc.getParameter("userId")[0]);

			Bean comm = abdao.read(params);

            MySqlConnectionManager.getInstance().commit();
            MySqlConnectionManager.getInstance().closeConnection();


            Map result=new HashMap();
            result.put("value",reqc.getParameter("commId")[0]);
            result.put("members",members);

			result.put("community",comm);

			resc.setResult(result);

            resc.setTarget("showMemberListResult");

            return resc;
        }catch(NullPointerException e){
			throw new ParameterInvalidException("入力内容が足りません", e);
		}catch(IntegrationException e){
            throw new BusinessLogicException(e.getMessage(),e);
        }
    }
}
