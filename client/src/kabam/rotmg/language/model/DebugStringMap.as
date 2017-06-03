package kabam.rotmg.language.model {
import kabam.rotmg.text.model.DebugTextInfo;

public class DebugStringMap implements StringMap {

      [Inject]
      public var delegate:StringMap;

      [Inject]
      public var languageModel:LanguageModel;

      public var debugTextInfos:Vector.<DebugTextInfo>;

      public function DebugStringMap() {
         this.debugTextInfos = new Vector.<DebugTextInfo>();
         super();
      }

      public function hasKey(param1:String) : Boolean {
         return true;
      }

      public function getValue(param1:String) : String {
         if(param1 != "" && Boolean(this.isInvalid(param1))) {
            return param1;
         }
         return this.delegate.getValue(param1);
      }

      private function isInvalid(param1:String) : Boolean {
         return Boolean(this.hasNo(param1)) || Boolean(this.hasWrongLanguage(param1));
      }

      private function hasNo(param1:String) : Boolean {
         return !this.delegate.hasKey(param1);
      }

      private function pushDebugInfo(param1:String) : void {
         var _local2:String = this.getLanguageFamily(param1);
         var _local3:DebugTextInfo = new DebugTextInfo();
         _local3.key = param1;
         _local3.hasKey = this.delegate.hasKey(param1);
         _local3.languageFamily = _local2;
         _local3.value = this.delegate.getValue(param1);
         this.debugTextInfos.push(_local3);
      }

      private function hasWrongLanguage(param1:String) : Boolean {
         return this.getLanguageFamily(param1) != this.languageModel.getLanguage();
      }

      public function clear() : void {
      }

      public function setValue(param1:String, param2:String, param3:String) : void {
         this.delegate.setValue(param1,param2,param3);
      }

      public function getLanguageFamily(param1:String) : String {
         return this.delegate.getLanguageFamily(param1);
      }
   }
}
