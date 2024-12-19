public class Practical6 {
    public static void main(String[] args) {
        Car mclaren = new Mclaren();
        mclaren.drive(); // Calls the overridden method in Mclaren
        mclaren.brake(); // Calls the inherited method from Car
        mclaren.accelerate(); // Calls the inherited method from Car
    }
}

class Car {
    // Superclass methods
    void drive() {
        System.out.println("Driving at a normal speed");
    }

    void brake() {
        System.out.println("Braking");
    }

    void accelerate() {
        System.out.println("Accelerating at a steady pace");
    }
}

// Subclass Mclaren overrides the drive() method
class Mclaren extends Car {
    @Override
    void drive() {
        System.out.println("Driving at a super-fast speed");
    }

    // Optional: can override other methods if needed
    @Override
    void accelerate() {
        System.out.println("Accelerating rapidly with turbo power");
    }
}
