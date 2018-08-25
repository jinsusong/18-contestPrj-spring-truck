package poly.dto.consumer;

public class CONSUMER_RcmmndMenuDTO {
	private String ft_seq;	//푸드트럭 번호
	private String ft_name;	//푸드트럭 이름
	private String file_path; //메뉴 이미지 경로
	private String menu_name; //메뉴 이름
	private String menu_intro; //메뉴 소개
	private String RevScore; // 푸드트럭 점수 (리뷰갯수 X 평균 평점)
	
	public String getFt_seq() {
		return ft_seq;
	}
	public void setFt_seq(String ft_seq) {
		this.ft_seq = ft_seq;
	}
	public String getFt_name() {
		return ft_name;
	}
	public void setFt_name(String ft_name) {
		this.ft_name = ft_name;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getMenu_intro() {
		return menu_intro;
	}
	public void setMenu_intro(String menu_intro) {
		this.menu_intro = menu_intro;
	}
	public String getRevScore() {
		return RevScore;
	}
	public void setRevScore(String revScore) {
		RevScore = revScore;
	}
	
	
}
