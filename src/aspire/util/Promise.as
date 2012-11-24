//
// aspire

package aspire.util {

/**
 * Contains a value which may not be ready yet. If you request the value with get(), we'll promise
 * to get back to you eventually, or immediately if the value is already available.
 */
public class Promise
{
    public function get (f :Function) :void
    {
        if (_callbacks != null) {
            _callbacks.push(f);
        } else {
            f.apply(undefined, _value);
        }
    }

    public function set (...value) :void
    {
        _value = value;

        if (_callbacks != null) {
            var c :Array = _callbacks;
            _callbacks = null; // Promise fulfilled

            for each (var f :Function in c) {
                f.apply(undefined, value);
            }
        }
    }

    public function and (other :Promise) :Promise
    {
        var p :Promise = new Promise();
        var values :Array = null; // The results from the first promise to complete

        this.get(function (...x) :void {
            if (values != null) {
                p.set.apply(p, x.concat(values));
            } else {
                values = x;
            }
        });
        other.get(function (...y) :void {
            if (values != null) {
                p.set.apply(p, values.concat(y));
            } else {
                values = y;
            }
        });

        return p;
    }

    public function get ready () :Boolean
    {
        return (_callbacks == null);
    }

    protected var _value :*;
    protected var _callbacks :Array = [];
}
}
