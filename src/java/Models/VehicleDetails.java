/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author PC
 */
public class VehicleDetails {
    private int carID;
    private String model;
    private int year;
    private String plateNumber;

    public VehicleDetails(String model, int year, String plateNumber) {
        this.model = model;
        this.year = year;
        this.plateNumber = plateNumber;
    }

    public VehicleDetails(int carID, String model, int year, String plateNumber) {
        this.carID = carID;
        this.model = model;
        this.year = year;
        this.plateNumber = plateNumber;
    }

    public int getCarID() {
        return carID;
    }

    public void setCarID(int carID) {
        this.carID = carID;
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
}


