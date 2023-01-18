package podo.podospring.service;

import java.util.HashMap;
import java.util.List;
import org.springframework.stereotype.Service;
import podo.podospring.dao.SessionManagerDAO;

@Service
public class SessionManagerService {

    SessionManagerDAO sessionManagerDAO;

    public SessionManagerService(SessionManagerDAO sessionManagerDAO) {
        this.sessionManagerDAO = sessionManagerDAO;
    }

    public List<HashMap<String, Object>> sessionConfirm(HashMap<String, Object> params) {
        return sessionManagerDAO.sessionConfirm(params);
    }
}
