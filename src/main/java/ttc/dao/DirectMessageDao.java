package ttc.dao;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import ttc.util.MySqlConnectionManager;
import ttc.bean.Bean;
import ttc.bean.DirectMessageBean;
import ttc.exception.integration.IntegrationException;

public class DirectMessageDao implements AbstractDao{

    public Bean read(Map map)throws IntegrationException{


        return null;
    }


    public List readAll(Map map)throws IntegrationException{

        DirectMessageBean dmBean=null;
        List result = new ArrayList();
        PreparedStatement pst = null;

        try{
            Connection cn = null;
            cn = MySqlConnectionManager.getInstance().getConnection();
            
            StringBuffer sql = new StringBuffer();

            sql.append("select message_id,message_body,message_date," );
            sql.append("fk_send_user_id,fk_receive_user_id,user_name ");
            sql.append("from direct_messages join users on user_id=fk_send_user_id ");
            sql.append("where fk_receive_user_id=?");
			
			boolean flag = map.containsKey("sendUserId");
			if(flag){
				sql.append(" and fk_send_user_id=?");
			}
			
			if(map.containsKey("group")){
				sql.append(" and message_date in (select MAX(message_date) from direct_messages group by fk_send_user_id) group by fk_send_user_id");
			}
			
			

            pst = cn.prepareStatement(new String(sql));
            pst.setString(1, (String)map.get("receiveUserId"));

			if(flag){
				pst.setString(2,(String)map.get("sendUserId"));
			}
			
            ResultSet rs = pst.executeQuery();

            while(rs.next()){
                dmBean = new DirectMessageBean();
                dmBean.setMessageId(rs.getString(1));
                dmBean.setMessageBody(rs.getString(2));
                dmBean.setDate(rs.getString(3));
                dmBean.setFromUserId(rs.getString(4));
                dmBean.setToUserId(rs.getString(5));
				dmBean.setFromUserName(rs.getString(6));
                result.add(dmBean);
            }

        }catch(SQLException e){
            throw new IntegrationException(e.getMessage(),e);
        }finally{
            try{
                if(pst!=null){
                    pst.close();
                }
            }catch(SQLException e){
                throw new IntegrationException(e.getMessage(),e);
            }
        }

        return result;
    }

    public int update(Map map)throws IntegrationException{
        return 0;
    }

    public int insert(Map map)throws IntegrationException{
        PreparedStatement pst = null;
        int result = 0;
        try{
            Connection cn = null;
            cn = MySqlConnectionManager.getInstance().getConnection();
            
            StringBuffer sql = new StringBuffer();
            sql.append("insert into ");
            sql.append("direct_messages(message_body,message_date, ");
            sql.append("fk_send_user_id,fk_receive_user_id) ");
            sql.append("values(?,?,?,?)");

            pst = cn.prepareStatement( new String(sql) );

            pst.setString(1, (String)map.get("messageBody"));
            pst.setString(2, (String)map.get("messageDate"));
            pst.setString(3, (String)map.get("sendUserId"));
            pst.setString(4, (String)map.get("receiveUserId"));

            result = pst.executeUpdate();

        }catch(SQLException e){
            MySqlConnectionManager.getInstance().rollback();
            throw new IntegrationException(e.getMessage(),e);
        }finally{
            try{
                if(pst!=null){
                    pst.close();
                }
            }catch(SQLException e){
                throw new IntegrationException(e.getMessage(),e);
            }
        }

        return result;
    }
}
