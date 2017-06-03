package com.company.assembleegameclient.editor {
   public class LOEBUILD_a001afe30b856ac454cdb0ebba01243c {

      private var list_:Vector.<LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99>;

      private var currPos:int = 0;

      public function LOEBUILD_a001afe30b856ac454cdb0ebba01243c() {
         this.list_ = new Vector.<LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99>();
         super();
      }

      public function addCommandList(param1:LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99) : void {
         this.list_.length = this.currPos;
         param1.execute();
         this.list_.push(param1);
         this.currPos++;
      }

      public function undo() : void {
         if(this.currPos == 0) {
            return;
         }
         this.list_[--this.currPos].unexecute();
      }

      public function redo() : void {
         if(this.currPos == this.list_.length) {
            return;
         }
         this.list_[this.currPos++].execute();
      }

      public function clear() : void {
         this.currPos = 0;
         this.list_.length = 0;
      }
   }
}
