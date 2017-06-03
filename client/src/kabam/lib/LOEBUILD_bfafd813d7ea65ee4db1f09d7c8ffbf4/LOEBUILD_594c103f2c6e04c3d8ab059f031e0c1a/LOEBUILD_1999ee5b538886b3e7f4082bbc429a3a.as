package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_594c103f2c6e04c3d8ab059f031e0c1a {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_20f35e630daf44dbfa4c3f68f5399d8c.Console;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_e34dff622740a5e2d6ed9c41d3c49688.LOEBUILD_30f8be529d25601fb19719d7f866e0c6;

import org.osflash.signals.Signal;

public class LOEBUILD_1999ee5b538886b3e7f4082bbc429a3a {

      [Inject]
      public var console:Console;

      [Inject]
      public var action:LOEBUILD_30f8be529d25601fb19719d7f866e0c6;

      [Inject]
      public var trigger:Signal;

      public function LOEBUILD_1999ee5b538886b3e7f4082bbc429a3a() {
         super();
      }

      public function execute() : void {
         this.console.register(this.action,this.trigger);
      }
   }
}
