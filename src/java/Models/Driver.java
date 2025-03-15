/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author PC
 */

public class Driver {
    private int driverId;
    private int userId;
    private String driverName;
    private String phoneNo;
    private String email;
    private String licenseNumber;
    private int carId;
    private String address; 

    private String username;
    private String carModel;
    private String plateNumber;
    private String vehicleType;
    private String password;
    
    public Driver() {
    }
    
    public Driver(int driverId, int userId, String driverName, String phoneNo, String email, 
                 String licenseNumber, int carId, String address) {
        this.driverId = driverId;
        this.userId = userId;
        this.driverName = driverName;
        this.phoneNo = phoneNo;
        this.email = email;
        this.licenseNumber = licenseNumber;
        this.carId = carId;
        this.address = address;
    }
    
    public int getDriverId() {
        return driverId;
    }
    
    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getDriverName() {
        return driverName;
    }
    
    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }
    
    public String getPhoneNo() {
        return phoneNo;
    }
    
    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getLicenseNumber() {
        return licenseNumber;
    }
    
    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }
    
    public int getCarId() {
        return carId;
    }
    
    public void setCarId(int carId) {
        this.carId = carId;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getCarModel() { return carModel; }
    public void setCarModel(String carModel) { this.carModel = carModel; }
    
    public String getPlateNumber() { return plateNumber; }
    public void setPlateNumber(String plateNumber) { this.plateNumber = plateNumber; }
    
    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    @Override
    public String toString() {
        return "Driver [driverId=" + driverId + ", userId=" + userId + ", driverName=" + driverName 
                + ", email=" + email + ", licenseNumber=" + licenseNumber + "]";
    }
}
