//
// aspire

package aspire.util {

/**
 * Collection of math utility functions.
 */
public class MathUtil
{
    public static const TWO_PI :Number = Math.PI * 2;

    /** A small value used to compare Number equivalency */
    public static const EPSILON :Number = 0.0001;

    /** Returns true if the two numbers differ by no more than EPSILON */
    public static function epsilonEquals (a :Number, b :Number) :Boolean {
        return Math.abs(b - a) <= EPSILON;
    }

    /** Returns the value of n clamped to be within the range [min, max]. */
    public static function clamp (n :Number, min :Number, max :Number) :Number {
        return Math.min(Math.max(n, min), max);
    }

    /** Converts degrees to radians. */
    public static function toRadians (degrees :Number) :Number {
        return degrees * D2R;
    }

    /** Converts radians to degrees. */
    public static function toDegrees (radians :Number) :Number {
        return radians * R2D;
    }

    /** Normalizes an angle in radians to occupy the [-pi, pi) range. */
    public static function normalizeAngle (a :Number) :Number {
        while (a < -Math.PI) {
            a += TWO_PI;
        }
        while (a >= Math.PI) {
            a -= TWO_PI;
        }
        return a;
    }

    /** Normalizes an angle to occupy the [0, 2pi) range. */
    public static function normalizeAnglePositive (a :Number) :Number {
        while (a < 0) {
            a += TWO_PI;
        }
        while (a >= TWO_PI) {
            a -= TWO_PI;
        }
        return a;
    }

    /**
     * Returns distance from point (x1, y1) to (x2, y2) in 2D.
     *
     * <p>Supports various distance metrics: the common Euclidean distance, taxicab distance,
     * arbitrary Minkowski distances, and Chebyshev distance.</p>
     *
     * <p>See the <a href="http://www.nist.gov/dads/HTML/lmdistance.html">NIST web page on
     * distance definitions</a>.</p>
     *
     * @param x1 x value of the first point
     * @param y1 y value of the first point
     * @param x2 x value of the second point
     * @param y2 y value of the second point
     * @param p Optional: p value of the norm function. Common cases:
     *          <ul><li>p = 2 (default): standard Euclidean distance on a plane</li>
     *              <li>p = 1: taxicab distance (aka Manhattan distance)</li>
     *              <li>p = Infinity: Chebyshev distance</li>
     *          </ul>
     *          <b>Note</b>: p &lt; 1 or p = NaN are treated as equivalent to p = Infinity
     */
    public static function distance (
        x1 :Number, y1 :Number, x2 :Number, y2 :Number, p :Number = 2) :Number
    {
        var dx :Number = x2 - x1;
        var dy :Number = y2 - y1;

        if (p == 2) {
            // optimized version for Euclidean
            return Math.sqrt(dx * dx + dy * dy);
        }

        // from here on out: we're not squaring dx and dy, so make them positive.
        dx = Math.abs(dx);
        dy = Math.abs(dy);

        if (p == 1) {
            // optimized version for taxicab distance
            return (dx + dy);

        } else if (!isFinite(p) || (p < 1)) { // aka: (p is Infinity, -Infinity, NaN, or negative)
            // optimized version for Chebyshev
            return Math.max(dx, dy);

        } else {
            // generic version (p > 2 && p < Infinity)
            var xx :Number = Math.pow(dx, p);
            var yy :Number = Math.pow(dy, p);
            return Math.pow(xx + yy, 1 / p);
        }
    }

    /**
     * Computes the floored division <code>dividend/divisor</code> which
     * is useful when dividing potentially negative numbers into bins. For
     * positive numbers, it is the same as normal division, for negative
     * numbers it returns <code>(dividend - divisor + 1) / divisor</code>.
     *
     * <p> For example, the following numbers floorDiv 10 are:
     * <pre>
     * -15 -10 -8 -2 0 2 8 10 15
     *  -2  -1 -1 -1 0 0 0  1  1
     * </pre></p>
     */
    public static function floorDiv (dividend :int, divisor :int) :int {
        return ((dividend >= 0) ? dividend : (dividend - divisor + 1))/divisor;
    }

    protected static const D2R :Number = Math.PI / 180.0;
    protected static const R2D :Number = 180.0 / Math.PI;
}
}
