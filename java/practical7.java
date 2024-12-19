interface Interface1 {
    void method1();
}

interface Interface2 {
    void method2();
}

class MultipleInheritance implements Interface1, Interface2 {
    public void method1() {
        System.out.println("Method 1 from Interface 1");
    }

    public void method2() {
        System.out.println("Method 2 from Interface 2");
    }

    public static void main(String[] args) {
        MultipleInheritance obj = new MultipleInheritance();

        obj.method1();
        obj.method2();
    }
}
