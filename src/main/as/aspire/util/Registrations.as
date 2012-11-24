//
// aspire

package aspire.util {

public class Registrations
{
    public static function createWithFunction (f :Function) :Registration {
        return new FunctionRegistration(f);
    }
}
}

import aspire.util.Registration;

class FunctionRegistration
    implements Registration
{
    public function FunctionRegistration (f :Function) {
        _f = f;
    }

    public function cancel () :void {
        var f :Function = _f;
        _f = null;
        f();
    }

    protected var _f :Function;
}
