package kabam.rotmg.characters.deletion.service {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_7ebef6bdf3535c86294f666e62e89578;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.characters.model.CharacterModel;

public class DeleteCharacterTask extends BaseTask {

      [Inject]
      public var character:LOEBUILD_7ebef6bdf3535c86294f666e62e89578;

      [Inject]
      public var client:AppEngineClient;

      [Inject]
      public var account:Account;

      [Inject]
      public var model:CharacterModel;

      public function DeleteCharacterTask() {
         super();
      }

      override protected function startTask() : void {
         this.client.setMaxRetries(2);
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/char/delete",this.getRequestPacket());
      }

      private function getRequestPacket() : Object {
         var _local1:Object = this.account.getCredentials();
         _local1.charId = this.character.charId();
         _local1.reason = 1;
         return _local1;
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         param1 && this.updateUserData();
         completeTask(param1,param2);
      }

      private function updateUserData() : void {
         this.model.deleteCharacter(this.character.charId());
      }
   }
}
