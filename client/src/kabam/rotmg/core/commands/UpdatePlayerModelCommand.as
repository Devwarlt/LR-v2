package kabam.rotmg.core.commands {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILOD_1839b10431d757564a37f7352035160a;
import com.company.assembleegameclient.editor.Command;

import kabam.rotmg.core.model.PlayerModel;

public class UpdatePlayerModelCommand extends Command {

      [Inject]
      public var model:PlayerModel;

      [Inject]
      public var data:XML;

      public function UpdatePlayerModelCommand() {
         super();
      }

      override public function execute() : void {
         this.model.setCharacterList(new LOEBUILOD_1839b10431d757564a37f7352035160a(this.data));
         this.model.isInvalidated = false;
      }
   }
}
