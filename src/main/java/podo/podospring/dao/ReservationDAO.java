package podo.podospring.dao;

import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import podo.podospring.common.dao.AbstractDAO;
import podo.podospring.common.ReturnException;

@Repository
public class ReservationDAO extends AbstractDAO {

    @SuppressWarnings("unchecked")
    public HashMap<String, Object> getCalendar(HashMap<String, Object> params) {

        String nowDate = (String)selectOne("reservation.nowDate",params);

        HashMap<String, Object> resultMap = (HashMap<String, Object>)selectOne("reservation.getCalendarQuery1",params);
        params.put("minDay",resultMap.get("MINDAY"));
        params.put("maxDay",resultMap.get("MAXDAY"));

        List<HashMap<String, Object>> resultList = selectList("reservation.getCalendarQuery2",params);
        resultMap.put("rows",resultList);
        resultMap.put("date",nowDate);
        resultMap.put("resultCode","0000");

        return resultMap;
    }

    @SuppressWarnings("unchecked")
    public HashMap<String, Object> getTeeList(HashMap<String, Object> params) {
        List<HashMap<String, Object>> resultList = selectList("reservation.getTeeQuery1",params);
        params.put("rows",resultList);
        int monthWeek = selectCnt("reservation.getTeeQuery2",params);
        params.put("monthWeek",monthWeek);

        HashMap<String, Object> weekCntMap = (HashMap<String, Object>)selectOne("reservation.getTeeQuery3",params);
        params.put("weekDayCnt",weekCntMap.get("WEEK_DAY_CNT"));
        params.put("weekEndCnt",weekCntMap.get("WEEK_END_CNT"));

        params.put("resultCode","0000");



        return params;
    }

    @SuppressWarnings("unchecked")
    @Transactional(rollbackFor = {Exception.class})
    public HashMap<String, Object> changeReservation(HashMap<String, Object> params)
            throws ReturnException {
        try {
            int bkCnt = selectCnt("reservation.changeReservation1", params);
            if (bkCnt > 0) {
                params.put("M","M");
                params.put("HOMEPAGE","HOMEPAGE");
                selectOne("reservation.changeReservation2", params);
                params.put("sResult", params.get("RESULT"));
                Object sResult = params.get("sResult");
                if (sResult.equals("0000")) {
                    //TODO 문자발송
                    //SP_SMS_SEND coDiv, "10001", phone, "", bDate, bCos, bTime, msName, msNum, "", "", "HOMEPAGE", ip, aDate, aCos, aTime
                    params.put("resultCode", "0000");
                } else {
                    params.put("resultCode", params.get("sResult"));
                    if (params.get("resultCode").equals("2000")) {
                        params.put("resultMessage", "이미 다른 회원이 예약한 타임입니다. 다른 시간을 이용해 주세요.");
                    } else if (params.get("resultCode").equals("3000")) {
                        params.put("resultMessage", "위약이 걸려있어 예약이 불가능합니다.");
                    } else if (params.get("resultCode").equals("4000")) {
                        params.put("resultMessage", "내장처리 된 예약입니다. 예약 변경 불가합니다.");
                    } else {
                        params.put("resultMessage", "예약이 실패하였습니다. 다시 시도해 주세요.");
                    }
                    throw new Exception();
                }
            } else {
                params.put("resultMessage", "등록된 예약이 없습니다.");
                throw new Exception();
            }
        } catch (Exception e) {
            throw new ReturnException(params,"실행중 에러가 발생");
        }
        return params;
    }

