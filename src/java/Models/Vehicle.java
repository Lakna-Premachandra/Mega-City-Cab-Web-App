/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author PC
 */

public class Vehicle {
    private int carId;
    private String model;
    private int year;
    private String plateNumber;
    private String licenseNumber;
    private String vehicleType;

    private String driverName;
    private boolean isAssigned;
    
    public Vehicle() {
    }
    
    public Vehicle(int carId, String model, int year, String plateNumber, String licenseNumber, String vehicleType) {
        this.carId = carId;
        this.model = model;
        this.year = year;
        this.plateNumber = plateNumber;
        this.licenseNumber = licenseNumber;
        this.vehicleType = vehicleType;
    }
    
    public int getCarId() {
        return carId;
    }
    
    public void setCarId(int carId) {
        this.carId = carId;
    }
    
    public String getModel() {
        return model;
    }
    
    public void setModel(String model) {
        this.model = model;
    }
    
    public int getYear() {
        return year;
    }
    
    public void setYear(int year) {
        this.year = year;
    }
    
    public String getPlateNumber() {
        return plateNumber;
    }
    
    public void setPlateNumber(String plateNumber) {
        this.plateNumber = plateNumber;
    }
    
    public String getLicenseNumber() {
        return licenseNumber;
    }
    
    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }
    
    public String getVehicleType() {
        return vehicleType;
    }
    
    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }
    
    public boolean isAssigned() { return isAssigned; }
    public void setAssigned(boolean isAssigned) { this.isAssigned = isAssigned; }
  
    @Override
    public String toString() {
        return "Car [carId=" + carId + ", model=" + model + ", year=" + year 
                + ", plateNumber=" + plateNumber + ", vehicleType=" + vehicleType + "]";
    }
}
