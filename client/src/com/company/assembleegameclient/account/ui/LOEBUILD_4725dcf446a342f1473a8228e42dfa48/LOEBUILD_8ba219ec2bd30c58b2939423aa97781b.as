package com.company.assembleegameclient.account.ui.LOEBUILD_4725dcf446a342f1473a8228e42dfa48 {
   public class LOEBUILD_8ba219ec2bd30c58b2939423aa97781b {

      private var selectables:Vector.<LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85>;

      private var selected:LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85;

      public function LOEBUILD_8ba219ec2bd30c58b2939423aa97781b(param1:Vector.<LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85>) {
         super();
         this.selectables = param1;
      }

      public function setSelected(param1:String) : void {
         var _local2:LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85 = null;
         for each(_local2 in this.selectables) {
            if(_local2.getValue() == param1) {
               this.replaceSelected(_local2);
               return;
            }
         }
      }

      public function getSelected() : LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85 {
         return this.selected;
      }

      private function replaceSelected(param1:LOEBUILD_8318ce1c96df6ce21eb2ed428c6d0f85) : void {
         if(this.selected != null) {
            this.selected.setSelected(false);
         }
         this.selected = param1;
         this.selected.setSelected(true);
      }
   }
}
