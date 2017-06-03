package com.company.assembleegameclient.map {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.BasicObject;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.ConfettiEffect;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.LightningEffect;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.NovaEffect;

import flash.display.IGraphicsData;
import flash.events.Event;
import flash.utils.Dictionary;
import flash.utils.getTimer;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class LOEBUILD_e381592941e087d5644194bd1995159f extends Map {

      public static const MODE_SNOW:int = 1;

      public static const MODE_AUTO_UPDATE:int = 2;

      public static const PSCALE:Number = 16;

      private var inUpdate_:Boolean = false;

      private var objsToAdd_:Vector.<BasicObject>;

      private var idsToRemove_:Vector.<int>;

      private var dt:uint = 0;

      private var dtBuildup:uint = 0;

      private var time:uint = 0;

      private var graphicsData_:Vector.<IGraphicsData>;

      public function LOEBUILD_e381592941e087d5644194bd1995159f(param1:int = -1) {
         this.objsToAdd_ = new Vector.<BasicObject>();
         this.idsToRemove_ = new Vector.<int>();
         this.graphicsData_ = new Vector.<IGraphicsData>();
         super(null);
         if(param1 == MODE_SNOW) {
            addEventListener(Event.ENTER_FRAME,this.activateModeSnow);
         }
         if(param1 == MODE_AUTO_UPDATE) {
            addEventListener(Event.ENTER_FRAME,this.updater);
         }
      }

      public static function getLocalPos(param1:Number) : Number {
         return param1 / PSCALE;
      }

      override public function addObj(param1:BasicObject, param2:Number, param3:Number) : void {
         param1.x_ = param2;
         param1.y_ = param3;
         if(this.inUpdate_) {
            this.objsToAdd_.push(param1);
         } else {
            this.internalAddObj(param1);
         }
      }

      override public function internalAddObj(param1:BasicObject) : void {
         var _local2:Dictionary = boDict_;
         if(_local2[param1.objectId_] != null) {
            return;
         }
         param1.map_ = this;
         _local2[param1.objectId_] = param1;
      }

      override public function internalRemoveObj(param1:int) : void {
         var _local2:Dictionary = boDict_;
         var _local3:BasicObject = _local2[param1];
         if(_local3 == null) {
            return;
         }
         _local3.removeFromMap();
         delete _local2[param1];
      }

      override public function update(param1:int, param2:int) : void {
         var _local3:BasicObject = null;
         var _local4:int = 0;
         this.inUpdate_ = true;
         for each(_local3 in boDict_) {
            if(!_local3.update(param1,param2)) {
               this.idsToRemove_.push(_local3.objectId_);
            }
         }
         this.inUpdate_ = false;
         for each(_local3 in this.objsToAdd_) {
            this.internalAddObj(_local3);
         }
         this.objsToAdd_.length = 0;
         for each(_local4 in this.idsToRemove_) {
            this.internalRemoveObj(_local4);
         }
         this.idsToRemove_.length = 0;
      }

      override public function draw(param1:Camera, param2:int) : void {
         var _local3:BasicObject = null;
         this.graphicsData_.length = 0;
         var _local4:int = 0;
         for each(_local3 in boDict_) {
            _local4++;
            _local3.computeSortValNoCamera(PSCALE);
            _local3.draw(this.graphicsData_,param1,param2);
         }
         graphics.clear();
         if(this.graphicsData_.length > 0) {
            graphics.drawGraphicsData(this.graphicsData_);
         }
      }

      private function activateModeSnow(param1:Event) : void {
         var _local2:int = 600;
         var _local3:int = 600;
         if(this.time != 0) {
            this.dt = getTimer() - this.time;
         }
         this.dtBuildup = this.dtBuildup + this.dt;
         this.time = getTimer();
         if(this.dtBuildup > 500) {
            this.dtBuildup = 0;
            this.doSnow(Math.random() * 600,-100);
         }
         this.update(this.time,this.dt);
         this.draw(null,this.time);
      }

      private function updater(param1:Event) : void {
         if(this.time != 0) {
            this.dt = getTimer() - this.time;
         }
         this.time = getTimer();
         this.update(this.time,this.dt);
         this.draw(null,this.time);
      }

      public function doNova(param1:Number, param2:Number, param3:int = 20, param4:int = 12447231) : void {
         var _local5:GameObject = new GameObject(null);
         _local5.x_ = getLocalPos(param1);
         _local5.y_ = getLocalPos(param2);
         var _local6:NovaEffect = new NovaEffect(_local5,param3,param4);
         this.addObj(_local6,_local5.x_,_local5.y_);
      }

      private function doSnow(param1:Number, param2:Number, param3:int = 20, param4:int = 12447231) : void {
         var _local5:WorldPosData = new WorldPosData();
         var _local6:WorldPosData = new WorldPosData();
         _local5.x_ = getLocalPos(param1);
         _local5.y_ = getLocalPos(param2);
         _local6.x_ = getLocalPos(param1);
         _local6.y_ = getLocalPos(600);
         var _local7:ConfettiEffect = new ConfettiEffect(_local5,_local6,param4,param3,true);
         this.addObj(_local7,_local5.x_,_local5.y_);
      }

      public function doLightning(param1:Number, param2:Number, param3:Number, param4:Number, param5:int = 200, param6:int = 12447231, param7:Number = 1) : void {
         var _local8:GameObject = new GameObject(null);
         _local8.x_ = getLocalPos(param1);
         _local8.y_ = getLocalPos(param2);
         var _local9:WorldPosData = new WorldPosData();
         _local9.x_ = getLocalPos(param3);
         _local9.y_ = getLocalPos(param4);
         var _local10:LightningEffect = new LightningEffect(_local8,_local9,param6,param5,param7);
         this.addObj(_local10,_local8.x_,_local8.y_);
      }
   }
}
