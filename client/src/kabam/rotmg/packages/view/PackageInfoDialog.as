package kabam.rotmg.packages.view {
import com.company.assembleegameclient.ui.DeprecatedTextButton;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextFormatAlign;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.graphics.ButtonLayoutHelper;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class PackageInfoDialog extends Sprite {

      private static const TITLE_Y:int = 8;

      private static const BUTTON_WIDTH:int = 120;

      private static const BUTTON_FONT:int = 16;

      private static const DIALOG_WIDTH:int = 546;

      private static const INNER_WIDTH:int = 416;

      private static const BUTTON_Y:int = 368;

      private static const MESSAGE_TITLE_Y:int = 164;

      private static const MESSAGE_BODY_Y:int = 210;

      private const background:DisplayObject = makeBackground();

      private const title:TextFieldDisplayConcrete = makeTitle();

      private const messageTitle:TextFieldDisplayConcrete = makeMessageTitle();

      private const messageBody:TextFieldDisplayConcrete = makeMessageBody();

      private const close:DeprecatedTextButton = makeCloseButton();

      public const closed:Signal = new NativeMappedSignal(close,MouseEvent.CLICK);

      public function PackageInfoDialog() {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }

      private function onAddedToStage(param1:Event) : void {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         x = (800 - width) / 2;
         y = (600 - height) / 2;
      }

      public function setTitle(param1:String) : PackageInfoDialog {
         this.title.setStringBuilder(new LineBuilder().setParams(param1));
         return this;
      }

      public function setBody(param1:String, param2:String) : PackageInfoDialog {
         this.messageTitle.setStringBuilder(new LineBuilder().setParams(param1));
         this.messageBody.setStringBuilder(new LineBuilder().setParams(param2));
         return this;
      }

      private function makeBackground() : DisplayObject {
         var _local1:PackageBackground = new PackageBackground();
         addChild(_local1);
         return _local1;
      }

      private function makeTitle() : TextFieldDisplayConcrete {
         var _local1:TextFieldDisplayConcrete = null;
         _local1 = new TextFieldDisplayConcrete().setSize(18).setColor(11974326).setTextWidth(DIALOG_WIDTH).setAutoSize(TextFormatAlign.CENTER).setBold(true);
         _local1.y = TITLE_Y;
         addChild(_local1);
         return _local1;
      }

      private function makeMessageTitle() : TextFieldDisplayConcrete {
         var _local1:TextFieldDisplayConcrete = null;
         _local1 = new TextFieldDisplayConcrete().setSize(14).setColor(14864077).setTextWidth(INNER_WIDTH).setAutoSize(TextFormatAlign.CENTER).setBold(true);
         _local1.x = (DIALOG_WIDTH - INNER_WIDTH) * 0.5;
         _local1.y = MESSAGE_TITLE_Y;
         addChild(_local1);
         return _local1;
      }

      private function makeMessageBody() : TextFieldDisplayConcrete {
         var _local1:TextFieldDisplayConcrete = null;
         _local1 = new TextFieldDisplayConcrete().setSize(14).setColor(10914439).setTextWidth(INNER_WIDTH).setAutoSize(TextFormatAlign.CENTER);
         _local1.x = (DIALOG_WIDTH - INNER_WIDTH) * 0.5;
         _local1.y = MESSAGE_BODY_Y;
         addChild(_local1);
         return _local1;
      }

      private function makeCloseButton() : DeprecatedTextButton {
         var _local1:DeprecatedTextButton = null;
         _local1 = new DeprecatedTextButton(BUTTON_FONT,TextKey.CLOSE,BUTTON_WIDTH);
         _local1.textChanged.addOnce(this.layoutButton);
         _local1.y = BUTTON_Y;
         addChild(_local1);
         return _local1;
      }

      private function layoutButton() : void {
         new ButtonLayoutHelper().layout(DIALOG_WIDTH,this.close);
      }
   }
}
