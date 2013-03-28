//
// aspire

package aspire.geom {

public class Points
{
    /** Returns the squared distance between two points */
    public static function distanceSq (x1 :Number, y1 :Number, x2 :Number, y2 :Number) :Number {
        const x :Number = x2 - x1;
        const y :Number = y2 - y1;
        return (x * x + y * y);
    }

    /** Returns the distance between two points */
    public static function distance (x1 :Number, y1 :Number, x2 :Number, y2 :Number) :Number {
        return Math.sqrt(distanceSq(x1, y1, x2, y2));
    }

    /** Returns the angle between two points */
    public static function angleBetween (x1 :Number, y1 :Number, x2 :Number, y2 :Number) :Number {
        var val :Number = Math.atan2(y2 - y1, x2 - x1);
        return (val >= 0 ? val : val + (2 * Math.PI));
    }
}
}
