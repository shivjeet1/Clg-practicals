#include <iostream>
#include <cstdlib>
#include <graphics.h>
using namespace std;

int main()
{
    int graphdriver = DETECT, graphmode;
    int x1, y1, x2, y2, tx, ty;

    // Read the line endpoints from the terminal before opening the graphics window
    cout << "Enter the two line endpoints (x1 y1 x2 y2): ";
    cin >> x1 >> y1 >> x2 >> y2;

    // Read translation coordinates
    cout << "Enter translation coordinates (tx ty): ";
    cin >> tx >> ty;

    // Initialize graphics mode for SDL_bgi
    initgraph(&graphdriver, &graphmode, NULL);

    // Draw original line (Default color - White)
    line(x1, y1, x2, y2);

    // Apply translation to both endpoints
    x1 = x1 + tx;
    y1 = y1 + ty;
    x2 = x2 + tx;
    y2 = y2 + ty;

    // Change color for the translated line so you can distinguish it
    setcolor(RED);

    // Draw the line after translation
    line(x1, y1, x2, y2);

    getch();
    closegraph();
    return 0;
}