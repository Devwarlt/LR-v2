package robotlegs.bender.extensions.matching {
import flash.utils.getQualifiedClassName;

public class TypeFilter implements ITypeFilter {

      protected var _allOfTypes:Vector.<Class>;

      protected var _anyOfTypes:Vector.<Class>;

      protected var _descriptor:String;

      protected var _noneOfTypes:Vector.<Class>;

      public function TypeFilter(param1:Vector.<Class>, param2:Vector.<Class>, param3:Vector.<Class>) {
         super();
         if(!param1 || !param2 || !param3) {
            throw ArgumentError("TypeFilter LOEBUILD_166e64f6c3677d0c513901242a3e702d can not be null");
         }
         this._allOfTypes = param1;
         this._anyOfTypes = param2;
         this._noneOfTypes = param3;
      }

      public function get allOfTypes() : Vector.<Class> {
         return this._allOfTypes;
      }

      public function get anyOfTypes() : Vector.<Class> {
         return this._anyOfTypes;
      }

      public function get descriptor() : String {
         return this._descriptor = this._descriptor || this.createDescriptor();
      }

      public function get noneOfTypes() : Vector.<Class> {
         return this._noneOfTypes;
      }

      public function matches(param1:*) : Boolean {
         var _local2:uint = this._allOfTypes.length;
         while(_local2--) {
            if(!(param1 is this._allOfTypes[_local2])) {
               return false;
            }
         }
         _local2 = this._noneOfTypes.length;
         while(_local2--) {
            if(param1 is this._noneOfTypes[_local2]) {
               return false;
            }
         }
         if(this._anyOfTypes.length == 0 && (this._allOfTypes.length > 0 || this._noneOfTypes.length > 0)) {
            return true;
         }
         _local2 = this._anyOfTypes.length;
         while(_local2--) {
            if(param1 is this._anyOfTypes[_local2]) {
               return true;
            }
         }
         return false;
      }

      protected function alphabetiseCaseInsensitiveFCQNs(param1:Vector.<Class>) : Vector.<String> {
         var _local2:String = null;
         var _local3:Vector.<String> = new Vector.<String>(0);
         var _local4:uint = param1.length;
         var _local5:uint = 0;
         while(_local5 < _local4) {
            _local2 = getQualifiedClassName(param1[_local5]);
            _local3[_local3.length] = _local2;
            _local5++;
         }
         _local3.sort(this.stringSort);
         return _local3;
      }

      protected function createDescriptor() : String {
         var _local1:Vector.<String> = this.alphabetiseCaseInsensitiveFCQNs(this.allOfTypes);
         var _local2:Vector.<String> = this.alphabetiseCaseInsensitiveFCQNs(this.anyOfTypes);
         var _local3:Vector.<String> = this.alphabetiseCaseInsensitiveFCQNs(this.noneOfTypes);
         return "all of: " + _local1.toString() + ", any of: " + _local2.toString() + ", none of: " + _local3.toString();
      }

      protected function stringSort(param1:String, param2:String) : int {
         if(param1 < param2) {
            return 1;
         }
         return -1;
      }
   }
}
