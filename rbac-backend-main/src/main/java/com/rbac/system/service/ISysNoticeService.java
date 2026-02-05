package com.rbac.system.service;

import com.rbac.system.domain.SysNotice;

import java.util.List;


public interface ISysNoticeService
{
    SysNotice selectNoticeById(Long noticeId);

    List<SysNotice> selectNoticeList(SysNotice notice);
    List<SysNotice> selectNoticesForUser(SysNotice notice, Long userId);
    void insertIfNotExists(Long noticeId, Long userId);
    boolean markSeen(Long noticeId, Long userId);
    boolean isSeen(Long noticeId, Long userId);

    int insertNotice(SysNotice notice);
    int updateNotice(SysNotice notice);

    int deleteNoticeById(Long noticeId);
    
    int deleteNoticeByIds(Long[] noticeIds);
}
