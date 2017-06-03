package org.hamcrest.object {
import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;

public class IsEqualMatcher extends BaseMatcher {

      private var _value:Object;

      public function IsEqualMatcher(param1:Object) {
         super();
         _value = param1;
      }

      private function areEqual(param1:Object, param2:Object) : Boolean {
         if(isNaN(param1 as Number)) {
            return isNaN(param2 as Number);
         }
         if(param1 == null) {
            return param2 == null;
         }
         if(param1 is Array) {
            return param2 is Array && Boolean(areArraysEqual(param1 as Array,param2 as Array));
         }
         return param1 == param2;
      }

      private function areArraysEqual(param1:Array, param2:Array) : Boolean {
         return Boolean(areArraysLengthsEqual(param1,param2)) && Boolean(areArrayElementsEqual(param1,param2));
      }

      override public function describeTo(param1:Description) : void {
         param1.appendValue(_value);
      }

      private function areArrayElementsEqual(param1:Array, param2:Array) : Boolean {
         var _local3:int = 0;
         var _local4:int = param1.length;
         while(_local3 < _local4) {
            if(!areEqual(param1[_local3],param2[_local3])) {
               return false;
            }
            _local3++;
         }
         return true;
      }

      override public function matches(param1:Object) : Boolean {
         return areEqual(param1,_value);
      }

      private function areArraysLengthsEqual(param1:Array, param2:Array) : Boolean {
         return param1.length == param2.length;
      }
   }
}
