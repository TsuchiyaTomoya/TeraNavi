package ttc.dao;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import ttc.util.MySqlConnectionManager;
import ttc.bean.Bean;
import ttc.bean.ArticleBean;
import ttc.bean.UserBean;
import ttc.bean.BlogBean;

import ttc.exception.integration.IntegrationException;

public class ArticleDao implements AbstractDao{

    public Bean read(Map map)throws IntegrationException{
        ArticleBean ab = new ArticleBean();
        PreparedStatement pst = null;
        try{
            Connection cn = null;
            cn = MySqlConnectionManager.getInstance().getConnection();
            StringBuffer sql = new StringBuffer();


            if( map.containsKey("lastInsert") ){

                //最後にインサートした記事のIDがほしい場合（記事投稿のタグ付けでのみ使用）
                sql.append("select last_insert_id() from articles limit 1 ");
                pst = cn.prepareStatement( new String(sql) );
                ResultSet rs = pst.executeQuery();
                rs.next();
                ab.setArticleId( rs.getString(1) );

            }else{

                //記事表からの取得----------------------------------------------------
                sql.append("select article_id, article_title, article_body, ");
                sql.append("article_created_date,fk_user_id, ");
                sql.append("user_name, user_icon_path ");
                sql.append("from articles join users ");
                sql.append("on articles.fk_user_id = users.user_id ");


    			if(map.containsKey("whereNo")){
    				String whereNo = (String)map.get("whereNo");
    				if(whereNo.equals("1")){
    					sql.append("where article_title=? and article_created_date=? and fk_user_id=?");
    					pst = cn.prepareStatement( new String(sql) );
    					pst.setString(1, (String)map.get("title"));
    					pst.setString(2, (String)map.get("date"));
    					pst.setString(3, (String)map.get("userId"));
    				}
    			}else{
    				sql.append("where article_id = ?");
    				pst = cn.prepareStatement( new String(sql) );
    				pst.setInt(1, Integer.parseInt( (String)map.get("articleId") ) );

    			}
                ResultSet rs = pst.executeQuery();

                rs.next();
                ab.setArticleId( rs.getString(1) );
                ab.setTitle( rs.getString(2) );
                ab.setArticleBody( rs.getString(3) );
                ab.setCreatedDate( rs.getString(4) );
                ab.setUserId(rs.getString(5));
                ab.setUserName(rs.getString(6));
                ab.setIconPath(rs.getString(7));
    			//------------------------------------------------------------------

            }


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

        return ab;
    }

    public int update(Map map)throws IntegrationException{
        PreparedStatement pst = null;
        int result = 0;
        try{

            ArticleBean ab =(ArticleBean)map.get("articlebean");
            Connection cn = MySqlConnectionManager.getInstance().getConnection();
            StringBuffer sql = new StringBuffer();

            sql.append("update articles set ");
            sql.append("article_title = ?, ");
            sql.append("article_body = ?, ");
            sql.append("article_status_flag = ?, ");
            sql.append("article_created_date = ? ");
            sql.append("where article_id = ?");

            pst = cn.prepareStatement( new String(sql) );

            //タイトルを変更
            if(map.containsKey("title")){
                pst.setString(1,(String)map.get("title"));
            }else{
                pst.setString(1,ab.getTitle());
            }

            //内容を変更
            if(map.containsKey("body")){
                pst.setString(2, (String)map.get("body"));
            }else{
                pst.setString(2,ab.getArticleBody());
            }

            pst.setString(3, (String)map.get("status"));

            pst.setString(4, (String)map.get("date"));

            pst.setInt(5, Integer.parseInt( (String)map.get("articleId") ) );


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
            sql.append("insert into ");
            sql.append("articles(fk_user_id, article_title, article_body, ");
            sql.append("article_created_date, article_status_flag) ");
            sql.append("values(?,?,?,?,?)");

            pst = cn.prepareStatement( new String(sql) );

            pst.setString(1, (String)map.get("userId"));
            pst.setString(2, (String)map.get("title"));
            pst.setString(3, (String)map.get("body"));
            pst.setString(4, (String)map.get("date"));
            pst.setString(5, (String)map.get("status"));

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
        PreparedStatement pst = null;
        List results = new ArrayList();
        try{
            Connection cn = null;
            cn = MySqlConnectionManager.getInstance().getConnection();
            StringBuffer sql = new StringBuffer();
            ResultSet rs = null;

            if( map.containsKey("archive") ){
                //月別アーカイブ用--------------------------------------------------------
                sql.append("select date_format(article_created_date, '%Y'), ");
                sql.append("date_format(article_created_date, '%m'), ");
                sql.append("count(*) ");
                sql.append("from articles ");
                sql.append("where fk_user_id = ? and article_status_flag=0 ");
                sql.append("group by date_format(article_created_date, '%Y%m') ");
                sql.append("order by article_created_date desc ");

                pst = cn.prepareStatement( new String(sql) );
                pst.setInt(1, Integer.parseInt( (String)map.get("userId") ));

                rs = pst.executeQuery();
                while( rs.next() ){
                    Map contents = new HashMap();
                    contents.put("year", rs.getString(1) );
                    contents.put("month", rs.getString(2) );
                    contents.put("count", rs.getString(3) );
                    results.add( contents );
                }
                //-----------------------------------------------------------------------
            }
            else{

                //記事一覧の取得----------------------------------------------------------------------
                sql.append("select article_id, article_title, article_body, ");
                sql.append("article_created_date, ");
                sql.append("fk_user_id, user_name, user_icon_path ");
                sql.append("from articles join users ");
                sql.append("on articles.fk_user_id = users.user_id ");
                sql.append("where fk_user_id = ? and article_status_flag = ? ");

                if(map.containsKey("where")){
                    sql.append((String)map.get("where"));
                }

                sql.append("order by article_created_date desc ");

                if(map.containsKey("option")){
                    sql.append((String)map.get("option"));
                }

                pst = cn.prepareStatement( new String(sql) );

                pst.setInt(1, Integer.parseInt( (String)map.get("userId") ));
                pst.setString(2, (String)map.get("flag") );

                rs = pst.executeQuery();

                while( rs.next() ){
                    ArticleBean ab = new ArticleBean();
                    ab.setArticleId( rs.getString(1) );
                    ab.setTitle( rs.getString(2) );
                    ab.setArticleBody( rs.getString(3) );
                    ab.setCreatedDate( rs.getString(4) );
                    ab.setUserId( rs.getString(5) );
                    ab.setUserName( rs.getString(6) );
                    ab.setIconPath( rs.getString(7) );


                    results.add(ab);
                }
                //-----------------------------------------------------------------------------------
            }

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

        return results;
    }

}
