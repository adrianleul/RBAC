package com.rbac.controller.system;

import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.rbac.common.constant.Constants;
import com.rbac.common.core.domain.AjaxResult;
import com.rbac.common.core.domain.entity.SysMenu;
import com.rbac.common.core.domain.entity.SysUser;
import com.rbac.common.core.domain.dto.LoginDto;
import com.rbac.common.core.domain.dto.LoginUser;
import com.rbac.common.utils.SecurityUtils;
import com.rbac.framework.web.service.SysLoginService;
import com.rbac.framework.web.service.SysPermissionService;
import com.rbac.framework.web.service.TokenService;
import com.rbac.system.service.ISysMenuService;
import com.rbac.system.service.ISysUserService;

@RestController
@RequestMapping("/auth")
public class SysLoginController
{
    @Autowired
    private SysLoginService loginService;

    @Autowired
    private ISysMenuService menuService;

    @Autowired
    private SysPermissionService permissionService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private ISysUserService userService;

    @PostMapping("/login")
    public AjaxResult login(@RequestBody LoginDto loginDto)
    {
        AjaxResult ajax = AjaxResult.success();
        String token = loginService.login(loginDto.getUsername(), loginDto.getPassword(), loginDto.getCode(),
                loginDto.getUuid());
        ajax.put(Constants.TOKEN, token);
        return ajax;
    }

    @GetMapping("/getInfo")
    public AjaxResult getInfo()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();

        // Always refresh the user entity to ensure latest roles/permissions
        SysUser refreshedUser = userService.selectUserByUserName(loginUser.getUser().getUserName());
        loginUser.setUser(refreshedUser);

        Set<String> roles = permissionService.getRolePermission(refreshedUser);
        Set<String> permissions = permissionService.getMenuPermission(refreshedUser);

        // Update cached permissions if changed
        if (loginUser.getPermissions() == null || !loginUser.getPermissions().equals(permissions)) {
            loginUser.setPermissions(permissions);
            tokenService.refreshToken(loginUser);
        }
        AjaxResult ajax = AjaxResult.success();
        ajax.put("user", refreshedUser);
        ajax.put("roles", roles);
        ajax.put("permissions", permissions);
        return ajax;
    }

    @GetMapping("/getRouters")
    public AjaxResult getRouters()
    {
        Long userId = SecurityUtils.getUserId();
        List<SysMenu> menus = menuService.selectMenuTreeByUserId(userId);
        return AjaxResult.success(menuService.buildMenus(menus));
    }
}
