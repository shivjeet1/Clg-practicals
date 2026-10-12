#include <stdio.h>
#include <stdlib.h>
#include <graphics.h>

int main()
{
    int x1, y1, x2, y2;
    int dx, dy, sx, sy, err, e2;
    int gd = DETECT, gm;

    system("clear");

    printf("Enter the value of x1:\t");
    scanf("%d", &x1);
    printf("Enter the value of y1:\t");
    scanf("%d", &y1);
    printf("Enter the value of x2:\t");
    scanf("%d", &x2);
    printf("Enter the value of y2:\t");
    scanf("%d", &y2);

    initgraph(&gd, &gm, NULL);

    dx = abs(x2 - x1);
    dy = abs(y2 - y1);

    sx = (x1 < x2) ? 1 : -1;
    sy = (y1 < y2) ? 1 : -1;

    err = dx - dy;

    while (1)
    {
        putpixel(x1, y1, 15);

        if (x1 == x2 && y1 == y2)
        {
            break;
        }

        e2 = 2 * err;

        if (e2 > -dy)
        {
            err = err - dy;
            x1 = x1 + sx;
        }

        if (e2 < dx)
        {
            err = err + dx;
            y1 = y1 + sy;
        }
    }

    getch();
    closegraph();
    return 0;
}