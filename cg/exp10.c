#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <graphics.h>

#define PI 3.14159265

void drawCycle(int x, int baseY, float angle)
{
    int r = 25;                                // wheel radius
    int ax = x, ay = baseY;                    // rear wheel center
    int bx = x + 70, by = baseY;               // front wheel center
    int i;

    // Wheels
    circle(ax, ay, r);
    circle(bx, by, r);

    // Rotating spokes (4 per wheel) so the cycle looks like it is moving
    for (i = 0; i < 4; i++)
    {
        float a = angle + i * (PI / 2);

        line(ax, ay, ax + (int)(r * cos(a)), ay + (int)(r * sin(a)));
        line(bx, by, bx + (int)(r * cos(a)), by + (int)(r * sin(a)));
    }

    // Frame
    line(ax, ay, bx, by);                      // bottom axle bar
    line(ax, ay - r + 5, bx, by - r + 5);      // mudguard bar above the wheels
    line(ax, ay, ax + 25, ay - 50);            // rear down tube
    line(bx, by, bx - 25, by - 50);            // front fork
    line(ax + 25, ay - 50, bx - 25, by - 50);  // top tube

    // Seat
    line(ax + 25, ay - 50, ax + 35, ay - 44);  // seat post
    line(ax + 30, ay - 44, ax + 45, ay - 44);  // seat

    // Handlebar
    line(bx - 25, by - 50, bx - 35, by - 60);  // handle stem
    line(bx - 42, by - 60, bx - 28, by - 60);  // handlebar

    // Pedal crank
    line(ax + 35, ay, ax + 35, ay - 12);       // crank arm
    line(ax + 30, ay - 12, ax + 40, ay - 12);  // pedal
}

int main()
{
    int x, y, speed, gd = DETECT, gm;
    float angle = 0.0;

    system("clear");

    // 1. Get cycle position and speed in terminal first
    printf("Enter center Y of the cycle (e.g., 350): ");
    scanf("%d", &y);
    printf("Enter speed in pixels per frame (e.g., 3): ");
    scanf("%d", &speed);

    // 2. Open graphics window
    initgraph(&gd, &gm, NULL);

    // 3. Animate: move the cycle forward (left to right) across the screen
    for (x = 40; x <= getmaxx() - 120; x += speed)
    {
        cleardevice();                 // clear the previous frame
        setcolor(WHITE);
        drawCycle(x, y, angle);        // draw the cycle at the new position
        angle += 0.2;                  // spin the spokes each frame
        delay(30);                     // small pause to make the motion visible
    }

    getch();
    closegraph();
    return 0;
}