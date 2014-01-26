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

    /** Return the sign of the value. val > 0 -> 1; val < 0 -> -1; val == 0 -> 0 */
    public static function sign (val :Number) :Number {
        return (val > 0 ? 1 : (val < 0 ? -1 : 0));
    }

    /** Returns true if the two numbers differ by no more than EPSILON */
    public static function epsilonEquals (a :Number, b :Number) :Boolean {
        return Math.abs(b - a) <= EPSILON;
    }

    /**
     * Returns the smaller of two values.
     * This differs from the built-in Math.min in that it doesn't accept varargs, and so doesn't
     * involve the creation of a temporary array.
     */
    public static function min (a :Number, b :Number) :Number {
        return (a < b ? a : b);
    }

    /**
     * Returns the larger of two values.
     * This differs from the built-in Math.max in that it doesn't accept varargs, and so doesn't
     * involve the creation of a temporary array.
     */
    public static function max (a :Number, b :Number) :Number {
        return (a > b ? a : b);
    }

    /** Returns the value of n clamped to be within the range [min, max]. */
    public static function clamp (n :Number, min :Number, max :Number) :Number {
        return (n < min ? min : (n > max ? max : n));
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
