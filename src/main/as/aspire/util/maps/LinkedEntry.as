//
// aspire

package aspire.util.maps {

/**
 * A special metastructure for keeping track of the ordering in a LinkedMap.
 * @private
 */
public class LinkedEntry
{
    public var before :LinkedEntry;

    public var after :LinkedEntry;

    public var key :Object;

    public var value :Object;

    public function LinkedEntry (key :Object, value :Object) {
        this.key = key;
        this.value = value;
    }

    public function addBefore (existing :LinkedEntry) :void {
        after = existing;
        before = existing.before;
        before.after = this;
        after.before = this;
    }

    public function remove () :void {
        before.after = after;
        after.before = before;
    }
}
}
