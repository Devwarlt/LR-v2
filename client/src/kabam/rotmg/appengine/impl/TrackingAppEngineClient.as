package kabam.rotmg.appengine.impl {
import flash.utils.getTimer;

import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.service.TrackingData;
import kabam.rotmg.core.signals.TrackEventSignal;

import org.osflash.signals.OnceSignal;

public class TrackingAppEngineClient implements AppEngineClient {

      [Inject]
      public var track:TrackEventSignal;

      [Inject]
      public var wrapped:SimpleAppEngineClient;

      private var target:String;

      private var time:int;

      public function TrackingAppEngineClient() {
         super();
      }

      public function get complete() : OnceSignal {
         return this.wrapped.complete;
      }

      public function setDataFormat(param1:String) : void {
         this.wrapped.setDataFormat(param1);
      }

      public function setSendEncrypted(param1:Boolean) : void {
         this.wrapped.setSendEncrypted(param1);
      }

      public function setMaxRetries(param1:int) : void {
         this.wrapped.setMaxRetries(param1);
      }

      public function sendRequest(param1:String, param2:Object) : void {
         this.target = param1;
         this.time = getTimer();
         this.wrapped.complete.addOnce(this.trackResponse);
         this.wrapped.sendRequest(param1,param2);
      }

      private function trackResponse(param1:Boolean, param2:*) : void {
         var _local3:TrackingData = new TrackingData();
         _local3.category = "AppEngineResponseTime";
         _local3.action = this.target;
         _local3.value = this.time - getTimer();
         this.track.dispatch(_local3);
      }

      public function requestInProgress() : Boolean {
         return false;
      }
   }
}
