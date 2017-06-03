package kabam.rotmg.pets.util {
import flash.utils.Dictionary;

import kabam.rotmg.pets.data.PetRarityEnum;

public class FeedFuseCostModel {

      private static const feedCosts:Dictionary = makeFeedDictionary();

      private static const fuseCosts:Dictionary = makeFuseDictionary();

      public function FeedFuseCostModel() {
         super();
      }

      private static function makeFuseDictionary() : Dictionary {
         var _local1:Dictionary = new Dictionary();
         _local1[PetRarityEnum.COMMON] = {
            "gold":100,
            "fame":300
         };
         _local1[PetRarityEnum.UNCOMMON] = {
            "gold":240,
            "fame":1000
         };
         _local1[PetRarityEnum.RARE] = {
            "gold":600,
            "fame":4000
         };
         _local1[PetRarityEnum.LEGENDARY] = {
            "gold":1800,
            "fame":15000
         };
         return _local1;
      }

      private static function makeFeedDictionary() : Dictionary {
         var _local1:Dictionary = new Dictionary();
         _local1[PetRarityEnum.COMMON] = {
            "gold":5,
            "fame":10
         };
         _local1[PetRarityEnum.UNCOMMON] = {
            "gold":12,
            "fame":30
         };
         _local1[PetRarityEnum.RARE] = {
            "gold":30,
            "fame":100
         };
         _local1[PetRarityEnum.LEGENDARY] = {
            "gold":60,
            "fame":350
         };
         _local1[PetRarityEnum.DIVINE] = {
            "gold":150,
            "fame":1000
         };
         return _local1;
      }

      public static function getFuseGoldCost(param1:PetRarityEnum) : int {
         return !!fuseCosts[param1]?int(fuseCosts[param1].gold):0;
      }

      public static function getFuseFameCost(param1:PetRarityEnum) : int {
         return !!fuseCosts[param1]?int(fuseCosts[param1].fame):0;
      }

      public static function getFeedGoldCost(param1:PetRarityEnum) : int {
         return feedCosts[param1].gold;
      }

      public static function getFeedFameCost(param1:PetRarityEnum) : int {
         return feedCosts[param1].fame;
      }
   }
}
