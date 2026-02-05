package com.rbac.system.mapper;

import com.rbac.common.core.domain.entity.SysDictType;

import java.util.List;

public interface SysDictTypeMapper
{
    List<SysDictType> selectDictTypeList(SysDictType dictType);

    List<SysDictType> selectDictTypeAll();

    SysDictType selectDictTypeById(Long dictId);

    SysDictType selectDictTypeByType(String dictType);

    int deleteDictTypeById(Long dictId);

    int deleteDictTypeByIds(Long[] dictIds);

    int insertDictType(SysDictType dictType);

    int updateDictType(SysDictType dictType);

    SysDictType checkDictTypeUnique(String dictType);
}
