//
// aspire

package aspire.util {

public interface TimerRegistration extends OneShotRegistration
{
    function start () :TimerRegistration;
    function stop () :TimerRegistration;
}
}
