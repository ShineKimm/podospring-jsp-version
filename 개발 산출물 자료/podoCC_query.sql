-- 세션 체크 쿼리문
    SELECT MS_SESSION_KEY
    FROM MS_MAININFO_DETAIL
    WHERE MS_NUM = IFNULL(NULLIF(${MS_NUM}, ''), '')
-- 로그인 쿼리문
-- doLoginCNT 아이디 갯수 확인
    SELECT COUNT(*) AS CNT
    FROM MS_MAININFO
    WHERE MS_MAIN_CODIV = ${coDiv}
    AND MS_ID = '${id}'
    AND IFNULL(NULLIF(MS_BLANK,''),'N') != 'Y'

-- verification 아이디 패스워드 일치여부 확인
	SELECT MS_NUM, MS_NAME
	FROM MS_MAININFO
	WHERE MS_MAIN_CODIV = '501'
	AND MS_ID = 'illsc122'
	AND MS_PASSWORD = '68d2c417713a44a6f74dd5557ce043dd44675037180318a1ac9d15f2b2529ba6'
	AND IFNULL(NULLIF(MS_BLANK,''),'N') <> 'Y'

-- 아이디 패스워드 일치하면 로그인 정보 (날짜, 세션키) 업데이트
	update MS_MAININFO_DETAIL
	SET LAST_LOGIN_DATETIME = NOW()
	,	MS_SESSION_KEY = '841722341'
	where MS_NUM = '200003107200'
	
-- 	휴대폰 중복체크 doCertification
    SELECT COUNT(*) CNT
    FROM MS_MAININFO
    WHERE MS_FIRST_PHONE1 = '${phone1}'
      AND MS_MID_PHONE1 = HEX(AES_ENCRYPT('${phone2}', 'JBOG'))
      AND MS_LAST_PHONE1 = '${phone3}'
      AND IFNULL(NULLIF(MS_BLANK,''),'N') = 'N'
   
-- 	아이디 중복체크 /chkDuplicateId
	SELECT COUNT(*) AS CNT 
	FROM MS_MAININFO 
	WHERE MS_ID = 'test'  
   
-- 	(공통) 주소 지역명 검색 /getCommonCode
SELECT CO_DIV
 	 , CD_DIVISION
 	 , CD_CODE
 	 , CD_TITLE1
 	 , CD_TITLE2
 	 , CD_TITLE3
 FROM CD_COMMON
WHERE CO_DIV = '501'
  AND CD_DIVISION = '003'
  AND CD_USEYN = 'Y'
  
-- 	회원가입 기능
--  정합성 체크 doSignUp1
--  입력한 휴대폰 번호로 가입된 아이디가 있는지 여부
	SELECT MS_ID                     																							
  	FROM MS_MAININFO               																							
 	WHERE MS_FIRST_PHONE1 = '010'																				
	AND CAST(AES_DECRYPT(UNHEX(MS_MID_PHONE1),'JBOG') AS CHAR) = '0000'
 	AND MS_LAST_PHONE1 = '0001'																		
 	AND IFNULL(NULLIF(MS_BLANK, ''), 'N') = 'N'  
 	
--  doSignUp2
--  msNum 사원번호 만들기
 	SELECT CONCAT('21', LPAD(CAST(NEXTVAL('%','','MS_MAININFO_SEQ') AS UNSIGNED),8,0), '00') MS_NUM
 	
--  doSignUp3
--  CD_TITLE1 지역명	
 	SELECT CD_TITLE1 FROM CD_COMMON WHERE CO_DIV = '501' AND CD_DIVISION = '003' AND CD_CODE = '0101' 
 	
--  doSignUp4
--  회원정보 저장 1
INSERT INTO MS_MAININFO (
      MS_NUM
    , MS_MAIN_CODIV
    , MS_DIVISION
    , MS_CLASS
    , MS_LEVEL
    , MS_ID
    , MS_PASSWORD
    , MS_NAME
    , MS_SEX
    , MS_BIRTH
    , MS_BIRTHYL
    , MS_FIRST_PHONE1
    , MS_MID_PHONE1
    , MS_LAST_PHONE1
    , MS_HOMEADDR1
    , SMS_CHK1
    , MS_EMAIL
    , MS_EMAIL_YN
    , MS_MKT_AGREE_YN
    , MS_MKT_AGREE_YN2
    , MS_MKT_AGREE_YN3
    , MS_FIRSTDAY
    , MS_CODIV_BRAND
    , MS_HYUPNUM
    , INPUT_STAFF
    , INPUT_DATETIME
    , INPUT_IP
    , UPDATE_STAFF
    , UPDATE_DATETIME
    , UPDATE_IP
) VALUES (
      ' & msNum & '
    , ' & coDiv & '
    , ' & netDivision & '
    , ' & netClass & '
    , ' & netLevel & '
    , ' & id & '
    , SHA2(' & pw & ', 256)
    , ' & name & '
    , ' & sex & '
    , ' & birth & '
    , ' & birthYL & '
    , ' & phone1 & '
    , HEX(AES_ENCRYPT(' & phone2 & ', 'JBOG'))
    , ' & phone3 & '
    , ' & homeAddress1 & '
    , 'Y'
    , HEX(AES_ENCRYPT(' & email & ', 'JBOG'))
    , ' & chkMail & '
    , ' & mkt1 & '
    , ' & mkt2 & '
    , ' & mkt3 & '
    , DATE_FORMAT(NOW(), '%Y%m%d')
    , '001'
    , ' & msNum & '
    , 'HOMEPAGE'
    , NOW()
    , ' & ip & '
    , 'HOMEPAGE'
    , NOW()
    , ' & ip & '
)
 	
--  doSignUp5
--  회원정보 저장 2
    INSERT INTO MS_MAININFO_DETAIL (
                                     MS_NUM
                                   , MS_AREA
                                   , MS_LOGIN_CD
                                   , MS_ID_IMSI_YN
                                   , MS_ID_AGREE_YN
                                   , INPUT_STAFF
                                   , INPUT_DATETIME
                                   , INPUT_IP
                                   , UPDATE_STAFF
                                   , UPDATE_DATETIME
                                   , UPDATE_IP
    ) VALUES (
               '${msNum}'
             , '${area}'
             , 'LOCAL'
             , 'N'
             , 'Y'
             , 'HOMEPAGE'
             , NOW()
             , '${ip}'
             , 'HOMEPAGE'
             , NOW()
             , '${ip}'
             )
             

-- doSignUp6             
SELECT COUNT(*)    CNT  
  FROM MS_BENEFIT  B  
 WHERE CO_DIV = ' & 501 & '
   AND B.MS_DIVISION = ' & 21 & '	
   AND B.MS_CLASS    = ' & 00 & '  
   AND B.MS_LEVEL    = ' & 00 & '              

-- doSignUp7
   
INSERT INTO MS_BENEFIT2                                                                                                                              
		   (                                                                                                                                                    
		     CO_DIV,               MS_NUM,               MS_DIVISION,                  MB_ENTRUSTYN,                                                            
		     MB_ENTRUST_CNT,       MB_WEEKDAY_CNT,       MB_WEEKEND_CNT,               MB_C_WEEKDAY_CNT,               MB_C_WEEKEND_CNT,                        
		     MB_C_SPRING_CNT,      MB_C_SUMMER_CNT,      MB_C_FALL_CNT,                MB_C_WINTER_CNT,                MB_SG_DC_CNT,                            
		     MB_SP_DC_CNT,         MB_AR_DC_CNT,         MB_GH_DC_CNT,                 MS_SALE_CD,                                                              
		     INPUT_STAFF,          INPUT_DATETIME,       INPUT_IP,                     UPDATE_STAFF,                   UPDATE_DATETIME,               UPDATE_IP 
		   )   
		   
		   
   SELECT                                                                                                                                               
     CO_DIV,               ' & 210004812800 & ',      MS_DIVISION,                  MB_ENTRUSTYN,                                                            
     MB_ENTRUST_CNT,       MB_WEEKDAY_CNT,       MB_WEEKEND_CNT,               MB_C_WEEKDAY_CNT,               MB_C_WEEKEND_CNT,                        
     0 MB_C_SPRING_CNT,    0 MB_C_SUMMER_CNT,    0 MB_C_FALL_CNT,              0 MB_C_WINTER_CNT,              0 MB_SG_DC_CNT,                          
     0 MB_SP_DC_CNT,       0 MB_AR_DC_CNT,       0 MB_GH_DC_CNT,               '',                                                                      
     'HOMEPAGE',           NOW(),                ' & 210.183.179.17 & ',                    'HOMEPAGE',                     NOW(),                         ' & 210.183.179.17 & ' 
     FROM MS_BENEFIT B                                                                                                                                  
    WHERE B.CO_DIV      = ' & 501 & '                                                                                                                      
      AND B.MS_DIVISION = ' & 21 & '                                                                                                                          
      AND B.MS_CLASS    = ' & 00 & '                                                                                                                          
      AND B.MS_LEVEL    = ' & 00 & '   
      
      
