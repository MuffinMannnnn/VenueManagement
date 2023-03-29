package project.bean;

/**
 * @Author:Jesse
 * @Version:1.0
 * @Date:2023/1/5 - 15:11
 * @Since:jdk1.8
 * @Description:场地图片实体类
 */

public class PlaceImage {
    private String type;
    private Place place;
    private int id;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Place getPlace() {
        return place;
    }

    public void setPlace(Place place) {
        this.place = place;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
