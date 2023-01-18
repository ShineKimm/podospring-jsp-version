package podo.podospring.controller;

import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import podo.podospring.service.CommonService;

@Controller
public class CommonController {
    private CommonService commonService;

    public CommonController(CommonService commonService) {
        this.commonService = commonService;
    }

    @ResponseBody
    @RequestMapping("/getCommonCode")
    public Map<String, Object> getCommonCode(@RequestParam HashMap<String, Object> params) {

        Map<String, Object> resultMap = commonService.getCommonCode(params);
        return resultMap;
    }

    @ResponseBody
    @RequestMapping("/deviceIdentification")
    public void deviceIdentification(@RequestParam HashMap<String, Object> params) {

        commonService.deviceIdentification(params);
    }
}
