package ttc.bean;
public class SecretQuestionBean implements Bean{
    private String questionBody;
    private String questionId;


	/**
	* Returns value of questionBody
	* @return
	*/
	public String getQuestionBody() {
		return questionBody;
	}

	/**
	* Sets new value of questionBody
	* @param
	*/
	public void setQuestionBody(String questionBody) {
		this.questionBody = questionBody;
	}

	/**
	* Returns value of questionId
	* @return
	*/
	public String getQuestionId() {
		return questionId;
	}

	/**
	* Sets new value of questionId
	* @param
	*/
	public void setQuestionId(String questionId) {
		this.questionId = questionId;
	}
}
