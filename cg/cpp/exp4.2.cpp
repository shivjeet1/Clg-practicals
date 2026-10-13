#include <iostream>
#include <cstdlib>
#include <graphics.h>
using namespace std;

int main()
{
    // Default coordinates for the 3D cuboid
    int x11 = 150, y11 = 150, x21 = 250, y21 = 250; // Front rectangle
    int x12 = 200, y12 = 100, x22 = 300, y22 = 200; // Back rectangle

    // Connecting edges between front and back rectangles
    int x1 = 150, y1 = 150, x2 = 200, y2 = 100;     // Line 1
    int x3 = 250, y3 = 150, x4 = 300, y4 = 100;     // Line 2
    int x5 = 150, y5 = 250, x6 = 200, y6 = 200;     // Line 3
    int x7 = 250, y7 = 250, x8 = 300, y8 = 200;     // Line 4

    int sf = 400, sy = 150; // Translation factors (shift values)
    int gdriver = DETECT, gmode;

    // Initialize graphics mode for SDL_bgi
    initgraph(&gdriver, &gmode, NULL);
    cleardevice();

    // Draw original 3D object (White)
    rectangle(x11, y11, x21, y21);
    rectangle(x12, y12, x22, y22);
    line(x1, y1, x2, y2);
    line(x3, y3, x4, y4);
    line(x5, y5, x6, y6);
    line(x7, y7, x8, y8);

    // Draw translated 3D object in GREEN (shifted by sf and sy)
    setcolor(GREEN);
    rectangle(x11 + sf, y11 + sy, x21 + sf, y21 + sy);
    rectangle(x12 + sf, y12 + sy, x22 + sf, y22 + sy);
    line(x1 + sf, y1 + sy, x2 + sf, y2 + sy);
    line(x3 + sf, y3 + sy, x4 + sf, y4 + sy);
    line(x5 + sf, y5 + sy, x6 + sf, y6 + sy);
    line(x7 + sf, y7 + sy, x8 + sf, y8 + sy);

    getch();
    closegraph();
    return 0;
}