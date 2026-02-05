package com.rbac.system.mapper;

import com.rbac.system.domain.SysRoleMenu;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SysRoleMenuMapper
{
    int checkMenuExistRole(Long menuId);

    int deleteRoleMenuByRoleId(Long roleId);

    int deleteRoleMenu(Long[] ids);

    int batchRoleMenu(List<SysRoleMenu> roleMenuList);
}
