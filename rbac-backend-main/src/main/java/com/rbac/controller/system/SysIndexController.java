package com.rbac.controller.system;

import com.rbac.common.config.rbacConfig;
import com.rbac.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SysIndexController
{
    @Autowired
    private rbacConfig npiConfig;

    @RequestMapping("/")
    public String index()
    {
        return StringUtils.format("Welcome to the {} backend management framework. Current version: v{}. Please access it via the frontend address.", npiConfig.getName(), npiConfig.getVersion());    }
}
