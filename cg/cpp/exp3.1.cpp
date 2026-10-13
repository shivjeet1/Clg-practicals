#include <iostream>
#include <cstdlib>
#include <graphics.h>
using namespace std;

void findNewCoordinate(int s[][2], int p[][1])
{
    int temp[2][1] = { 0 };
    for (int i = 0; i < 2; i++)
    {
        for (int j = 0; j < 1; j++)
        {
            for (int k = 0; k < 2; k++)
            {
                temp[i][j] += (s[i][k] * p[k][j]);
            }
        }
    }
    p[0][0] = temp[0][0];
    p[1][0] = temp[1][0];
}

int main()
{
    int x[3], y[3];
    int sx, sy;
    int gd = DETECT, gm;

    system("clear");

    // 1. Get inputs in terminal first
    cout << "Enter 3 points of the triangle (x1 y1 x2 y2 x3 y3):\n";
    cin >> x[0] >> y[0] >> x[1] >> y[1] >> x[2] >> y[2];

    cout << "Enter scaling factors (sx sy, e.g., 2 2): ";
    cin >> sx >> sy;

    // 2. Open graphics window
    initgraph(&gd, &gm, NULL);

    // Draw original triangle (White)
    line(x[0], y[0], x[1], y[1]);
    line(x[1], y[1], x[2], y[2]);
    line(x[2], y[2], x[0], y[0]);

    // Scaling Matrix
    int s[2][2] = { {sx, 0}, {0, sy} };
    int p[2][1];

    for (int i = 0; i < 3; i++)
    {
        p[0][0] = x[i];
        p[1][0] = y[i];
        findNewCoordinate(s, p);
        x[i] = p[0][0];
        y[i] = p[1][0];
    }

    // Set color to RED for scaled triangle
    setcolor(RED);

    // Draw scaled triangle
    line(x[0], y[0], x[1], y[1]);
    line(x[1], y[1], x[2], y[2]);
    line(x[2], y[2], x[0], y[0]);

    getch();
    closegraph();
    return 0;
}