public class Practical3 {

    // Static variable
    static int staticVariable = 10;

    // Instance variable
    int instanceVariable;

    // Constructor to initialize instance variable
    public Practical3(int value) {
        this.instanceVariable = value;
    }

    // Method to demonstrate local, instance, and static variables
    public void demonstrateVariables() {
        // Local variable
        int localVariable = 5;

        System.out.println("Inside demonstrateVariables method:");
        System.out.println("Static Variable: " + staticVariable);
        System.out.println("Instance Variable: " + instanceVariable);
        System.out.println("Local Variable: " + localVariable);
    }

    public static void main(String[] args) {
        // Creating an instance of the class
        Practical3 demo1 = new Practical3(20);
        demo1.demonstrateVariables();

        // Creating another instance to show instance variable scope
        Practical3 demo2 = new Practical3(30);
        demo2.demonstrateVariables();

        // Accessing static variable directly through the class name
        System.out.println("Static Variable accessed from main: " + Practical3.staticVariable);
    }
}
