package com.company.assembleegameclient.editor {
   public class LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99 {

      private var list_:Vector.<Command>;

      public function LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99() {
         this.list_ = new Vector.<Command>();
         super();
      }

      public function empty() : Boolean {
         return this.list_.length == 0;
      }

      public function addCommand(param1:Command) : void {
         this.list_.push(param1);
      }

      public function execute() : void {
         var _local1:Command = null;
         for each(_local1 in this.list_) {
            _local1.execute();
         }
      }

      public function unexecute() : void {
         var _local1:Command = null;
         for each(_local1 in this.list_) {
            _local1.unexecute();
         }
      }
   }
}
