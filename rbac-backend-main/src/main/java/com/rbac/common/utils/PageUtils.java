package com.rbac.common.utils;

import com.github.pagehelper.PageHelper;
import com.rbac.common.core.page.PageDomain;
import com.rbac.common.core.page.TableSupport;
import com.rbac.common.utils.sql.SqlUtil;

public class PageUtils extends PageHelper
{
    public static void startPage()
    {
        PageDomain pageDomain = TableSupport.buildPageRequest();
        Integer pageNum = pageDomain.getPageNum();
        Integer pageSize = pageDomain.getPageSize();
        String orderBy = SqlUtil.escapeOrderBySql(pageDomain.getOrderBy());
        Boolean reasonable = pageDomain.getReasonable();
        PageHelper.startPage(pageNum, pageSize, orderBy).setReasonable(reasonable);
    }

    public static void clearPage()
    {
        PageHelper.clearPage();
    }
}
