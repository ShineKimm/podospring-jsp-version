package podo.podospring.service;

import java.util.HashMap;
import org.springframework.stereotype.Service;
import podo.podospring.common.ReturnException;
import podo.podospring.dao.ReservationDAO;

@Service
public class ReservationService {
    ReservationDAO reservationDAO;

    public ReservationService(ReservationDAO reservationDAO) {
        this.reservationDAO = reservationDAO;
    }

    public HashMap<String, Object> getCalendar(HashMap<String, Object> params) {
        return reservationDAO.getCalendar(params);
    }

    public HashMap<String, Object> getTeeList(HashMap<String, Object> params) {
        return reservationDAO.getTeeList(params);
    }

    public HashMap<String, Object> changeReservation(HashMap<String, Object> params) {
        try {
            return reservationDAO.changeReservation(params);
        } catch (ReturnException e) {
            HashMap<String, Object> resultMap = (HashMap<String, Object>)e.getValue();
            return resultMap;
        }
    }

    public HashMap<String, Object> doReservation(HashMap<String, Object> params) throws Exception {
        try {
            return reservationDAO.doReservation(params);
        } catch (ReturnException e) {
            HashMap<String, Object> resultMap = (HashMap<String, Object>)e.getValue();
            return resultMap;
        }
    }

    public HashMap<String, Object> getReservationList(HashMap<String, Object> params) {
        return reservationDAO.getReservationList(params);
    }

    public HashMap<String, Object> blDeleteReservation(HashMap<String, Object> params) {
        return reservationDAO.blDeleteReservation(params);
    }

    public HashMap<String, Object> cancelReservation(HashMap<String, Object> params) {
        try {
            return reservationDAO.cancelReservation(params);
        } catch (ReturnException e) {
            HashMap<String, Object> resultMap = (HashMap<String, Object>)e.getValue();
            return resultMap;
        }
    }
}
