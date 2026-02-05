package com.rbac.system.service;

import com.rbac.system.domain.SysLogininfor;

import java.util.List;

public interface ISysLogininforService
{
    void insertLogininfor(SysLogininfor logininfor);

    List<SysLogininfor> selectLogininforList(SysLogininfor logininfor);

    int deleteLogininforByIds(Long[] infoIds);

    void cleanLogininfor();
}
