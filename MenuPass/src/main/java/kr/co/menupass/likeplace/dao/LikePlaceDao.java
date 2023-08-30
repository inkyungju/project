package kr.co.menupass.likeplace.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.menupass.likeplace.dto.LikePlace;

@Repository
public class LikePlaceDao {
 
    private final SqlSession sqlSession;

    @Autowired
    public LikePlaceDao(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }


    // 특정 장소가 이미 찜되었는지 확인하는 메서드
    public boolean isLikedPlace(LikePlace likePlace) {
        int count = sqlSession.selectOne("LikePlaceMapper.countLikedPlace", likePlace);
        return count > 0;
    }

    // 장소를 찜목록에 추가하는 메서드
    public int addLikedPlace(LikePlace likePlace) {
    	
 
        return sqlSession.insert("LikePlaceMapper.addLikedPlace", likePlace);
    }

    // 찜목록에서 장소를 제거하는 메서드
    public int removeLikedPlace(LikePlace likePlace) {
        return sqlSession.delete("LikePlaceMapper.removeLikedPlace", likePlace);
    }
    

    public List<LikePlace> getLikedPlacesByUser(LikePlace likePlace) {
        // data를 기반으로 사용자의 찜한 장소 목록을 DB에서 가져옵니다.
        return sqlSession.selectList("LikePlaceMapper.getLikedPlacesByUser", likePlace);
    }

    // 필요에 따라 추가적인 메서드를 정의할 수 있습니다.

}
