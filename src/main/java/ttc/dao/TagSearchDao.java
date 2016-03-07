package ttc.dao;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ttc.bean.ArticleBean;
import ttc.bean.UserBean;
import ttc.bean.Bean;

import ttc.exception.integration.IntegrationException;

import ttc.util.MySqlConnectionManager;

public class TagSearchDao implements AbstractDao{
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
        List user_result = new ArrayList();
        List article_result = new ArrayList();
        List result = new ArrayList();
        PreparedStatement pst = null;
        String[] tags = null;
        for(int i=0;i<map.size();i++){
            tags[i]=(String)map.get("tag"+i);
        }
        String tag=tags[0];

        try{
            Connection cn = null;
            cn = MySqlConnectionManager.getInstance().getConnection();
            StringBuffer sql = new StringBuffer();

            sql.append("select users.user_id,users.user_name,users.user_icon_path,article.article_id,article.article_title,article.article_body,article.article_created_date from tags ");
            sql.append("from tags join article_tag on tags.tag_id = article_tag.tag_id join articles on article_tag.tag_id = article.article_id ");
            sql.append("join users on articles.user_id=users.user_id ");
            sql.append("where tag_name=?");

            pst.setString(1,tag);

            pst = cn.prepareStatement(new String(sql));

            ResultSet rs = pst.executeQuery();

			while(rs.next()){
					UserBean users = new UserBean();
					users.setId(rs.getString(1));
					users.setUserName(rs.getString(2));
					users.setIconPath(rs.getString(3));
					user_result.add(users);
					ArticleBean article = new ArticleBean();
					article.setArticleId(rs.getString(3));
					article.setTitle(rs.getString(4));
					article.setArticleBody(rs.getString(5));
					article.setCreatedDate(rs.getString(6));

					article_result.add(article);
			}
			result.add(user_result);
			result.add(article_result);

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
