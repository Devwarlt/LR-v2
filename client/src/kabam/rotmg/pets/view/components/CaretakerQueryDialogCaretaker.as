package kabam.rotmg.pets.view.components {
import com.company.assembleegameclient.util.BitmapDataSpy;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import kabam.rotmg.pets.view.dialogs.CaretakerQueryDialog;

public class CaretakerQueryDialogCaretaker extends Sprite {

      private const speechBubble:CaretakerQuerySpeechBubble = makeSpeechBubble();

      private const detailBubble:CaretakerQueryDetailBubble = makeDetailBubble();

      private const icon:Bitmap = makeCaretakerIcon();

      public function CaretakerQueryDialogCaretaker() {
         super();
      }

      private function makeSpeechBubble() : CaretakerQuerySpeechBubble {
         var _local1:CaretakerQuerySpeechBubble = null;
         _local1 = new CaretakerQuerySpeechBubble(CaretakerQueryDialog.QUERY);
         _local1.x = 60;
         addChild(_local1);
         return _local1;
      }

      private function makeDetailBubble() : CaretakerQueryDetailBubble {
         var _local1:CaretakerQueryDetailBubble = null;
         _local1 = new CaretakerQueryDetailBubble();
         _local1.y = 60;
         return _local1;
      }

      private function makeCaretakerIcon() : Bitmap {
         var _local1:Bitmap = new Bitmap(this.makeDebugBitmapData());
         _local1.x = -16;
         _local1.y = -32;
         addChild(_local1);
         return _local1;
      }

      private function makeDebugBitmapData() : BitmapData {
         return new BitmapDataSpy(42,42,true,4278255360);
      }

      public function showDetail(param1:String) : void {
         this.detailBubble.setText(param1);
         removeChild(this.speechBubble);
         addChild(this.detailBubble);
      }

      public function showSpeech() : void {
         removeChild(this.detailBubble);
         addChild(this.speechBubble);
      }

      public function setCaretakerIcon(param1:BitmapData) : void {
         this.icon.bitmapData = param1;
      }
   }
}
