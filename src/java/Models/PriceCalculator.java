package Models;

public class PriceCalculator {
    private double distance;
    private double basePrice;
    private double distanceCost;
    private double totalPrice;
    
    public PriceCalculator(double distance, double basePrice, double distanceCost, double totalPrice) {
        this.distance = distance;
        this.basePrice = basePrice;
        this.distanceCost = distanceCost;
        this.totalPrice = totalPrice;
    }
    
    public double getDistance() {
        return distance;
    }
    
    public double getBasePrice() {
        return basePrice;
    }
    
    public double getDistanceCost() {
        return distanceCost;
    }
    
    public double getTotalPrice() {
        return totalPrice;
    }
}