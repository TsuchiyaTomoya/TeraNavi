package ttc.dao;

import java.text.SimpleDateFormat;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ttc.bean.UserBean;
import ttc.bean.Bean;
import ttc.exception.integration.IntegrationException;
import ttc.util.MySqlConnectionManager;

import ttc.exception.integration.AddressDuplicationException;
import ttc.exception.integration.UserUnregisteredException;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

public class UsersDao implements AbstractDao {

	PreparedStatement pst = null;
	Connection cn = null;
	ResultSet rs = null;

	public List readAll(Map map) throws IntegrationException {
		List list = new ArrayList();
		try {
			cn = MySqlConnectionManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();

			sql.append("select * from users ");

			if (map.containsKey("join")) {
				sql.append((String) map.get("join"));
			}

			sql.append("where user_status_flag=?");

			if (map.containsKey("where")) {
				sql.append((String) map.get("where"));
			}
			sql.append(" and not(user_status_flag=3)");
			pst = cn.prepareStatement(new String(sql));

			pst.setString(1, (String) map.get("userStatus"));

			if (map.containsKey("value")) {
				pst.setString(2, (String) map.get("value"));
			}

			rs = pst.executeQuery();
			while (rs.next()) {
				UserBean ub = new UserBean();

				ub.setId(rs.getString(1));
				ub.setLoginId(rs.getString(2));
				ub.setUserName(rs.getString(3));
				ub.setNameKana(rs.getString(4));
				ub.setSex(rs.getString(5));
				ub.setSexVisibleFlag(rs.getString(6));
				ub.setMailAddress(rs.getString(8));
				ub.setPassword(rs.getString(9));
				// あとでなおしてね
				// ub.setQuestion(rs.getString(10));
				ub.setSecretAnswer(rs.getString(11));
				ub.setHeaderPath(rs.getString(12));
				ub.setIconPath(rs.getString(13));
				// あとでなおしてね
				// ub.setTitle(rs.getString(14));
				// ub.setHeadPhotoPath(rs.getString(15));
				ub.setAdminFlag(rs.getString(16));
				ub.setLastLoginDate(rs.getString(17));
				ub.setAdminLastLoginDate(rs.getString(18));
				ub.setUserStatus(rs.getString(19));
				ub.setLockEndDate(rs.getString(20));
				ub.setLockStartDate(rs.getString(21));
				// ub.setBlogExplanation(rs.getString(22));
				ub.setProfile(rs.getString(23));
				list.add(ub);
			}
			MySqlConnectionManager.getInstance().commit();
		} catch (SQLException e) {
			throw new IntegrationException(e.getMessage(), e);
		} finally {
			try {
				if (pst != null) {
					pst.close();
				}
			} catch (SQLException e) {
				throw new IntegrationException(e.getMessage(), e);
			}
		}
		return list;
	}

	public int update(Map map) throws IntegrationException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		int result = 0;
		try {
			UserBean ub = (UserBean) map.get("userbean");
			Connection cn = MySqlConnectionManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("update users set user_name=?,user_name_kana=?,sex_visible_flag=?,");
			sql.append("mail_address=?,password=?,user_header_path=?,user_icon_path=?,");
			sql.append("last_login_date=?,user_status_flag=?,user_lock_start_date=?,user_lock_end_date=?,");
			sql.append("user_profile=? where user_id=?");
			pst = cn.prepareStatement(new String(sql));

			//ユーザーの名前を変更
			if (map.containsKey("userName")) {
				pst.setString(1, (String) map.get("userName"));
			} else {
				pst.setString(1, ub.getUserName());
			}
			//ユーザーの名前（カナ）を変更
			if (map.containsKey("userNameKana")) {
				pst.setString(2, (String) map.get("userNameKana"));
			} else {
				pst.setString(2, ub.getNameKana());
			}
			//性別の表示設定を変更
			if (map.containsKey("SexVisibleFlag")) {
				pst.setString(3, (String) map.get("SexVisibleFlag"));
			} else {
				pst.setString(3, ub.getSexVisibleFlag());
			}
			//メールアドレスの変更
			if (map.containsKey("mailAddress")) {
				pst.setString(4, (String) map.get("mailAddress"));
			} else {
				pst.setString(4, ub.getMailAddress());
			}
			//パスワードの変更
			if (map.containsKey("password")) {
				pst.setString(5, (String) map.get("password"));
			} else {
				pst.setString(5, ub.getPassword());
			}
			//ユーザーのヘッダー画像のパスを変更
			if (map.containsKey("headerPath")) {
				pst.setString(6, (String) map.get("headerPath"));
			} else {
				pst.setString(6, ub.getHeaderPath());
			}
			//ユーザーのアイコン画像パスを変更
			if (map.containsKey("iconPath")) {
				pst.setString(7, (String) map.get("iconPath"));
			} else {
				pst.setString(7, ub.getIconPath());
			}
			//ユーザーが最後にログインした日を変更
			if (map.containsKey("lastLoginDate")) {
				pst.setString(8, (String) map.get("lastLoginDate"));
			} else {
				pst.setString(8, ub.getLastLoginDate());
			}
			//ユーザーステータスを変更
			if (map.containsKey("userStatus")) {
				pst.setString(9, (String) map.get("userStatus"));
			} else {
				pst.setString(9, ub.getUserStatus());
			}
			//ユーザのロック開始の日にちを変更
			if (map.containsKey("lockStartDate")) {
				pst.setString(10, (String) map.get("lockStartDate"));
			} else {
				pst.setString(10, ub.getLockStartDate());
			}
			//ユーザのロック終了日を変更
			if (map.containsKey("lockEndDate")) {
				pst.setString(11, (String) map.get("lockEndDate"));
			} else {
				pst.setString(11, (String) ub.getLockEndDate());
			}
			//ユーザの自己紹介を変更
			if (map.containsKey("profile")) {
				pst.setString(12, (String) map.get("profile"));
			} else {
				pst.setString(12, ub.getProfile());
			}

			pst.setInt(13, Integer.parseInt((String) map.get("userId")));

			result = pst.executeUpdate();

		} catch (SQLException e) {
			MySqlConnectionManager.getInstance().rollback();
			throw new IntegrationException(e.getMessage(), e);
		} finally {
			try {
				if (pst != null) {
					pst.close();
				}
			} catch (SQLException e) {
				throw new IntegrationException(e.getMessage(), e);
			}
		}

