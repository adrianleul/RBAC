package com.rbac.system.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface SysDashboardMapper {

    int selectOnlineUsers();

    int selectTotalUsers();

    int selectTotalRoles();

    int selectTotalDepts();

    int selectTotalPosts();

    int selectUnseenNotices();

    List<Map<String, Object>> selectRoleOverview();

    List<Map<String, Object>> selectOperationChart();

    int selectTotalOperationLogs();

    int selectTotalLoginLogs();

    List<Map<String, Object>> selectRecentOperationLogs();

    List<Map<String, Object>> selectRecentLoginLogs();
}
