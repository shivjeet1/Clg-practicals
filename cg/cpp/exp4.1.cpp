#include <iostream>
#include <cstdlib>
#include <graphics.h>
using namespace std;

int main()
{
    // Default pre-defined coordinates for the 3D cuboid
    int x11 = 150, y11 = 150, x21 = 250, y21 = 250; // Front rectangle
    int x12 = 200, y12 = 100, x22 = 300, y22 = 200; // Back rectangle

    // Connecting edges between front and back rectangles
    int x1 = 150, y1 = 150, x2 = 200, y2 = 100;     // Edge 1
    int x3 = 250, y3 = 150, x4 = 300, y4 = 100;     // Edge 2
    int x5 = 150, y5 = 250, x6 = 200, y6 = 200;    // Edge 3
    int x7 = 250, y7 = 250, x8 = 300, y8 = 200;    // Edge 4

    int sx = 2, sy = 2; // Scaling factors
    int gdriver = DETECT, gmode;

    // Initialize graphics mode immediately
    initgraph(&gdriver, &gmode, NULL);
    cleardevice();

    // 1. Draw Original 3D Box in RED
    setcolor(RED);
    rectangle(x11, y11, x21, y21);
    rectangle(x12, y12, x22, y22);
    line(x1, y1, x2, y2);
    line(x3, y3, x4, y4);
    line(x5, y5, x6, y6);
    line(x7, y7, x8, y8);

    // 2. Draw Scaled 3D Box in GREEN
    setcolor(GREEN);
    rectangle(x11 / sx, y11 / sy, x21 / sx, y21 / sy);
    rectangle(x12 / sx, y12 / sy, x22 / sx, y22 / sy);
    line(x1 / sx, y1 / sy, x2 / sx, y2 / sy);
    line(x3 / sx, y3 / sy, x4 / sx, y4 / sy);
    line(x5 / sx, y5 / sy, x6 / sx, y6 / sy);
    line(x7 / sx, y7 / sy, x8 / sx, y8 / sy);

    getch();
    closegraph();
    return 0;
}