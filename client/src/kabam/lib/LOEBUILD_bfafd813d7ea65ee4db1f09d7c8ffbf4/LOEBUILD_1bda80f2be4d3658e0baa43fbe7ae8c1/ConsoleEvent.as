package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_1bda80f2be4d3658e0baa43fbe7ae8c1 {
import flash.events.Event;

public final class ConsoleEvent extends Event {

      public static const INPUT:String = "ConsoleEvent.INPUT";

      public static const GET_PREVIOUS:String = "ConsoleEvent.GET_PREVIOUS";

      public static const GET_NEXT:String = "ConsoleEvent.GET_NEXT";

      public static const OUTPUT:String = "ConsoleEvent.OUTPUT";

      public var data:String;

      public function ConsoleEvent(param1:String, param2:String = "") {
         super(param1,false,false);
         this.data = param2;
      }
   }
}
