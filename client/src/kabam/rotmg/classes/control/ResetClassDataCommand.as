package kabam.rotmg.classes.control {
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.CharacterSkinState;
import kabam.rotmg.classes.model.ClassesModel;

public class ResetClassDataCommand {

      [Inject]
      public var classes:ClassesModel;

      public function ResetClassDataCommand() {
         super();
      }

      public function execute() : void {
         var _local1:int = this.classes.getCount();
         var _local2:int = 0;
         while(_local2 < _local1) {
            this.resetClass(this.classes.getClassAtIndex(_local2));
            _local2++;
         }
      }

      private function resetClass(param1:CharacterClass) : void {
         param1.setIsSelected(param1.id == ClassesModel.WIZARD_ID);
         this.resetClassSkins(param1);
      }

      private function resetClassSkins(param1:CharacterClass) : void {
         var _local5:CharacterSkin = null;
         var _local2:CharacterSkin = param1.skins.getDefaultSkin();
         var _local3:int = param1.skins.getCount();
         var _local4:int = 0;
         while(_local4 < _local3) {
            _local5 = param1.skins.getSkinAt(_local4);
            if(_local5 != _local2) {
               this.resetSkin(param1.skins.getSkinAt(_local4));
            }
            _local4++;
         }
      }

      private function resetSkin(param1:CharacterSkin) : void {
         param1.setState(CharacterSkinState.LOCKED);
      }
   }
}
