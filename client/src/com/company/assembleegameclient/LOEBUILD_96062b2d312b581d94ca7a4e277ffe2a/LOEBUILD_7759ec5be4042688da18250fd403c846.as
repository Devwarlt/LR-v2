package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.editor.Command;

public class LOEBUILD_7759ec5be4042688da18250fd403c846 extends Command {

      private var map_:LOEBUILD_d5569d48c9e4a976a51c625e3a800107;

      private var x_:int;

      private var y_:int;

      private var oldTile_:LOEBUILD_822148805b3866cb113421c05e57390d;

      private var newTile_:LOEBUILD_822148805b3866cb113421c05e57390d;

      public function LOEBUILD_7759ec5be4042688da18250fd403c846(param1:LOEBUILD_d5569d48c9e4a976a51c625e3a800107, param2:int, param3:int, param4:LOEBUILD_822148805b3866cb113421c05e57390d, param5:LOEBUILD_822148805b3866cb113421c05e57390d) {
         super();
         this.map_ = param1;
         this.x_ = param2;
         this.y_ = param3;
         if(param4 != null) {
            this.oldTile_ = param4.clone();
         }
         if(param5 != null) {
            this.newTile_ = param5.clone();
         }
      }

      override public function execute() : void {
         if(this.newTile_ == null) {
            this.map_.eraseTile(this.x_,this.y_);
         } else {
            this.map_.setTile(this.x_,this.y_,this.newTile_);
         }
      }

      override public function unexecute() : void {
         if(this.oldTile_ == null) {
            this.map_.eraseTile(this.x_,this.y_);
         } else {
            this.map_.setTile(this.x_,this.y_,this.oldTile_);
         }
      }
   }
}
