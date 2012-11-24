//
// aspire

package aspire.ui {

import flash.events.ContextMenuEvent;
import flash.ui.ContextMenuItem;

import aspire.util.CommandEvent;

/**
 */
public class MenuUtil
{
    /**
     * Create a context menu item that will submit a command when selected.
     */
    public static function createCommandContextMenuItem (
        caption :String, cmdOrFn :Object, arg :Object = null,
        separatorBefore :Boolean = false, enabled :Boolean = true) :ContextMenuItem
    {
        var item :ContextMenuItem = new ContextMenuItem(caption, separatorBefore, enabled);
        item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
            function (event :ContextMenuEvent) :void {
                // mouseTarget may be null due to security reasons
                CommandEvent.dispatch(event.mouseTarget || event.contextMenuOwner, cmdOrFn, arg);
            });
        return item;
    }
}
}
