package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4.LOEBUILD_1685c4cb9754df6a8c65c8564d8d0d74;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.HitEffect;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.SparkParticle;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.tutorial.Tutorial;
import com.company.assembleegameclient.tutorial.doneAction;
import com.company.assembleegameclient.util.BloodComposition;
import com.company.assembleegameclient.util.FreeList;
import com.company.assembleegameclient.util.RandomUtil;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.GraphicsUtil;
import com.company.util.Trig;

import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.Dictionary;

import kabam.rotmg.assets.model.Player;

public class Projectile extends BasicObject {

      private static var objBullIdToObjId_:Dictionary = new Dictionary();

      public var props_:ObjectProperties;

      public var containerProps_:ObjectProperties;

      public var projProps_:ProjectileProperties;

      public var texture_:BitmapData;

      public var bulletId_:uint;

      public var ownerId_:int;

      public var containerType_:int;

      public var bulletType_:uint;

      public var damagesEnemies_:Boolean;

      public var damagesPlayers_:Boolean;

      public var damage_:int;

      public var sound_:String;

      public var startX_:Number;

      public var startY_:Number;

      public var startTime_:int;

      public var angle_:Number = 0;

      public var multiHitDict_:Dictionary;

      public var p_:LOEBUILD_1685c4cb9754df6a8c65c8564d8d0d74;

      private var staticPoint_:Point;

      private var staticVector3D_:Vector3D;

      protected var shadowGradientFill_:GraphicsGradientFill;

      protected var shadowPath_:GraphicsPath;

