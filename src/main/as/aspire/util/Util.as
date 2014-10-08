//
// aspire

package aspire.util {

import flash.utils.ByteArray;

/**
 * Contains a variety of utility functions.
 */
public class Util
{
    /**
     * Get an array containing the property keys of the specified object, in their
     * natural iteration order.
     */
    public static function keys (obj :Object) :Array {
        var arr :Array = [];
        for (var k :* in obj) { // no "each": iterate over keys
            arr.push(k);
        }
        return arr;
    }

    /**
     * Get an array containing the property values of the specified object, in their
     * natural iteration order.
     */
    public static function values (obj :Object) :Array {
        var arr :Array = [];
        for each (var v :* in obj) { // "each" iterates over values
            arr.push(v);
        }
        return arr;
    }

    /**
     * A nice utility method for testing equality in a better way.
     * If the objects are Equalable, then that will be tested. Arrays
     * and ByteArrays are also compared and are equal if they have
     * elements that are equals (deeply).
     */
    public static function equals (obj1 :Object, obj2 :Object) :Boolean {
        // catch various common cases (both primitive or null)
        if (obj1 === obj2) {
            return true;
        } else if (obj1 is Equalable) {
            // if obj1 is Equalable, then that decides it
            return (obj1 as Equalable).equals(obj2);

        } else if ((obj1 is Array) && (obj2 is Array)) {
            return Arrays.equals(obj1 as Array, obj2 as Array);

        } else if ((obj1 is ByteArray) && (obj2 is ByteArray)) {
            var ba1 :ByteArray = (obj1 as ByteArray);
            var ba2 :ByteArray = (obj2 as ByteArray);
            if (ba1.length != ba2.length) {
                return false;
            }
            for (var ii :int = 0; ii < ba1.length; ii++) {
                if (ba1[ii] != ba2[ii]) {
                    return false;
                }
            }
            return true;
        }

        return false;
    }
}
}
