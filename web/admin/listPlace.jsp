<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 2018/12/11
  Time: 20:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>

<script>
$(function () {
    $("#addForm").submit(function () {
        if (!checkEmpty("name", "场馆名称"))
            return false;
        if (!checkEmpty("location", "场馆地址"))
            return false;
        if (!checkEmpty("introduction", "场馆介绍"))
            return false;
        if (!checkEmpty("placePic", "场馆图片"))
            return false;
        return true;
    });
});

</script>

<title>场馆管理</title>

<div class="workingArea">
    <h1 class="label label-info">场馆管理</h1>
    <br>
    <br>

    <div class="listDataTableDiv">
        <div>
            <button type="button" class="btn btn-info"  data-toggle="modal" data-target="#addVenueModel" style="margin-bottom: 5px;"> 添加</button>
        </div>
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>图片</th>
                    <th>场馆名称</th>
                    <th>场馆地址</th>
                    <th>场地安排</th>
                    <th>场地信息</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${places}" var="p">

                    <tr>
                        <td>${p.id}</td>
                        <td><img height="40px" src="image/place/${p.id}.jpg"></td>
                        <td>${p.name}</td>
                        <td >
                            ${p.location}
                        </td>
                        <td style="display: none;">
                            ${p.ename}
                        </td>
                        <td style="display: none;">
                                ${p.introduction}
                        </td>
                        <td><a href="admin_stadiumPlan_list?pid=${p.id}&psid=0"><span class="glyphicon glyphicon-align-justify"></span> </a></td>
                        <td><a href="admin_placeStadium_list?pid=${p.id}"><span class="glyphicon glyphicon-th-list"></span></a></td>
                        <td><a href="javascript:void(0)" class="edit-place"><span class="glyphicon glyphicon-edit"></span></a></td>
                        <td><a deleteLink="true" href="admin_place_delete?id=${p.id}"><span class="glyphicon glyphicon-trash"></span></a></td>

                    </tr>

                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pageDiv">
        <%@ include file="../include/admin/adminPage.jsp" %>
    </div>

<!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="addVenueModel" tabindex="-1" role="dialog" aria-labelledby="addVenueModel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加场馆</h4>
            </div>
            <div class="modal-body">
                <form method="post" id="addForm" action="admin_place_add" enctype="multipart/form-data">
                    <table class="addTable">
                        <tr>
                            <td>场馆名称</td>
                            <td><input id="name" name="name" type="text" class="form-control"/></td>
                        </tr>
                        <tr>
                            <td>英文名称</td>
                            <td>
                                <input id="ename" name="ename" type="text" class="form-control"/>
                            </td>
                        </tr>
                        <tr>
                            <td>场馆地址</td>
                            <td>
                                <input id="location" name="location" type="text" class="form-control" />
                            </td>
                        </tr>
                        <tr>
                            <td>场馆简介</td>
                            <td>
                                <textarea id="introduction" name="introduction" class="form-control"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>场馆图片</td>
                            <td>
                                <input id="placePic" accept="image/*" type="file" name="filepath" />
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
    <div class="modal fade" id="editVenueModel" tabindex="-1" role="dialog" aria-labelledby="editVenueModel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="editVenue">编辑场馆</h4>
                </div>
                <div class="modal-body">
                    <form id="edit-form" method="post" action="admin_place_update">
                        <input type="hidden" id="edit-id" name="id"/>
                        <div class="form-group">
                            <label>场馆名称</label>
                            <input id="edit-name" name="name" type="text" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label >英文名称</label>
                            <input id="edit-ename" name="ename" type="text" class="form-control"/>
                        </div>

                        <div class="form-group">
                            <label >场馆地址</label>
                            <input id="edit-location" name="location" type="text" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label >场馆简介</label>
                            <textarea id="edit-introduction" name="introduction" class="form-control"></textarea>
                        </div>
                        <div class="form-group">
                            <label >场馆图片</label>
                            <img height="100px" width="100px" id="edit-image" src="" >
                            <input id="edit-placePic" accept="image/*" type="file" name="filepath" />
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
    <script type="text/javascript">
        $(".edit-place").click(function(){
            var arr=new Array();
            for(var i=0;i<6;i++){
                var value=$($(this).closest("tr").find("td")[i])[0].innerText;
                arr.push(value);
            }
            $("#edit-id").val(arr[0]);
            $("#edit-image").attr("src","image/place/"+arr[0]+".jpg");
            $("#edit-name").val(arr[2]);
            $("#edit-ename").val(arr[4].trim());
            $("#edit-location").val(arr[3]);
            $("#edit-introduction").val(arr[5].trim());
            $("#editVenueModel").modal('show');
        })
        $("#edit-save").click(function(){
            if (!checkEmpty("edit-name", "场馆名称"))
                return;
            if (!checkEmpty("edit-location", "场馆地址"))
                return;
            if (!checkEmpty("edit-introduction", "场馆介绍"))
                return;
            if (!checkEmpty("edit-ename", "英文名称"))
                return;
            document.getElementById("edit-form").submit();
        });
    </script>