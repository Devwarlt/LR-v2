package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import kabam.rotmg.text.view.stringBuilder.PatternBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class LOEBUILD_3d035f7e69af9b21fea3e879f88e0ea2 {

      public static const NAME_PARSER:RegExp = new RegExp("(.+)\\s\\((.+)\\)");

      public function LOEBUILD_3d035f7e69af9b21fea3e879f88e0ea2() {
         super();
      }

      public function parse(param1:String) : String {
         var _local2:Array = param1.match(NAME_PARSER);
         if(_local2 == null) {
            return this.wrapNameWithBracesIfRequired(param1);
         }
         return this.makePatternFromParts(_local2);
      }

      private function wrapNameWithBracesIfRequired(param1:String) : String {
         if(param1.charAt(0) == "{" && param1.charAt(param1.length - 1) == "}") {
            return param1;
         }
         return "{" + param1 + "}";
      }

      private function makePatternFromParts(param1:Array) : String {
         var _local2:* = "{" + param1[1] + "}";
         if(param1.length > 1) {
            _local2 = _local2 + (" (" + param1[2] + ")");
         }
         return _local2;
      }

      public function makeBuilder(param1:String) : StringBuilder {
         return new PatternBuilder().setPattern(this.parse(param1));
      }
   }
}
