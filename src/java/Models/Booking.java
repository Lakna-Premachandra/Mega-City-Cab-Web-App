/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.security.Timestamp;

/**
 *
 * @author PC
 */
public class Booking {
    private int bookingID;
    private int customerID;
    private int driverID;
    private int carID;
    private String startDestination;
    private String endDestination;
    private String bookingDateTime;
    private double amount;
    private String status;
    
    private String customerName;
    private String driverName;
    private String carModel;
    private String carPlateNumber;
    private String vehicleType;

    public int getBookingID() { return bookingID; }
    public void setBookingID(int bookingID) { this.bookingID = bookingID; }
    public int getCustomerID() { return customerID; }
    public void setCustomerID(int customerID) { this.customerID = customerID; }
    public int getDriverID() { return driverID; }
    public void setDriverID(int driverID) { this.driverID = driverID; }
    public int getCarID() { return carID; }
    public void setCarID(int carID) { this.carID = carID; }
    public String getStartDestination() { return startDestination; }
    public void setStartDestination(String startDestination) { this.startDestination = startDestination; }
    public String getEndDestination() { return endDestination; }
    public void setEndDestination(String endDestination) { this.endDestination = endDestination; }
    public String getBookingDateTime() { return bookingDateTime; }
    public void setBookingDateTime(String bookingDateTime) { this.bookingDateTime = bookingDateTime; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }
    public String getCarModel() { return carModel; }
    public void setCarModel(String carModel) { this.carModel = carModel; }
    public String getCarPlateNumber() { return carPlateNumber; }
    public void setCarPlateNumber(String carPlateNumber) { this.carPlateNumber = carPlateNumber; }
    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
    

}

