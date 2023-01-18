package podo.podospring.service;

import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import podo.podospring.common.ReturnException;
import podo.podospring.dao.BoardDAO;

@Service
public class BoardService{

    BoardDAO boardDAO;

    @Autowired
    public BoardService(BoardDAO boardDAO) {
        this.boardDAO = boardDAO;
    }

    public HashMap<String, Object> getBoardList(HashMap<String, Object> params) {
        return boardDAO.getBoardList(params);
    }

    public HashMap<String, Object> getBoardDetail(HashMap<String, Object> params) {
        return boardDAO.getBoardDetail(params);
    }

    public HashMap<String, Object> writeBoard(HashMap<String, Object> params) {
        try {
            return boardDAO.writeBoard(params);
        } catch (ReturnException e) {
            HashMap<String, Object> resultMap = (HashMap<String, Object>)e.getValue();
            return resultMap;
        }
    }

    public HashMap<String, Object> doDelete(HashMap<String, Object> params) {
        return boardDAO.doDelete(params);
    }

    public HashMap<String, Object> getJoinList(HashMap<String, Object> params) {
        return boardDAO.getJoinList(params);
    }

    public HashMap<String, Object> getReplyList(HashMap<String, Object> params) {
        return boardDAO.getReplyList(params);
    }

    public HashMap<String, Object> doDeleteReply(HashMap<String, Object> params) {
        return boardDAO.doDeleteReply(params);
    }

    public HashMap<String, Object> writeReply(HashMap<String, Object> params) {
        try {
        return boardDAO.writeReply(params);
        } catch (ReturnException e) {
            HashMap<String, Object> resultMap = (HashMap<String, Object>)e.getValue();
            return resultMap;
        }
    }

    public HashMap<String, Object> getJoinCalendar(HashMap<String, Object> params) {
        return boardDAO.getJoinCalendar(params);
    }

    public HashMap<String, Object> boardHonor(HashMap<String, Object> params) {
        HashMap<String, Object> Hmap = boardDAO.boardHonor(params);
        return Hmap;
    }


}
