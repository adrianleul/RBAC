package com.rbac.controller.system;

import com.rbac.common.annotation.Log;
import com.rbac.common.core.controller.BaseController;
import com.rbac.common.core.domain.AjaxResult;
import com.rbac.common.core.domain.entity.SysMenu;
import com.rbac.common.core.page.TableDataInfo;
import com.rbac.common.enums.RequestType;
import com.rbac.common.utils.SecurityUtils;
import com.rbac.system.domain.SysNotice;
import com.rbac.system.service.ISysNoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/system/notice")
public class SysNoticeController extends BaseController
{
    @Autowired
    private ISysNoticeService noticeService;

    @PreAuthorize("@ss.hasPermi('system:notice:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysNotice notice)
    {
        startPage();
        List<SysNotice> list = noticeService.selectNoticeList(notice);
        return getDataTable(list);
    }

    @GetMapping("/getUserNotice")
    public TableDataInfo listUserNotice(SysNotice notice)
    {
        startPage();
        Long userId = SecurityUtils.getUserId();
        List<SysNotice> list = noticeService.selectNoticesForUser(notice, userId);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('system:notice:query')")
    @GetMapping(value = "/{noticeId}")
    public AjaxResult getInfo(@PathVariable Long noticeId)
    {
        return success(noticeService.selectNoticeById(noticeId));
    }

    @PreAuthorize("@ss.hasPermi('system:notice:add')")
    @Log(title = "Notification Announcement", businessType = RequestType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysNotice notice)
    {
        notice.setCreateBy(getUsername());
        return toAjax(noticeService.insertNotice(notice));
    }

    @PreAuthorize("@ss.hasPermi('system:notice:edit')")
    @Log(title = "Notification Announcement", businessType = RequestType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysNotice notice)
    {
        notice.setUpdateBy(getUsername());
        return toAjax(noticeService.updateNotice(notice));
    }

    @PreAuthorize("@ss.hasPermi('system:notice:remove')")
    @Log(title = "Notification Announcement", businessType = RequestType.DELETE)
    @DeleteMapping("/{noticeIds}")
    public AjaxResult remove(@PathVariable Long[] noticeIds)
    {
        return toAjax(noticeService.deleteNoticeByIds(noticeIds));
    }

    @PostMapping("/mark-seen")
    public AjaxResult markSeen(@RequestBody Map<String, Long> body) {
        Long userId = SecurityUtils.getUserId();
        Long noticeId = body.get("noticeId");

        noticeService.insertIfNotExists(noticeId, userId); // ensure row exists
        boolean updated = noticeService.markSeen(noticeId, userId);

        return AjaxResult.success(updated ? "Marked as seen" : "Already seen");
    }

}