-- doSignUp8      
INSERT INTO MS_BENEFIT2                                                                                                                              
		   (                                                                                                                                                    
		     CO_DIV,               MS_NUM,               MS_DIVISION,                  MB_ENTRUSTYN,                                                            
		     MB_ENTRUST_CNT,       MB_WEEKDAY_CNT,       MB_WEEKEND_CNT,               MB_C_WEEKDAY_CNT,               MB_C_WEEKEND_CNT,                        
		     MB_C_SPRING_CNT,      MB_C_SUMMER_CNT,      MB_C_FALL_CNT,                MB_C_WINTER_CNT,                MB_SG_DC_CNT,                            
		     MB_SP_DC_CNT,         MB_AR_DC_CNT,         MB_GH_DC_CNT,                 MS_SALE_CD,                                                              
		     INPUT_STAFF,          INPUT_DATETIME,       INPUT_IP,                     UPDATE_STAFF,                   UPDATE_DATETIME,               UPDATE_IP 
		   )                                                                                                                                                    
	   SELECT                                                                                                                                               
	     ' & coDiv & ',      MS_NUM,               MS_DIVISION,                  'N',                                                                     
	     0,                    0,                    0,                            0,                              0,                                       
	     0,                    0,                    0,                            0,                              0,                                       
	     0,                    0,                    0,                            '',                                                                      
	     'HOMEPAGE',           NOW(),                ' & ip & ',                 'HOMEPAGE',                     NOW(),                        ' & ip & '  
	     FROM  MS_MAININFO                                                                                                                                  
	    WHERE  MS_NUM = ' & msNum & '       

/*-------------------------------------------------------*/
-- AdminDoLogin
-- 관리자 아이디 갯수 확인
    SELECT COUNT(*) AS CNT
    FROM USER_INFO
    WHERE USER_STAFF = '${id}'
      AND IFNULL(NULLIF(USER_DEL, ''), 'N') != 'Y'	    
	    
-- adminVerification
-- 관리자 아이디패스워드 확인 
SELECT USER_STAFF															 
  	 , USER_NAME															 
  FROM USER_INFO															 
 WHERE USER_STAFF = ' & id & '							 
   AND USER_PASSWORD = SHA2(' & pw & ', 256) 	    

--  아이디 정보 확인 쿼리  
select A.*
from MS_MAININFO A
where A.ms_id in ('test1111','test23343454')

-- 게시판 총 개시물 갯수
-- query2
SELECT COUNT(*) TOTAL_CNT																															
   FROM HP_BOARD H																																			
	If sType = 6 Then
   LEFT OUTER JOIN MS_MAININFO U																												
     ON H.INPUT_STAFF = U.MS_NUM																												
	Else
   LEFT OUTER JOIN USER_INFO U																													
     ON H.INPUT_STAFF = U.USER_STAFF																										
	End If
   LEFT OUTER JOIN (																																		
 		SELECT CO_DIV																																			
 		 		 , TYPE																																				
 		 		 , IDX																																				
 		 		 , IFNULL(NULLIF(FILE_NAME1, ''), '') AS FILE_NAME1														
 		 		 , IFNULL(NULLIF(FILE_PATH1, ''), '') AS FILE_PATH1														
 		 		 , IF(IFNULL(NULLIF(FILE_NAME2, ''), '') = '', 0, 1)													
 		 		 + IF(IFNULL(NULLIF(FILE_NAME3, ''), '') = '', 0, 1) AS ATTACH_CNT 						
 	    FROM HP_BOARD_ATTACH																														
   ) D																																									
     ON H.CO_DIV = D.CO_DIV																														
    AND H.TYPE   = D.TYPE																															
    AND H.IDX    = D.IDX																																
  WHERE H.CO_DIV = ' & coDiv & '																											
	If adminYn <> Y Then
		 AND H.DEL_DIV = '0'							                              										
	End If
    AND H.TYPE = ' & sType & '																												
	If boardDiv <>  Then
		 AND H.BOARD_DIV = ' & boardDiv & '		                              							
	End If
	If stDate <>  And edDate <>  Then
		 AND H.BK_DAY BETWEEN ' & stDate & ' AND ' & edDate & '		            					
	End If
	If searchText <>  Then
		If searchOption = title Then
    AND H.TITLE LIKE '% & searchText & %'																						
		ElseIf searchOption = content Then
    AND CAST(H.CONTENT AS CHAR(10000) CHARACTER SET UTF8) LIKE '% & searchText & %'	
		ElseIf searchOption = writer Then
    AND U.USER_NAME = ' & searchText & '																							
		End If
	End if
	
-- 	게시판 1개 개시물 상세내용
-- 	getBoardDetail
SELECT H.CO_DIV																																	
 		 , H.TYPE																																		
 		 , H.IDX																																		
 		 , H.TITLE																																	
 		 , CAST(H.CONTENT AS CHAR(10000) CHARACTER SET UTF8) AS CONTENT							
 		 , H.BOARD_DIV																															
 		 , H.JOIN_STATUS																														
 		 , H.BK_DAY																																	
 		 , H.BK_TIME																																
 		 , H.BK_PERSON																															
 		 , H.BK_FIRST_PHONE																													
 		 , CAST(AES_DECRYPT(UNHEX(H.BK_MID_PHONE),'JBOG') AS CHAR) AS BK_MID_PHONE	
 		 , H.BK_LAST_PHONE																													
 		 , H.LINK																																		
 		 , H.INPUT_STAFF																														
 		 , IFNULL(NULLIF(U.USER_NAME, ''), '관리자') AS WRITER_NAME									 
 		 , DATE_FORMAT(H.INPUT_DATETIME, '%Y-%m-%d') AS INPUT_DATETIME							
 		 , IFNULL(NULLIF(H.VIEW_CNT, 0), 0) AS VIEW_CNT															
 		 , IFNULL(NULLIF(A.FILE_NAME1, ''), '') AS FILE_NAME1												
 		 , IFNULL(NULLIF(A.ORIGIN_FILE_NAME1, ''), '') AS ORIGIN_FILE_NAME1					
 		 , IFNULL(NULLIF(A.FILE_PATH1, ''), '') AS FILE_PATH1												
 		 , IFNULL(NULLIF(A.FILE_NAME2, ''), '') AS FILE_NAME2												
 		 , IFNULL(NULLIF(A.ORIGIN_FILE_NAME2, ''), '') AS ORIGIN_FILE_NAME2					
 		 , IFNULL(NULLIF(A.FILE_PATH2, ''), '') AS FILE_PATH2												
 		 , IFNULL(NULLIF(A.FILE_NAME3, ''), '') AS FILE_NAME3												
 		 , IFNULL(NULLIF(A.ORIGIN_FILE_NAME3, ''), '') AS ORIGIN_FILE_NAME3					
 		 , IFNULL(NULLIF(A.FILE_PATH3, ''), '') AS FILE_PATH3												
   FROM HP_BOARD H																																
   LEFT OUTER JOIN USER_INFO U																										
     ON H.INPUT_STAFF = U.USER_STAFF																							
   LEFT OUTER JOIN HP_BOARD_ATTACH A																							
     ON H.CO_DIV      = A.CO_DIV																									
    AND H.TYPE        = A.TYPE																										
    AND H.IDX         = A.IDX																										
  WHERE H.CO_DIV      = '501'																					
    AND H.TYPE        = '1'																					
    AND H.IDX         = '72'	
    
--     상세조회 조회수 업데이트
--     ReCnt 
UPDATE HP_BOARD H																				
    SET VIEW_CNT = IFNULL(NULLIF(H.VIEW_CNT, 0), 0) + 1 	
  WHERE CO_DIV      = ' & coDiv & '
    AND TYPE        = ' & sType & '
    AND IDX         = ' & sIdx & '
    
--     관리자 접속현황
--     getMainData
SELECT IFNULL(SUM(S_WEB_CNT), 0)     S_WEB_CNT													
 		 , IFNULL(SUM(S_MOBILE_CNT), 0)  S_MOBILE_CNT												
 		 , IFNULL(SUM(S_ANDROID_CNT), 0) S_ANDROID_CNT											
 		 , IFNULL(SUM(S_IOS_CNT), 0)     S_IOS_CNT 													
 	FROM WEB_STATICS																											
  WHERE S_DATE = DATE_FORMAT(NOW(),'%Y%m%d')															
  UNION ALL																															
 SELECT IFNULL(SUM(S_WEB_CNT), 0)     S_WEB_CNT													
 		 , IFNULL(SUM(S_MOBILE_CNT), 0)  S_MOBILE_CNT												
 		 , IFNULL(SUM(S_ANDROID_CNT), 0) S_ANDROID_CNT											
 		 , IFNULL(SUM(S_IOS_CNT), 0)     S_IOS_CNT 													
 	FROM WEB_STATICS																											
  WHERE S_DATE = DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -1 DAY),'%Y%m%d')	
  UNION ALL																															
 SELECT IFNULL(SUM(S_WEB_CNT), 0)     S_WEB_CNT													
 		 , IFNULL(SUM(S_MOBILE_CNT), 0)  S_MOBILE_CNT												
 		 , IFNULL(SUM(S_ANDROID_CNT), 0) S_ANDROID_CNT											
 		 , IFNULL(SUM(S_IOS_CNT), 0)     S_IOS_CNT 													
 	FROM WEB_STATICS		
 	
