package podo.podospring.service;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import podo.podospring.dao.AdminDAO;

@Service
public class AdminService {

    AdminDAO adminDao;

    @Autowired
    public AdminService(AdminDAO adminDao) {
        this.adminDao = adminDao;
    }

    public Map<String, Object> adminDoLogin(HashMap<String, Object> params, HttpSession session) {
        return adminDao.AdminDoLogin(params,session);
    }

    public HashMap<String, Object> getMainData(HashMap<String, Object> params) {
        return adminDao.getMainData(params);
    }

    public HashMap<String, Object> getMessage(HashMap<String, Object> params) {
        return adminDao.getMessage(params);
    }

}
