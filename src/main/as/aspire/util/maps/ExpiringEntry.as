//
// aspire

package aspire.util.maps {

/**
 * @private
 */
public class ExpiringEntry extends LinkedEntry
{
    public var expireTime :int;

    public function ExpiringEntry (key :Object, value :Object, expireTime :int) {
        super(key, value);
        this.expireTime = expireTime;
    }
}
}
