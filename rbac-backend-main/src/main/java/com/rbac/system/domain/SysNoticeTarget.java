package com.rbac.system.domain;

import com.rbac.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class SysNoticeTarget extends BaseEntity {
    private static final long serialVersionUID = 1L;
    private Long targetId;
    private Long noticeId;
    private Long targetUserId;
    private Long targetDeptId;
    private Long targetRoleId;

    public Long getTargetId() {
        return targetId;
    }

    public Long getNoticeId() {
        return noticeId;
    }

    public Long getTargetUserId() {
        return targetUserId;
    }

    public Long getTargetDeptId() {
        return targetDeptId;
    }

    public Long getTargetRoleId() {
        return targetRoleId;
    }

    public void setTargetId(Long targetId) {
        this.targetId = targetId;
    }

    public void setNoticeId(Long noticeId) {
        this.noticeId = noticeId;
    }

    public void setTargetUserId(Long targetUserId) {
        this.targetUserId = targetUserId;
    }

    public void setTargetDeptId(Long targetDeptId) {
        this.targetDeptId = targetDeptId;
    }

    public void setTargetRoleId(Long targetRoleId) {
        this.targetRoleId = targetRoleId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("targetId", getTargetId())
                .append("noticeId", getNoticeId())
                .append("targetUserId", getTargetUserId())
                .append("targetDeptId", getTargetDeptId())
                .append("targetRoleId", getTargetRoleId())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .append("remark", getRemark())
                .toString();
    }
}
