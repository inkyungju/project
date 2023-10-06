package kr.co.menupass.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.menupass.member.dao.memberDao;
import kr.co.menupass.member.dto.memberDto;

@Service
public class memberService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private memberDao memberdao;

	public memberDto loginMember(memberDto member) {
		return memberdao.loginMember(sqlSession, member);
	}
	// 회원가입

	public int signupmember(memberDto member) {
		return memberDao.singup(sqlSession, member);
	}

	public memberDto updatein(int idx) {
		// TODO Auto-generated method stub
		return memberDao.updatein(sqlSession, idx);
	}

	public int updateMemberInfo(memberDto member) {
		// TODO Auto-generated method stub
		return memberDao.updateout(sqlSession, member);

	}

	public int memberEmail(String email) {
		// TODO Auto-generated method stub
		return memberDao.memberEmail(sqlSession, email);
	}

}
