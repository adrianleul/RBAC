package com.rbac.system.domain;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class SysDashboard {

    private int onlineUsers;
    private int totalUsers;
    private int totalRoles;
    private int totalDepts;
    private int totalPosts;
    private int unseenNotices;
    private List<RoleCount> roleOverview = new ArrayList<>();
    private ServerStatus serverStatus;
    private List<ChartData> operationsChart = new ArrayList<>();
    private int totalOperationLogs;
    private int totalLoginLogs;
    private List<LogEntry> recentOperationLogs = new ArrayList<>();
    private List<LogEntry> recentLoginLogs = new ArrayList<>();

    public int getOnlineUsers() { return onlineUsers; }
    public void setOnlineUsers(int onlineUsers) { this.onlineUsers = onlineUsers; }
    public int getTotalUsers() { return totalUsers; }
    public void setTotalUsers(int totalUsers) { this.totalUsers = totalUsers; }
    public int getTotalRoles() { return totalRoles; }
    public void setTotalRoles(int totalRoles) { this.totalRoles = totalRoles; }
    public int getTotalDepts() { return totalDepts; }
    public void setTotalDepts(int totalDepts) { this.totalDepts = totalDepts; }
    public int getTotalPosts() { return totalPosts; }
    public void setTotalPosts(int totalPosts) { this.totalPosts = totalPosts; }
    public int getUnseenNotices() { return unseenNotices; }
    public void setUnseenNotices(int unseenNotices) { this.unseenNotices = unseenNotices; }
    public List<RoleCount> getRoleOverview() { return roleOverview; }
    public void setRoleOverview(List<RoleCount> roleOverview) { this.roleOverview = roleOverview; }
    public ServerStatus getServerStatus() { return serverStatus; }
    public void setServerStatus(ServerStatus serverStatus) { this.serverStatus = serverStatus; }
    public List<ChartData> getOperationsChart() { return operationsChart; }
    public void setOperationsChart(List<ChartData> operationsChart) { this.operationsChart = operationsChart; }
    public int getTotalOperationLogs() { return totalOperationLogs; }
    public void setTotalOperationLogs(int totalOperationLogs) { this.totalOperationLogs = totalOperationLogs; }
    public int getTotalLoginLogs() { return totalLoginLogs; }
    public void setTotalLoginLogs(int totalLoginLogs) { this.totalLoginLogs = totalLoginLogs; }
    public List<LogEntry> getRecentOperationLogs() { return recentOperationLogs; }
    public void setRecentOperationLogs(List<LogEntry> recentOperationLogs) { this.recentOperationLogs = recentOperationLogs; }
    public List<LogEntry> getRecentLoginLogs() { return recentLoginLogs; }
    public void setRecentLoginLogs(List<LogEntry> recentLoginLogs) { this.recentLoginLogs = recentLoginLogs; }

    public static class RoleCount {
        private String roleName;
        private int count;
        public RoleCount() {}
        public RoleCount(String roleName, int count) { this.roleName = roleName; this.count = count; }
        public String getRoleName() { return roleName; }
        public void setRoleName(String roleName) { this.roleName = roleName; }
        public int getCount() { return count; }
        public void setCount(int count) { this.count = count; }
    }

    public static class ChartData {
        private String label;
        private int value;
        public ChartData() {}
        public ChartData(String label, int value) { this.label = label; this.value = value; }
        public String getLabel() { return label; }
        public void setLabel(String label) { this.label = label; }
        public int getValue() { return value; }
        public void setValue(int value) { this.value = value; }
    }

    public static class ServerStatus {
        private double systemLoad;
        private long totalMemory;
        private long freeMemory;
        private long usedMemory;
        private long uptimeMillis;
        public double getSystemLoad() { return systemLoad; }
        public void setSystemLoad(double systemLoad) { this.systemLoad = systemLoad; }
        public long getTotalMemory() { return totalMemory; }
        public void setTotalMemory(long totalMemory) { this.totalMemory = totalMemory; }
        public long getFreeMemory() { return freeMemory; }
        public void setFreeMemory(long freeMemory) { this.freeMemory = freeMemory; }
        public long getUsedMemory() { return usedMemory; }
        public void setUsedMemory(long usedMemory) { this.usedMemory = usedMemory; }
        public long getUptimeMillis() { return uptimeMillis; }
        public void setUptimeMillis(long uptimeMillis) { this.uptimeMillis = uptimeMillis; }
    }

    public static class LogEntry {
        private Long id;
        private String title;
        private String userName;
        private String ip;
        private String status;
        private String message;
        private LocalDateTime time;
        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        public String getUserName() { return userName; }
        public void setUserName(String userName) { this.userName = userName; }
        public String getIp() { return ip; }
        public void setIp(String ip) { this.ip = ip; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
        public LocalDateTime getTime() { return time; }
        public void setTime(LocalDateTime time) { this.time = time; }
    }
}
