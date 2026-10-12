#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <graphics.h>

// Default coordinates (renamed ya and yb to avoid <math.h> y1/y2 conflict)
int x1 = 200, ya = 150, x2 = 300, yb = 250; 
int mx, my, depth; 

void draw();
void rotate(); 

int main(void)
{
    int gd = DETECT, gm; 
    
    // Initialize graphics mode
    initgraph(&gd, &gm, NULL);
    
    // Calculate depth and center points automatically from default coordinates
    depth = (x2 - x1) / 4; 
    mx = (x1 + x2) / 2; 
    my = (ya + yb) / 2;

    printf("\n3D Transformation Rotating\n\n"); 

    // Draw original 3D box
    draw();
    
    // Ask for angle and draw rotated 3D box
    rotate();
    
    getch();
    closegraph();
    return 0;
}

void draw()
{
    bar3d(x1, ya, x2, yb, depth, 1);
}

void rotate()
{
    float t;
    int a1, b1, a2, b2, dep;
    int left, right, top, bottom;
    
    printf("Enter the angle to rotate = "); 
    scanf("%f", &t);
    
    // Convert degrees to radians
    t = t * (3.14159265 / 180.0);
    
    // Corrected rotation formulas (+ instead of - for y-transform second term)
    a1 = (int)(mx + (x1 - mx) * cos(t) - (ya - my) * sin(t));
    b1 = (int)(my + (x1 - mx) * sin(t) + (ya - my) * cos(t));
    
    a2 = (int)(mx + (x2 - mx) * cos(t) - (yb - my) * sin(t));
    b2 = (int)(my + (x2 - mx) * sin(t) + (yb - my) * cos(t));
    
    if (a2 > a1) 
        dep = (a2 - a1) / 4;
    else
        dep = (a1 - a2) / 4;
        
    // Sort coordinates to ensure proper rendering bounds for bar3d
    left   = (a1 < a2) ? a1 : a2;
    right  = (a1 > a2) ? a1 : a2;
    top    = (b1 < b2) ? b1 : b2;
    bottom = (b1 > b2) ? b1 : b2;
    
    setcolor(5);
    bar3d(left, top, right, bottom, dep, 1); 
}
