package com.rbac.system.service.impl;

import com.rbac.system.domain.SysDashboard;
import com.rbac.system.mapper.SysDashboardMapper;
import com.rbac.system.service.ISysDashboardService;
import com.rbac.common.core.redis.RedisCache;
import com.rbac.common.constant.CacheConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.management.ManagementFactory;
import java.lang.management.OperatingSystemMXBean;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Map;

@Service
public class SysDashboardServiceImpl implements ISysDashboardService {

    private final SysDashboardMapper dashboardMapper;
    @Autowired
    private RedisCache redisCache;

    @Autowired
    public SysDashboardServiceImpl(SysDashboardMapper dashboardMapper) {
        this.dashboardMapper = dashboardMapper;
    }

    @Override
    public SysDashboard selectDashboard() {
        SysDashboard ds = new SysDashboard();

        // Online users: count active login tokens in Redis (same as /monitor/online/list)
        java.util.Collection<String> keys = redisCache.keys(CacheConstants.LOGIN_TOKEN_KEY + "*");
        ds.setOnlineUsers(keys == null ? 0 : keys.size());
        ds.setTotalUsers(safeInt(dashboardMapper.selectTotalUsers()));
        ds.setTotalRoles(safeInt(dashboardMapper.selectTotalRoles()));
        ds.setTotalDepts(safeInt(dashboardMapper.selectTotalDepts()));
        ds.setTotalPosts(safeInt(dashboardMapper.selectTotalPosts()));
        ds.setUnseenNotices(safeInt(dashboardMapper.selectUnseenNotices()));

        List<Map<String, Object>> roleOverview = dashboardMapper.selectRoleOverview();
        for (Map<String, Object> m : roleOverview) {
            Object rn = m.get("role_name");
            Object cnt = m.get("cnt");
            if (rn == null) rn = m.get("ROLE_NAME");
            if (cnt == null) cnt = m.get("CNT");
            String roleName = rn == null ? "" : rn.toString();
            int count = safeInt(cnt);
            ds.getRoleOverview().add(new SysDashboard.RoleCount(roleName, count));
        }

        List<Map<String, Object>> ops = dashboardMapper.selectOperationChart();
        for (Map<String, Object> m : ops) {
            Object labelObj = m.get("label");
            Object cnt = m.get("cnt");
            String label = labelObj == null ? "" : labelObj.toString();
            int value = safeInt(cnt);
            ds.getOperationsChart().add(new SysDashboard.ChartData(label, value));
        }

        ds.setTotalOperationLogs(safeInt(dashboardMapper.selectTotalOperationLogs()));
        ds.setTotalLoginLogs(safeInt(dashboardMapper.selectTotalLoginLogs()));

        List<Map<String, Object>> recentOps = dashboardMapper.selectRecentOperationLogs();
        for (Map<String, Object> m : recentOps) {
            SysDashboard.LogEntry e = new SysDashboard.LogEntry();
            e.setId(asLong(m.get("oper_id"), m.get("operId")));
            e.setTitle(getString(m, "title"));
            e.setUserName(getString(m, "oper_name"));
            e.setIp(getString(m, "oper_ip"));
            e.setStatus(getString(m, "status"));
            Object t = m.get("oper_time");
            if (t != null) {
                e.setTime(convertToLocalDateTime(t));
            }
            ds.getRecentOperationLogs().add(e);
        }

        List<Map<String, Object>> recentLogins = dashboardMapper.selectRecentLoginLogs();
        for (Map<String, Object> m : recentLogins) {
            SysDashboard.LogEntry e = new SysDashboard.LogEntry();
            e.setId(asLong(m.get("info_id"), m.get("infoId")));
            e.setUserName(getString(m, "user_name"));
            e.setIp(getString(m, "ipaddr"));
            e.setStatus(getString(m, "status"));
            e.setMessage(getString(m, "msg"));
            Object t = m.get("login_time");
            if (t != null) {
                e.setTime(convertToLocalDateTime(t));
            }
            ds.getRecentLoginLogs().add(e);
        }

        // server status
        SysDashboard.ServerStatus ss = new SysDashboard.ServerStatus();
        try {
            OperatingSystemMXBean os = ManagementFactory.getOperatingSystemMXBean();
            double load = os.getSystemLoadAverage();
            ss.setSystemLoad(load);
        } catch (Throwable ignored) {}
        Runtime rt = Runtime.getRuntime();
        long totalMem = rt.totalMemory();
        long freeMem = rt.freeMemory();
        ss.setTotalMemory(totalMem);
        ss.setFreeMemory(freeMem);
        ss.setUsedMemory(totalMem - freeMem);
        ss.setUptimeMillis(ManagementFactory.getRuntimeMXBean().getUptime());
        ds.setServerStatus(ss);

        return ds;
    }

    private int safeInt(Object o) {
        if (o == null) return 0;
        if (o instanceof Number) return ((Number) o).intValue();
        try { return Integer.parseInt(o.toString()); } catch (Exception e) { return 0; }
    }

    private long asLong(Object... candidates) {
        for (Object o : candidates) {
            if (o == null) continue;
            if (o instanceof Number) return ((Number) o).longValue();
            try { return Long.parseLong(o.toString()); } catch (Exception ignored) {}
        }
        return 0L;
    }

    private String getString(Map<String, Object> m, String key) {
        Object v = m.get(key);
        if (v == null) return null;
        return v.toString();
    }

    private LocalDateTime convertToLocalDateTime(Object t) {
        if (t instanceof java.time.LocalDateTime) return (LocalDateTime) t;
        if (t instanceof java.sql.Timestamp) return ((java.sql.Timestamp) t).toLocalDateTime();
        if (t instanceof java.util.Date) return LocalDateTime.ofInstant(((java.util.Date) t).toInstant(), ZoneId.systemDefault());
        try {
            return LocalDateTime.parse(t.toString());
        } catch (Exception e) {
            return null;
        }
    }
}
