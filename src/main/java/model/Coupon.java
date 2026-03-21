package model;

public class Coupon {
    private int id;
    private String code;
    private String type; // 'percentage' or 'fixed'
    private double value;
    private double minOrder;
    private boolean active;

    public Coupon() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public double getValue() { return value; }
    public void setValue(double value) { this.value = value; }

    public double getMinOrder() { return minOrder; }
    public void setMinOrder(double minOrder) { this.minOrder = minOrder; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
