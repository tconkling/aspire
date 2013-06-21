//
// aspire

package aspire.geom {

import aspire.util.Hashable;

import flash.geom.Point;

/**
 * An integer-based point
 */
public class PointI
    implements Hashable
{
    public var x :int = 0;
    public var y :int = 0;

    /** Converts Point p to a PointI */
    public static function fromPoint (p :Point, out :PointI = null) :PointI {
        out = (out || new PointI());
        out.set(p.x, p.y);
        return out;
    }

    /** Constructs a PointI from the given values. */
    public function PointI (x :int = 0, y :int = 0) {
        this.x = x;
        this.y = y;
    }

    /** Sets the point's components to the given values. Returns this, for chaining. */
    public function set (x :int, y :int) :PointI {
        this.x = x;
        this.y = y;
        return this;
    }

    /** Converts the PointI to a Point. */
    public function toPoint (out :Point = null) :Point {
        out = (out || new Point());
        out.setTo(x, y);
        return out;
    }

    /** Converts the PointI to a Vector2 */
    public function toVector2 (out :Vector2 = null) :Vector2 {
        out = (out || new Vector2());
        out.set(x, y);
        return out;
    }

    /**
     * Returns a copy of this PointI.
     * If 'out' is not null, it will be used for the clone.
     */
    public function clone (out :PointI = null) :PointI {
        out = (out || new PointI());
        out.x = x;
        out.y = y;
        return out;
    }

    /**
     * Adds another PointI to this, in place.
     * Returns a reference to 'this', for chaining.
     */
    public function addLocal (v :PointI) :PointI {
        x += v.x;
        y += v.y;

        return this;
    }

    /** Returns a copy of this point added to 'p'. */
    public function add (p :PointI, out :PointI = null) :PointI {
        return clone(out).addLocal(p);
    }

    /**
     * Subtracts another point from this one, in place.
     * Returns a reference to 'this', for chaining.
     */
    public function subtractLocal (p :PointI) :PointI {
        x -= p.x;
        y -= p.y;

        return this;
    }

    /** Returns (this - p). */
    public function subtract (p :PointI, out :PointI = null) :PointI {
        return clone(out).subtractLocal(p);
    }

    /**
     * Offsets this PointI's values by the specified amounts.
     * Returns a reference to 'this', for chaining.
     */
    public function offsetLocal (xOffset :int, yOffset :int) :PointI {
        x += xOffset;
        y += yOffset;
        return this;
    }

    /** Returns a copy of this PointI, offset by the specified amount. */
    public function offset (xOffset :int, yOffset :int, out :PointI = null) :PointI {
        return clone(out).offsetLocal(xOffset, yOffset);
    }

    /** Returns true if this PointI is equal to obj. */
    public function equals (obj :Object) :Boolean {
        var p :PointI = obj as PointI;
        return (p != null && x == p.x && y == p.y);
    }

    public function hashCode () :int {
        return (31 * x) + y;
    }

    /** Returns a string representation of the PointI. */
    public function toString () :String {
        return "" + x + "," + y;
    }
}

}

