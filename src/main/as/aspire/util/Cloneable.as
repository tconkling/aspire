//
// aspire

package aspire.util {

/**
 * Implemented by objects that support creating a clone.
 */
public interface Cloneable
{
    /**
     * Create a clone of this object.
     *
     * @example A smart implementation that allows for subclassing.
     * <listing version="3.0">
     * public function clone () :Object
     * {
     *     var myObj :MyClass = MyClass(ClassUtil.newInstance(this)); // requires 0-arg constructor
     *     myObj.someInt = this.someInt; // copy all vars
     *     myObj.someArray = this.someArray.concat(); // make a clone of any mutable vars
     *     return myObj;
     * }
     * </listing>
     */
    function clone () :Object;
}
}
