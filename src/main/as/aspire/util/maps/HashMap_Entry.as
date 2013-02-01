//
// aspire

package aspire.util.maps {

import aspire.util.Hashable;

/**
 * A key/value pair in a HashMap. This is really an internal class to HashMap, and when
 * Flash CS4 is fixed, it will go nestle back into HashMap.as's luxurious folds.
 * @private
 */
public class HashMap_Entry
{
    public var key :Hashable;
    public var value :Object;
    public var hash :int;
    public var next :HashMap_Entry;

    public function HashMap_Entry (hash :int, key :Hashable, value :Object, next :HashMap_Entry) {
        this.hash = hash;
        this.key = key;
        this.value = value;
        this.next = next;
    }
}
}
