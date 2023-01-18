package podo.podospring.controller;

import java.util.HashMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MenuController {

    @GetMapping("/")
    public String indexPage() {
        return "index";
    }
    @GetMapping("/index")
    public String index() {
        return "/index";
    }
    @GetMapping("/member/login")
    public String login() {
        return "/member/login";
    }
    @GetMapping("/member/modify")
    public String modify() {
        return "/member/modify";
    }
    @RequestMapping("/member/join01")
    public String join01() {
        return "/member/join01";
    }
    @RequestMapping("/member/join02")
    public String join02() {
        return "/member/join02";
    }
    @RequestMapping("/member/join03")
    public String join03() {
        return "/member/join03";
    }
    @PostMapping("/member/join03")
    public String postJoin03(@RequestParam HashMap<String, Object> param, Model model) {
        model.addAttribute("param",param);
        return "/member/join03";
    }
    @RequestMapping("/member/join04")
    public String join04() {
        return "/member/join04";
    }

    @GetMapping("/board/list")
    public String boardList() {
        return "/board/list";
    }
    @GetMapping("/board/event")
    public String boardEvent() {
        return "/board/event";
    }
    @GetMapping("/board/honor")
    public String boardHonor() {
        return "/board/honor";
    }
    @GetMapping("/board/score")
    public String boardScore() {
        return "/board/score";
    }
    @GetMapping("/board/view")
    public String boardView() {
        return "/board/view";
    }
    @GetMapping("/board/write")
    public String boardWrite() {
        return "/board/write";
    }

    @GetMapping("/guide/reserGuide")
    public String reserGuide() {
        return "/guide/reserGuide";
    }
    @GetMapping("/guide/fee")
    public String fee() {
        return "/guide/fee";
    }
    @GetMapping("/guide/break")
    public String break_1() {
        return "/guide/break";
    }
    @GetMapping("/guide/etiquette")
    public String etiquette() {
        return "/guide/etiquette";
    }
    @GetMapping("/guide/inquiry")
    public String inquiry() {
        return "/guide/inquiry";
    }
    @GetMapping("/club/intro")
    public String intro() {
        return "/club/intro";
    }
    @GetMapping("/club/greeting")
    public String greeting() {
        return "/club/greeting";
    }
    @GetMapping("/course/intro")
    public String courseIntro() {
        return "/course/intro";
    }
    @GetMapping("/fac/fac01")
    public String fac01() {
        return "/fac/fac01";
    }
    @GetMapping("/fac/fac02")
    public String fac02() {
        return "/fac/fac02";
    }
    @GetMapping("/fac/fac03")
    public String fac03() {
        return "/fac/fac03";
    }
    @GetMapping("/fac/fac04")
    public String fac04() {
        return "/fac/fac04";
    }

//  admin
    @GetMapping("/admin/member/login")
    public String adminLogin() {
        return "/admin/member/login";
    }
    @GetMapping("/admin/index")
    public String adminIndex() {
        return "/admin/index";
    }
    @GetMapping("/admin")
    public String adminIndex_1() {
        return "/admin/index";
    }

    @GetMapping("/admin/board/list")
    public String adminList() {
        return "/admin/board/list";
    }
    @GetMapping("/admin/board/write")
    public String adminBoardWrite() {
        return "/admin/board/write";
    }
    @GetMapping("/admin/board/view")
    public String adminBoardView() {
        return "/admin/board/view";
    }
    @GetMapping("/admin/contents/message")
    public String adminContentsMessage() {
        return "/admin/contents/message";
    }


    @GetMapping("/member/clause")
    public String memberClause() {
        return "/member/clause";
    }
    @GetMapping("/member/email")
    public String memberEmail() {
        return "/member/email";
    }
    @GetMapping("/member/policy")
    public String memberPolicy() {
        return "/member/policy";
    }
    @RequestMapping("/reservation/reservation")
    public String reservation(@RequestParam HashMap<String, Object> params, Model model) {
        String BK_DAY = (String)params.get("BK_DAY");
        model.addAttribute("BK_DAY",BK_DAY);
        return "/reservation/reservation";
    }
    @GetMapping("/reservation/joinWrite")
    public String reservationJoinWrite() {
        return "/reservation/joinWrite";
    }
    @GetMapping("/reservation/View")
    public String reservationView() {
        return "/reservation/View";
    }
    @GetMapping("/reservation/joinList")
    public String reservationJoinList() {
        return "/reservation/joinList";
    }
    @GetMapping("/reservation/joinCal")
    public String reservationJoinCal() {
        return "/reservation/joinCal";
    }
    @GetMapping("/reservation/joinView")
    public String reservationJoinView() {
        return "/reservation/joinView";
    }

    @GetMapping("/reservation/reserCheck")
    public String reservationReserCheck() {
        return "/reservation/reserCheck";
    }

////////////////////////////////////////////

    // mobile page
    @GetMapping("/mobile/index")
    public String mobileIndex() {
        return "/mobile/index";
    }

    @GetMapping("/mobile/club/intro")
    public String mobileIntro() {
        return "/mobile/club/intro";
    }
    @GetMapping("/mobile/club/greeting")
    public String mobileClubGreeting() {
        return "/mobile/club/greeting";
    }
    @GetMapping("/mobile/club/location")
    public String mobileClubLocation() {
        return "/mobile/club/location";
    }
    @GetMapping("/mobile/guide/guide")
    public String mobileGuide() {
        return "/mobile/guide/guide";
    }
    @GetMapping("/mobile/guide/fee")
    public String mobileGuideFee() {
        return "/mobile/guide/fee";
    }
    @GetMapping("/mobile/guide/penalty")
    public String mobileGuidePenalty() {
        return "/mobile/guide/penalty";
    }
    @GetMapping("/mobile/guide/etiquette")
    public String mobileGuideEtiquette() {
        return "/mobile/guide/etiquette";
    }
    @GetMapping("/mobile/guide/etc")
    public String mobileGuideEtc() {
        return "/mobile/guide/etc";
    }
    @GetMapping("/mobile/course/intro")
    public String mobileCourseIntro() {
        return "/mobile/course/intro";
    }

    @GetMapping("/mobile/facil/clubhouse")
    public String mobileFacilClubhouse() {
        return "/mobile/facil/clubhouse";
    }
    @GetMapping("/mobile/facil/restaurant")
    public String mobileFacilRestaurant() {
        return "/mobile/facil/restaurant";
    }
    @GetMapping("/mobile/facil/proshop")
    public String mobileFacilProshop() {
        return "/mobile/facil/proshop";
    }
    @GetMapping("/mobile/facil/changing")
    public String mobileFacilChanging() {
        return "/mobile/facil/changing";
    }
    @GetMapping("/mobile/board/list")
    public String mobileBoardList() {
        return "/mobile/board/list";
    }
    @GetMapping("/mobile/board/event")
    public String mobileBoardEvent() {
        return "/mobile/board/event";
    }
    @GetMapping("/mobile/board/score")
    public String mobileBoardScore() {
        return "/mobile/board/score";
    }
    @GetMapping("/mobile/board/view")
    public String mobileBoardView() {
        return "/mobile/board/view";
    }
    @GetMapping("/mobile/board/write")
    public String mobileBoardWrite() {
        return "/mobile/board/write";
    }
    @GetMapping("/mobile/board/honor")
    public String mobileBoardHonor() {
        return "mobile/board/honor";
    }
    @GetMapping("/mobile/board/joinList")
    public String mobileBoardJoinList() {
        return "/mobile/board/joinList";
    }
    @RequestMapping("/mobile/reservation/reservation")
    public String mobileReservation(@RequestParam HashMap<String, Object> params, Model model) {
        String BK_DAY = (String)params.get("BK_DAY");
        model.addAttribute("BK_DAY",BK_DAY);
        return "/mobile/reservation/reservation";
    }
    @GetMapping("/club/location")
    public String clubLocation() {
        return "/club/location";
    }
    @GetMapping("/member/find")
    public String memberFind() {
        return "/member/find";
    }
    @GetMapping("/mobile/member/login")
    public String mobileMemberLogin() {
        return "/mobile/member/login";
    }
    @GetMapping("/mobile/member/join01")
    public String mobileMemberJoin01() {
        return "/mobile/member/join01";
    }
    @GetMapping("/mobile/reservation/reserCheck")
    public String mobileReservationReserCheck() {
        return "/mobile/reservation/reserCheck";
    }
    @GetMapping("/mobile/board/joinWrite")
    public String mobileBoardJoinWrite() {
        return "/mobile/board/joinWrite";
    }
    @GetMapping("/mobile/board/joinView")
    public String mobileBoardJoinView() {
        return "/mobile/board/joinView";
    }


}
