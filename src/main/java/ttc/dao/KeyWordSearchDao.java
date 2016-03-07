package ttc.dao;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ttc.bean.BlogBean;
import ttc.bean.Bean;

import ttc.exception.integration.IntegrationException;

import ttc.util.MySqlConnectionManager;

public class KeyWordSearchDao implements AbstractDao{
    public int insert(Map map)throws IntegrationException{
        return 0;
    }
    public int update(Map map)throws IntegrationException{
        return 0;
    }
    public Bean read(Map map)throws IntegrationException{
        return null;
    }

    public List readAll(Map map)throws IntegrationException{
        List result = new ArrayList();
        PreparedStatement pst = null;
        String[] keywords = (String[])map.get("keywords");


        try{
            Connection cn = null;
            cn = MySqlConnectionManager.getInstance().getConnection();
            StringBuffer sql = new StringBuffer();
            sql.append("select user_header_path,blog_title,blog_explanation,user_id ");
            sql.append("from users where blog_title like ?");
            for(int i=1;i<keywords.length;i++){

                sql.append(" and blog_title like ?");
            }

            pst = cn.prepareStatement(new String(sql));

            for(int i=0;i<keywords.length;i++){
                pst.setString(i+1,"%"+keywords[i]+"%");
            }



            ResultSet rs = pst.executeQuery();

            while(rs.next()){
                BlogBean blog = new BlogBean();
                blog.setHeaderPath(rs.getString(1));
                blog.setTitle(rs.getString(2));
                blog.setExplanation(rs.getString(3));
                blog.setUserId(rs.getString(4));
                result.add(blog);

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
}
