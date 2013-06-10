//
// aspire

package aspire.util {

public interface TimerRegistration extends Registration
{
    function once () :TimerRegistration;
    function start () :TimerRegistration;
    function stop () :TimerRegistration;
}
}
