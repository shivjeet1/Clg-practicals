interface Engine {
    void startEngine();
}
interface SafetyFeatures {
    void enableAirbags();
}

class SportsCar implements Engine, SafetyFeatures {
    public void startEngine() {
        System.out.println("Sports car engine started with a roar!");
    }

    public void enableAirbags() {
        System.out.println("Airbags enabled for safety.");
    }

    public static void main(String[] args) {
        SportsCar car = new SportsCar();

        car.startEngine();
        car.enableAirbags();
    }
}