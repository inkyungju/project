package kr.co.menupass.likeplace.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.menupass.likeplace.dao.LikePlaceDao;
import kr.co.menupass.likeplace.dto.LikePlace;

@Service
public class LikePlaceServiceImpl implements LikePlaceService {

    private final LikePlaceDao likePlaceDao;

    @Autowired
    public LikePlaceServiceImpl(LikePlaceDao likePlaceDao) {
        this.likePlaceDao = likePlaceDao;
    }

    @Override
    public int addLikedPlace(LikePlace likePlace) {
        return likePlaceDao.addLikedPlace(likePlace);
    }

    @Override
    public int removeLikedPlace(LikePlace likePlace) {
        return likePlaceDao.removeLikedPlace(likePlace);
    }

    @Override
    public boolean isLikedPlace(LikePlace likePlace) {
        // LikePlaceDao의 isLikedPlace 메서드를 호출하여 장소가 이미 찜되어 있는지 확인
        return likePlaceDao.isLikedPlace(likePlace);
    }
    
    @Override
    public List<LikePlace> getLikedPlacesByUser(LikePlace likePlace) {
        // data를 기반으로 사용자의 찜한 장소 목록을 DB에서 가져옵니다.
        return likePlaceDao.getLikedPlacesByUser(likePlace);
    }

}
