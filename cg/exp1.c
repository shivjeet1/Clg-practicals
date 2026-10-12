#include <stdio.h>
#include <stdlib.h>
#include <graphics.h>

int main()
{
    float x, y, x1, y1, x2, y2, dx, dy, length;
    int i, gd = DETECT, gm;

    system("clear");

    printf("Enter the value of x1:\t");
    scanf("%f", &x1);
    printf("Enter the value of y1:\t");
    scanf("%f", &y1);
    printf("Enter the value of x2:\t");
    scanf("%f", &x2);
    printf("Enter the value of y2:\t");
    scanf("%f", &y2);

    initgraph(&gd, &gm, NULL);

    dx = abs(x2 - x1);
    dy = abs(y2 - y1);

    if (dx >= dy)
    {
        length = dx;
    }
    else
    {
        length = dy;
    }

    dx = (x2 - x1) / length;
    dy = (y2 - y1) / length;

    x = x1;
    y = y1;
    i = 1;

    while (i <= length)
    {
        putpixel((int)(x + 0.5), (int)(y + 0.5), 15); 
        x = x + dx;
        y = y + dy; 
        i++;        
        /* delay(100); */
    }

    getch(); 
    closegraph();
    return 0;
}
