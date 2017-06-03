package com.company.assembleegameclient.screens.charrects {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c;
import com.company.assembleegameclient.ui.tooltip.MyPlayerToolTip;

public class MyPlayerToolTipFactory {

      public function MyPlayerToolTipFactory() {
         super();
      }

      public function create(param1:String, param2:XML, param3:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c) : MyPlayerToolTip {
         return new MyPlayerToolTip(param1,param2,param3);
      }
   }
}
