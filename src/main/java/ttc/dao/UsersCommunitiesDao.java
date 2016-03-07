package ttc.dao;

import java.util.List;

import java.util.Map;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import ttc.util.MySqlConnectionManager;
import ttc.bean.Bean;
import ttc.bean.CommunityBean;
import ttc.exception.integration.IntegrationException;

public class UsersCommunitiesDao implements AbstractDao{

    public Bean read(Map map)throws IntegrationException{
        CommunityBean cb=new CommunityBean();
        PreparedStatement pst = null;
        try{
            Connection cn = null;
            cn = MySqlConnectionManager.getInstance().getConnection();
            StringBuffer sql=new StringBuffer();
            sql.append("select community_id,community_name from communities where fk_user_id=? and community_id=?");

            pst = cn.prepareStatement(new String(sql));

            pst.setInt(1, Integer.parseInt((String)map.get("userId")));
            pst.setInt(2, Integer.parseInt((String)map.get("commId")));


            ResultSet rs = pst.executeQuery();

            if(rs.next()){

                cb.setId(rs.getString("community_id"));
				cb.setName(rs.getString("community_name"));

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
        return cb;

    }

    public int update(Map map)throws IntegrationException{
        PreparedStatement pst = null;
        int result = 0;
        try{
            Connection cn = null;
            cn = MySqlConnectionManager.getInstance().getConnection();

            StringBuffer sql = new StringBuffer();

            sql.append("update community_members_list set ");
			sql.append(map.get("target"));
            sql.append(" where fk_user_id=? and fk_community_id=?");
            System.out.println(new String(sql));
            pst = cn.prepareStatement(new String(sql));

            pst.setString(1,(String)map.get("userId"));
            pst.setString(2,(String)map.get("commId"));

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

    public int insert(Map map)throws IntegrationException{
        PreparedStatement pst = null;
        int result = 0;
        try{
            Connection cn = null;
            cn = MySqlConnectionManager.getInstance().getConnection();
            StringBuffer sql = new StringBuffer();
            sql.append("insert into community_members_list values(");
            sql.append("?,?,?,'0')");

            pst = cn.prepareStatement(new String(sql));

            pst.setString(1,(String)map.get("userId"));
            pst.setString(2,(String)map.get("commId"));
            
//			コミュニティ作成者の時に管理者フラグを立てるための分岐処理
			if(map.containsKey("adminFlag")){
				pst.setString(3, (String)map.get("adminFlag"));
			}else{
				pst.setString(3,"0");
			}

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

    public List readAll(Map map)throws IntegrationException{
        return null;
    }

}
