#include <stdio.h>
#include <stdlib.h>
#include <graphics.h>

#define MAX 20

int main()
{
    int n, i, j;
    int x[MAX], y[MAX];
    int ymin = 1000, ymax = 0;
    float xi[MAX];
    int gd = DETECT, gm;

    system("clear");

    // 1. Get polygon vertices in terminal first
    printf("Enter number of vertices of the polygon: ");
    scanf("%d", &n);

    printf("Enter coordinates of vertices (x y), in order:\n");
    for (i = 0; i < n; i++)
    {
        scanf("%d %d", &x[i], &y[i]);

        if (y[i] < ymin)
        {
            ymin = y[i];
        }
        if (y[i] > ymax)
        {
            ymax = y[i];
        }
    }

    // 2. Open graphics window
    initgraph(&gd, &gm, NULL);

    // 3. Draw polygon outline in RED
    setcolor(RED);
    for (i = 0; i < n; i++)
    {
        j = (i + 1) % n;
        line(x[i], y[i], x[j], y[j]);
    }

    // 4. Scan line fill
    setcolor(GREEN);
    for (int scan = ymin; scan <= ymax; scan++)
    {
        int count = 0;

        // Find intersections of this scan line with all polygon edges
        for (i = 0; i < n; i++)
        {
            j = (i + 1) % n;

            // Skip horizontal edges
            if (y[i] == y[j])
            {
                continue;
            }

            // Consider edge only for scan lines between its endpoints.
            // (Lower endpoint included, upper endpoint excluded so each
            // vertex is counted exactly once - correct parity rule.)
            int ylo, yhi;
            if (y[i] < y[j])
            {
                ylo = y[i];
                yhi = y[j];
            }
            else
            {
                ylo = y[j];
                yhi = y[i];
            }

            if (scan >= ylo && scan < yhi)
            {
                xi[count] = x[i] + (float)(scan - y[i]) * (float)(x[j] - x[i]) / (float)(y[j] - y[i]);
                count++;
            }
        }

        // Sort intersections from left to right
        for (i = 0; i < count - 1; i++)
        {
            for (j = i + 1; j < count; j++)
            {
                if (xi[i] > xi[j])
                {
                    float t = xi[i];
                    xi[i] = xi[j];
                    xi[j] = t;
                }
            }
        }

        // Fill between each pair of intersections
        for (i = 0; i + 1 < count; i += 2)
        {
            line((int)xi[i], scan, (int)xi[i + 1], scan);
        }
    }

    getch();
    closegraph();
    return 0;
}