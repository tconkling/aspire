//
// aspire

package aspire.util.maps {

import flash.errors.IllegalOperationError;

import aspire.util.Map;

/**
 * A map that throws IllegalOperationError is thrown if any mutating methods are called.
 */
public class ImmutableMap extends ForwardingMap
{
    public function ImmutableMap (source :Map) {
        super(source);
    }

    /** @inheritDoc */
    override public function put (key :Object, value :Object) :* {
        return immutable();
    }

    /** @inheritDoc */
    override public function remove (key :Object) :* {
        return immutable();
    }

    /** @inheritDoc */
    override public function clear () :void {
        immutable();
    }

    /** @private */
    protected function immutable () :void {
        throw new IllegalOperationError();
    }
}
}