    @SuppressWarnings("unchecked")
    @Transactional(rollbackFor = {Exception.class})
    public HashMap<String, Object> doReservation(HashMap<String, Object> params) throws Exception{

        HashMap<String, Object> resultMap = (HashMap<String, Object>)selectOne("reservation.reservationQuery1",params);
        params.forEach((key, value) -> resultMap.merge(key, value, (v1, v2) -> v2));
        System.out.println(resultMap);
        try{
            resultMap.put("msName",resultMap.get("MS_NAME"));
            resultMap.put("msDivision",resultMap.get("MS_DIVISION"));
            resultMap.put("msClass",resultMap.get("MS_CLASS"));
            resultMap.put("msLevel",resultMap.get("MS_LEVEL"));
            resultMap.put("phone",resultMap.get("MS_PHONE1"));
            resultMap.put("msPhone1",resultMap.get("MS_FIRST_PHONE1"));
            resultMap.put("msPhone2",resultMap.get("MS_MID_PHONE1"));
            resultMap.put("msPhone3",resultMap.get("MS_LAST_PHONE1"));

            resultMap.put("sResult","0000");
            resultMap.put("marketCd","002");
            resultMap.put("businessCd","001");

            int vCount1 = selectCnt( "reservation.vCount1",resultMap);
            if (vCount1 >= 1) {
                resultMap.put("sResult","2000");
            }
            int vCount2 = selectCnt( "reservation.vCount2",resultMap);
            if (vCount2 >= 1) {
                resultMap.put("sResult","3000");
            }
            int vCount3 = selectCnt( "reservation.vCount3",resultMap);
            if (resultMap.get("MS_DIVISION").equals("21")) {
                if (vCount3 >= 2) {
                    resultMap.put("sResult","5000");
                }
            }
            update("reservation.reservationQuery2",resultMap);
            int vCount4 = selectCnt( "reservation.vCount4",resultMap);
            if (vCount4 == 0) {
                resultMap.put("sResult","2000");
            }
            int bkSeq = selectCnt( "reservation.bkSeq",resultMap);
            resultMap.put("bkSeq",bkSeq);

            insert("reservation.reservationQuery3",resultMap);

            if (resultMap.get("sResult").equals("0000")) {
    //          TODO 예약됐을경우 SMS 문자 발송
    //            SP_SMS_SEND coDiv, "10000", phone, "", sDate, sCos, sTime, msName, msNum, "", "", "HOMEPAGE", ip, "", "", ""
                resultMap.put("resultCode", "0000");
            } else {
                resultMap.put("resultCode", resultMap.get("sResult"));
                //TODO 해당일자 예약건(sResult 1000) (sResult 4000)처리 로직이 없음
                if (resultMap.get("sResult").equals("1000")) {
                    resultMap.put("resultMessage", "해당일자에 이미 예약건이 있습니다.");
                } else if (resultMap.get("sResult").equals("2000")) {
                    resultMap.put("resultMessage", "이미 다른 회원이 예약한 타임입니다. 다른 시간을 이용해 주세요.");
                } else if (resultMap.get("sResult").equals("3000")) {
                    resultMap.put("resultMessage", "위약이 걸려있어 예약이 불가능합니다.");
                } else if (resultMap.get("sResult").equals("4000")) {
                    resultMap.put("resultMessage", "해당 월 예약횟수를 모두 사용하였습니다.");
                } else if (resultMap.get("sResult").equals("5000")) {
                    resultMap.put("resultMessage", "해당 일 예약횟수를 모두 사용하였습니다.");
                } else {
                    resultMap.put("resultMessage", "예약이 실패하였습니다. 다시 시도해 주세요.");
                }
                throw new Exception();
            }
        } catch(Exception e) {
            throw new ReturnException(resultMap,"실행중 에러가 발생");
        }

        return resultMap;
    }

    @SuppressWarnings("unchecked")
    public HashMap<String, Object> getReservationList(HashMap<String, Object> params) {
        List<HashMap<String, Object>> getReservationList = selectList("reservation.getReservationList",params);
        params.put("rows",getReservationList);

        params.put("resultCode","0000");
        params.put("resultMessage","");

        return params;
    }

    @SuppressWarnings("unchecked")
    public HashMap<String, Object> blDeleteReservation(HashMap<String, Object> params) {
        return params;
    }

    @SuppressWarnings("unchecked")
    @Transactional(rollbackFor = {Exception.class})
    public HashMap<String, Object> cancelReservation(HashMap<String, Object> params)
            throws ReturnException {

        HashMap<String, Object> resultMap = (HashMap<String, Object>)selectOne("reservation.cancelReservationQuery1",params);
        params.forEach((key, value) -> resultMap.merge(key, value, (v1, v2) -> v2));

        try{
            resultMap.put("msName",resultMap.get("MS_NAME"));
            resultMap.put("phone",resultMap.get("MS_PHONE1"));

            int diff = selectCnt("reservation.cancelReservationQuery2",resultMap);
            resultMap.put("cancelYn","Y");
            if (diff < 5) {
                resultMap.put("cancelYn","N");
            }
            LocalTime now = LocalTime.now();
            int hour = now.getHour();
            if (diff == 5 && hour <17) {
                resultMap.put("cancelYn","Y");
            }

            if (resultMap.get("cancelYn").equals("N")) {
                resultMap.put("resultCode", "2000");
                resultMap.put("resultMessage", "위약기간에 해당되어 예약취소가 불가능합니다.");
            } else {
                resultMap.put("RESULT","");
                selectOne("reservation.cancelReservationQuery3",resultMap);
                if (resultMap.get("RESULT").equals("0000")) {
                    // TODO 문자발송
                    // SP_SMS_SEND coDiv, "10002", phone, "", sDate, sCos, sTime, msName, msNum, "", "", "HOMEPAGE", ip, "", "", ""
                    resultMap.put("resultCode", "0000");
                } else {
                    resultMap.put("resultCode", (String)resultMap.get("RESULT"));

                    if (resultMap.get("resultCode").equals("1000")) {
                        resultMap.put("resultMessage", "내장처리 된 예약입니다. 예약 취소 불가합니다.");
                    } else {
                        resultMap.put("resultMessage", "예약취소 실패하였습니다. 다시 시도해 주세요.");
                    }
                    throw new Exception();
                }
            }
        } catch(Exception e) {
            throw new ReturnException(resultMap,"실행중 에러가 발생");
        }
        return resultMap;
    }
}
