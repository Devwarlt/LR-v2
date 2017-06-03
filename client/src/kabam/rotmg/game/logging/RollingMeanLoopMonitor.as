package kabam.rotmg.game.logging {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_7d62542c1c71a1fbf448efe308736a48;

public class RollingMeanLoopMonitor implements LoopMonitor {

      [Inject]
      public var watch:LOEBUILD_7d62542c1c71a1fbf448efe308736a48;

      private var watchMap:Object;

      public function RollingMeanLoopMonitor() {
         super();
         this.watchMap = {};
      }

      public function recordTime(param1:String, param2:int) : void {
         var _local3:GameSpriteLoopWatch = this.watchMap[param1] = this.watchMap[param1] || new GameSpriteLoopWatch(param1);
         _local3.logTime(param2);
         this.watch.dispatch(_local3);
      }
   }
}
