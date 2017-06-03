package kabam.rotmg.pets.data {
   public class FusionCalculator {

      private static var ranges:Object = makeRanges();

      public function FusionCalculator() {
         super();
      }

      private static function makeRanges() : Object {
         ranges = {};
         ranges[PetRarityEnum.COMMON.value] = 30;
         ranges[PetRarityEnum.UNCOMMON.value] = 20;
         ranges[PetRarityEnum.RARE.value] = 20;
         ranges[PetRarityEnum.LEGENDARY.value] = 20;
         return ranges;
      }

      public static function getStrengthPercentage(param1:PetVO, param2:PetVO) : Number {
         var _local3:Number = getRarityPointsPercentage(param1);
         var _local4:Number = getRarityPointsPercentage(param2);
         return average(_local3,_local4);
      }

      private static function average(param1:Number, param2:Number) : Number {
         return (param1 + param2) / 2;
      }

      private static function getRarityPointsPercentage(param1:PetVO) : Number {
         var _local2:int = ranges[param1.getRarity()];
         var _local3:int = param1.getMaxAbilityPower() - _local2;
         var _local4:int = param1.abilityList[0].level - _local3;
         return _local4 / _local2;
      }
   }
}
