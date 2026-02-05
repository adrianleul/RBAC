package com.rbac.system.mapper;

import com.rbac.system.domain.SysRoleDept;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SysRoleDeptMapper
{
    int deleteRoleDeptByRoleId(Long roleId);

    int deleteRoleDept(Long[] ids);

    int selectCountRoleDeptByDeptId(Long deptId);

    int batchRoleDept(List<SysRoleDept> roleDeptList);
}
