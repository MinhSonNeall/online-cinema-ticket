/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author Cuong
 */
public class DateItem {
    private String day;
    private String dayName;
    private boolean active;
    private String fullDate;

    public DateItem() {
    }

    public DateItem(String day, String dayName, boolean active) {
        this.day = day;
        this.dayName = dayName;
        this.active = active;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getDayName() {
        return dayName;
    }

    public void setDayName(String dayName) {
        this.dayName = dayName;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getFullDate() {
        return fullDate;
    }

    public void setFullDate(String fullDate) {
        this.fullDate = fullDate;
    }
    
    
    
}
