#include <iostream>
#include <cstdlib>
#include <graphics.h>
using namespace std;

void hilbert(int x, int y, int xi, int xj, int yi, int yj, int n)
{
    if (n <= 0)
    {
        int ax = x + (xi + yi) / 2;
        int ay = y + (xj + yj) / 2;
        int bx = x + (xi - yi) / 2;
        int by = y + (xj - yj) / 2;

        line(ax, ay, bx, by);
        delay(10);
        return;
    }

    hilbert(x, y, yi / 2, yj / 2, xi / 2, xj / 2, n - 1);
    hilbert(x + xi / 2, y + xj / 2, xi / 2, xj / 2, yi / 2, yj / 2, n - 1);
    hilbert(x + xi / 2 + yi / 2, y + xj / 2 + yj / 2, xi / 2, xj / 2, yi / 2, yj / 2, n - 1);
    hilbert(x + xi / 2 + yi, y + xj / 2 + yj, -yi / 2, -yj / 2, -xi / 2, -xj / 2, n - 1);
}

int main()
{
    int order, gd = DETECT, gm;
    int size = 400, offsetX = 80, offsetY = 40;

    system("clear");

    // 1. Get curve order in terminal first
    cout << "Enter the order of the Hilbert curve (1 to 5): ";
    cin >> order;

    // 2. Open graphics window
    initgraph(&gd, &gm, NULL);

    setcolor(15); // White

    // 3. Draw the Hilbert curve recursively
    hilbert(offsetX, offsetY, size, 0, 0, size, order);

    getch();
    closegraph();
    return 0;
}