--  회원가입 현황
 SELECT COUNT(*) CNT 																												
   FROM MS_MAININFO																													
  WHERE MS_FIRSTDAY = DATE_FORMAT(NOW(),'%Y%m%d')														
  UNION ALL 																																	
 SELECT COUNT(*) CNT 																												
   FROM MS_MAININFO																													
  WHERE MS_FIRSTDAY = DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -1 DAY),'%Y%m%d')	
  UNION ALL 																																	
 SELECT COUNT(*) CNT																													
   FROM (																																		
         SELECT  MS_NUM																											
           FROM  MS_MAININFO																									
          GROUP  BY  MS_NUM																									
        ) A																																	
	
-- 문구 로드
SELECT CO_DIV, HP_CODE, HP_CONTENTS 
FROM HP_MESSAGE 
WHERE CO_DIV = '501'

-- 관리자 글쓰기 기능
-- 조회수 idx
SELECT IFNULL(NULLIF(MAX(IDX), 0), 0) + 1 AS IDX 
FROM HP_BOARD 
WHERE CO_DIV = '501' AND TYPE = '1'

-- 글쓰기 기능 
-- writeBoardQuery2
INSERT INTO HP_BOARD (																										 																									
  	CO_DIV, 																	TYPE, 																				IDX,						 									
  	TITLE, 																		CONTENT, 																			DEL_DIV,													
 	BK_DAY,																		BK_TIME,																			BK_PERSON,												
 	BK_FIRST_PHONE,														BK_MID_PHONE,																	BK_LAST_PHONE,										
  	VIEW_CNT, 																BOARD_DIV,																		INPUT_STAFF, 											
  	INPUT_DATETIME,	 													INPUT_IP, 																		UPDATE_STAFF, 										
  	UPDATE_DATETIME, 													UPDATE_IP,																		LINK,				 		 									
  	JOIN_STATUS )		 																																																					
 VALUES (																																																	 									
  	' & coDiv & ', 													' & sType & ', 															' & idx & ',	 									
  	' & title & ', 													' & content & ', 														'0',															
 	' & bkDay & ',													' & bkTime & ',	 														 & bkPerson & ,									
 	' & phone1 & ',													HEX(AES_ENCRYPT(' & phone2 & ', 'JBOG')),		' & phone3 & ',									
  	0, 																				' & boardDiv & ',														' & staff & ', 									
  	NOW(),																		' & ipAddr & ', 														' & staff & ', 									
  	NOW(),																		' & ipAddr & ',															' & link & ',										
  	' & joinStatus & ' )
  	
-- writeBoardQuery3
INSERT INTO HP_BOARD_ATTACH (																							
 	CO_DIV, TYPE, IDX,																											
 	FILE_NAME1, ORIGIN_FILE_NAME1, FILE_PATH1,															
 	FILE_NAME2, ORIGIN_FILE_NAME2, FILE_PATH2,															
 	FILE_NAME3, ORIGIN_FILE_NAME3, FILE_PATH3 )															
 VALUES (																																	
 	' & coDiv & ', 			' & sType & ', 						' & idx & ',				
 	' & fileName1 & ', 	' & originFileName1 & ', 	' & filePath1 & ',	
 	' & fileName2 & ', 	' & originFileName2 & ', 	' & filePath2 & ',	
 	' & fileName3 & ', 	' & originFileName3 & ', 	' & filePath3 & ' )	  	
  	
-- updateQuery1
UPDATE HP_BOARD																												
SET TITLE 						= ' & title & '															
 	 	 , CONTENT 					= ' & content & '														
 	 	 , BOARD_DIV 				= ' & boardDiv & '													
 	 	 , JOIN_STATUS 		= ' & joinStatus & '													
 	 	 , BK_DAY 					= ' & bkDay & '															
 	 	 , BK_TIME 					= ' & bkTime & '														
 	 	 , BK_PERSON 				=  & bkPerson & 														
 	 	 , BK_FIRST_PHONE 	= ' & phone1 & '														
 	 	 , BK_MID_PHONE 		= HEX(AES_ENCRYPT(' & phone2 & ', 'JBOG'))	
 	 	 , BK_LAST_PHONE 		= ' & phone3 & '														
 	 	 , LINK					 		= ' & link & '															
 		 , UPDATE_STAFF 		= ' & staff & '															
 		 , UPDATE_DATETIME 	= NOW()																				
 		 , UPDATE_IP 				= ' & ipAddr & '														
WHERE CO_DIV 					= ' & coDiv & '															
AND TYPE 						= ' & sType & '															
AND IDX 							= ' & idx & '

-- updateQuery2
UPDATE HP_BOARD_ATTACH																
    SET CO_DIV = CO_DIV
		<if test=' !fileName1.equals("") and fileName1 !=null '>
 	 	 , FILE_NAME1 = ' & fileName1 & '								
 	 	 , ORIGIN_FILE_NAME1 = ' & originFileName1 & '	
 	 	 , FILE_PATH1 = ' & filePath1 & '								
		</if>
		<if test=' !fileName2.equals("") and fileName2 !=null '>
 	 	 , FILE_NAME2 = ' & fileName2 & '								
 	 	 , ORIGIN_FILE_NAME2 = ' & originFileName2 & '	
 	 	 , FILE_PATH2 = ' & filePath2 & '								
		</if>
		<if test=' !fileName3.equals("") and fileName3 !=null '>
 	 	 , FILE_NAME3 = ' & fileName3 & '								
 	 	 , ORIGIN_FILE_NAME3 = ' & originFileName3 & '	
 	 	 , FILE_PATH3 = ' & filePath3 & '								
		</if>
WHERE CO_DIV = ' & coDiv & '												
AND TYPE 	= ' & sType & '												
AND IDX 		= ' & idx & '													

-- 게시글 삭제
-- doDelete
UPDATE HP_BOARD 
SET DEL_DIV = '" & sDiv & "' 
WHERE CO_DIV = '" & coDiv & "' 
AND TYPE = '" & sType & "' 
AND IDX = '" & sIdx & "'

-- 인터넷 예약
-- 오늘 날짜 nowDate
SELECT DATE_FORMAT(NOW(), '%Y%m%d') 
FROM dual

-- 날짜 조회
-- MINDAY, MAXDAY
-- getCalendarQuery1
SELECT CASE WHEN CL_DAYDIV = '2' THEN                            
	   		  DATE_FORMAT(																	                   
			    IF(																						                   
			      WEEKDAY(																		                   
			        DATE_SUB(CL_SOLAR, INTERVAL -1 WEEK)			                   
			      ) = 1, 																			                   
			      DATE_SUB(CL_SOLAR, INTERVAL -1 WEEK), 			                   
			      DATE_ADD(																		                   
			        DATE_SUB(CL_SOLAR, INTERVAL -1 WEEK), 		                   
			        INTERVAL (																                   
			          1 - WEEKDAY(														                   
			            DATE_SUB(CL_SOLAR, INTERVAL -1 WEEK)	                   
			          )																				                   
			        ) DAY																			                   
			      )																						                   
			    ), 																						                   
			    '%Y%m%d'																			                   
			  )                                                           
		  ELSE                                                          
   			DATE_FORMAT(																	                     
			    IF(																						                   
			      WEEKDAY(																		                   
			        DATE_SUB(CL_SOLAR, INTERVAL -2 WEEK)			                   
			      ) = 1, 																			                   
			      DATE_SUB(CL_SOLAR, INTERVAL -2 WEEK), 			                   
			      DATE_ADD(																		                   
			        DATE_SUB(CL_SOLAR, INTERVAL -2 WEEK), 		                   
			        INTERVAL (																                   
			          1 - WEEKDAY(														                   
			            DATE_SUB(CL_SOLAR, INTERVAL -2 WEEK)	                   
			          )																				                   
			        ) DAY																			                   
			      )																						                   
			    ), 																						                   
			    '%Y%m%d'																			                   
			  )                                                           
		  END AS MINDAY,                                                
		CASE WHEN CL_DAYDIV = '2' THEN                                  
	 	 	DATE_FORMAT(																	                   
		      IF(																				                           
		        WEEKDAY(																	                           
		          DATE_SUB(CL_SOLAR, INTERVAL -1 WEEK)		                           
		        ) = 7, 																	                           
		        DATE_SUB(CL_SOLAR, INTERVAL -1 WEEK), 		                           
		        DATE_ADD(																                           
		          DATE_SUB(CL_SOLAR, INTERVAL -1 WEEK), 	                           
		          INTERVAL (															                           
		            7 - WEEKDAY(													                           
		              DATE_SUB(CL_SOLAR, INTERVAL -1 WEEK)                          
		            )																		                           
		          ) DAY																	                           
		        )																				                           
		      ), 																				                           
		      '%Y%m%d'																		                           
	  		)                                                           
		ELSE                                                            
	 	 	DATE_FORMAT(																	                   
		      IF(																				                           
		        WEEKDAY(																	                           
		          DATE_SUB(CL_SOLAR, INTERVAL -2 WEEK)		                           
		        ) = 7, 																	                           
		        DATE_SUB(CL_SOLAR, INTERVAL -2 WEEK), 		                           
		        DATE_ADD(																                           
		          DATE_SUB(CL_SOLAR, INTERVAL -2 WEEK), 	                           
		          INTERVAL (															                           
		            7 - WEEKDAY(													                           
		              DATE_SUB(CL_SOLAR, INTERVAL -2 WEEK)                          
		            )																		                           
		          ) DAY																	                           
		        )																				                           
		      ), 																				                           
		      '%Y%m%d'																		                           
	  		)                                                           
  		END AS MAXDAY                                                           
    FROM CL_DAYINFO																						               
   WHERE CO_DIV = '501'                                              
     AND CL_SOLAR = DATE_FORMAT(NOW(),'%Y%m%d')                     

     
