package kabam.rotmg.characters.reskin.view {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.ui.DeprecatedTextButton;
import com.company.assembleegameclient.ui.panels.Panel;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class ReskinPanel extends Panel {

      private const title:TextFieldDisplayConcrete = makeTitle();

      private const button:DeprecatedTextButton = makeButton();

      private const click:Signal = new NativeMappedSignal(button,MouseEvent.CLICK);

      public const reskin:Signal = new Signal();

      public function ReskinPanel(param1:GameSprite = null) {
         super(param1);
         this.click.add(this.onClick);
      }

      private function onClick() : void {
         this.reskin.dispatch();
      }

      private function makeTitle() : TextFieldDisplayConcrete {
         var _local1:TextFieldDisplayConcrete = null;
         _local1 = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setAutoSize(TextFieldAutoSize.CENTER);
         _local1.x = WIDTH / 2;
         _local1.setBold(true);
         _local1.filters = [new DropShadowFilter(0,0,0)];
         _local1.setStringBuilder(new LineBuilder().setParams(TextKey.RESKINPANEL_CHANGESKIN));
         addChild(_local1);
         return _local1;
      }

      private function makeButton() : DeprecatedTextButton {
         var _local1:DeprecatedTextButton = new DeprecatedTextButton(16,TextKey.RESKINPANEL_CHOOSE);
         _local1.textChanged.addOnce(this.onTextSet);
         addChild(_local1);
         return _local1;
      }

      private function onTextSet() : void {
         this.button.x = WIDTH / 2 - this.button.width / 2;
         this.button.y = HEIGHT - this.button.height - 4;
      }

      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.interact && stage.focus == null) {
            this.reskin.dispatch();
         }
      }
   }
}
