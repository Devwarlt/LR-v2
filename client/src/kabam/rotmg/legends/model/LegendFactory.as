package kabam.rotmg.legends.model {
import com.company.util.ConversionUtil;

import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.model.PlayerModel;

public class LegendFactory {

      [Inject]
      public var playerModel:PlayerModel;

      [Inject]
      public var classesModel:ClassesModel;

      [Inject]
      public var factory:CharacterFactory;

      private var ownAccountId:String;

      private var legends:Vector.<Legend>;

      public function LegendFactory() {
         super();
      }

      public function makeLegends(param1:XML) : Vector.<Legend> {
         this.ownAccountId = this.playerModel.getAccountId();
         this.legends = new Vector.<Legend>(0);
         this.makeLegendsFromList(param1.FameListElem,false);
         this.makeLegendsFromList(param1.MyFameListElem,true);
         return this.legends;
      }

      private function makeLegendsFromList(param1:XMLList, param2:Boolean) : void {
         var _local3:XML = null;
         var _local4:Legend = null;
         for each(_local3 in param1) {
            if(!this.legendsContains(_local3)) {
               _local4 = this.makeLegend(_local3);
               _local4.isOwnLegend = _local3.@accountId == this.ownAccountId;
               _local4.isFocus = param2;
               this.legends.push(_local4);
            }
         }
      }

      private function legendsContains(param1:XML) : Boolean {
         var _local2:Legend = null;
         for each(_local2 in this.legends) {
            if(_local2.accountId == param1.@accountId && _local2.charId == param1.@charId) {
               return true;
            }
         }
         return false;
      }

      public function makeLegend(param1:XML) : Legend {
         var _local2:int = param1.ObjectType;
         var _local3:int = param1.Texture;
         var _local4:CharacterClass = this.classesModel.getCharacterClass(_local2);
         var _local5:CharacterSkin = _local4.skins.getSkin(_local3);
         var _local6:int = !!param1.hasOwnProperty("Tex1")?int(param1.Tex1):0;
         var _local7:int = !!param1.hasOwnProperty("Tex2")?int(param1.Tex2):0;
         var _local8:Legend = new Legend();
         _local8.accountId = param1.@accountId;
         _local8.charId = param1.@charId;
         _local8.name = param1.Name;
         _local8.totalFame = param1.TotalFame;
         _local8.character = this.factory.makeIcon(_local5.template,100,_local6,_local7);
         _local8.equipmentSlots = _local4.slotTypes;
         _local8.equipment = ConversionUtil.toIntVector(param1.Equipment);
         return _local8;
      }
   }
}
