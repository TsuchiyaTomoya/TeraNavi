package ttc.bean;

import java.util.List;

public class CommunityBean implements Bean{
    private String id;
    private String name;
    private String profile;
    private String iconPath;
    private String headerPath;
    private String createdDate;
    private String deleteFlag;
    private int countMember;
    private List members;
    private List topics;
    private String createUserId;
	private String adminFlag;



    /**
    * Returns value of id
    * @return
    */
    public String getId() {
    	return id;
    }

    /**
    * Sets new value of id
    * @param
    */
    public void setId(String id) {
    	this.id = id;
    }

    /**
    * Returns value of name
    * @return
    */
    public String getName() {
    	return name;
    }

    /**
    * Sets new value of name
    * @param
    */
    public void setName(String name) {
    	this.name = name;
    }

    /**
    * Returns value of profile
    * @return
    */
    public String getProfile() {
    	return profile;
    }

    /**
    * Sets new value of profile
    * @param
    */
    public void setProfile(String profile) {
    	this.profile = profile;
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
    * Returns value of headerPath
    * @return
    */
    public String getHeaderPath() {
    	return headerPath;
    }

    /**
    * Sets new value of headerPath
    * @param
    */
    public void setHeaderPath(String headerPath) {
    	this.headerPath = headerPath;
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
    * Returns value of deleteFlag
    * @return
    */
    public String getDeleteFlag() {
    	return deleteFlag;
    }

    /**
    * Sets new value of deleteFlag
    * @param
    */
    public void setDeleteFlag(String deleteFlag) {
    	this.deleteFlag = deleteFlag;
    }

    /**
    * Returns value of members
    * @return
    */
    public List getMembers() {
    	return members;
    }

    /**
    * Sets new value of members
    * @param
    */
    public void setMembers(List members) {
    	this.members = members;
    }

    /**
    * Returns value of topics
    * @return
    */
    public List getTopics() {
    	return topics;
    }

    /**
    * Sets new value of topics
    * @param
    */
    public void setTopics(List topics) {
    	this.topics = topics;
    }

    public void setCountMember(int count){
        this.countMember=count;
    }
    public int getCountMember(){
        return countMember;
    }

    public void setCreateUserId(String userId){
        createUserId = userId;
    }

    public String getCreateUserId(){
        return createUserId;
    }

	/**
	 * @return the adminFlag
	 */
	public String getAdminFlag() {
		return adminFlag;
	}

	/**
	 * @param adminFlag the adminFlag to set
	 */
	public void setAdminFlag(String adminFlag) {
		this.adminFlag = adminFlag;
	}

}
