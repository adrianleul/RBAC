package com.rbac.system.service.impl;

import com.rbac.system.domain.SysNotice;
import com.rbac.system.domain.SysNoticeTarget;
import com.rbac.system.mapper.SysNoticeMapper;
import com.rbac.system.mapper.SysDeptMapper;
import com.rbac.system.service.ISysNoticeService;
import com.rbac.common.core.domain.entity.SysDept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.Set;

@Service
public class SysNoticeServiceImpl implements ISysNoticeService
{
    @Autowired
    private SysNoticeMapper noticeMapper;

    @Autowired
    private SysDeptMapper deptMapper;

    @Override
    public SysNotice selectNoticeById(Long noticeId)
    {
        return noticeMapper.selectNoticeById(noticeId);
    }

    @Override
    public List<SysNotice> selectNoticeList(SysNotice notice)
    {
        return noticeMapper.selectNoticeList(notice);
    }

    @Override
    public List<SysNotice> selectNoticesForUser(SysNotice notice, Long userId) {
        return noticeMapper.selectNoticesForUser(notice, userId);
    }

    @Override
    public void insertIfNotExists(Long noticeId, Long userId) {
        noticeMapper.insertIfNotExists(noticeId, userId);
    }

    @Override
    public boolean markSeen(Long noticeId, Long userId) {
        return noticeMapper.markSeen(noticeId, userId) > 0;
    }

    @Override
    public boolean isSeen(Long noticeId, Long userId) {
        Boolean seen = noticeMapper.isSeen(noticeId, userId);
        return seen != null && seen;
    }

    @Override
    @Transactional
    public int insertNotice(SysNotice notice)
    {
        // Step 1: Insert the notice and get the auto-generated noticeId
        int rows = noticeMapper.insertNotice(notice);
        Long noticeId = notice.getNoticeId(); // should now be set

        // Step 2: Expand department targets to include all descendant departments
        if (notice.getTargets() != null) {
            List<SysNoticeTarget> expandedTargets = new ArrayList<>();

            // Collect selected department IDs and expand with descendants
            Set<Long> deptIds = new LinkedHashSet<>();
            List<SysNoticeTarget> nonDeptTargets = new ArrayList<>();

            for (SysNoticeTarget target : notice.getTargets()) {
                if (target.getTargetDeptId() != null) {
                    deptIds.add(target.getTargetDeptId());
                } else {
                    nonDeptTargets.add(target);
                }
            }

            // For each selected department, add all descendants
            Set<Long> allDeptIds = new LinkedHashSet<>(deptIds);
            for (Long deptId : deptIds) {
                List<SysDept> children = deptMapper.selectChildrenDeptById(deptId);
                for (SysDept child : children) {
                    allDeptIds.add(child.getDeptId());
                }
            }

            // Build targets for all departments (selected + descendants)
            for (Long id : allDeptIds) {
                SysNoticeTarget deptTarget = new SysNoticeTarget();
                deptTarget.setNoticeId(noticeId);
                deptTarget.setTargetDeptId(id);
                expandedTargets.add(deptTarget);
            }

            // Add original non-dept targets (users/roles)
            for (SysNoticeTarget target : nonDeptTargets) {
                target.setNoticeId(noticeId);
                expandedTargets.add(target);
            }

            if (!expandedTargets.isEmpty()) {
                noticeMapper.insertNoticeTargets(expandedTargets);
            }
        }

        return rows;
    }

    @Override
    @Transactional
    public int updateNotice(SysNotice notice)
    {
        // 1. Update the notice
        int rows = noticeMapper.updateNotice(notice);

        // 2. Delete previous targets
        noticeMapper.deleteNoticeTargetsByNoticeId(notice.getNoticeId());

        // 3. Insert new targets if provided (expand departments to include descendants)
        if (notice.getTargets() != null && !notice.getTargets().isEmpty()) {
            List<SysNoticeTarget> expandedTargets = new ArrayList<>();

            Set<Long> deptIds = new LinkedHashSet<>();
            List<SysNoticeTarget> nonDeptTargets = new ArrayList<>();

            for (SysNoticeTarget target : notice.getTargets()) {
                if (target.getTargetDeptId() != null) {
                    deptIds.add(target.getTargetDeptId());
                } else {
                    nonDeptTargets.add(target);
                }
            }

            Set<Long> allDeptIds = new LinkedHashSet<>(deptIds);
            for (Long deptId : deptIds) {
                List<SysDept> children = deptMapper.selectChildrenDeptById(deptId);
                for (SysDept child : children) {
                    allDeptIds.add(child.getDeptId());
                }
            }

            for (Long id : allDeptIds) {
                SysNoticeTarget deptTarget = new SysNoticeTarget();
                deptTarget.setNoticeId(notice.getNoticeId());
                deptTarget.setTargetDeptId(id);
                expandedTargets.add(deptTarget);
            }

            for (SysNoticeTarget target : nonDeptTargets) {
                target.setNoticeId(notice.getNoticeId());
                expandedTargets.add(target);
            }

            noticeMapper.insertNoticeTargets(expandedTargets);
        }

        return rows;
    }

    @Override
    public int deleteNoticeById(Long noticeId)
    {
        return noticeMapper.deleteNoticeById(noticeId);
    }

    @Override
    public int deleteNoticeByIds(Long[] noticeIds)
    {
        return noticeMapper.deleteNoticeByIds(noticeIds);
    }
}
