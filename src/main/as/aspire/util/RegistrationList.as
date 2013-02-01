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
    public function add (r :Registration) :Registration {
        _regs.push(r);
        return r;
    }

    /**
     * Cancels all Registrations that have been added to the manager.
     */
    public function cancel () :void {
        var regs :Vector.<Registration> = _regs;
        _regs = new <Registration>[];
        for each (var r :Registration in regs) {
            r.cancel();
        }
    }

    protected var _regs :Vector.<Registration> = new <Registration>[];
}
}
