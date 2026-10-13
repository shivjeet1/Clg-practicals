#include <iostream>
#include <cstdlib>
#include <graphics.h>
using namespace std;

int main()
{
    int x, y, r, gd = DETECT, gm;
    int speed = 5;

    system("clear");

    // 1. Get circle position and size in terminal first
    cout << "Enter the center Y and radius of the circle (y r): ";
    cin >> y >> r;

    // 2. Open graphics window
    initgraph(&gd, &gm, NULL);

    // 3. Move the circle in the forward (right) direction across the screen
    for (x = r; x <= getmaxx() - r; x += speed)
    {
        cleardevice();      // clear the previous frame
        setcolor(RED);
        circle(x, y, r);    // draw the circle at the new position
        delay(20);          // small pause to make the motion visible
    }

    getch();
    closegraph();
    return 0;
}