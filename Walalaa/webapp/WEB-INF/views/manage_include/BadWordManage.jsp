<%@page import="com.utf18.site.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->

<title>Customizing Word setting</title>

<!-- 부트스트랩 -->
<link
   href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css"
   rel="stylesheet">

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script type="text/javascript"
   src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>

<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
<script
   src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
body {
   padding: 10px;
   margin: 0px;
   font-family: 'Jeju Gothic', sans-serif;
   font-size: 17px;
}

div.main {
   width: 100%;
   height: 70%;
   padding-top: 5px;
   margin: 0px;
   border-bottom: 1px lightgray solid;
}

div.sub {
   display: inline-flex;
   margin-right: -3px;
   margin-left: -3px;
}

div.checkbox {
   width: 25%;
   height: 100%;
   padding-left: 3%;
}

div.customWord {
   width: 60%;
   height: 100%;
}

div.warningCount {
   display: inline-block;
   height: 300px;
   width: 13%;
   position: relative;
   top: 0px;
   left: 3px;
}

table.wordtable {
   width: 100%;
   border-collapse: collapse;
}


tr.wordtr {
   border-bottom: solid 1px lightgray;
}

tr.wordtr>td{
   height: 40px;
}

div.showWaring {
   position: relative;
   top: 18px;
}

#badwordhead {
   border-bottom: 1px solid lightgray;
}

#SettingButton {
   position: relative;
   left: 30%;
   top: 7px;
}

/*    사용자 지정 비속어 단어 입력부분 */
.inputWord {
   padding: 10px 10px 10px 10px;
   width: 100%;
   height: 34px;
   border: 2px solid #9cd1ff;
   font-size: 15px;
}

/*   추가 버튼 */
#addbtn {
   background:
      url(${pageContext.request.contextPath}/assets/images/add4.png) center
      no-repeat #fff;
   width: 54px; height : 34px;
   border: none;
}
/* [호버] 추가 버튼 */
#addbtn:hover {
   background:
      url(${pageContext.request.contextPath}/assets/images/add_hover4.png)
      center no-repeat #fff;
   width: 54px; height : 34px;
   border: none;
}

/*   삭제 버튼 */
.btnDelete {
   background:
      url(${pageContext.request.contextPath}/assets/images/delete03.png) center
      no-repeat #fff;
   width: 30px; height : 33px;
   border: none;
}
/* [호버] 삭제 버튼 */
.btnDelete:hover {
   background:
      url(${pageContext.request.contextPath}/assets/images/delete03_hover.png)
      center no-repeat #fff;
   width: 30px; height : 33px;
   border: none;
}

/*   적용 버튼 */
.btnApply {
   background:
      url(${pageContext.request.contextPath}/assets/images/apply3.png) center
      no-repeat #fff;
   width: 60px; height : 25px;
   border: none;
}
/* [호버] 적용 버튼 */
.btnApply:hover {
   background:
      url(${pageContext.request.contextPath}/assets/images/apply2.png)
      center no-repeat #fff;
   width: 44px; height : 30px;
   border: none;
}
</style>

<script type="text/javascript">
   var Display = true;
   function doDisplay() {
      var con = document.getElementById("showWarning");
      if (con.style.display == 'none') {
         con.style.display = 'block';
      } else {
         con.style.display = 'none';
      }
   }
</script>

   <script>
      var getWarnCnt = 0;
      
      $(document).ready(function() {
         var id = "";
           id = $("#userId").val();
           
           console.log("레디 안 id : " + id);
         
         $.ajax({
               url: "${pageContext.request.contextPath}/getLimitWarnCnt.do",
               type: "post",
               data : {id : id},
               success: function(limitwarncount){ 
                  console.log("getlimit id : " + id);
                  getWarnCnt = limitwarncount;
                  var txt = "비속어가 " + getWarnCnt + "회 감지될 경우, 채팅금지 상태가 됩니다.";
                  document.getElementById('showtxt').innerHTML = txt;
               },
               error : function(XHR, status, error) {
                   console.error(status + " : " + error);
               }                   
            });
      });
   </script>

</head>

<body>
   <%
      UserVO login = (UserVO) session.getAttribute("login");
   %>
   <!--    방번호 확인하기      -->
   <input type="hidden" id="roomNum" name="roomNum" value="${roomNum}" />
   <input type="hidden" id="userId" name="userId" value="${login.email}">

   <!--  사용자 지정 비속어 단어 추가
   <form id="addCustomBadwordForm">
      <input type="hidden" id="id" name="id" value="${login.email}">
      <input type="hidden" id="content" name="content" />
   </form>
    -->
   <div class="main" align="center">
      <div class="customWord sub">
         <table class="wordtable">
            <thead id="badwordhead">
               <tr>
                  <td class="col-xs-1"><label for="inputword"
                     class="control-label" style="min-width: 40px; color: #63b7ff;">입력</label></td>
                  <td class="col-xs-10">
                     <div>
                        <input type="text" class="col-xs-11 form-control inputWord"
                           id="inputBadword" name="inputBadword"
                           placeholder="단어입력 - ex) 뚱때지">
                     </div>
                  </td>

                  <td class="col-xs-1">
                     <button type="button" class="btn" id="addbtn" 
                        onclick="addCustomBadword2('${inputBadword}', '${login.email}');"></button>
                  </td>
               </tr>
               <tr>
                  <td colspan="2">
                     <h3>추가 된 단어 리스트</h3>
                  <td><input id="SettingButton" name="SettingButton"
                      class="btn" type="button" onclick="apply('${login.email}')" value="적용"></td>
                  <!--    btnApply   적용/해제 버튼 이미지 설정     -->
               </tr>

            </thead>
            <tbody id="wordList">
               <!-- 욕 리스트가 로딩될 곳 -->
            </tbody>
         </table>
      </div>

      <div class="warningCount sub">
         <a href="javascript:setwarningCount();" id="awarn">경고 횟수 설정</a>
         <!--          <form action=""> -->
         <div id="showWarning" style="display: none;">
            <table id="warningtable">
               <tr>
                  <td><input type="text" class="form-control" id="inputCount"
                     name="inputCount"></td>
                  <td><button type="button" class="btn" onclick="javascript:setwarn('${login.email}');">설정</button></td>
               </tr>
               <tr>
                  <td colspan="2"> <font color="lightgray"><span id="showtxt"></span></font> </td>
