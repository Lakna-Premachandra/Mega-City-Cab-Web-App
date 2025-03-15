/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author PC
 */

public class Customer {
    private int customerId;
    private int userId;
    private String customerName;
    private String address;
    private String phoneNo;
    private String email;
    private String NIC;
    
    public Customer() {
    }
    
    public Customer(int customerId, int userId, String customerName, String address, String phoneNo, String email, String NIC) {
        this.customerId = customerId;
        this.userId = userId;
        this.customerName = customerName;
        this.address = address;
        this.phoneNo = phoneNo;
        this.email = email;
        this.NIC = NIC;
    }
    
    public int getCustomerId() {
        return customerId;
    }
    
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getCustomerName() {
        return customerName;
    }
    
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
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
    
    public String getNIC() {
        return NIC;
    }
    
    public void setNIC(String NIC) {
        this.NIC = NIC;
    }
    
    @Override
    public String toString() {
        return "Customer [customerId=" + customerId + ", userId=" + userId + ", customerName=" + customerName 
                + ", address=" + address + ", phoneNo=" + phoneNo + ", email=" + email + ", NIC=" + NIC + "]";
    }
}