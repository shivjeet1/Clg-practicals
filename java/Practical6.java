// Base class
class Animal {
    // Method to be overridden
    public void sound() {
        System.out.println("Animal makes a sound");
    }
}

// Subclass
class Dog extends Animal {
    // Overriding the sound() method
    @Override
    public void sound() {
        System.out.println("Dog barks");
    }
}

public class Practical6 {
    public static void main(String[] args) {
        // Create an instance of Animal
        Animal myAnimal = new Animal();
        myAnimal.sound(); // Calls the Animal's sound method

        // Create an instance of Dog
        Animal myDog = new Dog();
        myDog.sound(); // Calls the Dog's overridden sound method
    }
}
