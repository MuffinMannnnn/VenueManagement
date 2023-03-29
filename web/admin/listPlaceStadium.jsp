<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 2018/12/16
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>


<title>场地管理</title>

<div class="workingArea">

    <ol class="breadcrumb">
        <li><a href="admin_place_list">场馆管理</a></li>
        <li>${place.name}</li>
        <li><a href="admin_placeStadium_list?pid=${place.id}">场地管理</a></li>
    </ol>

    <div class="listDataTableDiv">
        <div>
            <button type="button" class="btn btn-info"  data-toggle="modal" data-target="#addAreaModel" style="margin-bottom: 5px;"> 添加</button>
        </div>
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
            <tr class="success">
                <th>ID</th>
                <th>场地名称</th>
                <th>数量</th>
                <th>费用/小时</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${placeStadiums}" var="ps">

                <tr>
                    <td>${ps.id}</td>
                    <td>${ps.name}</td>
                    <td>${ps.num}</td>
                    <td>${ps.fare}</td>
                    <td><a href="javascript:void(0)" class="edit-stadiums"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <td><a deleteLink="true" href="admin_placeStadium_delete?id=${ps.id}&pid=${place.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                </tr>

            </c:forEach>
            </tbody>
        </table>
    </div>

</div>
<!-- Modal -->
<div class="modal fade" id="addAreaModel" tabindex="-1" role="dialog" aria-labelledby="addVenueModel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加场地</h4>
            </div>
            <div class="modal-body">
                <form method="post" onsubmit="return checkForm()" id="add-form" action="admin_placeStadium_add?pid=${place.id}" enctype="multipart/form-data">
                    <table class="addTable">
                        <tr>
                            <td>场地名称</td>
                            <td><input id="name" name="name" type="text" class="form-control"/></td>
                        </tr>
                        <tr>
                            <td>场地数量</td>
                            <td>
                                <input id="num" name="num" type="text" class="form-control"/>
                            </td>
                        </tr>
                        <tr>
                            <td>场地费用/小时</td>
                            <td>
                                <input id="fare" name="fare" type="text" class="form-control" />
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

<div class="modal fade" id="editAreaModel" tabindex="-1" role="dialog" aria-labelledby="editAreaModel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="editVenue">编辑场地</h4>
            </div>
            <div class="modal-body">
                <form id="edit-form" method="post" action="admin_placeStadium_update">
                    <input type="hidden" id="edit-id" name="id"/>
                    <input type="hidden" name="pid" value="${place.id}" />
                    <div class="form-group">
                        <label>场地名称</label>
                        <input id="edit-name" name="name" type="text" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label >场地数量</label>
                        <input id="edit-num" name="num" type="text" class="form-control"/>
                    </div>

                    <div class="form-group">
                        <label >场地费用/小时</label>
                        <input id="edit-fare" name="fare" type="text" class="form-control" />
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
    $(".edit-stadiums").click(function(){
        var arr=new Array();
            for(var i=0;i<4;i++){
                var value=$($(this).closest("tr").find("td")[i])[0].innerText;
                arr.push(value);
            }
            $("#edit-id").val(arr[0]);
        $("#edit-name").val(arr[1]);
        $("#edit-num").val(arr[2]);
        $("#edit-fare").val(arr[3]);
      $("#editAreaModel").modal('show');
    })

    $("#edit-save").click(function(){
        if (!checkEmpty("edit-name", "场地名称"))
            return;
        if (!checkEmpty("edit-num", "场地数量"))
            return;
        if (!checkEmpty("edit-fare", "场地费用"))
            return;
        document.getElementById("edit-form").submit();
    })
    function checkForm(){
        if (!checkEmpty("name", "场地名称"))
            return false;
        if (!checkEmpty("num", "场地数量"))
            return;
        if (!checkEmpty("fare", "场地费用"))
            return;
        return true;
    }
</script>
