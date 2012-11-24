//
// aspire

package aspire.util {

/**
 * A List contains an ordered collection of objects.
 *
 * @see com.threerings.util.Lists
 */
public interface List
{
    function add (o :Object) :Boolean;

    function addAt (index :int, o :Object) :void;

    function get (index :int) :Object;

    function set (index :int, o :Object) :void;

    function contains (o :Object) :Boolean;

    function indexOf (o :Object) :int;

    function lastIndexOf (o :Object) :int;

    function remove (o :Object) :Boolean;

    function removeAt (index :int) :Object;

    function size () :int;

    function isEmpty () :Boolean;

    function clear () :void;

    function toArray () :Array;

    function forEach (fn :Function) :void;
}
}