<!--                   <font color="lightgray"> 비속어가 3회 감지될 경우, 채팅금지 상태가 됩니다. -->
               </tr>
            </table>
         </div>
         <!--          </form> -->
      </div>
   </div>

   <script type="text/javascript">
      var str = "";
      var number = 1;
      // 사용자 지정 비속어를 불러옴
      $(document).ready(function() {
         var email = '${login.email}';
         timer = setInterval(function() {
            //DB에 있는 전체 데이터 로딩 ()
            $.ajax({
               url : "getCustomBadwordList.do",
               type : "post",
               data : {email : email},
               dataType : "json",
               success : function(badWordList) {
                  str = "";
                  number = 1;
                  $('#wordList').empty();

                  for (var i = 0; i < badWordList.length; i++) {
                     render(badWordList[i]);
                  }

                  $('#wordList').append(str);
               },
               error : function(XHR, status, error) {
                  console.error(status + " : " + error);
               }
            });
         }, 1000); // 1초에 한번씩 받아온다.
      });

      // 추가 버튼 눌렀을 때
      function addCustomBadword2(inputBadword, inputEmail) {
         // $("#content").val(word); $("#addCustomBadwordForm").submit();         
         var email = inputEmail;
         var content = $("[name=inputBadword]").val();
         
         $('#inputBadword').val('');
         
         $.ajax({
            //async: false,
            type : "post",
            url : "addCustomBadword.do",
            data : {
               email : email,
               content : content
            },
            success : function() {
//                alert("추가되었습니다!!!!!!!!!!!!!!");
            },
            error : function(req, status, errThrown) {
               alert("network error occur");
            }
         });
      }

      function render(CustomBadwordVO) {
         str += "   <tr class='wordtr'>";
         str += "     <tr class='wordtr'>";
         str += "         <td class='col-xs-1'>" + number + "</td>"
         str += "         <td class='col-xs-10'>" + CustomBadwordVO.content + "</td>";
         str += "            <td class='col-xs-1'>";
         str += "            <button type='submit' class='btn btnright btnDelete' onclick='deleteWord("+ CustomBadwordVO.num + ");'></button>";
         str += "         </td>";
         str += "   </tr>"
         number++;
      }

      // 삭제 버튼 눌렀을 때
      function deleteWord(num) {
         var num = num;
//          alert(num);

         $.ajax({
            type : "post",
            url : "deleteCustomBadword.do",
            data : {
               num : num
            },
            success : function() {
               alert("삭제 완료!");
            },
            error : function(req, status, errThrown) {
               alert("network error occur");
            }
         });
      }
   </script>

   <script type="text/javascript">
      function setwarningCount() {
         document.getElementById('showWarning').style.display = 'flex';
         document.getElementById('awarn').style.display = 'none';
      };

      // 경고 횟수 설정
      function setwarn(inputemail) {
         var input = $("[name=inputCount]").val();
         var email = inputemail;
//          alert(input);

       var txt = "비속어가 " + input + "회 감지될 경우, 채팅금지 상태가 됩니다.";
         
         
         $.ajax({
            type : "post",
            url : "setWarnCount.do",
            data : {
               email : email,
               input : input // manage_warncount
            },
            success : function() {
               alert("경고횟수를 "+input+"으로 설정합니다.");
            },
            error : function(req, status, errThrown) {
               alert("network error occur");
            }
         });
         
         document.getElementById('showWarning').style.display = 'none';
         document.getElementById('awarn').style.display = 'flex';
         document.getElementById('showtxt').innerHTML = txt;

      };
   </script>
   <script type="text/javascript">
//       document.getElementById("SettingButton").onclick = 
         function apply(email){
   
         if (document.getElementById("SettingButton").value == "적용") {
            document.getElementById("SettingButton").value = '해제';         
            $.ajax({
               type : "post",
               url : "apply1.do",
               data : {
                  email : email
               },
               success : function() {
                  alert("리스트에 있는 단어를 채팅방에서 사용하지 못하도록 적용합니다");
               },
               error : function(req, status, errThrown) {
                  alert("network error occur");
               }
            });
         } else {
            document.getElementById("SettingButton").value = '적용';         
            $.ajax({
               type : "post",
               url : "apply0.do",
               data : {
                  email : email
               },
               success : function() {
                  alert("채팅방에 적용된 리스트를 해제합니다");
               },
               error : function(req, status, errThrown) {
                  alert("network error occur");
               }
            });
         }
      };
   </script>
</body>
</html>