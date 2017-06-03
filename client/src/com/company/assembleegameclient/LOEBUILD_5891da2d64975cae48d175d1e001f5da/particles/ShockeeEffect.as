package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;

import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

public class ShockeeEffect extends ParticleEffect {

      public var start_:Point;

      public var go:GameObject;

      private var isShocked:Boolean;

      public function ShockeeEffect(param1:GameObject) {
         super();
         this.go = param1;
      }

      override public function update(param1:int, param2:int) : Boolean {
         var _local3:Timer = new Timer(50,12);
         _local3.addEventListener(TimerEvent.TIMER,this.onTimer);
         _local3.start();
         return false;
      }

      private function onTimer(param1:TimerEvent) : void {
         this.isShocked = !this.isShocked;
         this.go.toggleShockEffect(this.isShocked);
      }
   }
}
