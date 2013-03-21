//
// aspire

package aspire.geom {

import aspire.util.Equalable;
import aspire.util.StringUtil;

/**
 * Rectangle with integer location and size
 */
public class RectangleI
    implements Equalable
{
    public var x :int;
    public var y :int;
    public var width :int;
    public var height :int;

    public function RectangleI (x :int = 0, y :int = 0, width :int = 0, height :int = 0) {
        setTo(x, y, width, height);
    }

    public function get left () :int {
        return x;
    }

    public function set left (val :int) :void {
        x = val;
    }

    public function get top () :int {
        return y;
    }

    public function set top (val :int) :void {
        y = val;
    }

    public function get right () :int {
        return x + width - 1;
    }

    /** Sets the right coordinate of the rectangle. Width is unaffected. */
    public function set right (val :int) :void {
        x = val - width + 1;
    }

    public function get bottom () :int {
        return y + height - 1;
    }

    /** Sets the bottom coordinate of the rectangle. Height is unaffected. */
    public function set bottom (val :int) :void {
        y = val - height + 1;
    }

    public function get isEmpty () :Boolean {
        return (width <= 0 || height <= 0);
    }

    public function offset (dx :int, dy :int) :void {
        x += dx;
        y += dy;
    }

    public function setTo (x :int, y :int, width :int, height :int) :void {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }

    /**
     * Grows the bounds of this rectangle by the specified amount (i.e. the upper-left corner moves
     * by the specified amount in the negative x and y direction and the width and height grow by
     * twice the specified amount).
     */
    public function grow (dx :int, dy :int) :void {
        x -= dx;
        y -= dy;
        width += dx + dx;
        height += dy + dy;
    }

    public function union (other :RectangleI, out :RectangleI = null) :RectangleI {
        out = (out || new RectangleI());
        const x1 :int = Math.min(x, other.x);
        const x2 :int = Math.max(x + width, other.x + other.width);
        const y1 :int = Math.min(y, other.y);
        const y2 :int = Math.max(y + height, other.y + other.height);
        out.setTo(x1, y1, x2 - x1, y2 - y1);
        return out;
    }

    public function intersection (other :RectangleI, out :RectangleI = null) :RectangleI {
        out = (out || new RectangleI());
        const x1 :int = Math.max(x, other.x);
        const y1 :int = Math.max(y, other.y);
        const x2 :int = Math.min(right, other.right);
        const y2 :int = Math.min(bottom, other.bottom);
        out.setTo(x1, y1, x2 - x1, y2 - y1);
        return out;
    }

    public function intersects (other :RectangleI) :Boolean {
        return !(intersection(other, R).isEmpty);
    }

    public function copyFrom (src :RectangleI) :void {
        this.x = src.x;
        this.y = src.y;
        this.width = src.width;
        this.height = src.height;
    }

    public function clone (out :RectangleI = null) :RectangleI {
        out = (out || new RectangleI());
        out.copyFrom(this);
        return out;
    }

    public function equals (obj :Object) :Boolean {
        const o :RectangleI = (obj as RectangleI);
        return (o != null && x == o.x && y == o.y && width == o.width && height == o.height);
    }

    public function toString () :String {
        return StringUtil.simpleToString(this, [ "x", "y", "width", "height" ]);
    }

    protected static const R :RectangleI = new RectangleI();
}
}
