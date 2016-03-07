package ttc.dao;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ttc.bean.ArticleBean;
import ttc.bean.Bean;

import ttc.exception.integration.IntegrationException;

import ttc.util.MySqlConnectionManager;

public class ArticleSortDao implements AbstractDao{
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

        try{
            Connection cn = null;
            cn = MySqlConnectionManager.getInstance().getConnection();
            StringBuffer sql = new StringBuffer();

            String sortType=(String)map.get("sortType");


            if(sortType=="0"){
                //新着順に並び替え
                sql.append("select article_id,article_title,article_body,article_created_date, ");
                sql.append("fk_user_id, user_name, user_icon_path ");
                sql.append("from articles join users on articles.fk_user_id = users.user_id ");
                sql.append("where article_status_flag = 0 ");
                sql.append("order by article_created_date desc");

            }
            else if(sortType=="1"){
                //古い順に並び替え
                sql.append("select article_id,article_title,article_body,article_created_date,");
                sql.append("fk_user_id, user_name ");
                sql.append("from articles join users on articles.fk_user_id = users.user_id ");
                sql.append("where article_status_flag = 0 ");
                sql.append("order by article_created_date asc");
            }
            pst = cn.prepareStatement(new String(sql));

            ResultSet rs = pst.executeQuery();

            while(rs.next()){
                ArticleBean article = new ArticleBean();
                article.setArticleId(rs.getString(1));
                article.setTitle(rs.getString(2));
                article.setArticleBody(rs.getString(3));
                article.setCreatedDate(rs.getString(4));
                article.setUserId(rs.getString(5));
                article.setUserName(rs.getString(6));
                article.setIconPath(rs.getString(7));

				result.add(article);

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
