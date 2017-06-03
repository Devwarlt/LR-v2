package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.sound.SoundEffectLibrary;

import flash.utils.Dictionary;

import kabam.rotmg.errors.control.LOEBUILD_5c3fafb478917eee32f80d979a87cb36;

public class ObjectProperties {

      public var type_:int;

      public var id_:String;

      public var displayId_:String;

      public var shadowSize_:int;

      public var isPlayer_:Boolean = false;

      public var isEnemy_:Boolean = false;

      public var drawOnGround_:Boolean = false;

      public var drawUnder_:Boolean = false;

      public var occupySquare_:Boolean = false;

      public var plr_:Boolean = false;

      public var nm_:Boolean = false;

      public var fullOccupy_:Boolean = false;

      public var enemyOccupySquare_:Boolean = false;

      public var static_:Boolean = false;

      public var noMiniMap_:Boolean = false;

      public var protectFromGroundDamage_:Boolean = false;

      public var protectFromSink_:Boolean = false;

      public var z_:Number = 0;

      public var flying_:Boolean = false;

      public var color_:uint = 16777215;

      public var showName_:Boolean = false;

      public var dontFaceAttacks_:Boolean = false;

      public var bloodProb_:Number = 0.0;

      public var bloodColor_:uint = 16711680;

      public var shadowColor_:uint = 0;

      public var sounds_:Object = null;

      public var portrait_:TextureData = null;

      public var minSize_:int = 100;

      public var maxSize_:int = 100;

      public var sizeStep_:int = 5;

      public var whileMoving_:WhileMovingProperties = null;

      public var oldSound_:String = null;

      public var projectiles_:Dictionary;

      public var angleCorrection_:Number = 0;

      public var rotation_:Number = 0;

      public function ObjectProperties(param1:XML) {
         var _local2:XML = null;
         var _local3:XML = null;
         var _local4:int = 0;
         this.projectiles_ = new Dictionary();
         super();
         if(param1 == null) {
            return;
         }
         this.type_ = int(param1.@type);
         this.id_ = String(param1.@id);
         this.displayId_ = this.id_;
         if(param1.hasOwnProperty("DisplayId")) {
            this.displayId_ = param1.DisplayId;
         }
         this.shadowSize_ = !!param1.hasOwnProperty("ShadowSize")?int(param1.ShadowSize):100;
         this.isPlayer_ = param1.hasOwnProperty("Player");
         this.isEnemy_ = param1.hasOwnProperty("Enemy");
         this.drawOnGround_ = param1.hasOwnProperty("DrawOnGround");
         if(Boolean(this.drawOnGround_) || Boolean(param1.hasOwnProperty("DrawUnder"))) {
            this.drawUnder_ = true;
         }
         this.occupySquare_ = param1.hasOwnProperty("OccupySquare");
         this.fullOccupy_ = param1.hasOwnProperty("FullOccupy");
         this.enemyOccupySquare_ = param1.hasOwnProperty("EnemyOccupySquare");
         this.static_ = param1.hasOwnProperty("Static");
         this.noMiniMap_ = param1.hasOwnProperty("NoMiniMap");
         this.protectFromGroundDamage_ = param1.hasOwnProperty("ProtectFromGroundDamage");
         this.protectFromSink_ = param1.hasOwnProperty("ProtectFromSink");
         this.flying_ = param1.hasOwnProperty("Flying");
         this.showName_ = param1.hasOwnProperty("ShowName");
         this.dontFaceAttacks_ = param1.hasOwnProperty("DontFaceAttacks");
         if(param1.hasOwnProperty("Z")) {
            this.z_ = Number(param1.Z);
         }
         if(param1.hasOwnProperty("Color")) {
            this.color_ = uint(param1.Color);
         }
         if(param1.hasOwnProperty("Size")) {
            this.minSize_ = this.maxSize_ = param1.Size;
         } else {
            if(param1.hasOwnProperty("MinSize")) {
               this.minSize_ = param1.MinSize;
            }
            if(param1.hasOwnProperty("MaxSize")) {
               this.maxSize_ = param1.MaxSize;
            }
            if(param1.hasOwnProperty("SizeStep")) {
               this.sizeStep_ = param1.SizeStep;
            }
         }
         this.oldSound_ = !!param1.hasOwnProperty("OldSound")?String(param1.OldSound):null;
         for each(_local2 in param1.Projectile) {
            _local4 = int(_local2.@id);
            this.projectiles_[_local4] = new ProjectileProperties(_local2);
         }
         this.plr_ = param1.hasOwnProperty(LOEBUILD_5c3fafb478917eee32f80d979a87cb36.p1R);
         this.nm_ = param1.hasOwnProperty(LOEBUILD_5c3fafb478917eee32f80d979a87cb36.nm1Y);
         this.angleCorrection_ = !!param1.hasOwnProperty("AngleCorrection")?Number(Number(param1.AngleCorrection) * Math.PI / 4):Number(0);
         this.rotation_ = !!param1.hasOwnProperty("Rotation")?Number(param1.Rotation):Number(0);
         if(param1.hasOwnProperty("BloodProb")) {
            this.bloodProb_ = Number(param1.BloodProb);
         }
         if(param1.hasOwnProperty("BloodColor")) {
            this.bloodColor_ = uint(param1.BloodColor);
         }
         if(param1.hasOwnProperty("ShadowColor")) {
            this.shadowColor_ = uint(param1.ShadowColor);
         }
         for each(_local3 in param1.Sound) {
            if(this.sounds_ == null) {
               this.sounds_ = {};
            }
            this.sounds_[int(_local3.@id)] = _local3.toString();
         }
         if(param1.hasOwnProperty("Portrait")) {
            this.portrait_ = new LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a(XML(param1.Portrait));
         }
         if(param1.hasOwnProperty("WhileMoving")) {
            this.whileMoving_ = new WhileMovingProperties(XML(param1.WhileMoving));
         }
      }

      public function loadSounds() : void {
         var _local1:String = null;
         if(this.sounds_ == null) {
            return;
         }
         for each(_local1 in this.sounds_) {
            SoundEffectLibrary.load(_local1);
         }
      }

      public function getSize() : int {
         if(this.minSize_ == this.maxSize_) {
            return this.minSize_;
         }
         var _local1:int = (this.maxSize_ - this.minSize_) / this.sizeStep_;
         return this.minSize_ + int(Math.random() * _local1) * this.sizeStep_;
      }
   }
}

class WhileMovingProperties {

   public var z_:Number = 0.0;

   public var flying_:Boolean = false;

   function WhileMovingProperties(param1:XML) {
      super();
      if(param1.hasOwnProperty("Z")) {
         this.z_ = Number(param1.Z);
      }
      this.flying_ = param1.hasOwnProperty("Flying");
   }
}
