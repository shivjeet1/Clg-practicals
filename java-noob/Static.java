public class Static {
    public static void main(String[] args) {
        Student.change();

        Student s1 = new Student( 01, "Piyanshu");
        Student s2 = new Student( 02, "Yash");
        Student s3 = new Student( 03, "Aditya");

        s1.display();
        s2.display();
        s3.display();
    }
}

class Student{
    int rollno;
    String name;
    static String college = "VIT";
    
    static void change(){
        college = "SSGMCE";
    }

    Student(int r, String n ){
        rollno = r;
        name = n;
    }

    void display(){
        System.out.println("Roll No. "+rollno+"\t Name: "+name);
    }

}
