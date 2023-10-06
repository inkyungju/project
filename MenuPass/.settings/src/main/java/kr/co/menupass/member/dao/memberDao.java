package kr.co.menupass.member.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.co.menupass.member.dto.memberDto;

@Repository

public class memberDao {
	public memberDto loginMember(SqlSessionTemplate sqlSession, memberDto au) {

		return sqlSession.selectOne("memberMapper.login", au);
	}

	public static int singup(SqlSessionTemplate sqlSession, memberDto member) {

		return sqlSession.insert("memberMapper.singup", member);

	}

	public static memberDto updatein(SqlSessionTemplate sqlSession, int idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.updatein", idx);
	}

	public static int updateout(SqlSessionTemplate sqlSession, memberDto member) {
		// TODO Auto-generated method stub
		return sqlSession.update("memberMapper.updateout", member);
	}

	public static int memberEmail(SqlSessionTemplate sqlSession, String email) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.memberEmail", email);
	}
}
