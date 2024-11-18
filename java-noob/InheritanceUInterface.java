interface printable{
    void print();
}
interface showable{
    void show();
}
class Test3 implements printable, showable{
    public void print(){
        System.out.println("Hello");
    }
    public void show(){
        System.out.println("Well Come");
    }
    public static void main(String[] args){
        Test3 t = new Test3();
        t.show();
        t.print();
        }
} 