-- getCalendarQuery2     
SELECT A.CL_SOLAR AS CL_SOLAR	 
       , A.CL_DAYDIV 
       , NVL(B.BOOKG_ABLE_CNT, 0) AS BK_TEAM	 
       , SUBSTRING(A.CL_SOLAR, 7, 2) + 0 AS DAYNUM	 
       , A.CL_BUSINESS AS CL_BUSINESS	 
       , CASE 
	       WHEN DAYOFWEEK(NOW()) = 3 AND  DATE_FORMAT(NOW(), '%H%i') < '0900'																									
 		        THEN DATE_FORMAT(DATE_ADD('20221227', INTERVAL -1 DAY),'%Y%m%d')	
 		        ELSE '20230103' END MAXDAY	 
    FROM CL_DAYINFO A	 
    LEFT OUTER JOIN ( 
        SELECT A.CO_DIV 
             , A.CL_SOLAR 
             , CAST(COUNT(B.BK_TIME) AS CHAR) AS BOOKG_ABLE_CNT 
          FROM CL_DAYINFO A	 
         INNER JOIN BK_HISTORY B  
            ON A.CO_DIV = B.CO_DIV  
           AND A.CL_SOLAR = B.BK_DAY	 
           AND NVL(B.BK_NAME,'') = ''	 
           AND NVL(B.BK_MSNUM,'') = ''	 
           AND NVL(B.BK_YN,'N') = 'N'	 
           AND (TIMESTAMPDIFF(MINUTE, NVL(BK_LOCKTIME, NOW()), NOW()) > 5	OR NVL(BK_LOCKTIME, '') = '')  
           AND B.BK_DAY > DATE_FORMAT(NOW(), '%Y%m%d')	 
         WHERE A.CO_DIV = '501' 
           AND A.CL_SOLAR LIKE CONCAT('202301', '%')	 
           AND A.CL_BUSINESS IN ('1', '2', '3', '4')	 
 			AND B.BK_DAY <= '20230103'																																												
 			AND CASE WHEN DAYOFWEEK(NOW()) = 3 AND B.BK_DAY >= '20221227' 																									
 		        THEN DATE_FORMAT(NOW(), '%H%i') >= '0900'	ELSE 1 = 1 END																										
           AND B.BK_DAY > DATE_FORMAT(NOW(), '%Y%m%d')  
         GROUP BY A.CL_SOLAR	 
    ) B  
      ON A.CO_DIV = B.CO_DIV	 
     AND A.CL_SOLAR = B.CL_SOLAR	 
   WHERE A.CL_SOLAR LIKE CONCAT('202301', '%')	 
     AND A.CO_DIV = '501' 
   GROUP BY A.CL_SOLAR	 
   ORDER BY A.CL_SOLAR      

--    getTeeList
--    getTeeQuery1

 SELECT A.CO_DIV 																		AS CO_DIV					 								
 		 , A.BK_DAY 																		AS BK_DAY					 								
 		 , A.BK_COS 																		AS BK_COS					 								
 		 , B.CD_TITLE1																	AS BK_COS_NM			 								
 		 , A.BK_TIME 																		AS BK_TIME				 								
 		 , A.BK_ROUNDF 																	AS BK_ROUNDF			 								
 		 , D.CL_BUSINESS 																	AS CL_BUSINESS			 								
 		 , IFNULL(NULLIF(E.MN_AMOUNT_DIV, ''), '') 			AS BK_B_CHARGE		 								
 		 , IFNULL(NULLIF(G.CD_TITLE1, ''), '')	   			AS BK_B_CHARGE_NM	 								
 		 , IFNULL(NULLIF(F.MN_AMOUNT_DIV, ''), '') 			AS BK_S_CHARGE		 								
 		 , IFNULL(NULLIF(H.CD_TITLE1, ''), '')	   			AS BK_S_CHARGE_NM	 								
 		 , CASE WHEN IFNULL(NULLIF(A.BK_CS,''),'N') = 'C' THEN '인턴캐디' WHEN IFNULL(NULLIF(A.BK_CS,''),'N') = 'Y' THEN '캐디' ELSE '셀프' END AS BK_CADDY 	 	
 	FROM BK_HISTORY A																										 								
  INNER JOIN CD_COMMON B																								 								
 	  ON A.CO_DIV = B.CO_DIV																						 								
 	 AND A.BK_COS = B.CD_CODE																						 								
 	 AND B.CD_DIVISION = '012'																					 								
  INNER JOIN CL_DAYINFO D																							 								
 	  ON A.CO_DIV = D.CO_DIV 																						 								
 	 AND A.BK_DAY = D.CL_SOLAR																					 								
 	LEFT OUTER JOIN (																										 								
 		SELECT A.CO_DIV																										 								
 			 	 , A.MN_AMOUNT_DIV																						 								
 		 	 	 , A.START_TIME																								 								
 		 		 , A.END_TIME																									 								
 		 		 , A.YOIL																											 								
 	       , IF(A.COS_CODE = 'Z', '%', A.COS_CODE) AS COS_CODE					 								
 	    FROM MN_MASTER_COST A																						 								
 	   INNER JOIN (																											 								
 	   	SELECT B.CO_DIV																									 								
 	   		 , MAX(GIJUN_DAY) GIJUN_DAY																		 								
 	        FROM MN_MASTER_COST B																				 								
 	       WHERE B.CO_DIV    = '501'																		 			
 	         AND GIJUN_DAY <= '20221122'																 						
 	       GROUP BY B.CO_DIV																						 								
 		 ) B																															 								
 	      ON A.CO_DIV      = B.CO_DIV																		 								
 	     AND A.GIJUN_DAY   = B.GIJUN_DAY																 								
 	   WHERE A.CO_DIV      = '501'																			 			
 	     AND A.MB_CO_DIV   = '501'																			 			
 	     AND A.MS_DIVISION = '21'     																		
 	     AND A.MS_CLASS    = '00'     																			
 	     AND A.MS_LEVEL    = '00'																						
 	) E																																	 								
 	  ON A.CO_DIV = E.CO_DIV																						 								
 	 AND A.BK_TIME BETWEEN E.START_TIME AND E.END_TIME									 								
 	 AND IF(D.CL_BUSINESS = '4', '8', D.CL_DAYDIV) = E.YOIL 						 								
 	 AND A.BK_COS LIKE E.COS_CODE   																		 								
 	LEFT OUTER JOIN (																										 								
 		SELECT CO_DIV																											 								
 			 , MN_DAY																												 								
 			 , MN_COS																												 								
 			 , MN_TIME																											 								
 			 , MN_AMOUNT_DIV																								 								
 	    FROM MN_COST_SALE  																							 								
 	   WHERE CO_DIV = '501'																							 			
 	     AND MN_DAY = '20221122'																				 						
 	) F																																	 								
 	  ON A.CO_DIV  = F.CO_DIV																						 								
 	 AND A.BK_DAY  = F.MN_DAY																						 								
 	 AND A.BK_COS  = F.MN_COS																						 								
 	 AND A.BK_TIME = F.MN_TIME																					 								
 	LEFT OUTER JOIN (																										 								
 		SELECT CO_DIV																											 								
 			 , CD_CODE																											 								
 			 , CD_TITLE1																										 								
 	  FROM CD_COMMON																										 								
 	   WHERE CO_DIV      = '501'																				 			
 	     AND CD_DIVISION = '004'																				 								
 	) G  																																 								
 	  ON E.CO_DIV        = G.CO_DIV																			 								
 	 AND E.MN_AMOUNT_DIV = G.CD_CODE   																	 								
 	LEFT OUTER JOIN (																										 								
 		SELECT CO_DIV																											 								
 			 , CD_CODE																											 								
 			 , CD_TITLE1																										 								
 	  FROM CD_COMMON																										 								
 	   WHERE CO_DIV      = '501'																				 			
 	     AND CD_DIVISION = '004'																				 								
 	) H																																	 								
 	  ON F.CO_DIV        = H.CO_DIV																			 								
 	 AND F.MN_AMOUNT_DIV = H.CD_CODE                      							 								
  WHERE A.CO_DIV = '501'																								 			
 	 AND A.BK_DAY = '20221122'	
-- 	If sCos <> All Then
--  	 AND A.BK_COS = 'All'		   																								
-- 	End If
 	 AND IFNULL(NULLIF(A.BK_NAME, ''), '') = ''																					
 	 AND IFNULL(NULLIF(A.BK_MSNUM, ''), '') = ''																				
 	 AND IFNULL(NULLIF(A.BK_YN, ''), 'N') = 'N'																					
 	 AND (TIMESTAMPDIFF(minute, NVL(A.BK_LOCKTIME, NOW()), NOW()) > 5										
 	  OR IFNULL(A.BK_LOCKTIME, '') = '')																								
  ORDER BY A.BK_TIME, A.BK_COS

-- getTeeQuery2  
SELECT  CL_MONTH_WEEK         
FROM  CL_DAYINFO         
WHERE  CO_DIV   = '501'                                                                 
AND  CL_SOLAR = '20221122'

