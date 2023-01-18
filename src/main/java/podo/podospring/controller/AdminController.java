package podo.podospring.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import podo.podospring.service.AdminService;

@Controller
public class AdminController {

    private AdminService adminService;

    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }
    @RequestMapping("/adminDoLogin")
    @ResponseBody
    public Map<String, Object> adminDoLogin(@RequestParam HashMap<String, Object> params, HttpSession session) {
        Map<String, Object> result = adminService.adminDoLogin(params,session);
        return result;
    }
    @RequestMapping("/getMainData")
    @ResponseBody
    public HashMap<String, Object> getMainData(@RequestParam HashMap<String, Object> params) {
        HashMap<String, Object> result = adminService.getMainData(params);
        return result;
    }
    @RequestMapping("/getMessage")
    @ResponseBody
    public HashMap<String, Object> getMessage(@RequestParam HashMap<String, Object> params) {
        HashMap<String, Object> result = adminService.getMessage(params);
        return result;
    }

    @RequestMapping("/adminDoLogout")
    @ResponseBody
    public HashMap<String, Object> adminDoLogout(@RequestParam HashMap<String, Object> params, HttpSession session) {
        session.invalidate();
        params.put("resultCode","0000");
        return params;
    }
}
