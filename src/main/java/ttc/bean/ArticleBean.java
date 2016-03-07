package ttc.bean;

import java.util.List;

public class ArticleBean implements Bean{
    private String articleId;
    private String userId;
    private String title;
    private String articleBody;
    private String createdDate;
    private List tags;
    private List comments;
    private String userName;
    private String iconPath;
	private int commentCount;

	/**
	* Returns value of articleId
	* @return
	*/
	public String getArticleId() {
		return articleId;
	}

	/**
	* Sets new value of articleId
	* @param
	*/
	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	/**
	* Returns value of userId
	* @return
	*/
	public String getUserId() {
		return userId;
	}

	/**
	* Sets new value of userId
	* @param
	*/
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	* Returns value of title
	* @return
	*/
	public String getTitle() {
		return title;
	}

	/**
	* Sets new value of title
	* @param
	*/
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	* Returns value of articleBody
	* @return
	*/
	public String getArticleBody() {
		return articleBody;
	}

	/**
	* Sets new value of articleBody
	* @param
	*/
	public void setArticleBody(String articleBody) {
		this.articleBody = articleBody;
	}

	/**
	* Returns value of createdDate
	* @return
	*/
	public String getCreatedDate() {
		return createdDate;
	}

	/**
	* Sets new value of createdDate
	* @param
	*/
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	/**
	* Returns value of tags
	* @return
	*/
	public List getTags() {
		return tags;
	}

	/**
	* Sets new value of tags
	* @param
	*/
	public void setTags(List tags) {
		this.tags = tags;
	}

	/**
	* Returns value of comments
	* @return
	*/
	public List getComments() {
		return comments;
	}

	/**
	* Sets new value of comments
	* @param
	*/
	public void setComments(List comments) {
		this.comments = comments;
		setCommentCount(this.comments.size());
	}

	/**
	* Returns value of userName
	* @return
	*/
	public String getUserName() {
		return userName;
	}

	/**
	* Sets new value of userName
	* @param
	*/
	public void setUserName(String userName) {
		this.userName = userName;
	}

	/**
	* Returns value of iconPath
	* @return
	*/
	public String getIconPath() {
		return iconPath;
	}

	/**
	* Sets new value of iconPath
	* @param
	*/
	public void setIconPath(String iconPath) {
		this.iconPath = iconPath;
	}

	/**
	* Returns value of commentCount
	* @return
	*/
	public int getCommentCount() {
		return commentCount;
	}

	/**
	* Sets new value of commentCount
	* @param
	*/
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
}
