package podo.podospring.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Repository;
import podo.podospring.common.dao.AbstractDAO;

@Repository
public class AdminDAO extends AbstractDAO {

    @SuppressWarnings("unchecked")
    public Map<String, Object> AdminDoLogin(HashMap<String, Object> params, HttpSession session) {

        int cnt = selectCnt("admin.AdminDoLogin", params);
        if (cnt < 1) {
            params.put("resultCode", "1000");
            params.put("resultMessage", "존재하지 않는 아이디입니다.");
        } else {
            Map<String, Object> adminVerification = (Map<String, Object>) selectOne("admin.adminVerification", params);
            if (adminVerification == null) {
                params.put("resultCode", "2000");
                params.put("resultMessage", "암호가 잘못되었습니다.");
            } else {
                session.setAttribute("USER_STAFF",adminVerification.get("USER_STAFF"));
                session.setAttribute("USER_NAME",adminVerification.get("USER_NAME"));
                params.put("resultCode", "0000");
            }
        }
        return params;
    }

    @SuppressWarnings("unchecked")
    public HashMap<String, Object> getMainData(HashMap<String, Object> params) {
        List<HashMap<String, Object>> connect = selectList("admin.query1", params);
        if (connect.size() > 0) {
            params.put("connect", connect);
        }

        List<HashMap<String, Object>> member = selectList("admin.query2", params);
        if (member.size() > 0) {
            params.put("member", member);
        }
        params.put("resultCode","0000");

        return params;
    }

    public HashMap<String, Object> getMessage(HashMap<String, Object> params) {

        List<HashMap<String, Object>> getMessage = selectList("admin.getMessage", params);
        params.put("rows",getMessage);
        params.put("resultCode","0000");

        return params;
    }

}
