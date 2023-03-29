package project.servlet;

import org.apache.commons.lang.StringUtils;
import project.bean.Place;
import project.dao.PlaceDAO;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import project.util.ImageUtil;
import project.util.Page;

public class PlaceServlet extends BaseBackServlet {

    public String add(HttpServletRequest request, HttpServletResponse response, Page page) {
        Map<String, String> params = new HashMap<>();
        InputStream is = super.parseUpload(request, params);

        Place place = new Place();

        place.setName(params.get("name"));
        place.setEname(params.get("ename"));
        place.setLocation(params.get("location"));
        place.setIntroduction(params.get("introduction"));
        placeDAO.add(place);

        File imageFolder = new File(request.getSession().getServletContext().getRealPath("image/place"));
        //System.out.println(request.getSession().getServletContext().getRealPath("image/place"));
        File file = new File(imageFolder, place.getId() + ".jpg");


        try {
            if (is != null && is.available() != 0) {
                try(FileOutputStream fos = new FileOutputStream(file)) {
                    byte b[] = new byte[1024 * 1024];
                    int length = 0;
                    while ((length = is.read(b)) != -1) {
                        fos.write(b, 0, length);
                    }
                    fos.flush();
                    BufferedImage img = ImageUtil.change2jpg(file);
                    ImageIO.write(img, "jpg", file);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "@admin_place_list";
    }

    public String delete(HttpServletRequest request, HttpServletResponse response, Page page) {
        int id = Integer.parseInt(request.getParameter("id"));
        placeDAO.delete(id);
        return "@admin_place_list";
    }

    public String edit(HttpServletRequest request, HttpServletResponse response, Page page) {
        return "";
    }

    public String update(HttpServletRequest request, HttpServletResponse response, Page page) throws UnsupportedEncodingException {
        Place place = new Place();
        Map<String, String> params = new HashMap<>();
        String name = new String(request.getParameter("name").getBytes("iso-8859-1"), "utf-8");
        String ename = new String(request.getParameter("ename").getBytes("iso-8859-1"), "utf-8");
        String location = new String(request.getParameter("location").getBytes("iso-8859-1"), "utf-8");
        String introduction = new String(request.getParameter("introduction").getBytes("iso-8859-1"), "utf-8");
        place.setId(Integer.parseInt(request.getParameter("id")));
        place.setName(name);
        place.setEname(ename);
        place.setLocation(location);
        place.setIntroduction(introduction);
        placeDAO.update(place);
        String filepath = new String(request.getParameter("filepath").getBytes("iso-8859-1"), "utf-8");
        if(!StringUtils.isEmpty(filepath)){
            File imageFolder = new File(request.getSession().getServletContext().getRealPath("image/place"));
            File file = new File(imageFolder, place.getId() + ".jpg");
            InputStream is = super.parseUpload(request, params);
            try {
                if (is != null && is.available() != 0) {
                    try(FileOutputStream fos = new FileOutputStream(file)) {
                        byte b[] = new byte[1024 * 1024];
                        int length = 0;
                        while ((length = is.read(b)) != -1) {
                            fos.write(b, 0, length);
                        }
                        fos.flush();
                        BufferedImage img = ImageUtil.change2jpg(file);
                        ImageIO.write(img, "jpg", file);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "@admin_place_list";
    }


    public String list(HttpServletRequest request, HttpServletResponse response, Page page) {
        List<Place> places = placeDAO.list(page.getStart(), page.getCount());
        int total = placeDAO.getTotal();
        page.setTotal(total);

        request.setAttribute("places", places);
        request.setAttribute("page", page);

        return "admin/listPlace.jsp";
    }


}
