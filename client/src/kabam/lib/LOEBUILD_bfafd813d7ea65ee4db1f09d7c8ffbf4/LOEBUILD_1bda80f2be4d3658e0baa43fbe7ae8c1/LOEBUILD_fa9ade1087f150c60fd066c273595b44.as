package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_1bda80f2be4d3658e0baa43fbe7ae8c1 {
import com.junkbyte.console.Console;
import com.junkbyte.console.ConsoleConfig;

import flash.display.BlendMode;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_20f35e630daf44dbfa4c3f68f5399d8c.LOEBUILD_f20658650d987d31063b593c05980397;
import kabam.lib.resizing.view.Resizable;

public final class LOEBUILD_fa9ade1087f150c60fd066c273595b44 extends Sprite implements Resizable {

      private static const DEFAULT_OUTPUT:String = "kabam.lib/LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4";

      private const PATTERN:RegExp = new RegExp("\\[0x(.+)\\:(.+)\\]","ig");

      private const HTML_TEMPLATE:String = "<font color=\'#$1\'>$2</font>";

      private var watchTextField:TextField;

      private var logConsole:Console;

      private const logged:Array = [];

      private const watched:Array = [];

      private const watchMap:Object = {};

      private var watchBottom:Number;

      public function LOEBUILD_fa9ade1087f150c60fd066c273595b44() {
         this.watchTextField = new TextField();
         super();
         alpha = 0.8;
         blendMode = BlendMode.LAYER;
         addChild(this.watchTextField);
         this.watchTextField.alpha = 0.6;
         this.watchTextField.defaultTextFormat = new TextFormat("_sans",14,16777215,true);
         this.watchTextField.htmlText = DEFAULT_OUTPUT;
         this.watchTextField.selectable = false;
         this.watchTextField.multiline = true;
         this.watchTextField.wordWrap = true;
         this.watchTextField.autoSize = TextFieldAutoSize.LEFT;
         this.watchTextField.background = true;
         this.watchTextField.border = false;
         this.watchTextField.backgroundColor = 13056;
         this.logConsole = new Console("",new ConsoleConfig());
         addChild(this.logConsole);
      }

      public function watch(param1:LOEBUILD_f20658650d987d31063b593c05980397) : void {
         var _local2:LOEBUILD_f20658650d987d31063b593c05980397 = this.watchMap[param1.name] = this.watchMap[param1.name] || this.makeWatch(param1.name);
         _local2.data = param1.data.replace(this.PATTERN,this.HTML_TEMPLATE);
         this.updateOutputText();
      }

      public function unwatch(param1:String) : void {
         var _local2:LOEBUILD_f20658650d987d31063b593c05980397 = this.watchMap[param1];
         if(_local2) {
            delete this.watchMap[param1];
            this.watched.splice(this.watched.indexOf(_local2),1);
         }
      }

      private function makeWatch(param1:String) : LOEBUILD_f20658650d987d31063b593c05980397 {
         var _local2:LOEBUILD_f20658650d987d31063b593c05980397 = new LOEBUILD_f20658650d987d31063b593c05980397(param1);
         this.watched.push(_local2);
         return _local2;
      }

      public function log(param1:String) : void {
         var _local2:String = param1.replace(this.PATTERN,this.HTML_TEMPLATE);
         this.logged.push(_local2);
         this.logConsole.addHTML(_local2);
      }

      public function clear() : void {
         var _local1:* = null;
         this.logged.length = 0;
         this.watched.length = 0;
         for(_local1 in this.watchMap) {
            delete this.watchMap[_local1];
         }
      }

      public function resize(param1:Rectangle) : void {
         this.watchBottom = param1.height - LOEBUILD_9a1afe308cb8a3976519f048fad72e19.HEIGHT;
         x = param1.x;
         y = param1.y;
         this.watchTextField.width = param1.width;
         this.logConsole.width = param1.width;
         this.snapWatchTextToInputView();
      }

      private function snapWatchTextToInputView() : void {
         this.watchTextField.y = this.watchBottom - this.watchTextField.height;
      }

      private function updateOutputText() : void {
         this.watchTextField.htmlText = this.watched.join("\n");
         this.snapWatchTextToInputView();
      }

      public function getText() : String {
         return this.logged.join("\r");
      }
   }
}
