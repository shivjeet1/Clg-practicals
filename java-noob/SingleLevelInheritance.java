public class SingleLevelInheritance {
    public static void main(String[] args) {
        Mclaren m1 = new Mclaren();
        m1.drive();
        m1.accelerate();
        m1.turbo();
        m1.nitro();
        m1.brake();
    }
}

class Car{
    void drive(){
        System.out.println("Driving");
    }
    void brake(){
        System.out.println("Braking");
    }
    void accelerate(){
        System.out.println("Accelerating");
    }
}

class Mclaren extends Car {
    void nitro(){

        System.out.println("Nitro-ON");
    }
    void turbo(){
        System.out.println("Turbo-Speed-ON");
    }
}