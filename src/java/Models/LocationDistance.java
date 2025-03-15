package Models;

public class LocationDistance {
    private int distanceID;
    private int fromLocationID;
    private int toLocationID;
    private double distanceKM;

    public LocationDistance(int distanceID, int fromLocationID, int toLocationID, double distanceKM) {
        this.distanceID = distanceID;
        this.fromLocationID = fromLocationID;
        this.toLocationID = toLocationID;
        this.distanceKM = distanceKM;
    }

    public int getDistanceID() {
        return distanceID;
    }

    public void setDistanceID(int distanceID) {
        this.distanceID = distanceID;
    }

    public int getFromLocationID() {
        return fromLocationID;
    }

    public void setFromLocationID(int fromLocationID) {
        this.fromLocationID = fromLocationID;
    }

    public int getToLocationID() {
        return toLocationID;
    }

    public void setToLocationID(int toLocationID) {
        this.toLocationID = toLocationID;
    }

    public double getDistanceKM() {
        return distanceKM;
    }

    public void setDistanceKM(double distanceKM) {
        this.distanceKM = distanceKM;
    }
}