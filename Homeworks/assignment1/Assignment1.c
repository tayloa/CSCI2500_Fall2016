// Assignment 1, linear interpolation
// Given a set of points, construct the equation for a line given any
// two adjacent points.  Use the slope-intercept form y = mx + b
#include <float.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

struct point
{
    double x;
    double y;
};

// Allocate the right amount of memory to store "count" number of "point"s
// We assume malloc() never fails :)
// pointer to array of pointers
void allocate_points(struct point ** ptr, int count)
{
    ptr = (struct point*) malloc(count * sizeof(struct point));
}

// Ask for the proper number of X and Y coordinates
// The X coordinates should strictly increase and will never be negative
// Y values can vary
// Return -1 (immediately) if the X coordinates do not strictly increase
// Return 0 if no problems were encountered in this function
int collect_points(struct point * points, int count)
{
    float x0 = -1; // x0 will hold the previous x value while x1 holds the next x value
    float x1,y;ss
    for(int i = 0; i < count; i++) {

        struct point temppt; // temp point to hold x and y
        printf("Please enter X[%d]: \n",i);
        scanf("%f",&x1);

        if( x1 <= x0 || x1 < 0)
            return -1;

        temppt.x = x1;

        printf("Please enter Y[%d]: \n",i);
        scanf("%f",&y);
        temppt.y = y;

        points[i] = temppt;
        x0 = x1;
    }
    return 0;
}

// Simply print out the list of coordinates stored in "points"
// Use a width of 6 and a precision of 3 so things line up nice
// This should help with debugging
void print_points(struct point * points, int count)
{
    for(int i = 0; i < count; i++){
        printf("Point[%d] is (%6.3f, %6.3f)\n", i , points[i].x , points[i].y);
    }
}

// Find the slope between two points
// m = (y_2 - y_1) / (x_2 - x_1)
double find_slope(struct point p1, struct point p2)
{
    double m = (p2.y - p1.y) / (p2.x - p1.x);
    return m;
}

// Find intercept given the slope and a point it passes through
double find_intercept(double slope, struct point p)
{
    // y = mx + b ====> b = y - mx
    double b = p.y - ( slope * ( p.x ) );
    return b;
}

// This function should find the Y value of the curve given an X coordinate
// If it's not within our set of points, it cannot be interpolated
// Return DBL_MAX
// Otherwise, return the point we calculated
double y_val_at(struct point * points, int count, double x)
{
    // check to see if x is in range
    if ( (float)x < (float)points[0].x || (float) x > (float)points[count-1].x )
        return DBL_MAX;

    struct point p1;
    struct point p2;
    float tempx; // only used to compare x values
    // bools to make sure p1 and p2 actually get values
    int l1 = 0;
    int l2 = 0;

    // get closest smaller x value
    for(int i = 0;i < count; i++){
        tempx = points[i].x;

        // if the x is already a value of one of our points, return its y
        if( (float)x == (float) tempx )
            return points[i].y;

        if(x > points[i].x){
            p1 = points[i];
            l1 = 1;
        }

    }

    // get closest higher x value
    for(int i = 0;i < count; i++){

        if( (float)x == (float) tempx )
            return points[i].y;

        if(x < points[i].x){
            p2 = points[i];
            l2 = 1;
            break;
        }
    }

    // check if p1 and p2 don't have values, return DBL_MAX
    if( !l1 || !l2 )
        return DBL_MAX;

    // calculation for interpolatde y value
    // find slope for line between point range
    double m = find_slope(p1, p2);

    // plug in slope to find the y intercept
    double b = find_intercept(m, p1);

    // find the y value
    double y = (m * x) + b;
    return y;
}

// DO NOT MODIFY THIS FUNCTION
// This assignment must be completed using the main() function AS-IS
int main()
{
    int ret;
    struct point *points;
    int num_points = 0;

    printf("How many data points would you like to enter? (2 or more): \n");
    scanf("%d", &num_points);
    if (num_points <= 1) {
        return 0;
    }

    allocate_points(&points, num_points);

    printf("Please enter non-negative X values.\n");
    ret = collect_points(points, num_points);
    if (ret == -1) {
        printf("Please enter points in order of ascending X values.\n");
        return -1;
    }

    print_points(points, num_points);

    while (1) {
        double x, y;
        printf("Please enter an X coordinate (-1 to exit): \n");
        scanf("%lf", &x);
        if (x == -1) {
            break;
        }

        y = y_val_at(points, num_points, x);
        if (y == DBL_MAX) {
            printf(" %6.3lf cannot be interpolated\n", x);
        }
        else {
            printf(" %6.3lf maps to (%6.3lf, %6.3lf)\n", x, x, y);
        }
    }

    return 0;
}
