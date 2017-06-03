package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.editor.Command;

public class LOEBUILD_7c5347632b200e9d64e19d0924796c4d extends Command {

      private var map_:LOEBUILD_d5569d48c9e4a976a51c625e3a800107;

      private var x_:int;

      private var y_:int;

      private var layer_:int;

      private var oldType_:int;

      private var newType_:int;

      public function LOEBUILD_7c5347632b200e9d64e19d0924796c4d(param1:LOEBUILD_d5569d48c9e4a976a51c625e3a800107, param2:int, param3:int, param4:int, param5:int, param6:int) {
         super();
         this.map_ = param1;
         this.x_ = param2;
         this.y_ = param3;
         this.layer_ = param4;
         this.oldType_ = param5;
         this.newType_ = param6;
      }

      override public function execute() : void {
         this.map_.modifyTile(this.x_,this.y_,this.layer_,this.newType_);
      }

      override public function unexecute() : void {
         this.map_.modifyTile(this.x_,this.y_,this.layer_,this.oldType_);
      }
   }
}
