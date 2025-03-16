package Models;

/**
 *
 * @author PC
 */
public class Booking {
    private int bookingID;
    private int customerID;
    private Integer driverID;  
    private Integer carID;     
    private String startDestination;
    private String endDestination;
    private String startLocationName; 
    private String endLocationName;   
    private String bookingDateTime;
    private double amount;
    private String status;
    private String bookingTime;

    private String description;
    private String address;    
    private String customerName;
    private String customerMobile; 
    private String driverName;
    private String carModel;
    private String carPlateNumber;
    private String vehicleType;
    
    
    public Booking() {
    }
    
    public int getBookingID() { return bookingID; }
    public void setBookingID(int bookingID) { this.bookingID = bookingID; }
    
    public int getCustomerID() { return customerID; }
    public void setCustomerID(int customerID) { this.customerID = customerID; }
    
    public Integer getDriverID() { return driverID; }
    public void setDriverID(Integer driverID) { this.driverID = driverID; }
    
    public Integer getCarID() { return carID; }
    public void setCarID(Integer carID) { this.carID = carID; }
    
    public String getStartDestination() { return startDestination; }
    public void setStartDestination(String startDestination) { this.startDestination = startDestination; }
    
    public String getEndDestination() { return endDestination; }
    public void setEndDestination(String endDestination) { this.endDestination = endDestination; }
    
    public String getStartLocationName() { return startLocationName; }
    public void setStartLocationName(String startLocationName) { this.startLocationName = startLocationName; }
    
    public String getEndLocationName() { return endLocationName; }
    public void setEndLocationName(String endLocationName) { this.endLocationName = endLocationName; }
    
    public String getBookingDateTime() { return bookingDateTime; }
    public void setBookingDateTime(String bookingDateTime) { this.bookingDateTime = bookingDateTime; }
    
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getBookingTime() { return bookingTime; }
    public void setBookingTime(String bookingTime) { this.bookingTime = bookingTime; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    
    public String getCustomerMobile() { return customerMobile; }
    public void setCustomerMobile(String customerMobile) { this.customerMobile = customerMobile; }
    
    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }
    
    public String getCarModel() { return carModel; }
    public void setCarModel(String carModel) { this.carModel = carModel; }
    
    public String getCarPlateNumber() { return carPlateNumber; }
    public void setCarPlateNumber(String carPlateNumber) { this.carPlateNumber = carPlateNumber; }
    
    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }

}