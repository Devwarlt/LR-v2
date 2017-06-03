package com.company.assembleegameclient.map.LOEBUILD_4a218ca1436fee34076fdca93698bac4 {
import com.company.assembleegameclient.map.Camera;

import flash.display.Sprite;

import kabam.rotmg.game.view.components.QueuedStatusText;
import kabam.rotmg.game.view.components.QueuedStatusTextList;

public class LOEBUILD_2f05f88d589905f707225941d764de4a extends Sprite {

      private const speechBalloons:Object = {};

      private const queuedText:Object = {};

      public function LOEBUILD_2f05f88d589905f707225941d764de4a() {
         super();
         mouseEnabled = true;
         mouseChildren = true;
      }

      public function addSpeechBalloon(param1:LOEBUILD_d71287c311912d45ec3f504b24da0385) : void {
         var _local2:int = param1.go_.objectId_;
         var _local3:LOEBUILD_d71287c311912d45ec3f504b24da0385 = this.speechBalloons[_local2];
         if(Boolean(_local3) && Boolean(contains(_local3))) {
            removeChild(_local3);
         }
         this.speechBalloons[_local2] = param1;
         addChild(param1);
      }

      public function addStatusText(param1:LOEBUILD_862a0e20385d01174a45beed4b836305) : void {
         addChild(param1);
      }

      public function addQueuedText(param1:QueuedStatusText) : void {
         var _local2:int = param1.go_.objectId_;
         var _local3:QueuedStatusTextList = this.queuedText[_local2] = this.queuedText[_local2] || this.makeQueuedStatusTextList();
         _local3.append(param1);
      }

      private function makeQueuedStatusTextList() : QueuedStatusTextList {
         var _local1:QueuedStatusTextList = new QueuedStatusTextList();
         _local1.target = this;
         return _local1;
      }

      public function draw(param1:Camera, param2:int) : void {
         var _local4:LOEBUILD_9842b5c73c563ba5cc56f3d815afd768 = null;
         var _local3:int = 0;
         while(_local3 < numChildren) {
            _local4 = getChildAt(_local3) as LOEBUILD_9842b5c73c563ba5cc56f3d815afd768;
            if(!_local4 || Boolean(_local4.draw(param1,param2))) {
               _local3++;
            } else {
               _local4.dispose();
            }
         }
      }
   }
}
