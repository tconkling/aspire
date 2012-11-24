//
// aspire

package aspire.ui {

import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

/**
 * Displays a simple button with a rounded rectangle or rectangle for a face.
 */
public class SimpleTextButton extends SimpleButton
{
    public function SimpleTextButton (
        text :String, rounded :Boolean = true, foreground :uint = 0x003366,
        background :uint = 0x6699CC, highlight :uint = 0x0066FF, padding :int = 5,
        textFormat :TextFormat = null)
    {
        upState = makeFace(text, rounded, foreground, background, padding, textFormat);
        overState = makeFace(text, rounded, highlight, background, padding, textFormat);
        downState = makeFace(text, rounded, background, highlight, padding, textFormat);
        hitTestState = overState;
    }

    protected function makeFace (
        text :String, rounded :Boolean, foreground :uint, background :uint,
        padding :int, textFormat :TextFormat) :Sprite
    {
        var face :Sprite = new Sprite();

        // create the label so that we can measure its size
        var label :TextField = new TextField();
        if (textFormat) {
            label.defaultTextFormat = textFormat;
        }
        label.text = text;
        label.textColor = foreground;
        label.autoSize = TextFieldAutoSize.LEFT;
        face.addChild(label);

        var w :Number = label.width + 2 * padding;
        var h :Number = label.height + 2 * padding;

        // draw our button background (and outline)
        face.graphics.beginFill(background);
        face.graphics.lineStyle(1, foreground);
        if (rounded) {
            face.graphics.drawRoundRect(0, 0, w, h, padding, padding);
        } else {
            face.graphics.drawRect(0, 0, w, h);
        }
        face.graphics.endFill();

        label.x = padding;
        label.y = padding;

        return face;
    }
}
}
