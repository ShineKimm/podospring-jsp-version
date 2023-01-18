package podo.podospring.service;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Service;
import podo.podospring.common.ReturnException;
import podo.podospring.dao.MemberDAO;

@Service
public class MemberService {

    MemberDAO memberDAO;

    public MemberService(MemberDAO memberDAO) {
        this.memberDAO = memberDAO;
    }

    public Map<String, Object> doLogin(Map<String, Object> params)
            throws NoSuchAlgorithmException {
        return memberDAO.doLogin(params);
    }

    public Map<String, Object> chkDuplicateId(HashMap<String, Object> params) {

        return memberDAO.chkDuplicateId(params);
    }

    public Map<String, Object> doCertification(HashMap<String, Object> params) {
        return memberDAO.doCertification(params);
    }

    public Map<String, Object> doSignUp(HashMap<String, Object> params) {
        try {
            return memberDAO.doSignUp(params);
        } catch (ReturnException e) {
            HashMap<String, Object> resultMap = (HashMap<String, Object>)e.getValue();
            return resultMap;
        }
    }

    public Map<String, Object> doUpdateMemeber(HashMap<String, Object> params) {
        return memberDAO.doUpdateMemeber(params);
    }

    public Map<String, Object> doDeleteMemeber(HashMap<String, Object> params) {
        return memberDAO.doDeleteMemeber(params);
    }

    public Map<String, Object> doFindId(HashMap<String, Object> params) {
        return memberDAO.doFindId(params);
    }

    public Map<String, Object> doFindPw(HashMap<String, Object> params) {
        return memberDAO.doFindPw(params);
    }
}
