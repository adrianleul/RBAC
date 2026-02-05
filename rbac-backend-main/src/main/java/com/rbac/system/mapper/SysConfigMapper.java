package com.rbac.system.mapper;

import com.rbac.system.domain.SysConfig;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SysConfigMapper
{
    SysConfig selectConfig(SysConfig config);
    SysConfig selectConfigById(Long configId);
    List<SysConfig> selectConfigList(SysConfig config);
    SysConfig checkConfigKeyUnique(String configKey);
    int insertConfig(SysConfig config);
    int updateConfig(SysConfig config);
    int deleteConfigById(Long configId);
    int deleteConfigByIds(Long[] configIds);
}