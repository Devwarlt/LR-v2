package com.company.assembleegameclient.map.LOEBUILD_8640380935243b4a9c3cbd5e4ae3bef6 {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_094a173d3b32f44f5b5c996e8710ae28;
import kabam.rotmg.assets.model.Player;

import flash.display.Sprite;
import flash.events.Event;

public class LOEBUILD_991b09fca81e41ffa4e060448ae08469 extends Sprite {

      public var map_:Map;

      public var partyMemberArrows_:Vector.<LOEBUILD_ee2d15ada259b3b28f666dd0efe286c5> = null;

      public var questArrow_:LOEBUILD_247f81ddb717f0a150491fda67ee2fbc;

      public function LOEBUILD_991b09fca81e41ffa4e060448ae08469(param1:Map) {
         var _local3:LOEBUILD_ee2d15ada259b3b28f666dd0efe286c5 = null;
         super();
         this.map_ = param1;
         this.partyMemberArrows_ = new Vector.<LOEBUILD_ee2d15ada259b3b28f666dd0efe286c5>(LOEBUILD_094a173d3b32f44f5b5c996e8710ae28.NUM_MEMBERS,true);
         var _local2:int = 0;
         while(_local2 < LOEBUILD_094a173d3b32f44f5b5c996e8710ae28.NUM_MEMBERS) {
            _local3 = new LOEBUILD_ee2d15ada259b3b28f666dd0efe286c5();
            this.partyMemberArrows_[_local2] = _local3;
            addChild(_local3);
            _local2++;
         }
         this.questArrow_ = new LOEBUILD_247f81ddb717f0a150491fda67ee2fbc(this.map_);
         addChild(this.questArrow_);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }

      private function onRemovedFromStage(param1:Event) : void {
         LOEBUILD_4a59873dd40437adf7708a4430a17690.removeMenu();
      }

      public function draw(param1:Camera, param2:int) : void {
         var _local6:LOEBUILD_ee2d15ada259b3b28f666dd0efe286c5 = null;
         var _local7:Player = null;
         var _local8:int = 0;
         var _local9:LOEBUILD_ee2d15ada259b3b28f666dd0efe286c5 = null;
         var _local10:Number = NaN;
         var _local11:Number = NaN;
         if(this.map_.player_ == null) {
            return;
         }
         var _local3:LOEBUILD_094a173d3b32f44f5b5c996e8710ae28 = this.map_.party_;
         var _local4:Player = this.map_.player_;
         var _local5:int = 0;
         while(_local5 < LOEBUILD_094a173d3b32f44f5b5c996e8710ae28.NUM_MEMBERS) {
            _local6 = this.partyMemberArrows_[_local5];
            if(!_local6.mouseOver_) {
               if(_local5 >= _local3.members_.length) {
                  _local6.setGameObject(null);
               } else {
                  _local7 = _local3.members_[_local5];
                  if(Boolean(_local7.drawn_) || _local7.map_ == null || Boolean(_local7.dead_)) {
                     _local6.setGameObject(null);
                  } else {
                     _local6.setGameObject(_local7);
                     _local8 = 0;
                     while(_local8 < _local5) {
                        _local9 = this.partyMemberArrows_[_local8];
                        _local10 = _local6.x - _local9.x;
                        _local11 = _local6.y - _local9.y;
                        if(_local10 * _local10 + _local11 * _local11 < 64) {
                           if(!_local9.mouseOver_) {
                              _local9.addGameObject(_local7);
                           }
                           _local6.setGameObject(null);
                           break;
                        }
                        _local8++;
                     }
                     _local6.draw(param2,param1);
                  }
               }
            }
            _local5++;
         }
         if(!this.questArrow_.mouseOver_) {
            this.questArrow_.draw(param2,param1);
         }
      }
   }
}
