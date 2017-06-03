package com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99 {
import com.company.assembleegameclient.util.FameUtil;

public class LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c {

      public var charStatsXML_:XML;

      public function LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c(param1:XML) {
         super();
         this.charStatsXML_ = param1;
      }

      public function bestLevel() : int {
         return this.charStatsXML_.BestLevel;
      }

      public function bestFame() : int {
         return this.charStatsXML_.BestFame;
      }

      public function numStars() : int {
         return FameUtil.numStars(int(this.charStatsXML_.BestFame));
      }
   }
}
