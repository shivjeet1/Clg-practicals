#include <graphics.h>
#include <stdlib.h> 
#include <stdio.h> 

int main()
{
    int graphdriver = DETECT, graphmode; 
    int x1, y1, x2, y2, tx, ty;

    // Read the line endpoints from the terminal before opening the graphics window
    printf("Enter the two line endpoints (x1 y1 x2 y2): ");
    scanf("%d %d %d %d", &x1, &y1, &x2, &y2); 

    // Read translation coordinates
    printf("Enter translation coordinates (tx ty): ");
    scanf("%d %d", &tx, &ty); 

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
