package podo.podospring.dao;

import java.util.HashMap;
import java.util.List;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import podo.podospring.common.dao.AbstractDAO;
import podo.podospring.common.ReturnException;

@Repository
public class BoardDAO extends AbstractDAO {

    @SuppressWarnings("unchecked")
    public HashMap<String, Object> getBoardList(HashMap<String, Object> params) {

        params.put("resultCode", "0000");
        params.put("resultMessage", "");
        List<HashMap<String, Object>> bordList = selectList("board.query1", params);
        int totalCnt = selectCnt("board.query2", params);

        if (bordList != null) {
            params.put("rows",bordList);
            params.put("totalCnt",totalCnt);
            params.put("resultCode", "0000");
        }

        return params;
    }

    @SuppressWarnings("unchecked")
    public HashMap<String, Object> getBoardDetail(HashMap<String, Object> params) {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();

        List<HashMap<String, Object>> getBoardDetail = selectList("board.getBoardDetail", params);
        update("board.ReCnt", params);

        if (getBoardDetail.size() > 0) {
            resultMap.put("rows", getBoardDetail);
            resultMap.put("resultCode", "0000");
        }
        return resultMap;
    }

    @SuppressWarnings("unchecked")
    @Transactional(rollbackFor = {Exception.class})
    public HashMap<String, Object> writeBoard(HashMap<String, Object> params)
            throws ReturnException {
        try{
            int errNum = 0;
            if ("I".equals((String)params.get("actionFlag"))) {
                int idx = selectCnt("board.idx", params);
                params.put("idx",idx);
                int ReCnt2 = insert("board.writeBoardQuery2", params);
                if (ReCnt2 < 1) {
                    errNum = errNum +1;
                }
                int ReCnt3 = insert("board.writeBoardQuery3", params);
                if (ReCnt3 < 1) {
                    errNum = errNum +1;
                }
            } else if ("U".equals((String)params.get("actionFlag"))) {
                params.get("idx");
                int ReCnt4 = update("board.updateQuery1",params);
                if (ReCnt4 < 1) {
                    errNum = errNum +1;
                }
                if (null != params.get("fileName1") || null != params.get("fileName2") || null != params.get("fileName3")) {
                    int ReCnt5 = update("board.updateQuery2",params);
                    if (ReCnt5 < 1) {
                        errNum = errNum +1;
                    }
                }
            }

            if (errNum > 0) {
                params.put("resultCode", "9999");
                params.put("resultMessage", "오류가 발생하였습니다. 잠시 후 다시 시도해주세요.");
                throw new Exception();
            } else {
                params.put("resultCode", "0000");
            }
        } catch(Exception e) {
            throw new ReturnException(params,"실행중 에러가 발생");
        }
        return params;
    }//writeBoard

    @SuppressWarnings("unchecked")
    public HashMap<String, Object> doDelete(HashMap<String, Object> params) {
        update("board.doDelete",params);
        params.put("resultCode","0000");
        return params;
    }

    @SuppressWarnings("unchecked")
    public HashMap<String, Object> getJoinList(HashMap<String, Object> params) {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        List<HashMap<String, Object>> getJoinList = selectList("board.getJoinList", params);
        resultMap.put("rows",getJoinList);
        int totalCnt = selectCnt("board.joinTotalCnt", params);
        resultMap.put("totalCnt",totalCnt);
        resultMap.put("resultCode","0000");

        return resultMap;
    }

    @SuppressWarnings("unchecked")
    public HashMap<String, Object> getReplyList(HashMap<String, Object> params) {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();

        List<HashMap<String, Object>> getReplyList = selectList("board.getReplyList", params);
        resultMap.put("rows",getReplyList);
        resultMap.put("resultCode","0000");
        return resultMap;
    }

    @SuppressWarnings("unchecked")
    public HashMap<String, Object> doDeleteReply(HashMap<String, Object> params) {
        update("board.doDeleteReply", params);
        params.put("resultCode","0000");
        return params;
    }

    @SuppressWarnings("unchecked")
    @Transactional(rollbackFor = {Exception.class})
    public HashMap<String, Object> writeReply(HashMap<String, Object> params)
            throws ReturnException {
        try{
            int seq = selectCnt("board.writeReplySeq", params);
            params.put("seq",seq);
            int ReCnt = insert("board.writeReplyInsert", params);
            if (ReCnt == 0) {
                params.put("resultCode", "9999");
                params.put("resultMessage", "오류가 발생하였습니다. 잠시 후 다시 시도해주세요.");
                throw new Exception();
            } else {
                params.put("resultCode", "0000");
            }
        } catch(Exception e) {
            throw new ReturnException(params,"실행중 에러가 발생");
        }

        return params;
    }


    @SuppressWarnings("unchecked")
    public HashMap<String, Object> getJoinCalendar(HashMap<String, Object> params) {
        List<HashMap<String, Object>> resultList = selectList("board.getJoinCalendar1", params);
        params.put("rows",resultList);
        params.put("resultCode","0000");
        return params;
    }

    @SuppressWarnings("unchecked")
    public HashMap<String, Object> boardHonor(HashMap<String, Object> params) {
        int intRecordCount = selectCnt("board.boardHonor2", params);
        params.put("intRecordCount",intRecordCount);

        List<HashMap<String, Object>> boardHonorList = selectList("board.boardHonor3", params);
        params.put("rows",boardHonorList);
        params.put("resultCode", "0000");

        return params;
    }
}
