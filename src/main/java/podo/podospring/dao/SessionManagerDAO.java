package podo.podospring.dao;

import java.util.HashMap;
import java.util.List;
import org.springframework.stereotype.Repository;
import podo.podospring.common.dao.AbstractDAO;

@Repository
public class SessionManagerDAO extends AbstractDAO {

    @SuppressWarnings("unchecked")
    public List<HashMap<String, Object>> sessionConfirm(HashMap<String, Object> params) {
        List<HashMap<String, Object>> list = selectList("session.sessionConfirm", params);
        return list;
    }



}
