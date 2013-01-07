//
// aspire

package aspire.geom {

import flash.geom.Point;

import aspire.util.Equalable;

/**
 * An integer-based point
 */
public class PointI
    implements Equalable
{
    public var x :int = 0;
    public var y :int = 0;

    /** Converts Point p to a PointI */
    public static function fromPoint (p :Point) :PointI
    {
        return new PointI(p.x, p.y);
    }

    /** Constructs a PointI from the given values. */
    public function PointI (x :int = 0, y :int = 0)
    {
        this.x = x;
        this.y = y;
    }

    /** Sets the point's components to the given values. */
    public function set (x :int, y :int) :void
    {
        this.x = x;
        this.y = y;
    }

    /** Converts the PointI to a Point. */
    public function toPoint () :Point
    {
        return new Point(x, y);
    }

    /** Converts the PointI to a Vector2 */
    public function toVector2 () :Vector2
    {
        return new Vector2(x, y);
    }

    /** Returns a copy of this PointI. */
    public function clone () :PointI
    {
        return new PointI(x, y);
    }

    /**
     * Adds another PointI to this, in place.
     * Returns a reference to 'this', for chaining.
     */
    public function addLocal (v :PointI) :PointI
    {
        x += v.x;
        y += v.y;

        return this;
    }

    /** Returns a copy of this point added to 'p'. */
    public function add (p :PointI) :PointI
    {
        return clone().addLocal(p);
    }

    /**
     * Subtracts another point from this one, in place.
     * Returns a reference to 'this', for chaining.
     */
    public function subtractLocal (p :PointI) :PointI
    {
        x -= p.x;
        y -= p.y;

        return this;
    }

    /** Returns (this - p). */
    public function subtract (p :PointI) :PointI
    {
        return clone().subtractLocal(p);
    }

    /**
     * Offsets this PointI's values by the specified amounts.
     * Returns a reference to 'this', for chaining.
     */
    public function offsetLocal (xOffset :int, yOffset :int) :PointI
    {
        x += xOffset;
        y += yOffset;
        return this;
    }

    /** Returns a copy of this PointI, offset by the specified amount. */
    public function offset (xOffset :int, yOffset :int) :PointI
    {
        return clone().offsetLocal(xOffset, yOffset);
    }

    /** Returns true if this PointI is equal to obj. */
    public function equals (obj :Object) :Boolean
    {
        var p :PointI = obj as PointI;
        return (p != null && x == p.x && y == p.y);
    }

    /** Returns a string representation of the PointI. */
    public function toString () :String
    {
        return "" + x + "," + y;
    }
}

}

