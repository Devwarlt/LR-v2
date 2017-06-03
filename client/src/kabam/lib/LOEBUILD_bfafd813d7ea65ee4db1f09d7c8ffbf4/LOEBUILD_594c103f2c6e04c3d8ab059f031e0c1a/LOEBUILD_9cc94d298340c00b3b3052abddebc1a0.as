package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_594c103f2c6e04c3d8ab059f031e0c1a {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_20f35e630daf44dbfa4c3f68f5399d8c.Console;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_1ae25a3912f1d8ee2661ddca73054356;

public final class LOEBUILD_9cc94d298340c00b3b3052abddebc1a0 {

      [Inject]
      public var console:Console;

      [Inject]
      public var log:LOEBUILD_1ae25a3912f1d8ee2661ddca73054356;

      public function LOEBUILD_9cc94d298340c00b3b3052abddebc1a0() {
         super();
      }

      public function execute() : void {
         var _local1:String = "  " + this.console.getNames().join("\r  ");
         this.log.dispatch(_local1);
      }
   }
}
