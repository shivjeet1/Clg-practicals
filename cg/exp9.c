#include <stdio.h>
#include <stdlib.h>
#include <graphics.h>

int main()
{
    int x1, y1, x2, y2, color;
    int gd = DETECT, gm;

    system("clear");

    // 1. Get rectangle corners and fill color in terminal first
    printf("Enter top-left corner of rectangle (x1 y1): ");
    scanf("%d %d", &x1, &y1);
    printf("Enter bottom-right corner of rectangle (x2 y2): ");
    scanf("%d %d", &x2, &y2);
    printf("Enter fill color index (2=GREEN 4=RED 9=LIGHTBLUE 14=YELLOW): ");
    scanf("%d", &color);

    // 2. Open graphics window
    initgraph(&gd, &gm, NULL);

    // 3. Draw the outline of the rectangle in WHITE
    setcolor(WHITE);
    rectangle(x1, y1, x2, y2);

    // 4. Fill the interior of the rectangle with the chosen color
    setfillstyle(SOLID_FILL, color);
    floodfill((x1 + x2) / 2, (y1 + y2) / 2, WHITE);

    getch();
    closegraph();
    return 0;
}