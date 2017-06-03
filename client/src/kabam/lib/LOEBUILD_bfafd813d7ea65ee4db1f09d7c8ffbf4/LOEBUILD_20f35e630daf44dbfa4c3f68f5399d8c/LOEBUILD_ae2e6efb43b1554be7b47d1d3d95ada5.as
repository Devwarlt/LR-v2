package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_20f35e630daf44dbfa4c3f68f5399d8c {
import org.osflash.signals.Signal;

public class LOEBUILD_ae2e6efb43b1554be7b47d1d3d95ada5 {

      private var signalMap:Object;

      private var descriptionMap:Object;

      function LOEBUILD_ae2e6efb43b1554be7b47d1d3d95ada5() {
         super();
         this.signalMap = {};
         this.descriptionMap = {};
      }

      public function register(param1:String, param2:String, param3:Signal) : void {
         this.signalMap[param1] = param3;
         this.descriptionMap[param1] = param2;
      }

      public function getNames() : Vector.<String> {
         var _local2:* = null;
         var _local1:Vector.<String> = new Vector.<String>(0);
         for(_local2 in this.signalMap) {
            _local1.push(_local2 + " - " + this.descriptionMap[_local2]);
         }
         return _local1;
      }

      public function execute(param1:String) : void {
         var _local2:Array = param1.split(" ");
         if(_local2.length == 0) {
            return;
         }
         var _local3:String = _local2.shift();
         var _local4:Signal = this.signalMap[_local3];
         if(!_local4) {
            return;
         }
         if(_local2.length > 0) {
            _local4.dispatch.apply(this,_local2.join(" ").split(","));
         } else {
            _local4.dispatch.apply(this);
         }
      }

      public function has(param1:String) : Boolean {
         var _local2:Array = param1.split(" ");
         return _local2.length > 0 && this.signalMap[_local2[0]] != null;
      }
   }
}
