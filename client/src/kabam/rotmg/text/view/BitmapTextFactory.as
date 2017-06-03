package kabam.rotmg.text.view {
import com.company.assembleegameclient.util.BitmapDataSpy;
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.model.TextAndMapProvider;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class BitmapTextFactory {

      private const glowFilter:GlowFilter = new GlowFilter(0,1,3,3,1,5);

      public var padding:int = 0;

      private var textfield:TextFieldDisplayConcrete;

      public function BitmapTextFactory(param1:FontModel, param2:TextAndMapProvider) {
         super();
         this.textfield = new TextFieldDisplayConcrete();
         this.textfield.setFont(param1.getFont());
         this.textfield.setTextField(param2.getTextField());
         this.textfield.setStringMap(param2.getStringMap());
      }

      public function make(param1:StringBuilder, param2:int, param3:uint, param4:Boolean, param5:Matrix, param6:Boolean) : BitmapData {
         this.configureTextfield(param2,param3,param4,param1);
         return this.makeBitmapData(param6,param5);
      }

      private function configureTextfield(param1:int, param2:uint, param3:Boolean, param4:StringBuilder) : void {
         this.textfield.setSize(param1).setColor(param2).setBold(param3).setAutoSize(TextFieldAutoSize.LEFT);
         this.textfield.setStringBuilder(param4);
      }

      private function makeBitmapData(param1:Boolean, param2:Matrix) : BitmapData {
         var _local3:int = this.textfield.width + this.padding + param2.tx;
         var _local4:int = this.textfield.height + this.padding;
         var _local5:BitmapData = new BitmapDataSpy(_local3,_local4,true,0);
         _local5.draw(this.textfield,param2);
         param1 && _local5.applyFilter(_local5,_local5.rect,PointUtil.ORIGIN,this.glowFilter);
         return _local5;
      }
   }
}
