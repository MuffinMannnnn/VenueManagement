package project.servlet;

import project.bean.Place;
import project.bean.PlaceStadium;
import project.bean.StadiumPlan;
import project.util.Page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class StadiumPlanServlet extends BaseBackServlet{
    public String add(HttpServletRequest request, HttpServletResponse response, Page page) {
        return null;
    }
    public String delete(HttpServletRequest request, HttpServletResponse response, Page page) {
        return null;
    }
    public String edit(HttpServletRequest request, HttpServletResponse response, Page page) {
        return null;
    }

    public String update(HttpServletRequest request, HttpServletResponse response, Page page) {
        int pid = Integer.parseInt(request.getParameter("pid"));
        int psid = Integer.parseInt(request.getParameter("psid"));
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        try{
            stadiumPlanItemDAO.edit(itemId,"已预约");
        }catch (Exception e){
            e.printStackTrace();
        }
        return "@admin_stadiumPlan_list?pid=" + pid + "&psid=" + psid + "&date=" + request.getParameter("date");
    }

    //列出pid场馆，psid场地，date日的安排列表
    public String list(HttpServletRequest request, HttpServletResponse response, Page page) throws IOException {
        int pid = Integer.parseInt(request.getParameter("pid"));
        Place place = placeDAO.get(pid);
        List<PlaceStadium> placeStadiums = placeStadiumDAO.list(pid);
        //获取场地id号
        int psid = Integer.parseInt(request.getParameter("psid"));
        PlaceStadium placeStadium=new PlaceStadium();
        if(psid!=0){
            placeStadium = placeStadiumDAO.get(psid);
        }else{
         if(placeStadiums.size()>0){
             psid=placeStadiums.get(0).getId();
             placeStadium = placeStadiumDAO.get(psid);
         }
        }
        request.setAttribute("placeStadium", placeStadium);
        //获取请求日期
        String time = request.getParameter("date");
        java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
        if (time != null) {
            date = java.sql.Date.valueOf(time);
        }


        //获取能获取的有效日期
        Date current = new Date(System.currentTimeMillis());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(current);
        List<java.sql.Date> dateValid = new ArrayList<>();
        calendar.add(Calendar.DATE, 0);
        dateValid.add(new java.sql.Date(calendar.getTimeInMillis()));
        calendar.add(Calendar.DATE, 1);
        dateValid.add(new java.sql.Date(calendar.getTimeInMillis()));
        calendar.add(Calendar.DATE, 1);
        dateValid.add(new java.sql.Date(calendar.getTimeInMillis()));

        //获取所有场的安排表

        List<StadiumPlan> stadiumPlanList = stadiumPlanDAO.search(psid, date);
        request.setAttribute("place", place);
        request.setAttribute("placeStadiums", placeStadiums);
        request.setAttribute("stadiumPlanList", stadiumPlanList);
        request.setAttribute("dates", dateValid);
        request.setAttribute("date", date);
        request.setAttribute("name", placeStadium.getName());

        return "admin/listStadiumPlan.jsp";
    }

}
