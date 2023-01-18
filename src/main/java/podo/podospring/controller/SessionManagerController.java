package podo.podospring.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import podo.podospring.service.SessionManagerService;

@Controller
public class SessionManagerController {

    private SessionManagerService sessionManagerService;

    public SessionManagerController(SessionManagerService sessionManagerService) {
        this.sessionManagerService = sessionManagerService;
    }


    @ResponseBody
    @RequestMapping("/sessionConfirm")
    public List<HashMap<String, Object>> sessionConfirm(HttpServletRequest request, @RequestParam HashMap<String, Object> params, Model model) {

        List <HashMap<String, Object>> resultList = new ArrayList<>();
        HttpSession session = request.getSession();
        String sessionId = session.getId();
        String resultCode = "9999";
        String resultMessage = "";
        params.put("MS_NUM",session.getAttribute("MS_NUM"));

        if (session.getAttribute("MS_NUM") != null) {
            // MS_NUM(회원아이디) 가 있으면 MS_SESSION_KEY 를 받아옴
            resultList = sessionManagerService.sessionConfirm(params);
            String MS_SESSION_KEY = (String) resultList.get(0).get("MS_SESSION_KEY");

            if (resultList == null) {
                session.invalidate();
                resultCode = "2000";
                resultMessage = "회원인증이 진행되어 로그아웃 되었습니다.";
            } else {
                if (MS_SESSION_KEY.equals(sessionId)) {
                    resultCode = "0000";
                } else {
                    session.invalidate();
                    resultCode = "2000";
                    resultMessage = "다른 사용자가 접속하여 로그아웃 되었습니다.";
                }
            }
        } else {
            resultCode = "1000";
            resultMessage = "로그아웃 상태입니다.";
        }
        model.addAttribute("resultCode",resultCode);
        model.addAttribute("resultMessage",resultMessage);

        return resultList;
    }
}
