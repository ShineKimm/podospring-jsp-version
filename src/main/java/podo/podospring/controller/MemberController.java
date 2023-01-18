package podo.podospring.controller;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import podo.podospring.service.MemberService;

//' Member API (method)
//        ' doLogin 			  : 로그인
//        ' doLogout			  : 로그아웃
//        ' chkDuplicateId  : 아이디 중복체크
//        ' doSignUp 			  : 회원 가입
//        ' doUpdateMemeber : 회원 정보 수정
//        ' doFindId				: 아이디 찾기
//        ' doFindPw				: 비밀번호 찾기
//        ' doDeleteMemeber : 회원 탈퇴
//        ' doCertification : 인증번호 전송
//        ' getVisitList		: 내장내역 조회
//        ' getScoreList		: 스코어정보 조회
//        ' getCouponList		: 쿠폰조회

@Controller
public class MemberController {
    private MemberService memberService;


    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;

    }

    @ResponseBody
    @RequestMapping("/doLogin")
    public Map<String, Object> doLogin(@RequestParam HashMap<String, Object> params, HttpSession session)
            throws NoSuchAlgorithmException {

        //System.out.println("session.getId() = " + session.getId());
        params.put("sessionID", session.getId());
        Map<String, Object> resultMap = memberService.doLogin(params);

        return resultMap;
    }

    @ResponseBody
    @RequestMapping("/doLogout")
    public Map<String, Object> doLogout(@RequestParam HashMap<String, Object> params, HttpSession session) {

        session.invalidate();
        params.put("resultCode","0000");

        return params;
    }

    @ResponseBody
    @RequestMapping("/chkDuplicateId")
    public Map<String, Object> chkDuplicateId(@RequestParam HashMap<String, Object> params) {

        Map<String, Object> resultMap = memberService.chkDuplicateId(params);
        return resultMap;
    }

    @ResponseBody
    @RequestMapping("/doCertification")
    public Map<String, Object> doCertification(@RequestParam HashMap<String, Object> params) {

        Map<String, Object> resultMap = memberService.doCertification(params);
        return resultMap;
    }

    @ResponseBody
    @RequestMapping("/doSignUp")
    public Map<String, Object> doSignUp(@RequestParam HashMap<String, Object> params) {

        params.put("coDiv",params.get("coDiv"));
        params.put("name",params.get("name"));
        params.put("id",params.get("id"));
        params.put("pw",params.get("pw"));
        params.put("birth",params.get("birth"));
        params.put("birthYL",params.get("chkBirth"));
        params.put("sex",params.get("sex"));
        params.put("area",params.get("homeAddress1"));
        params.put("phone1",params.get("phone1"));
        params.put("phone2",params.get("phone2"));
        params.put("phone3",params.get("phone3"));
        params.put("mkt1",params.get("mkt1"));
        params.put("mkt2",params.get("mkt2"));
        params.put("mkt3",params.get("mkt3"));
        params.put("sms",params.get("sms"));
        params.put("email",params.get("email"));
        params.put("chkMail",params.get("chkMail"));

        if (params.get("chkMail").equals("") || params.get("chkMail").equals("undefined")) {
            params.put("chkMail","N");
        }
        if (params.get("sms").equals("N")) {
            params.put("mkt1","N");
            params.put("mkt2","N");
            params.put("mkt3","N");
        } else if (params.get("sms").equals("Y")) {
            params.put("mkt1","Y");
            params.put("mkt2","Y");
            params.put("mkt3","Y");
        }

        Map<String, Object> resultMap = memberService.doSignUp(params);
        return resultMap;
    }

    @Transactional(rollbackFor = {Exception.class})
    @ResponseBody
    @RequestMapping("/doUpdateMemeber")
    public Map<String, Object> doUpdateMemeber(@RequestParam HashMap<String, Object> params,HttpSession session) {
        params.put("coDiv",params.get("coDiv"));
        params.put("pw",params.get("pw"));
        params.put("birth",params.get("birth"));
        params.put("birthYL",params.get("chkBirth"));
        params.put("sex",params.get("sex"));
        params.put("area",params.get("homeAddress1"));
        params.put("phone1",params.get("phone1"));
        params.put("phone2",params.get("phone2"));
        params.put("phone3",params.get("phone3"));
        params.put("sms",params.get("sms"));
        params.put("email",params.get("email"));
        params.put("chkMail",params.get("chkMail"));
        params.put("ip",params.get("ip"));
        String ms_num = (String)session.getAttribute("MS_NUM");
        params.put("ms_num",ms_num);

        if (params.get("chkMail").equals("") || params.get("chkMail").equals("undefined") || params.get("chkMail") == null) {
            params.put("chkMail","N");
        }
        if (params.get("sms").equals("N")) {
            params.put("mkt1","N");
            params.put("mkt2","N");
            params.put("mkt3","N");
        } else if (params.get("sms").equals("Y")) {
            params.put("mkt1","Y");
            params.put("mkt2","Y");
            params.put("mkt3","Y");
        }
        Map<String, Object> resultMap = memberService.doUpdateMemeber(params);
        session.setAttribute("MS_MAIN_CODIV",resultMap.get("coDiv"));
        session.setAttribute("MS_SEX",resultMap.get("sex"));
        session.setAttribute("SMS_CHK1",resultMap.get("sms"));
        session.setAttribute("MS_FIRST_PHONE1",resultMap.get("phone1"));
        session.setAttribute("MS_MID_PHONE1",resultMap.get("phone2"));
        session.setAttribute("MS_LAST_PHONE1",resultMap.get("phone3"));
        session.setAttribute("MS_BIRTH",resultMap.get("birth"));
        session.setAttribute("MS_EMAIL_YN",resultMap.get("chkMail"));
        session.setAttribute("MS_EMAIL",resultMap.get("email"));
        session.setAttribute("INPUT_IP",resultMap.get("ip"));
        session.setAttribute("MS_BIRTHYL",resultMap.get("birthYL"));
        session.setAttribute("MS_AREA",resultMap.get("area"));
        session.setAttribute("MS_NUM",resultMap.get("ms_num"));

        resultMap.put("resultCode","0000");
        return resultMap;
    }
    @ResponseBody
    @RequestMapping("/doDeleteMemeber")
    public Map<String, Object> doDeleteMemeber(@RequestParam HashMap<String, Object> params,HttpSession session) {
        params.put("coDiv",params.get("coDiv"));
        params.put("MS_NUM",session.getAttribute("MS_NUM"));

        Map<String, Object> resultMap = memberService.doDeleteMemeber(params);
        return resultMap;
    }
    @ResponseBody
    @RequestMapping("/doFindId")
    public Map<String, Object> doFindId(@RequestParam HashMap<String, Object> params) {
        params.put("coDiv",params.get("coDiv"));
        params.put("name",params.get("name"));
        params.put("phone",params.get("phone"));

        Map<String, Object> resultMap = memberService.doFindId(params);
        return resultMap;
    }
    @ResponseBody
    @RequestMapping("/doFindPw")
    public Map<String, Object> doFindPw(@RequestParam HashMap<String, Object> params,HttpSession session) {
        params.put("coDiv",params.get("coDiv"));
        params.put("name",params.get("name"));
        params.put("id",params.get("id"));

        Map<String, Object> resultMap = memberService.doFindPw(params);
        return resultMap;
    }
}
