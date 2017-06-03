package kabam.rotmg.text.view.stringBuilder {
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.language.model.StringMap;

public class LineBuilder implements StringBuilder {

      public var key:String;

      public var tokens:Object;

      private var postfix:String = "";

      private var prefix:String = "";

      private var map:StringMap;

      public function LineBuilder() {
         super();
      }

      public static function fromJSON(param1:String) : LineBuilder {
         var _local2:Object = JSON.parse(param1);
         return new LineBuilder().setParams(_local2.key,_local2.tokens);
      }

      public static function getLocalizedStringFromKey(param1:String, param2:Object = null) : String {
         var _local3:LineBuilder = new LineBuilder();
         _local3.setParams(param1,param2);
         var _local4:StringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
         _local3.setStringMap(_local4);
         return _local3.getString();
      }

      public static function getLocalizedStringFromJSON(param1:String) : String {
         var _local2:LineBuilder = null;
         var _local3:StringMap = null;
         if(param1.charAt(0) == "{") {
            _local2 = LineBuilder.fromJSON(param1);
            _local3 = StaticInjectorContext.getInjector().getInstance(StringMap);
            _local2.setStringMap(_local3);
            return _local2.getString();
         }
         return param1;
      }

      public static function returnStringReplace(param1:String, param2:Object = null, param3:String = "", param4:String = "") : String {
         var _local6:* = null;
         var _local7:String = null;
         var _local8:* = null;
         var _local5:String = stripCurlyBrackets(param1);
         for(_local6 in param2) {
            _local7 = param2[_local6];
            _local8 = "{" + _local6 + "}";
            while(_local5.indexOf(_local8) != -1) {
               _local5 = _local5.replace(_local8,_local7);
            }
         }
         _local5 = _local5.replace(new RegExp("\\\\n","g"),"\n");
         return param3 + _local5 + param4;
      }

      public static function getLocalizedString2(param1:String, param2:Object = null) : String {
         var _local3:LineBuilder = new LineBuilder();
         _local3.setParams(param1,param2);
         var _local4:StringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
         _local3.setStringMap(_local4);
         return _local3.getString();
      }

      private static function stripCurlyBrackets(param1:String) : String {
         var _local2:Boolean = param1 != null && param1.charAt(0) == "{" && param1.charAt(param1.length - 1) == "}";
         return !!_local2?param1.substr(1,param1.length - 2):param1;
      }

      public function toJson() : String {
         return JSON.stringify({
            "key":this.key,
            "tokens":this.tokens
         });
      }

      public function setParams(param1:String, param2:Object = null) : LineBuilder {
         this.key = param1 || "";
         this.tokens = param2;
         return this;
      }

      public function setPrefix(param1:String) : LineBuilder {
         this.prefix = param1;
         return this;
      }

      public function setPostfix(param1:String) : LineBuilder {
         this.postfix = param1;
         return this;
      }

      public function setStringMap(param1:StringMap) : void {
         this.map = param1;
      }

      public function getString() : String {
         var _local3:* = null;
         var _local4:String = null;
         var _local5:* = null;
         var _local1:String = stripCurlyBrackets(this.key);
         var _local2:String = this.map.getValue(_local1) || "";
         for(_local3 in this.tokens) {
            _local4 = this.tokens[_local3];
            if(_local4.charAt(0) == "{" && _local4.charAt(_local4.length - 1) == "}") {
               _local4 = this.map.getValue(_local4.substr(1,_local4.length - 2));
            }
            _local5 = "{" + _local3 + "}";
            while(_local2.indexOf(_local5) != -1) {
               _local2 = _local2.replace(_local5,_local4);
            }
         }
         _local2 = _local2.replace(new RegExp("\\\\n","g"),"\n");
         return this.prefix + _local2 + this.postfix;
      }
   }
}
