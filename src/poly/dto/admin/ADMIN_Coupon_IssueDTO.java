package poly.dto.admin;

public class ADMIN_Coupon_IssueDTO {
	private int issue_code;
	private int user_seq;
	private String coupon_code;
	private int coupon_count;
	private String coupon_issuedate;
	private int coupon_use;
	
	public int getIssue_code() {
		return issue_code;
	}
	public void setIssue_code(int issue_code) {
		this.issue_code = issue_code;
	}
	public int getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(int user_seq) {
		this.user_seq = user_seq;
	}
	public String getCoupon_code() {
		return coupon_code;
	}
	public void setCoupon_code(String coupon_code) {
		this.coupon_code = coupon_code;
	}
	public int getCoupon_count() {
		return coupon_count;
	}
	public void setCoupon_count(int coupon_count) {
		this.coupon_count = coupon_count;
	}
	public String getCoupon_issuedate() {
		return coupon_issuedate;
	}
	public void setCoupon_issuedate(String coupon_issuedate) {
		this.coupon_issuedate = coupon_issuedate;
	}
	public int getCoupon_use() {
		return coupon_use;
	}
	public void setCoupon_use(int coupon_use) {
		this.coupon_use = coupon_use;
	}
}
