/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

/**
 *
 * @author PC
 */
public class SimpleJsonBuilder {
    private StringBuilder json;
    
    public SimpleJsonBuilder() {
        json = new StringBuilder("{");
    }
    
    public SimpleJsonBuilder add(String key, String value) {
        if (json.length() > 1) {
            json.append(",");
        }
        json.append("\"").append(key).append("\":\"").append(value).append("\"");
        return this;
    }
    
    public SimpleJsonBuilder add(String key, int value) {
        if (json.length() > 1) {
            json.append(",");
        }
        json.append("\"").append(key).append("\":").append(value);
        return this;
    }
    
    public SimpleJsonBuilder add(String key, double value) {
        if (json.length() > 1) {
            json.append(",");
        }
        json.append("\"").append(key).append("\":").append(value);
        return this;
    }
    
    public SimpleJsonBuilder add(String key, boolean value) {
        if (json.length() > 1) {
            json.append(",");
        }
        json.append("\"").append(key).append("\":").append(value);
        return this;
    }
    
    public String build() {
        return json.append("}").toString();
    }
}
