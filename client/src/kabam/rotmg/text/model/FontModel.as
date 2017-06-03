package kabam.rotmg.text.model {
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

public class FontModel {

    public static const DIABLO:Class = FontModel_Diablo;

    public static const DIABLO_Bold:Class = FontModel_Diablo_Bold;

      public static const MyriadPro:Class = FontModel_MyriadPro;

      public static const MyriadPro_Bold:Class = FontModel_MyriadPro_Bold;

      private var fontInfo:FontInfo;

      public function FontModel() {
         super();
         Font.registerFont(MyriadPro);
         Font.registerFont(DIABLO_Bold);
         var _local1:Font = new MyriadPro();
         this.fontInfo = new FontInfo();
         this.fontInfo.setName(_local1.fontName);
      }

      public function getFont() : FontInfo {
         return this.fontInfo;
      }

      public function apply(param1:TextField, param2:int, param3:uint, param4:Boolean, param5:Boolean = false) : TextFormat {
         var _local6:TextFormat = param1.defaultTextFormat;
         _local6.size = param2;
         _local6.color = param3;
         _local6.font = this.getFont().getName();
         _local6.bold = param4;
         if(param5) {
            _local6.align = "center";
         }
         param1.defaultTextFormat = _local6;
         param1.setTextFormat(_local6);
         return _local6;
      }

      public function getFormat(param1:TextField, param2:int, param3:uint, param4:Boolean) : TextFormat {
         var _local5:TextFormat = param1.defaultTextFormat;
         _local5.size = param2;
         _local5.color = param3;
         _local5.font = this.getFont().getName();
         _local5.bold = param4;
         return _local5;
      }
   }
}
