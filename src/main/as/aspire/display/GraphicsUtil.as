//
// aspire

package aspire.display {

import flash.display.Graphics;

public class GraphicsUtil
{
    /**
     * Draws a dashed rectangle using the currently-set lineStyle.
     */
    public static function dashRect (
        g :Graphics, x :Number, y :Number, width :Number, height :Number,
        dashLength :Number = 5, spaceLength :Number = 5) :void
    {
        const x2 :Number = x + width;
        const y2 :Number = y + height;
        dashTo(g, x, y, x2, y, dashLength, spaceLength);
        dashTo(g, x2, y, x2, y2, dashLength, spaceLength);
        dashTo(g, x2, y2, x, y2, dashLength, spaceLength);
        dashTo(g, x, y2, x, y, dashLength, spaceLength);
    }

    /**
     * Draws a dashed line using the currently set lineStyle.
     */
    public static function dashTo (
        g :Graphics, x1 :Number, y1 :Number, x2 :Number, y2 :Number,
        dashLength :Number = 5, spaceLength :Number = 5) :void
    {
        const dx :Number = (x2 - x1), dy :Number = (y2 - y1);
        var length :Number = Math.sqrt(dx*dx + dy*dy);
        const units :Number = length/(dashLength+spaceLength);
        const dashSpaceRatio :Number = dashLength/(dashLength+spaceLength);
        const dashX :Number = (dx/units)*dashSpaceRatio, dashY :Number = (dy/units)*dashSpaceRatio;
        const spaceX :Number = (dx/units)-dashX, spaceY :Number = (dy/units)-dashY;

        g.moveTo(x1, y1);
        while (length > 0) {
            x1 += dashX;
            y1 += dashY;
            length -= dashLength;
            if (length < 0) {
                x1 = x2;
                y1 = y2;
            }
            g.lineTo(x1, y1);
            x1 += spaceX;
            y1 += spaceY;
            g.moveTo(x1, y1);
            length -= spaceLength;
        }
        g.moveTo(x2, y2);
    }
}
}
