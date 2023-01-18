package podo.podospring.service;

import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Service;
import podo.podospring.dao.CommonDAO;

@Service
public class CommonService {
    CommonDAO commonDAO;

    public CommonService(CommonDAO commonDAO) {
        this.commonDAO = commonDAO;
    }

    public Map<String, Object> getCommonCode(HashMap<String, Object> params) {

        return commonDAO.getCommonCode(params);
    }

    public void deviceIdentification(HashMap<String, Object> params) {
        commonDAO.deviceIdentification(params);
    }
}
