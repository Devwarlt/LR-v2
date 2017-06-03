package kabam.rotmg.appengine.impl {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_7d62542c1c71a1fbf448efe308736a48;

public class AppEngineRequestStats {

      [Inject]
      public var watch:LOEBUILD_7d62542c1c71a1fbf448efe308736a48;

      private const nameMap:Object = {};

      public function AppEngineRequestStats() {
         super();
      }

      public function recordStats(param1:String, param2:Boolean, param3:int) : void {
         var _local4:StatsWatch = this.nameMap[param1] = this.nameMap[param1] || new StatsWatch(param1);
         _local4.addResponse(param2,param3);
         this.watch.dispatch(_local4);
      }
   }
}

import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_20f35e630daf44dbfa4c3f68f5399d8c.LOEBUILD_f20658650d987d31063b593c05980397;

class StatsWatch extends LOEBUILD_f20658650d987d31063b593c05980397 {

   private static const STATS_PATTERN:String = "[APPENGINE STATS] [0xFFEE00:{/x={MEAN}ms, ok={OK}/{COUNT}} {NAME}]";

   private static const MEAN:String = "{MEAN}";

   private static const COUNT:String = "{COUNT}";

   private static const OK:String = "{OK}";

   private static const NAME:String = "{NAME}";

   private var count:int;

   private var time:int;

   private var mean:int;

   private var ok:int;

   function StatsWatch(param1:String) {
      super(param1,"");
      this.count = 0;
      this.ok = 0;
      this.time = 0;
   }

   public function addResponse(param1:Boolean, param2:int) : void {
      param1 && ++this.ok;
      this.time = this.time + param2;
      this.mean = this.time / ++this.count;
      data = this.report();
   }

   private function report() : String {
      return STATS_PATTERN.replace(MEAN,this.mean).replace(COUNT,this.count).replace(OK,this.ok).replace(NAME,name);
   }
}