-- getTeeQuery3
SELECT   IFNULL(SUM(IF(CL.CL_BUSINESS =  '1', 1, 0)), 0)            WEEK_DAY_CNT                                                                                                
         ,IFNULL(SUM(IF(CL.CL_BUSINESS <> '1', 1, 0)), 0)            WEEK_END_CNT                                                                                                
FROM  BK_HISTORY  BK                                                                                                                                                          
      INNER JOIN  (SELECT  CO_DIV, CL_SOLAR, CL_BUSINESS                                                                                                                      
                        FROM  CL_DAYINFO                                                                                                                                         
                       WHERE  CO_DIV        = '501'                                                                                                                           
                         AND  CL_SOLAR      BETWEEN DATE_FORMAT(DATE_ADD('20221122', INTERVAL -7 DAY), '%Y%m%d') AND DATE_FORMAT(DATE_ADD('20221122', INTERVAL 7 DAY), '%Y%m%d')         
                         AND  CL_MONTH_WEEK = '48'                                                                                                                   
                     )  CL                                                                                                                                                       
              ON  BK.CO_DIV = CL.CO_DIV                                                                                                                                       
             AND  BK.BK_DAY = CL.CL_SOLAR                                                                                                                                     
WHERE  BK.CO_DIV   = '501'                                                                                                                                                  
AND  BK.BK_DAY   BETWEEN DATE_FORMAT(DATE_ADD('20221122', INTERVAL -7 DAY), '%Y%m%d') AND DATE_FORMAT(DATE_ADD('20221122', INTERVAL 7 DAY), '%Y%m%d')                                   
AND  BK.BK_MSNUM LIKE CONCAT(SUBSTR('200004187800', 1, 10), '%')                                                                                                                   
AND  BK.RAIN_CHK = 'N'                                                                                                                                                       
AND  BK.BK_NAME  <> ''

-- setSession
-- 세션정보 저장
SELECT H.MS_NUM																																	 	
 		 , H.MS_MAIN_CODIV																													 	
 		 , H.MS_DIVISION																														 	
 		 , H.MS_CLASS																																 	
 		 , H.MS_LEVEL																																 	
 		 , H.MS_ID																																	 	
 		 , H.MS_PASSWORD																														 	
 		 , H.MS_NAME																																 	
 		 , H.MS_SEX																																	 	
 		 , H.MS_BIRTH																																 	
 		 , H.MS_BIRTHYL																															 	
 		 , CAST(AES_DECRYPT(UNHEX(H.MS_EMAIL),'JBOG') AS CHAR) AS MS_EMAIL					 	
 		 , H.MS_EMAIL_YN																														 	
 		 , H.MS_FIRST_PHONE1																												 	
 		 , CAST(AES_DECRYPT(UNHEX(H.MS_MID_PHONE1),'JBOG') AS CHAR) AS MS_MID_PHONE1 	
 		 , H.MS_LAST_PHONE1																													 	
 		 , H.SMS_CHK1																																 	
 		 , CAST(AES_DECRYPT(UNHEX(H.MS_HOMETEL),'JBOG') AS CHAR) AS MS_HOMETEL			 	
 		 , H.MS_HOMEZIP																															 	
 		 , H.MS_HOMEADDR1																														 	
 		 , H.MS_HOMEADDR2																														 	
 		 , CAST(AES_DECRYPT(UNHEX(H.MS_COMPTEL),'JBOG') AS CHAR) AS MS_COMPTEL			 	
 		 , H.MS_COMPZIP																															 	
 		 , H.MS_COMPADDR1																														 	
 		 , H.MS_COMPADDR2																														 	
 		 , H.MS_DM_H																																 	
 		 , H.MS_DM_C																																 	
 		 , H.MS_CAR_NO																															 	
 		 , H.MS_FIRSTDAY																														 	
 		 , H.MS_WEEKDAY_CNT																														 	
 		 , H.MS_WEEKEND_CNT																														 	
 		 , H.INPUT_STAFF																														 	
 		 , H.INPUT_DATETIME																													 	
 		 , H.INPUT_IP																																 	
 		 , H.UPDATE_STAFF																														 	
 		 , H.UPDATE_DATETIME																												 	
 		 , H.UPDATE_IP																															 	
 		 , D.MS_JOB_CD																															 	
 		 , D.MS_AREA																																 	
 		 , IF(IFNULL(C.CD_LENGTH, 0) = 0, 21, C.CD_LENGTH) AS MS_BK_CNT								
   FROM MS_MAININFO H																														 	
  INNER JOIN MS_MAININFO_DETAIL D																								 	
 	  ON H.MS_NUM = D.MS_NUM																											 	
   LEFT OUTER JOIN CD_COMMON C																								 			
 	  ON H.MS_MAIN_CODIV = C.CO_DIV																									
 	 AND H.MS_CLASS      = C.CD_CODE																								
 	 AND C.CD_DIVISION   = '006'																										
  WHERE H.MS_NUM = '200004187800'																									

--   예약
--   doReservation
--   예약자 정보
-- reservationQuery1
  SELECT MS_NAME																									
    		, MS_DIVISION                     							
    		, MS_CLASS                     							
    		, MS_LEVEL                     							
    		, CONCAT(MS_FIRST_PHONE1                     							
    		, CAST(AES_DECRYPT(UNHEX(MS_MID_PHONE1),'JBOG') AS CHAR)  
    		, MS_LAST_PHONE1) AS MS_PHONE1  														
    		, MS_FIRST_PHONE1  														
    		, CAST(AES_DECRYPT(UNHEX(MS_MID_PHONE1),'JBOG') AS CHAR)  														
    		, MS_LAST_PHONE1  														
    FROM MS_MAININFO               															
   WHERE MS_NUM = '200004187800'   
   
-- vCount1   
	SELECT COUNT(*)                                                                                                    
	  FROM BK_HISTORY                                                                                                  
	 WHERE CO_DIV  = '& coDiv &'                                                                                     
	   AND BK_DAY  = '& sDate &'                                                                                     
	   AND BK_COS  = '& sCos &'                                                                                      
	   AND BK_TIME = '& sTime &'                                                                                     
	   AND (IFNULL(NULLIF(BK_NAME, ''), 'X') <> 'X'                                                                    
		OR BK_YN = 'Y'                                                                                                   
		OR TIMESTAMPDIFF( MINUTE, IFNULL(IFNULL(BK_LOCKTIME, ''), DATE_ADD(NOW(), INTERVAL -5 MINUTE)), NOW()) < 6)  
		
-- vCount2
SELECT COUNT(BL_MSNUM)                                             
	  FROM BL_BREACH                                                   
	 WHERE CO_DIV        = '& coDiv &'                               
	   AND BL_MSNUM      = '& msNum &'                                    
	   AND BL_BK_NOSTART <= DATE_FORMAT(NOW(), '%Y%m%d')               
	   AND BL_BK_NOEND   > DATE_FORMAT(NOW(), '%Y%m%d')                
	   AND (IFNULL(BL_CONF, 'N') = 'N' OR IFNULL(BL_CONF, 'B') = 'B') 	

-- vCount3
	SELECT COUNT(*)                
	  FROM BK_HISTORY                 
	 WHERE CO_DIV   = '& coDiv &'   
	   AND BK_MEMORIALYN   = DATE_FORMAT(NOW(), '%Y%m%d') 
	   AND BK_MSNUM = '& msNum &' 	   

