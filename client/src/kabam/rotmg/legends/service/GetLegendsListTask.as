package kabam.rotmg.legends.service {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.legends.model.Legend;
import kabam.rotmg.legends.model.LegendFactory;
import kabam.rotmg.legends.model.LegendsModel;
import kabam.rotmg.legends.model.Timespan;

public class GetLegendsListTask extends BaseTask {

      [Inject]
      public var client:AppEngineClient;

      [Inject]
      public var player:PlayerModel;

      [Inject]
      public var model:LegendsModel;

      [Inject]
      public var factory:LegendFactory;

      [Inject]
      public var timespan:Timespan;

      public var charId:int;

      public function GetLegendsListTask() {
         super();
      }

      override protected function startTask() : void {
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/fame/list",this.makeRequestObject());
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         param1 && this.updateFameListData(param2);
         completeTask(param1,param2);
      }

      private function updateFameListData(param1:String) : void {
         var _local2:Vector.<Legend> = this.factory.makeLegends(XML(param1));
         this.model.setLegendList(_local2);
      }

      private function makeRequestObject() : Object {
         var _local1:Object = {};
         _local1.timespan = this.timespan.getId();
         _local1.accountId = this.player.getAccountId();
         _local1.charId = this.charId;
         return _local1;
      }
   }
}
