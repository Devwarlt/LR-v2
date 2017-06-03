package kabam.rotmg.characters.model {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_7ebef6bdf3535c86294f666e62e89578;

import kabam.rotmg.core.model.PlayerModel;

public class LegacyCharacterModel implements CharacterModel {

      [Inject]
      public var wrapped:PlayerModel;

      private var selected:LOEBUILD_7ebef6bdf3535c86294f666e62e89578;

      public function LegacyCharacterModel() {
         super();
      }

      public function getCharacterCount() : int {
         return this.wrapped.getCharacterCount();
      }

      public function getCharacter(param1:int) : LOEBUILD_7ebef6bdf3535c86294f666e62e89578 {
         return this.wrapped.getCharById(param1);
      }

      public function deleteCharacter(param1:int) : void {
         this.wrapped.deleteCharacter(param1);
         if(this.selected.charId() == param1) {
            this.selected = null;
         }
      }

      public function select(param1:LOEBUILD_7ebef6bdf3535c86294f666e62e89578) : void {
         this.selected = param1;
      }

      public function getSelected() : LOEBUILD_7ebef6bdf3535c86294f666e62e89578 {
         return this.selected;
      }
   }
}
