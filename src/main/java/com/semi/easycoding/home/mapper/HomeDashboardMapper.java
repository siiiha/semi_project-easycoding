package com.semi.easycoding.home.mapper;

import com.semi.easycoding.home.dto.GrassCellDto;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.semi.easycoding.home.dto.LearningStatsDto;
import com.semi.easycoding.home.dto.TodayProgressDto;

@Mapper
public interface HomeDashboardMapper {

    List<GrassCellDto> selectGrassCells(
            @Param("memberId") Long memberId
    );

    LearningStatsDto selectLearningStats(
            @Param("memberId") Long memberId
    );

    TodayProgressDto selectTodayProgress(
            @Param("memberId") Long memberId
    );
}