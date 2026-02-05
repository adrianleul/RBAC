package com.rbac.system.service;

import com.rbac.common.core.domain.dto.LoginUser;
import com.rbac.system.domain.SysUserOnline;

public interface ISysUserOnlineService
{
    SysUserOnline selectOnlineByIpaddr(String ipaddr, LoginUser user);

    SysUserOnline selectOnlineByUserName(String userName, LoginUser user);

    SysUserOnline selectOnlineByInfo(String ipaddr, String userName, LoginUser user);

    SysUserOnline loginUserToUserOnline(LoginUser user);
}
