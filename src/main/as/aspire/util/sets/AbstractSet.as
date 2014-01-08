//
// aspire

package aspire.util.sets {

/**
 * A skeletal building block for sets.
 * @private
 */
public /* abstract */ class AbstractSet
{
    /**
     * Return a String representation of this Set.
     * @public
     */
    public function toString () :String {
        var s :String = "Set [";
        var theSet :Object = this;
        var comma :Boolean = false;
        forEach(function (value :Object) :void {
            if (comma) {
                s += ", ";
            }
            s += (value === theSet) ? "(this Set)" : value;
            comma = true;
        });
        s += "]";
        return s;
    }

    /** @copy com.threerings.util.Set#forEach() */
    public function forEach (fn :Function) :void {
        throw new Error("Abstract");
    }
}
}
