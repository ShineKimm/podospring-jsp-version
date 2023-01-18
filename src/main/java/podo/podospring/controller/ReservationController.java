package podo.podospring.controller;

import java.util.HashMap;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import podo.podospring.service.ReservationService;

//' Reservation API (method)
//        ' getCalendar 					: 달력 로드
//        ' getWaitCalendar 				: 대기예약 달력 로드
//        ' getTeeList						: 타임 리스트 로드
//        ' getWaitTeeList					: 타임 리스트 로드
//        ' doReservation					: 예약
//        ' doWaitReservation				: 대기예약
//        ' changeReservation				: 예약 변경
//        ' cancelReservation				: 예약 취소
//        ' cancelWaitReservation		    : 대기예약 취소
//        ' cancelPackage					: 패키지예약 취소
//        ' getReservationList			    : 예약 리스트 조회
//        ' getPackageDetail				: 패키지 상세 조회
//        ' doSearchPartner					: 동반자 조회
//        ' registPartner					: 동반자 등록
//        ' getRoomCharge					: 객실요금 조회
//        ' registPackage					: 패키지 예약
//        ' sendSms							: 패키지 취소 문자전송

@Controller
public class ReservationController {
    private ReservationService reservationService;
    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    @ResponseBody
    @RequestMapping("/getCalendar")
    public HashMap<String, Object> getCalendar(@RequestParam HashMap<String, Object> params) {

        HashMap<String, Object> result = reservationService.getCalendar(params);

        return result;
    }

    @ResponseBody
    @RequestMapping("/getTeeList")
    public HashMap<String, Object> getTeeList(@RequestParam HashMap<String, Object> params) {

        params.put("coDiv",params.get("coDiv"));
        params.put("sDate",params.get("date"));
        params.put("sCos",params.get("cos"));
        params.put("msNum",params.get("msNum"));

        params.put("sDivision","21");
        params.put("sClass","00");
        params.put("sLevel","00");

        HashMap<String, Object> result = reservationService.getTeeList(params);
        return result;
    }

    @ResponseBody
    @RequestMapping("/changeReservation")
    public HashMap<String, Object> changeReservation(@RequestParam HashMap<String, Object> params, HttpSession session) {


        params.put("coDiv",params.get("coDiv"));
        params.put("aDate",params.get("aday"));
        params.put("aCos",params.get("acos"));
        params.put("aTime",params.get("atime"));
        params.put("bDate",params.get("bDay"));
        params.put("bCos",params.get("bCos"));
        params.put("bTime",params.get("bTime"));
        params.put("sCharge",params.get("charge"));
        params.put("sMedia",params.get("media"));
        params.put("msNum",params.get("msNum"));
        String msName = (String)session.getAttribute("MS_NAME");
        params.put("msName",msName);
        params.put("phone",(String)session.getAttribute("MS_FIRST_PHONE1")+(String)session.getAttribute("MS_FIRST_PHONE1")+(String)session.getAttribute("MS_LAST_PHONE1"));
        params.put("ip",params.get("ip"));

        HashMap<String, Object> result = reservationService.changeReservation(params);


        return result;
    }

    @ResponseBody
    @RequestMapping("/doReservation")
    public HashMap<String, Object> doReservation(@RequestParam HashMap<String, Object> params)
            throws Exception {


        params.put("coDiv",params.get("coDiv"));
        params.put("sDate",params.get("day"));
        params.put("sCos",params.get("cos"));
        params.put("sTime",params.get("time"));
        params.put("sCharge",params.get("charge"));
        params.put("sMedia",params.get("media"));
        params.put("msNum",params.get("msNum"));
        params.put("ip",params.get("ip"));

        HashMap<String, Object> result = reservationService.doReservation(params);


        return result;
    }

    @ResponseBody
    @RequestMapping("/getReservationList")
    public HashMap<String, Object> getReservationList(@RequestParam HashMap<String, Object> params) {

        params.put("coDiv",params.get("coDiv"));
        params.put("msNum",params.get("msNum"));
        params.put("stDate",params.get("stDate"));
        params.put("edDate",params.get("fnDate"));

        HashMap<String, Object> result = reservationService.getReservationList(params);


        return result;
    }

    @ResponseBody
    @RequestMapping("/blDeleteReservation")
    public HashMap<String, Object> blDeleteReservation(@RequestParam HashMap<String, Object> params) {
        HashMap<String, Object> result = reservationService.blDeleteReservation(params);
        return result;
    }

    @ResponseBody
    @RequestMapping("/cancelReservation")
    public HashMap<String, Object> cancelReservation(@RequestParam HashMap<String, Object> params, HttpSession session) {
        params.put("coDiv",params.get("coDiv"));
        params.put("sDate",params.get("day"));
        params.put("sCos",params.get("cos"));
        params.put("sTime",params.get("time"));
        params.put("msNum",params.get("msNum"));
        params.put("msName",session.getAttribute("MS_NAME"));
        params.put("phone",(String)session.getAttribute("MS_FIRST_PHONE1") + session.getAttribute("MS_MID_PHONE1") + session.getAttribute("MS_LAST_PHONE1"));

        HashMap<String, Object> result = reservationService.cancelReservation(params);
        return result;
    }



}
