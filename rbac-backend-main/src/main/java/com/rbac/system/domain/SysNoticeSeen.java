package com.rbac.system.domain;

import java.time.LocalDateTime;

public class SysNoticeSeen {
    private Long noticeId;
    private Long userId;
    private Boolean seen;
    private LocalDateTime seenAt;

    public Long getNoticeId() {
        return noticeId;
    }

    public Long getUserId() {
        return userId;
    }

    public Boolean getSeen() {
        return seen;
    }

    public LocalDateTime getSeenAt() {
        return seenAt;
    }

    public void setNoticeId(Long noticeId) {
        this.noticeId = noticeId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setSeen(Boolean seen) {
        this.seen = seen;
    }

    public void setSeenAt(LocalDateTime seenAt) {
        this.seenAt = seenAt;
    }
}