      public function Projectile() {
         this.p_ = new LOEBUILD_1685c4cb9754df6a8c65c8564d8d0d74(100);
         this.staticPoint_ = new Point();
         this.staticVector3D_ = new Vector3D();
         this.shadowGradientFill_ = new GraphicsGradientFill(GradientType.RADIAL,[0,0],[0.5,0],null,new Matrix());
         this.shadowPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,new Vector.<Number>());
         super();
      }

      public static function findObjId(param1:int, param2:uint) : int {
         return objBullIdToObjId_[param2 << 24 | param1];
      }

      public static function getNewObjId(param1:int, param2:uint) : int {
         var _local3:int = getNextFakeObjectId();
         objBullIdToObjId_[param2 << 24 | param1] = _local3;
         return _local3;
      }

      public static function removeObjId(param1:int, param2:uint) : void {
         delete objBullIdToObjId_[param2 << 24 | param1];
      }

      public static function dispose() : void {
         objBullIdToObjId_ = new Dictionary();
      }

      public function reset(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:int, param7:String = "", param8:String = "") : void {
         var _local11:Number = NaN;
         clear();
         this.containerType_ = param1;
         this.bulletType_ = param2;
         this.ownerId_ = param3;
         this.bulletId_ = param4;
         this.angle_ = Trig.boundToPI(param5);
         this.startTime_ = param6;
         objectId_ = getNewObjId(this.ownerId_,this.bulletId_);
         z_ = 0.5;
         this.containerProps_ = LOEBUILD_efda783509bc93eea698457c87bbee3f.propsLibrary_[this.containerType_];
         this.projProps_ = this.containerProps_.projectiles_[param2];
         var _local9:String = param7 != "" && this.projProps_.objectId_ == param8?param7:this.projProps_.objectId_;
         this.props_ = LOEBUILD_efda783509bc93eea698457c87bbee3f.getPropsFromId(_local9);
         hasShadow_ = this.props_.shadowSize_ > 0;
         var _local10:TextureData = LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToTextureData_[this.props_.type_];
         this.texture_ = _local10.getTexture(objectId_);
         this.damagesPlayers_ = this.containerProps_.nm_;
         this.damagesEnemies_ = !this.damagesPlayers_;
         this.sound_ = this.containerProps_.oldSound_;
         this.multiHitDict_ = !!this.projProps_.multiHit_?new Dictionary():null;
         if(this.projProps_.size_ >= 0) {
            _local11 = this.projProps_.size_;
         } else {
            _local11 = LOEBUILD_efda783509bc93eea698457c87bbee3f.getSizeFromType(this.containerType_);
         }
         this.p_.setSize(8 * (_local11 / 100));
         this.damage_ = 0;
      }

      public function setDamage(param1:int) : void {
         this.damage_ = param1;
      }

      override public function addTo(param1:Map, param2:Number, param3:Number) : Boolean {
         var _local4:Player = null;
         this.startX_ = param2;
         this.startY_ = param3;
         if(!super.addTo(param1,param2,param3)) {
            return false;
         }
         if(!this.containerProps_.flying_ && Boolean(square_.sink_)) {
            z_ = 0.1;
         } else {
            _local4 = param1.goDict_[this.ownerId_] as Player;
            if(_local4 != null && _local4.sinkLevel_ > 0) {
               z_ = 0.5 - 0.4 * (_local4.sinkLevel_ / LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.MAX_SINK_LEVEL);
            }
         }
         return true;
      }

      public function moveTo(param1:Number, param2:Number) : Boolean {
         var _local3:Square = map_.getSquare(param1,param2);
         if(_local3 == null) {
            return false;
         }
         x_ = param1;
         y_ = param2;
         square_ = _local3;
         return true;
      }

      override public function removeFromMap() : void {
         super.removeFromMap();
         removeObjId(this.ownerId_,this.bulletId_);
         this.multiHitDict_ = null;
         FreeList.deleteObject(this);
      }

      private function positionAt(param1:int, param2:Point) : void {
         var _local5:Number = NaN;
         var _local6:Number = NaN;
         var _local7:Number = NaN;
         var _local8:Number = NaN;
         var _local9:Number = NaN;
         var _local10:Number = NaN;
         var _local11:Number = NaN;
         var _local12:Number = NaN;
         var _local13:Number = NaN;
         var _local14:Number = NaN;
         param2.x = this.startX_;
         param2.y = this.startY_;
         var _local3:Number = param1 * (this.projProps_.speed_ / 10000);
         var _local4:Number = this.bulletId_ % 2 == 0?Number(0):Number(Math.PI);
         if(this.projProps_.wavy_) {
            _local5 = 6 * Math.PI;
            _local6 = Math.PI / 64;
            _local7 = this.angle_ + _local6 * Math.sin(_local4 + _local5 * param1 / 1000);
            param2.x = param2.x + _local3 * Math.cos(_local7);
            param2.y = param2.y + _local3 * Math.sin(_local7);
         } else if(this.projProps_.parametric_) {
            _local8 = param1 / this.projProps_.lifetime_ * 2 * Math.PI;
            _local9 = Math.sin(_local8) * (!!(this.bulletId_ % 2)?1:-1);
            _local10 = Math.sin(2 * _local8) * (this.bulletId_ % 4 < 2?1:-1);
            _local11 = Math.sin(this.angle_);
            _local12 = Math.cos(this.angle_);
            param2.x = param2.x + (_local9 * _local12 - _local10 * _local11) * this.projProps_.magnitude_;
            param2.y = param2.y + (_local9 * _local11 + _local10 * _local12) * this.projProps_.magnitude_;
         } else {
            if(this.projProps_.boomerang_) {
               _local13 = this.projProps_.lifetime_ * (this.projProps_.speed_ / 10000) / 2;
               if(_local3 > _local13) {
                  _local3 = _local13 - (_local3 - _local13);
               }
            }
            param2.x = param2.x + _local3 * Math.cos(this.angle_);
            param2.y = param2.y + _local3 * Math.sin(this.angle_);
            if(this.projProps_.amplitude_ != 0) {
               _local14 = this.projProps_.amplitude_ * Math.sin(_local4 + param1 / this.projProps_.lifetime_ * this.projProps_.frequency_ * 2 * Math.PI);
               param2.x = param2.x + _local14 * Math.cos(this.angle_ + Math.PI / 2);
               param2.y = param2.y + _local14 * Math.sin(this.angle_ + Math.PI / 2);
            }
         }
      }

      override public function update(param1:int, param2:int) : Boolean {
         var _local5:Vector.<uint> = null;
         var _local7:Player = null;
         var _local8:* = false;
         var _local9:Boolean = false;
         var _local10:Boolean = false;
         var _local11:int = 0;
         var _local12:Boolean = false;
         var _local3:int = param1 - this.startTime_;
         if(_local3 > this.projProps_.lifetime_) {
            return false;
         }
         var _local4:Point = this.staticPoint_;
         this.positionAt(_local3,_local4);
         if(!this.moveTo(_local4.x,_local4.y) || square_.tileType_ == 65535) {
            if(this.damagesPlayers_) {
               map_.gs_.gsc_.squareHit(param1,this.bulletId_,this.ownerId_);
            } else if(square_.obj_ != null) {
               _local5 = BloodComposition.getColors(this.texture_);
               map_.addObj(new HitEffect(_local5,100,3,this.angle_,this.projProps_.speed_),_local4.x,_local4.y);
            }
            return false;
         }
         if(square_.obj_ != null && (!square_.obj_.props_.nm_ || !this.damagesEnemies_) && (Boolean(square_.obj_.props_.enemyOccupySquare_) || !this.projProps_.passesCover_ && Boolean(square_.obj_.props_.occupySquare_))) {
            if(this.damagesPlayers_) {
               map_.gs_.gsc_.otherHit(param1,this.bulletId_,this.ownerId_,square_.obj_.objectId_);
            } else {
               _local5 = BloodComposition.getColors(this.texture_);
               map_.addObj(new HitEffect(_local5,100,3,this.angle_,this.projProps_.speed_),_local4.x,_local4.y);
            }
            return false;
         }
         var _local6:GameObject = this.getHit(_local4.x,_local4.y);
         if(_local6 != null) {
            _local7 = map_.player_;
            _local8 = _local7 != null;
            _local9 = _local6.props_.nm_;
            _local10 = Boolean(_local8) && !_local7.isPaused() && (Boolean(this.damagesPlayers_) || Boolean(_local9) && this.ownerId_ == _local7.objectId_);
            if(_local10) {
               _local11 = GameObject.damageWithDefense(this.damage_,_local6.defense_,this.projProps_.armorPiercing_,_local6.condition_);
               _local12 = false;
               if(_local6.hp_ <= _local11) {
                  _local12 = true;
                  if(_local6.props_.nm_) {
                     doneAction(map_.gs_,Tutorial.KILL_ACTION);
                  }
               }
               if(_local6 == _local7) {
                  map_.gs_.gsc_.playerHit(this.bulletId_,this.ownerId_);
                  _local6.damage(this.containerType_,_local11,this.projProps_.effects_,false,this);
               } else if(_local6.props_.nm_) {
                  map_.gs_.gsc_.enemyHit(param1,this.bulletId_,_local6.objectId_,_local12);
                  _local6.damage(this.containerType_,_local11,this.projProps_.effects_,_local12,this);
               } else if(!this.projProps_.multiHit_) {
                  map_.gs_.gsc_.otherHit(param1,this.bulletId_,this.ownerId_,_local6.objectId_);
               }
            }
            if(this.projProps_.multiHit_) {
               this.multiHitDict_[_local6] = true;
            } else {
               return false;
            }
         }
         return true;
      }

      public function getHit(param1:Number, param2:Number) : GameObject {
         var _local5:GameObject = null;
         var _local6:Number = NaN;
         var _local7:Number = NaN;
         var _local8:Number = NaN;
         var _local9:Number = NaN;
         var _local3:Number = Number.MAX_VALUE;
         var _local4:GameObject = null;
         for each(_local5 in map_.goDict_) {
            if(!_local5.isInvincible()) {
               if(!_local5.isStasis()) {
                  if(Boolean(this.damagesEnemies_) && Boolean(_local5.props_.nm_) || Boolean(this.damagesPlayers_) && Boolean(_local5.props_.plr_)) {
                     if(!(Boolean(_local5.dead_) || Boolean(_local5.isPaused()))) {
                        _local6 = _local5.x_ > param1?Number(_local5.x_ - param1):Number(param1 - _local5.x_);
                        _local7 = _local5.y_ > param2?Number(_local5.y_ - param2):Number(param2 - _local5.y_);
                        if(!(_local6 > _local5.radius_ || _local7 > _local5.radius_)) {
                           if(!(Boolean(this.projProps_.multiHit_) && this.multiHitDict_[_local5] != null)) {
                              if(_local5 == map_.player_) {
                                 return _local5;
                              }
                              _local8 = Math.sqrt(_local6 * _local6 + _local7 * _local7);
                              _local9 = _local6 * _local6 + _local7 * _local7;
                              if(_local9 < _local3) {
                                 _local3 = _local9;
                                 _local4 = _local5;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return _local4;
      }

      override public function draw(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : void {
         var _local6:uint = 0;
         var _local7:uint = 0;
         var _local8:int = 0;
         var _local9:int = 0;
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.drawProj_) {
            return;
         }
         var _local4:BitmapData = this.texture_;
         if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.projColorType_ != 0) {
            switch(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.projColorType_) {
               case 1:
                  _local6 = 16777100;
                  _local7 = 16777215;
                  break;
               case 2:
                  _local6 = 16777100;
                  _local7 = 16777100;
                  break;
               case 3:
                  _local6 = 16711680;
                  _local7 = 16711680;
                  break;
               case 4:
                  _local6 = 255;
                  _local7 = 255;
                  break;
               case 5:
                  _local6 = 16777215;
                  _local7 = 16777215;
                  break;
               case 6:
                  _local6 = 0;
                  _local7 = 0;
            }
            _local4 = TextureRedrawer.redraw(_local4,120,true,_local7);
         }
         var _local5:Number = this.props_.rotation_ == 0?Number(0):Number(param3 / this.props_.rotation_);
         this.staticVector3D_.x = x_;
         this.staticVector3D_.y = y_;
         this.staticVector3D_.z = z_;
         this.p_.draw(param1,this.staticVector3D_,this.angle_ - param2.angleRad_ + this.props_.angleCorrection_ + _local5,param2.wToS_,param2,_local4);
         if(this.projProps_.particleTrail_) {
            _local8 = this.projProps_.particleTrailLifetimeMS != -1?int(this.projProps_.particleTrailLifetimeMS):600;
            _local9 = 0;
            for(; _local9 < 3; _local9++) {
               if(map_ != null && map_.player_.objectId_ != this.ownerId_) {
                  if(this.projProps_.particleTrailIntensity_ == -1 && Math.random() * 100 > this.projProps_.particleTrailIntensity_) {
                     continue;
                  }
               }
               map_.addObj(new SparkParticle(100,this.projProps_.particleTrailColor_,_local8,0.5,RandomUtil.plusMinus(3),RandomUtil.plusMinus(3)),x_,y_);
            }
         }
      }

      override public function drawShadow(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : void {
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.drawProj_) {
            return;
         }
         var _local4:Number = this.props_.shadowSize_ / 400;
         var _local5:Number = 30 * _local4;
         var _local6:Number = 15 * _local4;
         this.shadowGradientFill_.matrix.createGradientBox(_local5 * 2,_local6 * 2,0,posS_[0] - _local5,posS_[1] - _local6);
         param1.push(this.shadowGradientFill_);
         this.shadowPath_.data.length = 0;
         Vector.<Number>(this.shadowPath_.data).push(posS_[0] - _local5,posS_[1] - _local6,posS_[0] + _local5,posS_[1] - _local6,posS_[0] + _local5,posS_[1] + _local6,posS_[0] - _local5,posS_[1] + _local6);
         param1.push(this.shadowPath_);
         param1.push(GraphicsUtil.END_FILL);
      }
   }
}
