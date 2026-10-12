#include <graphics.h>
#include <stdlib.h> 
#include <stdio.h> 
#include <math.h> 

int main()
{
    int graphdriver = DETECT, graphmode; 
    int x1, y1, x2, y2;
    int nx1, ny1, nx2, ny2; 
    double th, rad, c, s; 

    system("clear");

    // Read line endpoints (try something like: 200 200 400 200)
    printf("Enter the 2 line end points (x1 y1 x2 y2): "); 
    scanf("%d %d %d %d", &x1, &y1, &x2, &y2); 

    // Initialize graphics mode for SDL_bgi
    initgraph(&graphdriver, &graphmode, NULL); 

    // Draw original line (White)
    line(x1, y1, x2, y2);

    // Read rotation angle in degrees (e.g., 45 or 90)
    printf("\nEnter the rotation angle (in degrees): "); 
    scanf("%lf", &th); 

    rad = (th * 3.14159265) / 180.0;
    c = cos(rad); 
    s = sin(rad);

    // Pivot rotation around (x1, y1) so the line stays visible on screen:
    // Keep x1, y1 fixed, and rotate x2, y2 relative to x1, y1
    nx1 = x1;
    ny1 = y1;

    nx2 = (int)(x1 + (x2 - x1) * c - (y2 - y1) * s);
    ny2 = (int)(y1 + (x2 - x1) * s + (y2 - y1) * c);

    // Change color to RED for the rotated line
    setcolor(RED);

    // Draw the rotated line
    line(nx1, ny1, nx2, ny2); 

    getch(); 
    closegraph();
    return 0;
}
