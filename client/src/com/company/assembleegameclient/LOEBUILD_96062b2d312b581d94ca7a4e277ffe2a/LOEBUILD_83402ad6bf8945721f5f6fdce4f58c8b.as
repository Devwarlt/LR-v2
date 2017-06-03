package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.editor.Command;

public class LOEBUILD_83402ad6bf8945721f5f6fdce4f58c8b extends Command {

      private var map_:LOEBUILD_d5569d48c9e4a976a51c625e3a800107;

      private var x_:int;

      private var y_:int;

      private var oldName_:String;

      private var newName_:String;

      public function LOEBUILD_83402ad6bf8945721f5f6fdce4f58c8b(param1:LOEBUILD_d5569d48c9e4a976a51c625e3a800107, param2:int, param3:int, param4:String, param5:String) {
         super();
         this.map_ = param1;
         this.x_ = param2;
         this.y_ = param3;
         this.oldName_ = param4;
         this.newName_ = param5;
      }

      override public function execute() : void {
         this.map_.modifyObjectName(this.x_,this.y_,this.newName_);
      }

      override public function unexecute() : void {
         this.map_.modifyObjectName(this.x_,this.y_,this.oldName_);
      }
   }
}
