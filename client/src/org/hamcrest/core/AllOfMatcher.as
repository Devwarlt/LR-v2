package org.hamcrest.core {
import org.hamcrest.Description;
import org.hamcrest.DiagnosingMatcher;
import org.hamcrest.Matcher;

public class AllOfMatcher extends DiagnosingMatcher {

      private var _matchers:Array;

      public function AllOfMatcher(param1:Array) {
         super();
         _matchers = param1 || [];
      }

      override protected function matchesOrDescribesMismatch(param1:Object, param2:Description) : Boolean {
         var _local3:Matcher = null;
         for each(_local3 in _matchers) {
            if(!_local3.matches(param1)) {
               param2.appendDescriptionOf(_local3).appendText(" ").appendMismatchOf(_local3,param1);
               return false;
            }
         }
         return true;
      }

      override public function describeTo(param1:Description) : void {
         param1.appendList("("," and ",")",_matchers);
      }
   }
}
