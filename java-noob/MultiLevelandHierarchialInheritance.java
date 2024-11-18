public class MultiLevelandHierarchialInheritance {
    public static void main(String[] args) {
        Supra m1 = new Supra();
        m1.drive();
        m1.accelerate();
        //m1.turbo(); //Compile Time error as turbo() does not exists in Supra
        m1.nitro();
        m1.horn();
        m1.brake();
        Mclaren m2 = new Mclaren();
        m2.turbo();
    }
}
//vehicle->Car->Supra OR vehicle->Car->Mclaren is an example of MultiLevelInheritance
class vehicle{
    void drive(){
        System.out.println("Driving");
    }
    void brake(){
        System.out.println("Braking");
    }
}

class Car extends vehicle {
    void horn(){
        System.out.println("PEEP-PEEP");
    }
    void accelerate(){
        System.out.println("Accelerating");
    }
}

class Supra extends Car{
    void nitro(){

        System.out.println("Nitro-ON");
    }
}
class Mclaren extends Car{
    void turbo(){
        System.out.println("Turbo-Speed-ON");
    }
}