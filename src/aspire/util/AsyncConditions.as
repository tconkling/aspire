//
// aspire

package aspire.util {

/**
 * Records the completion of multiple conditions and calls a function when all are completed.
 */
public class AsyncConditions
{
    /**
     * Creates an AsyncConditions that calls onAllComplete when satisfy is called for everything in
     * conditions.
     */
    public function AsyncConditions (conditions :Array, onAllSatisfied :Function)
    {
        _onAllSatisfied = onAllSatisfied;
        for each (var cond :String in conditions) {
            _unsatisfied.add(cond);
        }
    }

    /**
     * Marks condition as satisfied. If satisfy has already been called for condition or condition
     * wasn't in the set of conditions, a warning is logged. If condition is the last unsatisfied
     * condition, the satisfaction callback is called.
     */
    public function satisfy (condition :Object) :void
    {
        if (_unsatisfied.remove(condition)) {
            _satisfied.add(condition);
            if(_unsatisfied.isEmpty()) {
                _onAllSatisfied();
            }
        } else if (_satisfied.contains(condition)) {
            log.warning("Condition satisfied multiple times", "condition", condition);
        } else {
            log.warning("Unknown condition satisfied", "condition", condition);
        }
    }

    protected var _onAllSatisfied :Function;

    protected const _unsatisfied :Set = Sets.newSetOf(String);
    protected const _satisfied :Set = Sets.newSetOf(Object);

    private static const log :Log = Log.getLog(AsyncConditions);
}
}
