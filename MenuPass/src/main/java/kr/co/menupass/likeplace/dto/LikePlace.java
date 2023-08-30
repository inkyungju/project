package kr.co.menupass.likeplace.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class LikePlace {
	private int index;
	private int likePlace_id;
	private int member_no;


	private String place_name;
	private String road_address_name;

	private String x;
	private String y;
	private String keyword;

	private String address_name;
	private String phone;

	
}
