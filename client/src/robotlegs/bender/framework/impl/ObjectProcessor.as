package robotlegs.bender.framework.impl {
import org.hamcrest.Matcher;

public class ObjectProcessor {

      private const _handlers:Array = [];

      public function ObjectProcessor() {
         super();
      }

      public function addObjectHandler(param1:Matcher, param2:Function) : void {
         this._handlers.push(new ObjectHandler(param1,param2));
      }

      public function processObject(param1:Object) : void {
         var _local2:ObjectHandler = null;
         for each(_local2 in this._handlers) {
            _local2.handle(param1);
         }
      }
   }
}

import org.hamcrest.Matcher;

class ObjectHandler {

   private var _matcher:Matcher;

   private var _handler:Function;

   function ObjectHandler(param1:Matcher, param2:Function) {
      super();
      this._matcher = param1;
      this._handler = param2;
   }

   public function handle(param1:Object) : void {
      this._matcher.matches(param1) && this._handler(param1);
   }
}