-- reservationQuery2	   
 	UPDATE BK_HISTORY                                                                               
 	   SET BK_RSVNO        = NVL(BK_RSVNO, NEXTVAL('& coDiv &', 'G', 'BK_HISTORY_SEQ'))           
 		 , BK_MSNUM        = '& msNum &'                                                            
 		 , BK_NAME         = '& msName &'                                                           
 		 , BK_MEDIA_TEMP   = BK_MEDIA                                                                 
 		 , BK_MEDIA        = '& sMedia &'                                                           
 		 , BK_DIVISION     = '1'                                                                      
 		 , BK_FIRST_PHONE1 = '& msPhone1 &'                                                         
 		 , BK_MID_PHONE1   = HEX(AES_ENCRYPT('& msPhone2 &', 'JBOG'))                               
 		 , BK_LAST_PHONE1  = '& msPhone3 &'                                                         
 		 , BK_CHARGE       = '& sCharge &'                                                          
 		 , BK_FIRST_DAY    = NVL(BK_FIRST_DAY, DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'))                    
 		 , BK_AREA    	   = DATE_FORMAT(NOW(), '%Y%m%d')                                             
 		 , BK_MEMORIALYN   = DATE_FORMAT(NOW(), '%Y%m%d')                                             
 		 , BK_MS_DIV       = '& msDivision &'                                                       
 		 , BK_MS_CLASS     = '& msClass &'                                                          
 		 , BK_MS_LEVEL     = '& msLevel &'                                                          
 		 , BK_MS_YN        = '2'                                                                      
 		 , BK_MARKET_CD    = '& marketCd &'                                                         
 		 , BK_BUSINESS_CD  = '& businessCd &'                                                       
 		 , BK_SMSSEND1     = 'Y'                                                                      
 		 , UPDATE_STAFF    = 'HOMEPAGE'                                                               
 		 , UPDATE_DATETIME = NOW()                                                                    
 		 , UPDATE_IP = '& ip &'                                                                     
 	 WHERE CO_DIV = '& coDiv &'                                                                   
 	   AND BK_DAY = '& sDate &'                                                                   
 	   AND BK_COS = '& sCos &'                                                                    
 	   AND BK_TIME = '& sTime &'                                                                  
 	   AND IFNULL(NULLIF(BK_NAME, ''), '') = ''                                                    	   
 	   
-- vCount4
 SELECT COUNT(*)                     
   FROM BK_HISTORY                   
  WHERE CO_DIV  = '& coDiv &'      
    AND BK_DAY  = '& sDate &'      
    AND BK_COS  = '& sCos &'       
    AND BK_TIME = '& sTime &'      
    AND BK_NAME = '& msName &'    

-- bkSeq
 	SELECT IFNULL(MAX(BK_SEQ), 0) + 1  
 	  FROM BK_HISTORY_LOG              
 	 WHERE CO_DIV = '& coDiv &'      
 	   AND BK_DAY = '& sDate &'      
    
-- reservationQuery3    
	INSERT INTO BK_HISTORY_LOG(                                                                         
		CO_DIV, BK_DAY, BK_COS, BK_TIME, BK_SEQ, BK_RSVNO,                                                
		BK_NAME, BK_MSNUM, BK_PART, BK_GPNUM, BK_ROUNDF, BK_MEDIA,                                        
		BK_PERSON, BK_FIRST_PHONE1, BK_MID_PHONE1, BK_LAST_PHONE1, BK_SMSSEND1, BK_FIRST_PHONE2,          
		BK_MID_PHONE2, BK_LAST_PHONE2, BK_SMSSEND2, BK_TEL, BK_RM_NUM, BK_CART,                           
		BK_CART_CNT, BK_MAC_ADDR, BK_CHARGE, BK_CS, BK_RING, BK_CERT_NUM,                                 
		BK_REMARK, BK_REMARK2, INPUT_STAFF, INPUT_DATETIME, INPUT_IP, UPDATE_STAFF,                       
		UPDATE_DATETIME, UPDATE_IP, BK_SUB_CD, BK_SUB_NAME, BK_EVENT, BK_LOG_DIV, BK_FIRST_DAY,           
		BK_MS_DIV, BK_MS_CLASS, BK_MS_LEVEL, BK_MS_YN, BK_MARKET_CD, BK_BUSINESS_CD, BK_COMP_CD )         
	SELECT                                                                                              
		CO_DIV, BK_DAY, BK_COS, BK_TIME, '& bkSeq &', BK_RSVNO,                                         
		BK_NAME, BK_MSNUM, BK_PART, BK_GPNUM, BK_ROUNDF, BK_MEDIA,                                        
		BK_PERSON, BK_FIRST_PHONE1, BK_MID_PHONE1, BK_LAST_PHONE1, BK_SMSSEND1, BK_FIRST_PHONE2,          
		BK_MID_PHONE2, BK_LAST_PHONE2, BK_SMSSEND2, BK_TEL, BK_RM_NUM, BK_CART,                           
		BK_CART_CNT, BK_MAC_ADDR, BK_CHARGE, BK_CS, BK_RING, BK_CERT_NUM,                                 
		BK_REMARK, BK_REMARK2, INPUT_STAFF, INPUT_DATETIME, INPUT_IP, UPDATE_STAFF,                       
		UPDATE_DATETIME, UPDATE_IP, BK_SUB_CD, BK_SUB_NAME, BK_EVENT, 'I', BK_FIRST_DAY,                  
		BK_MS_DIV, BK_MS_CLASS, BK_MS_LEVEL, BK_MS_YN, BK_MARKET_CD, BK_BUSINESS_CD, BK_COMP_CD           
	 FROM BK_HISTORY                                                                                    
	WHERE CO_DIV  = '& coDiv &'                                                                       
	  AND BK_DAY  = '& sDate &'                                                                       
	  AND BK_COS  = '& sCos &'                                                                        
	  AND BK_TIME = '& sTime &'                                                                       
	  AND BK_NAME = '& msName &'                                                                          
    
-- getReservationList			: 예약 리스트 조회
 SELECT B.BK_DAY																																				 	
 		 , B.BK_TIME																																			 	
 		 , B.BK_COS																																				 	
 		 , C.CD_TITLE1 AS BK_COS_NM																												 	
 		 , B.BK_RSVNO																																			 	
 		 , B.BK_NAME																																			 	
 		 , CASE WHEN IFNULL(NULLIF(B.BK_ROUNDF,''),'1') = '1' THEN '18홀' ELSE '9홀' END BK_ROUNDF	
 		 , B.BK_MEDIA																																			 	
 		 , B.BK_PERSON																																		 	
 		 , B.BK_FIRST_PHONE1																															 	
 		 , TRIM(CAST(AES_DECRYPT(UNHEX(B.BK_MID_PHONE1),'JBOG') AS CHAR)) AS BK_MID_PHONE1 	
 		 , B.BK_LAST_PHONE1																																 	
 		 , B.BK_CHARGE																																		 	
 		 , D.CD_TITLE1 AS BK_CHARGE_NM																										 	
 		 , IF(B.BK_DAY > DATE_FORMAT(NOW(), '%Y%m%d'), 'Y', 'N') AS CHANGE_YN						 	 	
 		 , DATEDIFF(B.BK_DAY, NOW()) AS CANCEL_DIFF					 																
 		 , CASE WHEN IFNULL(NULLIF(B.BK_CS,''),'N') = 'C' THEN '인턴캐디' WHEN IFNULL(NULLIF(B.BK_CS,''),'N') = 'Y' THEN '캐디' ELSE '셀프' END BK_CADDY					 																
 		 , CASE WHEN B.BK_DAY > DATE_FORMAT(NOW(), '%Y%m%d') THEN 'Y' ELSE 'N' END AS AFTER_YN	
   FROM BK_HISTORY B																																		 	
  INNER JOIN CD_COMMON C																																 	
     ON B.CO_DIV = C.CO_DIV																														 	
    AND B.BK_COS = C.CD_CODE																														 	
    AND C.CD_DIVISION = '012'																													 	
 	LEFT OUTER JOIN CD_COMMON D																					 								 	
 	  ON B.CO_DIV    = D.CO_DIV																			 										 	
 	 AND B.BK_CHARGE = D.CD_CODE																												 	
 	 AND D.CD_DIVISION = '004'                      							 										 	 	
   LEFT OUTER JOIN CL_DAYINFO E																													
     ON B.CO_DIV = E.CO_DIV																															
 	 AND B.BK_DAY = E.CL_SOLAR																														
  WHERE B.CO_DIV = ' & coDiv & '																											 	
    AND B.BK_MSNUM = ' & msNum & '																										 	
    AND B.BK_DAY >= CONCAT(DATE_FORMAT(NOW(), '%Y%m'),'01')													 	
    AND B.BK_ROUNDF NOT IN ('3','4')													 	
	 ORDER BY B.BK_DAY																																		
	  
-- cancelReservation				: 예약 취소
-- cancelReservationQuery1	 
	SELECT MS_NAME																									
    		, CONCAT(MS_FIRST_PHONE1                     							
    		, CAST(AES_DECRYPT(UNHEX(MS_MID_PHONE1),'JBOG') AS CHAR)  
    		, MS_LAST_PHONE1) AS MS_PHONE1  														
    FROM MS_MAININFO               															
   WHERE MS_NUM = '200004187800'  
	 
-- cancelReservationQuery2
SELECT DATEDIFF('221215', NOW()) AS CANCEL_DIFF

-- cancelReservationQuery3
CALL SP_HOMEPAGE_BOOKING_CANCEL(
	'501'
 , '20221124'
 , 'B'
 , '0619'
 , '200004187800' 
 , '210.183.179.17' 
 , @RESULT)

-- cancelReservationQuery4 
SELECT CONVERT("0000", CHAR(200))   

-- 예약 변경
-- changeReservation1
SELECT COUNT(*) AS CNT					  
   FROM BK_HISTORY								  
  WHERE CO_DIV   = ' & coDiv & ' 
    AND BK_DAY   = ' & bDate & ' 
 	 AND BK_COS   = ' & bCos & '  
 	 AND BK_TIME  = ' & bTime & ' 
 	 AND BK_MSNUM = ' & msNum & ' 
 	 
-- changeReservation2
CALL SP_BOOK0100_BK_HISTORY_COPY(
	  ' & coDiv & '
 , ' & aDate & '
 , ' & aCos & '
 , ' & aTime & '
 , ' & bDate & '
 , ' & bCos & '
 , ' & bTime & '
 , 'M' 
 , 'HOMEPAGE' 
 , ' & ip & ' 
 , @RESULT)  	 
 
-- 조인게시판 리스트
-- getJoinList
 
   		SELECT H.CO_DIV																																
 				 , H.TYPE																																	
 				 , H.IDX																																	
 				 , 0 AS SEQ																																
 				 , H.TITLE																																
 				 , CAST(H.CONTENT AS CHAR(10000) CHARACTER SET UTF8) AS CONTENT						
 				 , H.BOARD_DIV																														
 				 , H.JOIN_STATUS																													
 				 , IFNULL(NULLIF(U.MS_NAME, ''), '') AS WRITER_NAME												
 				 , DATE_FORMAT(H.INPUT_DATETIME, '%Y.%m.%d') 	AS INPUT_DATETIME						
 			 	 , H.VIEW_CNT																															
 		  FROM HP_BOARD H																															
 		  LEFT OUTER JOIN MS_MAININFO U																								
 		    ON H.INPUT_STAFF = U.MS_NUM																								
 		 WHERE H.CO_DIV  = ' & coDiv & '																						
 		   AND H.TYPE    = ' & sType & '																						
 		   AND H.DEL_DIV = '0'							                              						
 		   AND H.BK_DAY  BETWEEN ' & stDate & ' AND ' & edDate & '	
 		   
-- 조인게시판 리스트 갯수 
   	SELECT COUNT(*) AS CNT																					
 		  FROM HP_BOARD H																								
 		  LEFT OUTER JOIN MS_MAININFO U																	
 		    ON H.INPUT_STAFF = U.MS_ID																	
 		 WHERE H.CO_DIV  = ' & coDiv & '															
 		   AND H.TYPE    = ' & sType & '															
 		   AND H.DEL_DIV = '0'							                            
 		   AND H.BK_DAY  BETWEEN ' & stDate & ' AND ' & edDate & '	
	If searchText <>  Then
		If searchOption = title Then
    AND H.TITLE LIKE '% & searchText & %'																						
		ElseIf searchOption = content Then
    AND CAST(H.CONTENT AS CHAR(10000) CHARACTER SET UTF8) LIKE '% & searchText & %'	
		ElseIf searchOption = writer Then
    AND U.MS_NAME = ' & searchText & '																									   
 
-----------------------------------    
-- 댓글리스트
-- getReplyList
    
 SELECT H.CO_DIV																								 									
 		 , H.TYPE																									 									
 		 , H.IDX																									 									
 		 , H.SEQ																									 									
 		 , H.CONTENT																							 									
 		 , H.BK_PERSON																						 									
 		 , IFNULL(NULLIF(U.MS_NAME, ''), '') AS WRITER_NAME				 									
 		 , H.BK_FIRST_PHONE																				 									
 		 , CAST(AES_DECRYPT(UNHEX(H.BK_MID_PHONE),'JBOG') AS CHAR) AS BK_MID_PHONE 	
 		 , H.BK_LAST_PHONE																				 									
 		 , DATE_FORMAT(H.INPUT_DATETIME, '%Y.%m.%d') 	AS INPUT_DATETIME										
 		 , H.INPUT_STAFF																					 									
 	FROM HP_BOARD_REPLY	H																				 									
   LEFT OUTER JOIN MS_MAININFO U																 									
     ON H.INPUT_STAFF = U.MS_NUM																 									
  WHERE H.CO_DIV      = ' & coDiv & '												 									
    AND H.TYPE        = ' & sType & '												 									
    AND H.IDX         = ' & sIdx & '													 									
		 AND H.DEL_DIV 		 = '0'							                              					
  ORDER BY H.SEQ asc
  
 --------------------------
 select mm.ms_id, mm.MS_NAME
 from ms_maininfo mm 
 where mm.ms_id = 'test1122'
 
--  조인게시판 게시글 삭제
-- doDeleteReply
 UPDATE HP_BOARD_REPLY SET DEL_DIV = '1' 
 WHERE CO_DIV = '" & coDiv & "' 
 AND TYPE = '" & sType & "' 
 AND IDX = '" & sIdx & "' 
 AND SEQ = '" & sSeq & "'
 -----------------------------
 select H.ms_num ,H.ms_birthyl 
 from MS_MAININFO H
 where H.ms_id ='test1125'
 
-- 회원정보 업데이트1
--  doUpdateMemeber1
 UPDATE MS_MAININFO 																									 
    SET MS_SEX						= ' & sex & '															 
	If pw <>  Then
      , MS_PASSWORD 			= SHA2(' & pw & ', 256)										 
	End If
    	 , MS_BIRTH					= ' & birth & '														 
    	 , MS_BIRTHYL				= ' & birthYL & '													 
    	 , MS_FIRST_PHONE1	= ' & phone1 & '													 
    	 , MS_MID_PHONE1		= HEX(AES_ENCRYPT(' & phone2 & ', 'JBOG')) 
    	 , MS_LAST_PHONE1		= ' & phone3 & '													 
    	 , MS_MKT_AGREE_YN					= ' & mkt1 & '															 
    	 , MS_MKT_AGREE_YN2					= ' & mkt2 & '															 
    	 , MS_MKT_AGREE_YN3					= ' & mkt3 & '															 
    	 , MS_EMAIL					= HEX(AES_ENCRYPT(' & email & ', 'JBOG'))	 
    	 , MS_EMAIL_YN					= '& chkMail &'	 
    	 , UPDATE_STAFF 		= 'HOMEPAGE'																 
    	 , UPDATE_DATETIME 	= NOW()																			 
    	 , UPDATE_IP 				= ' & ip & '															 
  WHERE MS_NUM = ' & Session(MS_NUM) & '	
  -- 회원정보 업데이트2
--   doUpdateMemeber2
 UPDATE MS_MAININFO_DETAIL										
    SET MS_AREA					= ' & area & '		
    	 , UPDATE_STAFF 		= 'HOMEPAGE'				
    	 , UPDATE_DATETIME 	= NOW()							
    	 , UPDATE_IP 				= ' & ip & '			
  WHERE MS_NUM = ' & Session(MS_NUM) & '	  
  
-- 댓글 등록1
-- writeReplySeq  
SELECT IFNULL(NULLIF(MAX(SEQ), 0), 0) + 1 AS SEQ 
FROM HP_BOARD_REPLY 
WHERE CO_DIV = '" & coDiv & "' 
AND TYPE = '" & sType & "' 
AND IDX = '" & sIdx & "'  

-- 댓글 등록2
-- writeReplyInsert
 INSERT INTO HP_BOARD_REPLY (																															
 	CO_DIV, 								TYPE, 							IDX,																				
 	SEQ, 										TITLE, 							CONTENT,																		
 	DEL_DIV, 						INPUT_STAFF, 																
 	INPUT_DATETIME, 				INPUT_IP, 					UPDATE_STAFF,																
 	UPDATE_DATETIME, 				UPDATE_IP																												
 ) VALUES (																																								
 	' & coDiv & ', 				' & sType & ', 		' & sIdx & ',															
 	' & seq & ', 					'', 								' & content & ',													
 	'0', 								' & Session(MS_NUM) & ',								
 	NOW(), 									' & ip & ', 			' & Session(MS_NUM) & ',								
 	NOW(), 									' & ip & '																										
 )

-- 조인게시판 조인캘린더
 SELECT A.CL_SOLAR 											AS CL_SOLAR				
 		 , SUBSTRING(A.CL_SOLAR, 7, 2) + 0 	AS DAYNUM					
 		 , A.CL_DAYDIV 											AS CL_DAYDIV			
 		 , A.CL_BUSINESS 										AS CL_BUSINESS		
 		 , IFNULL(B.TEAM_CNT_1, 0)  				AS TEAM_CNT_1			
 		 , IFNULL(B.TEAM_CNT_2, 0)  				AS TEAM_CNT_2			
   FROM CL_DAYINFO A																				
   LEFT OUTER JOIN (																				
 			SELECT CO_DIV																				
 					 , BK_DAY																				
 					 , SUM(IF(BOARD_DIV = '1', 1, 0)) AS TEAM_CNT_1	
 					 , SUM(IF(BOARD_DIV = '2', 1, 0)) AS TEAM_CNT_2	
 			  FROM HP_BOARD																			
 			 WHERE CO_DIV = ' & coDiv & '											
 			   AND TYPE = '6'																		
 			   AND DEL_DIV <> '1'																
 			   AND BK_DAY LIKE CONCAT(' & selYm & ', '%')												
 		 	 GROUP BY CO_DIV, BK_DAY														
   ) B																											
     ON A.CO_DIV = B.CO_DIV																
    AND A.CL_SOLAR = B.BK_DAY															
  WHERE A.CO_DIV = ' & coDiv & '													
    AND A.CL_SOLAR LIKE CONCAT(' & selYm & ', '%')				
  GROUP BY A.CL_SOLAR																			
  ORDER BY A.CL_SOLAR																			
 
-- 홀인원 게시판
-- 달력 계산을 위한 현재 날짜
-- BoardHonor1
select DATE_FORMAT(NOW(),'%Y%m%d') NOWDATE, DATE_FORMAT(NOW(),'%W') NOWDAY, DATE_FORMAT(NOW(),'%H') NOWHOUR 
from dual  

-- BoardHonor2
SELECT COUNT(holl_msname) 
FROM ms_hollhist 
WHERE co_div = '501' 
ORDER BY holl_day DESC, HOLL_SEQ  
  
-- BoardHonor3
SELECT DATE_FORMAT(HOLL_DAY,'%Y.%m.%d') HOLL_DAY
     , replace(HOLL_MSNAME, substr(HOLL_MSNAME, 2, 1), '*') HOLL_MSNAME
     ,(case
      when HOLL_DIV = '01' then '알바트로스'
      when HOLL_DIV = '02' then '홀인원'
      when HOLL_DIV = '03' then '이글'
      end) as HOLL_DIV
     , HOLL_COS
     , HOLL_TIME
     , HOLL_NO
     , HOLL_BALL
     , HOLL_CLUB
     , HOLL_DIV
     , CONCAT(HOLL_DONG1,' ',HOLL_DONG2,' ',HOLL_DONG3) HOLL_DONG
FROM ms_hollhist
WHERE co_div = '501'
ORDER BY HOLL_DAY DESC, HOLL_SEQ
LIMIT 0, 10
 
-- ---------------
-- 달력 날짜 생성 
-- 등록년도 월 입력해야함 202201%
 
insert into cl_dayinfo (co_div, cl_solar, cl_lunar, cl_daydiv, cl_business, input_staff, input_datetime, input_ip, update_staff, update_datetime, update_ip, biz_id,amt_yn,cl_work,cl_bk_start,cl_day_week,cl_month_week,cl_year_week,cl_rain,will_magam_yn,will_card_yn,will_grup_yn,cl_c_business)
   select co_div, cl_solar, cl_solar as cl_lunar, DAYOFWEEK(cl_solar)  as cl_daydiv
   , case DAYOFWEEK(cl_solar) when 7 then '2' when 1 then '3' else '1' end  as cl_business
   , 'danny' as input_staff, now() as input_datetime, '127.0.0.1' as input_ip
   , 'danny' as update_staff, now() as update_datetime, '127.0.0.1' as update_ip
   , biz_id,amt_yn,cl_work,cl_bk_start,cl_day_week,cl_month_week,cl_year_week,cl_rain,will_magam_yn,will_card_yn,will_grup_yn,cl_c_business
     from (select co_div, concat('2023', substr(cl_solar, 5, 4)) as cl_solar, biz_id,amt_yn,cl_work,cl_bk_start,cl_day_week,cl_month_week,cl_year_week,cl_rain,will_magam_yn,will_card_yn,will_grup_yn,cl_c_business from CL_DAYINFO where co_div = '501' and cl_solar like '202201%') t

 
-- 날짜 생성 쿼리
-- replace(bk_day,'20221108','20231231') as bk_day  
-- 20221108 데이터 가져올 날짜 20231231 생성할 날짜
insert into bk_history 
	(
	co_div
	, bk_day
	, bk_cos
	, bk_time
	, bk_part
	, bk_roundf
	, bk_media
	, bk_person
	, bk_yn
	, bk_cart_cnt
	, rain_chk
	, bk_cs
	, bk_cert_yn
	, bk_en
	, input_staff
	, input_datetime
	, input_ip
	, update_staff
	, update_datetime
	, update_ip
	, bk_sun_amt
	, bk_next_yn
	, bk_unsigned_yn
	, bk_golfday_yn
	, BK_IMN_YN
	, BK_ADV_YN
	, BK_JOIN_YN
	, BK_RELE_YN
	, BK_MATCH_PRO_CHASU
	, BK_MATCH_VALUE
	, BK_AUTH_YN
	, BK_NOSHOW_YN
	, BK_KIOSK_PERSON
	)
select co_div
	, replace(bk_day,'20221108','20221230') as bk_day
	, bk_cos
	, bk_time
	, bk_part
	, bk_roundf
	, bk_media
	, bk_person
	, bk_yn
	, bk_cart_cnt
	, rain_chk
	, bk_cs
	, bk_cert_yn
	, bk_en
	, input_staff
	, input_datetime
	, input_ip
	, update_staff
	, update_datetime
	, update_ip
	, bk_sun_amt
	, bk_next_yn
	, bk_unsigned_yn
	, bk_golfday_yn
	, BK_IMN_YN
	, BK_ADV_YN
	, BK_JOIN_YN
	, BK_RELE_YN
	, BK_MATCH_PRO_CHASU
	, BK_MATCH_VALUE
	, BK_AUTH_YN
	, BK_NOSHOW_YN
	, BK_KIOSK_PERSON
FROM bk_history 
WHERE co_div='501' 
AND bk_day='20221108'
 
-- 회원탈퇴 
-- doDeleteMemeber1
 SELECT COUNT(*) AS CNT                        
   FROM BK_HISTORY                             
  WHERE CO_DIV = ' & coDiv & '               
    AND BK_DAY >= DATE_FORMAT(NOW(), '%Y%m%d') 
    AND BK_MSNUM = ' & Session(MS_NUM) & ' 

-- doDeleteMemeber2
 SELECT COUNT(*) AS CNT                             
   FROM BL_BREACH                                   
  WHERE CO_DIV = ' & coDiv & '                    
    AND BL_MSNUM = ' & Session(MS_NUM) & '      
    AND BL_BK_NOEND >= DATE_FORMAT(NOW(), '%Y%m%d')     
    
-- doDeleteMemeber2
    UPDATE MS_MAININFO 
    SET MS_BLANK = 'Y' 
    WHERE MS_NUM = '" & Session("MS_NUM") & "'
    
-- 아이디 찾기    
-- doFindId 
  SELECT MS_ID                     															
    FROM MS_MAININFO               															
   WHERE MS_MAIN_CODIV = ' & coDiv & '  												
     AND MS_NAME = ' & name & '  															
     AND CONCAT(MS_FIRST_PHONE1																	
 			 , CAST(AES_DECRYPT(UNHEX(MS_MID_PHONE1),'JBOG') AS CHAR)	
 			 , MS_LAST_PHONE1) = ' & phone & '   										
     AND IFNULL(NULLIF(MS_BLANK,''),'N') = 'N'
     
-- 비밀번호 찾기
-- doFindPw1
  SELECT MS_NUM																									
    		, CONCAT(MS_FIRST_PHONE1                     							
    		, CAST(AES_DECRYPT(UNHEX(MS_MID_PHONE1),'JBOG') AS CHAR)  
    		, MS_LAST_PHONE1) AS MS_PHONE  														
    FROM MS_MAININFO               															
   WHERE MS_MAIN_CODIV = ' & coDiv & '  												
     AND MS_NAME = ' & name & '  															
     AND MS_ID = ' & id & '  																	
     AND IFNULL(NULLIF(MS_BLANK,''),'N') = 'N'
-- doFindPw2
UPDATE MS_MAININFO
SET MS_PASSWORD = SHA2('" & newPw & "', 256) 
WHERE MS_NUM = '" & msNum & "'     
     
-- 예약변경     
-- 애러코드 4000 내장처리등록 - (날짜/시간/코스) 등록 쿼리
INSERT INTO podo.en_history
(co_div, en_chkinno, en_day, en_cos, en_time, en_name, en_payclose, en_hole, en_round, en_locker, en_gpnum, en_charge, en_sale_charge, en_sale_div, en_sex, en_foreign, en_cart, en_msnum, en_ms_id, en_total, en_green_sum, en_green_cost, en_green_vat, en_spec_tax, en_edu_tax, en_sport_tax, en_farm_tax, en_soci_tax, en_other_tax, en_cart_sum, en_cart_cost, en_cart_vat, en_rent_sum, en_rent_cost, en_rent_vat, en_payment, en_billno, en_caddy_amount, en_cartno, en_caddynum, en_return, en_lock_prt, en_cert_no, en_agree_yn, en_caddy_prt, en_sun_payment, en_joy_yn, en_so_yn, en_cart_pass, en_chkin_yn, en_late_yn, input_staff, input_datetime, input_ip, update_staff, update_datetime, update_ip, en_old_green, en_discount_amt, en_sale_amount, jb_chkinno, en_label, en_msdiv, en_unsigned_yn, en_msclass, en_main_codiv, en_mslevel, EN_VISITID, EN_OLD_MC_COST, EN_OLD_LEVEL, EN_SUNBUL_YN, EN_CSALE_AMOUNT, EN_CSALE_DIV)
VALUES('501', 'G40000332167', '20221231', 'B', '0612', '대니', NULL, 18, '1', '', '2020000001', 'P0015', '', '', '1', '1', NULL, '', '', 162500, 140000, 127273, 12727, 0, 0, 0, 0, 0, 0, 22500, 20455, 2045, 0, 0, 0, 'N', NULL, 0, NULL, '', 'N', 'N', '', '', 'N', '', '', 'N', '', 'N', 'N', 'TEST', '2022-10-25 09:54:09', '10.3.60.135', 'TEST', '2022-10-25 09:54:09', '10.3.60.135', 140000, 0, 0, NULL, NULL, '20', 'N', '01', '501', '10', NULL, NULL, NULL, 'N', 0, '');

-- 디바이스 정보 가져오기
-- 오늘 날짜 row 생성여부
--deviceIdentification1
Select * from web_statics WHERE S_DATE = DATE_FORMAT(NOW(),'%Y%m%d')

--deviceIdentification2
insert into web_statics (s_date, s_web_cnt, s_mobile_cnt, s_android_cnt, s_ios_cnt) 
values (
DATE_FORMAT(NOW(),'%Y%m%d')
, & web_cnt &
, & mobile_cnt &
, & android_cnt &
, & ios_cnt &
)

--deviceIdentification3
update web_statics 
set s_date = DATE_FORMAT(NOW(),'%Y%m%d')
, s_web_cnt = s_web_cnt + & web_cnt &
, s_mobile_cnt = s_mobile_cnt + & mobile_cnt &
, s_android_cnt = s_android_cnt + & android_cnt &
, s_ios_cnt = s_ios_cnt + & ios_cnt & 
where s_date = DATE_FORMAT(NOW(),'%Y%m%d')







