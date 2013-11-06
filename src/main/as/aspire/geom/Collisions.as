//
// aspire

package aspire.geom {

/** Collision math utility functions */
public class Collisions
{
    /**
     * Calls the given callback for each integer point that the given line passes through,
     * using the Bresenham line algorithm.
     *
     * @param callback the function to call for each coordinate.
     * It should be of the form: <code>function (x :int, y :int) :Boolean</code>
     * Return true from the callback to stop the intersection test, or false/void to continue.
     */
    public static function getBresenhamLineIntersections (x0 :int, y0 :int, x1 :int, y1 :int,
        callback :Function) :void {

        // Bresenham line algorithm, copied from here:
        // http://trystans.blogspot.com/2013/02/line-of-sight-los-in-actionscript.html

        var dx:int = Math.abs(x1 - x0);
        var dy:int = Math.abs(y1 - y0);
        var sx:int = x0 < x1 ? 1 : -1;
        var sy:int = y0 < y1 ? 1 : -1;
        var err:int = dx - dy;

        while (true) {
            if (callback(x0, y0)) {
                return;
            }

            if (x0 == x1 && y0 == y1) {
                break;
            }

            var e2 :int = err * 2;
            if (e2 > -dx) {
                err -= dy;
                x0 += sx;
            }
            if (e2 < dx){
                err += dx;
                y0 += sy;
            }
        }
    }
    /**
     * Calls the given callback for each integer point that the given line passes through,
     * using a "supercover" algorithm that covers all points, not just one per axis, as
     * in Bresenham.
     *
     * @param cornersTouchNeighbors if true, then a line that passes at a 45-degree diagonal
     * between two points will "touch" all points in the 2x2 square that those coordinates
     * are a part of. For example, a line passing through (0,0) and (1,1) would intersect all four
     * points (0,0), (0,1), (1,0), and (1,1):
     *          **
     *          **
     * If cornersTouchNeighbors is false, only (0,0) and (1,1) would be intersected:
     *          -*
     *          *-
     *
     * @param callback the function to call for each point.
     * It should be of the form: <code>function (x :int, y :int) :Boolean</code>
     * Return true from the callback to stop the intersection test, or false/void to continue.
     */
    public static function getSupercoverLineIntersections (x0 :int, y0 :int, x1 :int, y1 :int,
        cornersTouchNeighbors :Boolean, callback :Function) :void
    {
        // "supercover" line algorithm, described here:
        // http://lifc.univ-fcomte.fr/~dedu/projects/bresenham/index.html

        if (callback(x0, y0)) {
            return;
        }

        var ii :int;            // loop counter
        var ystep :int;
        var xstep :int;         // the step on y and x axis
        var error :int;         // the error accumulated during the increment
        var errorprev :int;     // *vision the previous value of the error variable
        var yy :int = y0;
        var xx :int = x0;       // the line points
        var ddy :int;
        var ddx :int;           // compulsory variables: the double values of dy and dx
        var dx :int = x1 - x0;
        var dy :int = y1 - y0;

        // NB the last point can't be here, because of its previous point (which has to be verified)
        if (dy < 0) {
            ystep = -1;
            dy = -dy;
        } else {
            ystep = 1;
        }

        if (dx < 0) {
            xstep = -1;
            dx = -dx;
        } else {
            xstep = 1;
        }

        ddy = 2 * dy;  // work with double values for full precision
        ddx = 2 * dx;

        if (ddx >= ddy) {  // first octant (0 <= slope <= 1)
            // compulsory initialization (even for errorprev, needed when dx==dy)
            errorprev = error = dx;  // start in the middle of the square
            for (ii = 0; ii < dx; ii++) {  // do not use the first point (already done)
                xx += xstep;
                error += ddy;
                if (error > ddx) {  // increment y if AFTER the middle ( > )
                    yy += ystep;
                    error -= ddx;
                    // three cases (octant == right->right-top for directions below):
                    if (error + errorprev < ddx) {  // bottom square also
                        if (callback(xx, yy - ystep)) {
                            return;
                        }
                    } else if (error + errorprev > ddx) {  // left square also
                        if (callback(xx - xstep, yy)) {
                            return;
                        }
                    } else if (cornersTouchNeighbors) {  // corner: bottom and left squares also
                        if (callback(xx, yy - ystep)) {
                            return;
                        }
                        if (callback(xx - xstep, yy)) {
                            return;
                        }
                    }
                }

                if (callback(xx, yy)) {
                    return;
                }
                errorprev = error;
            }

        } else {  // the same as above
            errorprev = error = dy;
            for (ii = 0; ii < dy; ii++) {
                yy += ystep;
                error += ddx;
                if (error > ddy) {
                    xx += xstep;
                    error -= ddy;
                    if (error + errorprev < ddy) {
                        if (callback(xx - xstep, yy)) {
                            return;
                        }
                    } else if (error + errorprev > ddy) {
                        if (callback(xx, yy - ystep)) {
                            return;
                        }
                    } else if (cornersTouchNeighbors) {
                        if (callback(xx - xstep, yy)) {
                            return;
                        }
                        if (callback(xx, yy - ystep)) {
                            return;
                        }
                    }
                }
                if (callback(xx, yy)) {
                    return;
                }
                errorprev = error;
            }
        }
        // the last point (y1,x1) has to be the same with the last point of the algorithm
        // assert ((y == y1) && (x == x1));
    }

    /** Returns true if the two circles intersect. */
    public static function circlesIntersect (
        cA :Vector2,
        rA :Number,
        cB :Vector2,
        rB :Number) :Boolean
    {
        return (cB.subtract(cA).lengthSquared <= ((rA + rB) * (rA + rB)));
    }

    /**
     * Returns a value in [0, 1] that indicates the distance that circle A's path
     * must be scaled to avoid intersecting with circle B, or -1 if no interesection
     * occurs. The two circles must not already be intersecting.
     *
     * @param cA the moving circle's center point
     * @param rA the moving circle's radius
     * @param directionA the moving circle's movement vector (must be unit length)
     * @param distanceA the distance the moving circle is traveling
     * @param cB the static circle's center point
     * @param rB the static circle's radius
     */
    public static function movingCircleIntersectsStaticCircle (
        cA :Vector2,
        rA :Number,
        directionA :Vector2,
        distanceA :Number,
        cB :Vector2,
        rB :Number) :Number
    {
        // http://www.gamasutra.com/features/20020118/vandenhuevel_02.htm

        var c :Vector2 = cB.subtract(cA);
        var cLengthSquared :Number = c.lengthSquared;

        var d :Number = c.dot(directionA);

        // A is moving in the wrong direction
        if (d <= 0) {
            return -1;
        }

        var f :Number = cLengthSquared - (d * d);
        var minDistSquared :Number = ((rA + rB) * (rA + rB));

        // A will pass but not collide with B
        if (f > minDistSquared) {
            return -1;
        }

        var t :Number = minDistSquared - f;

        if (t < 0) {
            return -1;
        }

        var collideDistance :Number = d - Math.sqrt(t);

        if (collideDistance > distanceA) {
            return -1;
        }

        return collideDistance / distanceA;
    }

    /**
     * Returns a value in [0, 1] that indicates the distance that the two circles'
     * paths must be scaled to avoid intersecting each other, or -1 if no interesection
     * will occurs. The two circles must not already be intersecting.
     *
     * @param cA circle A's center point
     * @param rA circle A's radius
     * @param dA circle A's movement offset
     * @param cB circle B's center point
     * @param rB circle B's radius
     * @param dB circle B's movement offset
     */
    public static function movingCirclesIntersect (
        cA :Vector2,
        rA :Number,
        dA :Vector2,
        cB :Vector2,
        rB :Number,
        dB :Vector2) :Number
    {
        var direction :Vector2 = dA.subtract(dB);
        var distance :Number = direction.normalizeLocalAndGetLength();

        return movingCircleIntersectsStaticCircle(cA, rA, direction, distance, cB, rB);
    }

    /**
     * Returns the minimum distance between the point "pt" and the line segement that lies
     * between linePt1 and linePt2.
     *
     * If linePt1 and linePt2 are coincident, the function will return Infinity.
     */
    public static function minDistanceFromPointToLineSegment (pt :Vector2, linePt1 :Vector2,
        linePt2 :Vector2) :Number
    {
        // technique described at http://local.wasp.uwa.edu.au/~pbourke/geometry/pointline/

        // determine 'u'
        var uDenom :Number = linePt2.subtract(linePt1).lengthSquared;

        if (uDenom == 0) {
            return Infinity;    // the line points given are coincident
        }

        var uNumer :Number = (((pt.x - linePt1.x) * (linePt2.x - linePt1.x)) +
            ((pt.y - linePt1.y) * (linePt2.y - linePt1.y)));

        var u :Number = uNumer / uDenom;

        /* if u is not between 0 and 1, there is no point on the line segment that forms
        a tangent to the line with pt. i.e.:

        * pt

        *-----------* line
        */

        if (u < 0 || u > 1) {
            // find the smallest distance between pt and both line segment points
            var a :Number = linePt1.subtract(pt).length;
            var b :Number = linePt2.subtract(pt).length;

            return Math.min(a, b);
        } else {
            // solve for the point of intersection of the tangent
            var p :Vector2 = new Vector2();

            p.x = linePt1.x + (u * (linePt2.x - linePt1.x));
            p.y = linePt1.y + (u * (linePt2.y - linePt1.y));

            // return the distance from pt to p
            p.subtractLocal(pt);
            return Math.abs(p.length);
        }
    }
}
}
