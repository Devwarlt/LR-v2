package kabam.rotmg.classes.model {
   public class CharacterSkins {

      private const skins:Vector.<CharacterSkin> = new Vector.<CharacterSkin>(0);

      private const map:Object = {};

      private var defaultSkin:CharacterSkin;

      private var selectedSkin:CharacterSkin;

      private var maxLevelAchieved:int;

      public function CharacterSkins() {
         super();
      }

      public function getCount() : int {
         return this.skins.length;
      }

      public function getDefaultSkin() : CharacterSkin {
         return this.defaultSkin;
      }

      public function getSelectedSkin() : CharacterSkin {
         return this.selectedSkin;
      }

      public function getSkinAt(param1:int) : CharacterSkin {
         return this.skins[param1];
      }

      public function addSkin(param1:CharacterSkin, param2:Boolean = false) : void {
         param1.changed.add(this.onSkinChanged);
         this.skins.push(param1);
         this.map[param1.id] = param1;
         this.updateSkinState(param1);
         if(param2) {
            this.defaultSkin = param1;
            if(!this.selectedSkin) {
               this.selectedSkin = param1;
               param1.setIsSelected(true);
            }
         } else if(param1.getIsSelected()) {
            this.selectedSkin = param1;
         }
      }

      private function onSkinChanged(param1:CharacterSkin) : void {
         if(Boolean(param1.getIsSelected()) && this.selectedSkin != param1) {
            this.selectedSkin && this.selectedSkin.setIsSelected(false);
            this.selectedSkin = param1;
         }
      }

      public function updateSkins(param1:int) : void {
         var _local2:CharacterSkin = null;
         this.maxLevelAchieved = param1;
         for each(_local2 in this.skins) {
            this.updateSkinState(_local2);
         }
      }

      private function updateSkinState(param1:CharacterSkin) : void {
         if(!param1.skinSelectEnabled) {
            param1.setState(CharacterSkinState.UNLISTED);
         } else if(param1.getState().isSkinStateDeterminedByLevel()) {
            param1.setState(this.getSkinState(param1));
         }
      }

      private function getSkinState(param1:CharacterSkin) : CharacterSkinState {
         if(!param1.skinSelectEnabled) {
            return CharacterSkinState.UNLISTED;
         }
         if(this.maxLevelAchieved >= param1.unlockLevel && param1.unlockSpecial == null) {
            return CharacterSkinState.PURCHASABLE;
         }
         return CharacterSkinState.LOCKED;
      }

      public function getSkin(param1:int) : CharacterSkin {
         return this.map[param1] || this.defaultSkin;
      }

      public function getListedSkins() : Vector.<CharacterSkin> {
         var _local2:CharacterSkin = null;
         var _local1:Vector.<CharacterSkin> = new Vector.<CharacterSkin>();
         for each(_local2 in this.skins) {
            if(_local2.getState() != CharacterSkinState.UNLISTED) {
               _local1.push(_local2);
            }
         }
         return _local1;
      }
   }
}
