package kabam.rotmg.characters.reskin.control {
import flash.display.DisplayObject;

import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_088c13bb3ec60be2dbf0d6fb5453c1be;
import kabam.rotmg.characters.reskin.view.ReskinCharacterView;
import kabam.rotmg.classes.model.CharacterSkins;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.classes.view.CharacterSkinListItemFactory;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class OpenReskinDialogCommand {

      [Inject]
      public var openDialog:OpenDialogSignal;

      [Inject]
      public var hideConsole:LOEBUILD_088c13bb3ec60be2dbf0d6fb5453c1be;

      [Inject]
      public var player:PlayerModel;

      [Inject]
      public var model:ClassesModel;

      [Inject]
      public var factory:CharacterSkinListItemFactory;

      public function OpenReskinDialogCommand() {
         super();
      }

      public function execute() : void {
         this.hideConsole.dispatch();
         this.openDialog.dispatch(this.makeView());
      }

      private function makeView() : ReskinCharacterView {
         var _local1:ReskinCharacterView = new ReskinCharacterView();
         _local1.setList(this.makeList());
         _local1.x = (800 - _local1.width) * 0.5;
         _local1.y = (600 - _local1.viewHeight) * 0.5;
         return _local1;
      }

      private function makeList() : Vector.<DisplayObject> {
         var _local1:CharacterSkins = this.getCharacterSkins();
         return this.factory.make(_local1);
      }

      private function getCharacterSkins() : CharacterSkins {
         return this.model.getSelected().skins;
      }
   }
}
