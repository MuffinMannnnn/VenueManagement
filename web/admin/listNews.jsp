<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 2018/12/24
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>

<script>
    $(function () {
        $("#addForm").submit(function () {
            if (!checkEmpty("title", "通知标题"))
                return false;
            if (!checkEmpty("content", "通知内容"))
                return false;
            return true;
        });
    });

</script>


<title>通知管理</title>

<div class="workingArea">
    <h1 class="label label-info">通知管理</h1>

    <br>
    <br>

    <div class="listDataTableDiv">
        <div>
            <button type="button" class="btn btn-info"  data-toggle="modal" data-target="#addNewsModel" style="margin-bottom: 5px;"> 添加</button>
        </div>
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
            <tr class="success">
                <th>ID</th>
                <th>通知标题</th>
                <th>通知内容</th>
                <th>通知时间</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${news}" var="n">
                <tr>
                    <td>${n.id}</td>
                    <td>${n.title}</td>
                    <td>${n.content}</td>
                    <td>${n.TIMEX}</td>
                    <td><a href="javascript:void(0)" class="edit-news"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <td><a deleteLink="true" href="admin_news_delete?nid=${n.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                </tr>
            </c:forEach>
            </tbody>

        </table>
    </div>

    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp"%>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="addNewsModel" tabindex="-1" role="dialog" aria-labelledby="addNewsModel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">添加通知</h4>
                </div>
                <div class="modal-body">
                    <form method="post" id="addForm" action="admin_news_add" enctype="multipart/form-data">
                        <table class="addTable">
                            <tr>
                                <td>通知标题</td>
                                <td><input id="title" name="title" type="text" class="form-control"/></td>
                            </tr>
                            <tr>
                                <td>通知内容</td>
                                <td>
                                    <textarea id="content" name="content" class="form-control" style="width: 490px;height: 200px;"></textarea>
                                </td>
                            </tr>
                            <tr class="submitTR">
                                <td colspan="2" align="center">
                                    <button type="submit" class="btn btn-success">提交</button>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="editNewsModel" tabindex="-1" role="dialog" aria-labelledby="editNewsModel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="editVenue">编辑通知</h4>
                </div>
                <div class="modal-body">
                    <form id="edit-form" method="post" action="admin_news_update">
                        <input type="hidden" id="edit-id" name="id"/>
                        <div class="form-group">
                            <label>通知标题</label>
                            <input id="edit-title" name="title" type="text" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label>通知内容</label>
                            <textarea id="edit-content" name="content" class="form-control" style="width: 490px;height: 200px;"></textarea>
                        </div>
                        <button type="button" id="edit-save" class="btn btn-default">提交</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <%@include file="../include/admin/adminFooter.jsp"%>
</div>
<script type="text/javascript">
    $(".edit-news").click(function(){
        var arr=new Array();
        for(var i=0;i<3;i++){
            var value=$($(this).closest("tr").find("td")[i])[0].innerText;
            arr.push(value);
        }
        $("#edit-id").val(arr[0]);
        $("#edit-title").val(arr[1]);
        $("#edit-content").val(arr[2]);
        $("#editNewsModel").modal('show');
    })

    $("#edit-save").click(function(){
        if (!checkEmpty("edit-title", "通知标题"))
            return;
        if (!checkEmpty("edit-content", "通知内容"))
            return;
        document.getElementById("edit-form").submit();
    })

</script>
