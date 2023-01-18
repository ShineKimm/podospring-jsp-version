package podo.podospring.controller;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import podo.podospring.service.BoardService;

@Controller
public class BoardController {
    private static final Logger logger =
            LoggerFactory.getLogger(BoardController.class);
    private BoardService boardService;
    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    @ResponseBody
    @RequestMapping("/getBoardList")
    public HashMap<String, Object> getBoardList(@RequestParam HashMap<String, Object> params) {
        params.put("sType",params.get("type"));
        HashMap<String, Object> result = boardService.getBoardList(params);
        return result;

    }

    @ResponseBody
    @RequestMapping("/getBoardDetail")
    public HashMap<String, Object> getBoardDetail(@RequestParam HashMap<String, Object> params) {
        params.put("sType",params.get("type"));
        params.put("sIdx",params.get("idx"));
        HashMap<String, Object> result = boardService.getBoardDetail(params);


        return result;
    }

    @ResponseBody
    @RequestMapping("/writeBoard")
    public HashMap<String, Object> writeBoard(@RequestParam HashMap<String, Object> params, HttpSession session, MultipartHttpServletRequest files) {

        params.put("actionFlag",params.get("flag"));
        params.put("coDiv",params.get("coDiv"));
        params.put("sType",params.get("type"));
        params.put("title",params.get("txtTitle"));
        params.put("content",params.get("txtContent"));
        params.put("boardDiv",params.get("boardDiv"));
        params.put("joinStatus",params.get("joinStatus"));
        params.put("bkDay",params.get("bkDay"));
        params.put("bkTime",params.get("bkTime"));
        params.put("bkPerson",params.get("bkPerson"));
        params.put("phone1",params.get("phone1"));
        params.put("phone2",params.get("phone2"));
        params.put("phone3",params.get("phone3"));
        params.put("link",params.get("link"));
        params.put("timeStamp",params.get("timeStamp"));
        params.put("ipAddr",params.get("ip"));
        String staff = (String)session.getAttribute("USER_STAFF");
        params.put("staff",staff);
        String sType = (String)params.get("sType");

        if (sType.equals("6")) {
            staff = (String)session.getAttribute("MS_NUM");
            params.put("staff",staff);
        }
        if (null == params.get("bkPerson")) {
            params.put("bkPerson","0");
        }

        java.util.Iterator<String> fileNames =  files.getFileNames();
        int index = 1;
        while(fileNames.hasNext())
        {
            String fileId = fileNames.next();
            MultipartFile mFile = files.getFile(fileId);
            String originFileName = mFile.getOriginalFilename();

            if (!originFileName.equals("")) {
                    params.put("originFileName" + index, originFileName);
            } else {
                if (params.get("originFileName" + index) == null || params.get("originFileName" + index).equals("")) {
                    params.put("originFileName" + index, "");
                }
            }

            String extension = originFileName.substring(originFileName.lastIndexOf(".") + 1);
            Timestamp timestamp = new Timestamp((System.currentTimeMillis()));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
            String timestampDate = sdf.format(timestamp);
            String fileName = timestampDate + "_" + index + "." + extension;

            if (!originFileName.equals("")) {
                params.put("fileName" + index, fileName);
            }

            //TODO 파일 업로드경로 서버경로로 설정
            //String filePath = "C:\\web\\podo\\uploads";
            String filePath = "C:\\uploads";
            LocalDate now = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
            String today = now.format(formatter);
            if (!originFileName.equals("")) {
                params.put("filePath"+index, "/uploads/"+today);
            }

            File file = new File(filePath+"\\"+today+"\\"+fileName);
            if (mFile.getSize()!=0) {
                if (! file.exists()) { // 경로상 파일이 존재하지 않을 경우
                    try {
                        if (file.mkdirs()) {
                            System.out.println("폴더가 생성되었습니다.");
                        }
                        file.createNewFile(); //이후 파일 생성
                    } catch (Exception e) {
                        e.getStackTrace();
                    }
                }
                try {
                    mFile.transferTo(file); //임시로 저장된 multipartFile을 실제 파일로 전송
                } catch (IllegalStateException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            index++;
        }

        boardService.writeBoard(params);
        return params;
    }

    @ResponseBody
    @RequestMapping("/doDelete")
    public HashMap<String, Object> doDelete(@RequestParam HashMap<String, Object> params) {
        params.put("coDiv",params.get("coDiv"));
        params.put("sType",params.get("type"));
        params.put("sIdx",params.get("idx"));
        params.put("sDiv",params.get("div"));
        if (params.get("sDiv") == null) {
            params.put("sDiv","1");
        }
        params = boardService.doDelete(params);
        return params;
    }

    @ResponseBody
    @RequestMapping("/getJoinList")
    public HashMap<String, Object> getJoinList(@RequestParam HashMap<String, Object> params) {
        params.put("coDiv",params.get("coDiv"));
        params.put("sType",params.get("type"));
        params.put("stDate",params.get("stDate"));
        params.put("edDate",params.get("edDate"));
        params.put("startCnt",params.get("startCnt"));
        params.put("pageCnt",params.get("pageCnt"));
        params.put("searchText",params.get("searchText"));
        params.put("searchOption",params.get("searchOption"));

        params = boardService.getJoinList(params);



        return params;
    }

    @ResponseBody
    @RequestMapping("/getReplyList")
    public HashMap<String, Object> getReplyList(@RequestParam HashMap<String, Object> params) {
        params.put("coDiv",params.get("coDiv"));
        params.put("sType",params.get("type"));
        params.put("sIdx",params.get("idx"));

        params = boardService.getReplyList(params);



        return params;
    }

    @ResponseBody
    @RequestMapping("/doDeleteReply")
    public HashMap<String, Object> doDeleteReply(@RequestParam HashMap<String, Object> params) {
        params.put("coDiv",params.get("coDiv"));
        params.put("sType",params.get("type"));
        params.put("sIdx",params.get("idx"));
        params.put("sSeq",params.get("seq"));

        params = boardService.doDeleteReply(params);
        return params;
    }

    @ResponseBody
    @RequestMapping("/writeReply")
    public HashMap<String, Object> writeReply(@RequestParam HashMap<String, Object> params, HttpSession session) {
        params.put("coDiv",params.get("coDiv"));
        params.put("sType",params.get("type"));
        params.put("sIdx",params.get("idx"));
        params.put("content",params.get("content"));
        params.put("content",params.get("content"));
        params.put("ipAddr",params.get("ip"));

        params.put("MS_NUM", session.getAttribute("MS_NUM"));

        params = boardService.writeReply(params);
        return params;
    }

    @ResponseBody
    @RequestMapping("/getJoinCalendar")
    public HashMap<String, Object> getJoinCalendar(@RequestParam HashMap<String, Object> params, HttpSession session) {
        params.put("coDiv",params.get("coDiv"));
        params.put("selYm",params.get("selYm"));

        params = boardService.getJoinCalendar(params);
        return params;
    }

    @ResponseBody
    @RequestMapping("/board/honorList")
    public HashMap<String, Object> boardHonor(@RequestParam HashMap<String, Object> params) {
        HashMap<String, Object> resultMap = boardService.boardHonor(params);
        return resultMap;
    }

    @ResponseBody
    @GetMapping("/images/getfile")
    public Resource showImage(@RequestParam String fullpath) throws MalformedURLException{
        logger.debug("###fullpath######"+ fullpath);
        return new UrlResource("file:"+fullpath);
    }



}