		return result;

	}

	public int insert(Map map) throws IntegrationException {
		int count = 0;
		try {
			cn = MySqlConnectionManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("insert into users(login_id,user_name,");
			sql.append("user_name_kana,sex,sex_visible_flag,");
			sql.append("mail_address,password,fk_secret_question_id,secret_answer,admin_flag,user_status_flag) ");
			sql.append("values(?,?,?,?,?,?,?,?,?,?,'0')");
			pst = cn.prepareStatement(new String(sql));

			pst.setString(1, (String) map.get("loginId"));
			pst.setString(2, (String) map.get("userName"));
			pst.setString(3, (String) map.get("nameKana"));
			pst.setString(4, (String) map.get("sex"));
			pst.setString(5, (String) map.get("sexVisibleFlag"));
			pst.setString(6, (String) map.get("mailAddress"));
			pst.setString(7, (String) map.get("password"));
			pst.setString(8, (String) map.get("quepstionId"));
			pst.setString(9, (String) map.get("secretAnswer"));
			pst.setString(10, (String) map.get("adminFlag"));

			count = pst.executeUpdate();

		} catch (MySQLIntegrityConstraintViolationException e) {
			throw new AddressDuplicationException(e.getMessage(), e);
		} catch (SQLException e) {
			MySqlConnectionManager.getInstance().rollback();
			throw new IntegrationException(e.getMessage(), e);
		} finally {
			try {
				if (pst != null) {
					pst.close();
				}
			} catch (SQLException e) {
				throw new IntegrationException(e.getMessage(), e);
			}
		}
		return count;
	}

	public Bean read(Map map) throws IntegrationException {
		UserBean ub = new UserBean();
		PreparedStatement pst = null;
		try {
			Connection cn = null;
			cn = MySqlConnectionManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select user_id,login_id,user_name,user_name_kana,sex,sex_visible_flag");
			sql.append(",mail_address,password,user_header_path,user_icon_path,admin_flag,last_login_date,");
			sql.append("admin_last_login_date,user_status_flag,user_lock_end_date,user_lock_start_date,");
			sql.append("fk_secret_question_id,user_profile,secret_answer,community_members_list.community_admin_flag");
			sql.append(",users.blog_status_flag from users left outer join community_members_list ");
			sql.append("on users.user_id=community_members_list.fk_user_id ");
			sql.append((String) map.get("where"));
			sql.append("and not(user_status_flag=3)");
			pst = cn.prepareStatement(new String(sql));

			pst.setString(1, (String) map.get("value"));

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {

				ub.setId(rs.getString("user_id"));
				ub.setLoginId(rs.getString("login_id"));
				ub.setUserName(rs.getString("user_name"));
				ub.setNameKana(rs.getString("user_name_kana"));
				ub.setSex(rs.getString("sex"));
				ub.setSexVisibleFlag(rs.getString("sex_visible_flag"));
				ub.setMailAddress(rs.getString("mail_address"));
				ub.setPassword(rs.getString("password"));
				ub.setHeaderPath(rs.getString("user_header_path"));
				ub.setIconPath(rs.getString("user_icon_path"));
				ub.setAdminFlag(rs.getString("admin_flag"));
				ub.setLastLoginDate(rs.getString("last_login_date"));
				ub.setAdminLastLoginDate(rs.getString("admin_last_login_date"));
				ub.setUserStatus(rs.getString("user_status_flag"));
				ub.setLockEndDate(rs.getString("user_lock_end_date"));
				ub.setLockStartDate(rs.getString("user_lock_start_date"));
				ub.setQuestionNo(rs.getString("fk_secret_question_id"));
				ub.setProfile(rs.getString("user_profile"));
				ub.setSecretAnswer(rs.getString("secret_answer"));
				ub.setCommunityAdminFlag(rs.getString("community_admin_flag"));
				ub.setBlogStatus(rs.getString("blog_status_flag"));
			} else {
				throw new UserUnregisteredException("登録されていません", null);
			};

		} catch (SQLException e) {
			throw new IntegrationException(e.getMessage(), e);
		} finally {
			try {
				if (pst != null) {
					pst.close();
				}
			} catch (SQLException e) {
				throw new IntegrationException(e.getMessage(), e);
			}
		}
		return ub;
	}

}
