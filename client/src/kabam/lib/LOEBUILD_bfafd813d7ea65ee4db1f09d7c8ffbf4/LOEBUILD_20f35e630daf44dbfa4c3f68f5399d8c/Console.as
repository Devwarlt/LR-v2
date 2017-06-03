package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_20f35e630daf44dbfa4c3f68f5399d8c {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_e34dff622740a5e2d6ed9c41d3c49688.LOEBUILD_30f8be529d25601fb19719d7f866e0c6;

import org.osflash.signals.Signal;

public final class Console {

      private var hash:LOEBUILD_ae2e6efb43b1554be7b47d1d3d95ada5;

      private var history:LOEBUILD_e7e0f08b17ea83c4787b003b9f4a9470;

      public function Console() {
         super();
         this.hash = new LOEBUILD_ae2e6efb43b1554be7b47d1d3d95ada5();
         this.history = new LOEBUILD_e7e0f08b17ea83c4787b003b9f4a9470();
      }

      public function register(param1:LOEBUILD_30f8be529d25601fb19719d7f866e0c6, param2:Signal) : void {
         this.hash.register(param1.name,param1.description,param2);
      }

      public function hasAction(param1:String) : Boolean {
         return this.hash.has(param1);
      }

      public function execute(param1:String) : void {
         this.history.add(param1);
         this.hash.execute(param1);
      }

      public function getNames() : Vector.<String> {
         return this.hash.getNames();
      }

      public function getPreviousAction() : String {
         return this.history.getPrevious();
      }

      public function getNextAction() : String {
         return this.history.getNext();
      }
   }
}
