package com.rbac.controller.system;

import com.rbac.common.core.controller.BaseController;
import com.rbac.common.core.domain.AjaxResult;
import com.rbac.common.enums.RequestType;
import com.rbac.system.domain.SysDashboard;
import com.rbac.system.service.ISysDashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/system/dashboard")
public class SysDashboardController extends BaseController {

	@Autowired
	private ISysDashboardService dashboardService;

	@PreAuthorize("@ss.hasPermi('admin:dashboard:list')")
	@GetMapping
	public AjaxResult overview() {
		SysDashboard data = dashboardService.selectDashboard();
		return AjaxResult.success(data);
	}
}

