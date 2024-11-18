
interface It
{
void m1();
void m2();
void m3();
}
abstract class Test implements It
{
public void m1()
{
System.out.println("m1-method");
}
}
abstract class Test1 extends Test
{
public void m2()
{
System.out.println("m2-method");
}
}
class Test2 extends Test1
{
public void m3()
{
System.out.println("m3-method");
}
public static void main(String[] args)
{
Test2 t = new Test2();
t.m1();
t.m2();
t.m3();
}
}

    
