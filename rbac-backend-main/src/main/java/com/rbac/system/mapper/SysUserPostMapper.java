package com.rbac.system.mapper;

import com.rbac.system.domain.SysUserPost;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SysUserPostMapper
{
    int deleteUserPostByUserId(Long userId);

    int countUserPostById(Long postId);

    int deleteUserPost(Long[] ids);

    int batchUserPost(List<SysUserPost> userPostList);
}
