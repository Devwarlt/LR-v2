package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.util.BitmapDataSpy;
import com.company.assembleegameclient.util.TextureRedrawer;

import flash.display.BitmapData;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.text.model.FontModel;

public class Sign extends GameObject {

      private var stringMap:StringMap;

      private var fontModel:FontModel;

      public function Sign(param1:XML) {
         super(param1);
         texture_ = null;
         this.stringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
         this.fontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
      }

      override protected function getTexture(param1:Camera, param2:int) : BitmapData {
         if(texture_ != null) {
            return texture_;
         }
         var _local3:TextField = new TextField();
         _local3.multiline = true;
         _local3.wordWrap = false;
         _local3.autoSize = TextFieldAutoSize.LEFT;
         _local3.textColor = 16777215;
         _local3.embedFonts = true;
         var _local4:TextFormat = new TextFormat();
         _local4.align = TextFormatAlign.CENTER;
         _local4.font = this.fontModel.getFont().getName();
         _local4.size = 24;
         _local4.color = 16777215;
         _local4.bold = true;
         _local3.defaultTextFormat = _local4;
         var _local5:String = this.stringMap.getValue(this.stripCurlyBrackets(name_));
         _local3.text = _local5.split("|").join("\n");
         var _local6:BitmapData = new BitmapDataSpy(_local3.width,_local3.height,true,0);
         _local6.draw(_local3);
         texture_ = TextureRedrawer.redraw(_local6,size_,false,0);
         return texture_;
      }

      private function stripCurlyBrackets(param1:String) : String {
         var _local2:Boolean = param1 != null && param1.charAt(0) == "{" && param1.charAt(param1.length - 1) == "}";
         return !!_local2?param1.substr(1,param1.length - 2):param1;
      }
   }
}
