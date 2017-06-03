package kabam.rotmg.text.view.stringBuilder {
import kabam.rotmg.language.model.StringMap;

public class AppendingLineBuilder implements StringBuilder {

      private var data:Vector.<LineData>;

      private var delimiter:String = "\n";

      private var provider:StringMap;

      public function AppendingLineBuilder() {
         this.data = new Vector.<LineData>();
         super();
      }

      public function pushParams(param1:String, param2:Object = null, param3:String = "", param4:String = "") : AppendingLineBuilder {
         this.data.push(new LineData().setKey(param1).setTokens(param2).setOpeningTags(param3).setClosingTags(param4));
         return this;
      }

      public function setDelimiter(param1:String) : AppendingLineBuilder {
         this.delimiter = param1;
         return this;
      }

      public function setStringMap(param1:StringMap) : void {
         this.provider = param1;
      }

      public function getString() : String {
         var _local2:LineData = null;
         var _local1:Vector.<String> = new Vector.<String>();
         for each(_local2 in this.data) {
            _local1.push(_local2.getString(this.provider));
         }
         return _local1.join(this.delimiter);
      }

      public function hasLines() : Boolean {
         return this.data.length != 0;
      }

      public function clear() : void {
         this.data = new Vector.<LineData>();
      }
   }
}

import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

class LineData {

   public var key:String;

   public var tokens:Object;

   public var openingHTMLTags:String = "";

   public var closingHTMLTags:String = "";

   function LineData() {
      super();
   }

   public function setKey(param1:String) : LineData {
      this.key = param1;
      return this;
   }

   public function setTokens(param1:Object) : LineData {
      this.tokens = param1;
      return this;
   }

   public function setOpeningTags(param1:String) : LineData {
      this.openingHTMLTags = param1;
      return this;
   }

   public function setClosingTags(param1:String) : LineData {
      this.closingHTMLTags = param1;
      return this;
   }

   public function getString(param1:StringMap) : String {
      var _local3:String = null;
      var _local4:* = null;
      var _local5:StringBuilder = null;
      var _local6:String = null;
      var _local2:String = this.openingHTMLTags;
      if((_local3 = param1.getValue(TextKey.stripCurlyBrackets(this.key))) == null) {
         _local3 = this.key;
      }
      _local2 = _local2.concat(_local3);
      for(_local4 in this.tokens) {
         if(this.tokens[_local4] is StringBuilder) {
            _local5 = StringBuilder(this.tokens[_local4]);
            _local5.setStringMap(param1);
            _local2 = _local2.replace("{" + _local4 + "}",_local5.getString());
         } else {
            _local6 = this.tokens[_local4];
            if(_local6.length > 0 && _local6.charAt(0) == "{" && _local6.charAt(_local6.length - 1) == "}") {
               _local6 = param1.getValue(_local6.substr(1,_local6.length - 2));
            }
            _local2 = _local2.replace("{" + _local4 + "}",_local6);
         }
      }
      _local2 = _local2.replace(new RegExp("\\\\n","g"),"\n");
      _local2 = _local2.concat(this.closingHTMLTags);
      return _local2;
   }
}
