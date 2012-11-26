//
// aspire

package aspire.util {

public class RegistrationList
    implements Registration
{
    /**
     * Adds a Registration to the manager.
     * @return the Registration passed to the function.
     */
    public function add (r :Registration) :Registration
    {
        _regs.push(r);
        return r;
    }

    /**
     * Cancels all Registrations that have been added to the manager.
     */
    public function cancel () :void
    {
        var regs :Array = _regs;
        _regs = [];
        for each (var r :Registration in regs) {
            r.cancel();
        }
    }

    protected var _regs :Array = [];
}
}
