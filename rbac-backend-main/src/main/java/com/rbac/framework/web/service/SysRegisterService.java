package com.rbac.framework.web.service;

import com.rbac.common.constant.CacheConstants;
import com.rbac.common.constant.Constants;
import com.rbac.common.constant.UserConstants;
import com.rbac.common.core.domain.entity.SysUser;
import com.rbac.common.core.domain.dto.RegisterDto;
import com.rbac.common.core.redis.RedisCache;
import com.rbac.common.exception.user.CaptchaException;
import com.rbac.common.exception.user.CaptchaExpireException;
import com.rbac.common.utils.MessageUtils;
import com.rbac.common.utils.SecurityUtils;
import com.rbac.common.utils.StringUtils;
import com.rbac.framework.manager.AsyncManager;
import com.rbac.framework.manager.factory.AsyncFactory;
import com.rbac.system.service.ISysConfigService;
import com.rbac.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SysRegisterService
{
    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysConfigService configService;

    @Autowired
    private RedisCache redisCache;

    public String register(RegisterDto registerBody)
    {
        String msg = "", username = registerBody.getUsername(), password = registerBody.getPassword();
        SysUser sysUser = new SysUser();
        sysUser.setUserName(username);

        boolean captchaEnabled = configService.selectCaptchaEnabled();
        if (captchaEnabled)
        {
            validateCaptcha(username, registerBody.getCode(), registerBody.getUuid());
        }

        if (StringUtils.isEmpty(username)) {
            msg = "Username cannot be empty";
        } else if (StringUtils.isEmpty(password)) {
            msg = "User password cannot be empty";
        } else if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH) {
            msg = "Account length must be between 2 and 20 characters";
        } else if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH) {
            msg = "Password length must be between 5 and 20 characters";
        } else if (!userService.checkUserNameUnique(sysUser)) {
            msg = "Saving user '" + username + "' failed. The registration account already exists";
        }
        else
        {
            sysUser.setNickName(username);
            sysUser.setPassword(SecurityUtils.encryptPassword(password));
            boolean regFlag = userService.registerUser(sysUser);
            if (!regFlag)
            {
                msg = "Registration failed. Please contact the system administrator.";
            }
            else
            {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.REGISTER, MessageUtils.message("user.register.success")));
            }
        }
        return msg;
    }

    public void validateCaptcha(String username, String code, String uuid)
    {
        String verifyKey = CacheConstants.CAPTCHA_CODE_KEY + StringUtils.nvl(uuid, "");
        String captcha = redisCache.getCacheObject(verifyKey);
        redisCache.deleteObject(verifyKey);
        if (captcha == null)
        {
            throw new CaptchaExpireException();
        }
        if (!code.equalsIgnoreCase(captcha))
        {
            throw new CaptchaException();
        }
    }
}
