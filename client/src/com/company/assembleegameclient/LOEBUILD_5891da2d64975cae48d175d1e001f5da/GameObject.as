package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.GraphicHelper;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.HWAccelerate;
import com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4.LOEBUILD_1cd204050ec7f52020766f99b3129701;
import com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4.Object3D;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.map.LOEBUILD_4a218ca1436fee34076fdca93698bac4.LOEBUILD_862a0e20385d01174a45beed4b836305;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b.Animations;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b.LOEBUILD_b98058c639863689a15a54bd69990a3b;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.ExplosionEffect;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.HitEffect;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.ParticleEffect;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.ShockerEffect;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.BloodComposition;
import com.company.assembleegameclient.util.ConditionEffect;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;
import com.company.util.CachingColorTransformer;
import com.company.util.ConversionUtil;
import com.company.util.GraphicsUtil;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.filters.ColorMatrixFilter;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;
import flash.utils.getTimer;

import kabam.rotmg.assets.model.Player;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.messaging.impl.data.WorldPosData;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.stage3D.GraphicsFillExtra;
import kabam.rotmg.stage3D.Object3D.Object3DStage3D;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class GameObject extends BasicObject {

      protected static const PAUSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);

      protected static const CURSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.redFilterMatrix);

      protected static const IDENTITY_MATRIX:Matrix = new Matrix();

      private static const ZERO_LIMIT:Number = 0.00001;

      private static const NEGATIVE_ZERO_LIMIT:Number = -ZERO_LIMIT;

      public static const ATTACK_PERIOD:int = 300;

      public var nameBitmapData_:BitmapData = null;

      private var nameFill_:GraphicsBitmapFill = null;

    protected var _0aA_:Point;

    private var mobSpd:String;

      private var namePath_:GraphicsPath = null;

      public var shockEffect:ShockerEffect;

      private var isShocked:Boolean;

      private var isShockedTransformSet:Boolean = false;

      private var isCharging:Boolean;

      private var isChargingTransformSet:Boolean = false;

      public var props_:ObjectProperties;

      public var name_:String;

      public var radius_:Number = 0.5;

      public var facing_:Number = 0;

      public var flying_:Boolean = false;

      public var attackAngle_:Number = 0;

      public var attackStart_:int = 0;

      public var animatedChar_:AnimatedChar = null;

      public var texture_:BitmapData = null;

      public var mask_:BitmapData = null;

      public var randomTextureData_:Vector.<TextureData> = null;

      public var obj3D_:Object3D = null;

      public var object3d_:Object3DStage3D = null;

      public var effect_:ParticleEffect = null;

      public var animations_:Animations = null;

      public var dead_:Boolean = false;

      protected var portrait_:BitmapData = null;

      protected var texturingCache_:Dictionary = null;

      public var maxHP_:int = 200;

      public var hp_:int = 200;

      public var size_:int = 100;

      public var level_:int = -1;

      public var defense_:int = 0;

      public var slotTypes_:Vector.<int> = null;

      public var equipment_:Vector.<int> = null;

      public var condition_:Vector.<uint>;

      protected var tex1Id_:int = 0;

      protected var tex2Id_:int = 0;

      public var isInteractive_:Boolean = false;

      public var objectType_:int;

      private var nextBulletId_:uint = 1;

      private var sizeMult_:Number = 1;

      public var sinkLevel_:int = 0;

      public var hallucinatingTexture_:BitmapData = null;

      public var flash_:FlashDescription = null;

      public var connectType_:int = -1;

      private var isStunImmune_:Boolean = false;

      private var isParalyzeImmune_:Boolean = false;

      private var isDazedImmune_:Boolean = false;

      protected var lastTickUpdateTime_:int = 0;

      protected var myLastTickId_:int = -1;

      protected var posAtTick_:Point;

      protected var tickPosition_:Point;

      protected var moveVec_:Vector3D;

      protected var bitmapFill_:GraphicsBitmapFill;

      protected var path_:GraphicsPath;

      protected var vS_:Vector.<Number>;

      protected var uvt_:Vector.<Number>;

      protected var fillMatrix_:Matrix;

      private var hpbarBackFill_:GraphicsSolidFill = null;

      private var hpbarBackPath_:GraphicsPath = null;

      private var hpbarFill_:GraphicsSolidFill = null;

      private var hpbarPath_:GraphicsPath = null;

      private var icons_:Vector.<BitmapData> = null;

      private var iconFills_:Vector.<GraphicsBitmapFill> = null;

      private var iconPaths_:Vector.<GraphicsPath> = null;

      protected var shadowGradientFill_:GraphicsGradientFill = null;

      protected var shadowPath_:GraphicsPath = null;

      public function GameObject(param1:XML) {
         var _local4:int = 0;
         this.props_ = LOEBUILD_efda783509bc93eea698457c87bbee3f.defaultProps_;
         this.condition_ = new <uint>[0,0];
         this.posAtTick_ = new Point();
         this.tickPosition_ = new Point();
         this.moveVec_ = new Vector3D();
         this.bitmapFill_ = new GraphicsBitmapFill(null,null,false,false);
         this.path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,null);
         this.vS_ = new Vector.<Number>();
         this.uvt_ = new Vector.<Number>();
         this.fillMatrix_ = new Matrix();
         super();
         if(param1 == null) {
            return;
         }
         this.objectType_ = int(param1.@type);
         this.props_ = LOEBUILD_efda783509bc93eea698457c87bbee3f.propsLibrary_[this.objectType_];
         hasShadow_ = this.props_.shadowSize_ > 0;
         var _local2:TextureData = LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToTextureData_[this.objectType_];
         this.texture_ = _local2.texture_;
         this.mask_ = _local2.mask_;
         this.animatedChar_ = _local2.animatedChar_;
         this.randomTextureData_ = _local2.randomTextureData_;
         if(_local2.effectProps_ != null) {
            this.effect_ = ParticleEffect.fromProps(_local2.effectProps_,this);
         }
         if(this.texture_ != null) {
             this.sizeMult_ = this.texture_.height / 8;
         }
         if(param1.hasOwnProperty("Model")) {
            this.obj3D_ = LOEBUILD_1cd204050ec7f52020766f99b3129701.getObject3D(String(param1.Model));
            this.object3d_ = LOEBUILD_1cd204050ec7f52020766f99b3129701.getStage3dObject3D(String(param1.Model));
            if(this.texture_ != null) {
               this.object3d_.setBitMapData(this.texture_);
            }
         }
         var _local3:LOEBUILD_b98058c639863689a15a54bd69990a3b = LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToAnimationsData_[this.objectType_];
         if(_local3 != null) {
            this.animations_ = new Animations(_local3);
         }
         z_ = this.props_.z_;
         this.flying_ = this.props_.flying_;
         if(param1.hasOwnProperty("MaxHitPoints")) {
            this.hp_ = this.maxHP_ = int(param1.MaxHitPoints);
         }
         if(param1.hasOwnProperty("Defense")) {
            this.defense_ = int(param1.Defense);
         }
         if(param1.hasOwnProperty("SlotTypes")) {
            this.slotTypes_ = ConversionUtil.toIntVector(param1.SlotTypes);
            this.equipment_ = new Vector.<int>(this.slotTypes_.length);
            _local4 = 0;
            while(_local4 < this.equipment_.length) {
               this.equipment_[_local4] = -1;
               _local4++;
            }
         }
         if(param1.hasOwnProperty(""))
         if(param1.hasOwnProperty("Tex1")) {
            this.tex1Id_ = int(param1.Tex1);
         }
         if(param1.hasOwnProperty("Tex2")) {
            this.tex2Id_ = int(param1.Tex2);
         }
          //FML ;-;
         /*if(param1.hasOwnProperty("Scale16x")) {
             var _init1:BitmapData = null;
             var _init2:int = 0;
             var _local116x:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[this.objectType_];
             if(_local116x.hasOwnProperty("ScaleValue")) {
                 _local216x = _local116x.ScaleValue;
             }
             var _local216x:int = 5;
             if(_local116x.hasOwnProperty("ScaleValue")) {
                 _local216x = _local116x.ScaleValue;
             }
             var _local316x:BitmapData = LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(this.objectType_,60,true,true,_local216x);
             _local316x = BitmapUtil.cropToBitmapData(_local316x,4,4,_local316x.width - 8,_local316x.height - 8);
             //this.objectType_.
         }*/
         if(param1.hasOwnProperty("ParalyzeImmune")) {
            this.isParalyzeImmune_ = true;
         }
         if(param1.hasOwnProperty("DazedImmune")) {
            this.isDazedImmune_ = true;
         }
         this.props_.loadSounds();
      }

      public static function damageWithDefense(param1:int, param2:int, param3:Boolean, param4:Vector.<uint>) : int {
         var _local5:int = param2;
         if(Boolean(param3) || (param4[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORBROKEN_BIT) != 0) {
            _local5 = 0;
         } else if((param4[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORED_BIT) != 0) {
            _local5 = _local5 * 2;
         }
         var _local6:int = param1 * 3 / 20;
         var _local7:int = Math.max(_local6,param1 - _local5);
         if((param4[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.INVULNERABLE_BIT) != 0) {
            _local7 = 0;
         }
         if((param4[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PETRIFIED_BIT) != 0) {
            _local7 = _local7 * 0.9;
         }
         if((param4[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.CURSE_BIT) != 0) {
            _local7 = _local7 * 1.2;
         }
         return _local7;
      }

      public function setObjectId(param1:int) : void {
         var _local2:TextureData = null;
         objectId_ = param1;
         if(this.randomTextureData_ != null) {
            _local2 = this.randomTextureData_[objectId_ % this.randomTextureData_.length];
            this.texture_ = _local2.texture_;
            this.mask_ = _local2.mask_;
            this.animatedChar_ = _local2.animatedChar_;
            if(this.object3d_ != null) {
               this.object3d_.setBitMapData(this.texture_);
            }
         }
      }

      public function setAltTexture(param1:int) : void {
         var _local3:TextureData = null;
         var _local2:TextureData = LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToTextureData_[this.objectType_];
         if(param1 == 0) {
            _local3 = _local2;
         } else {
            _local3 = _local2.getAltTextureData(param1);
            if(_local3 == null) {
               return;
            }
         }
         this.texture_ = _local3.texture_;
         this.mask_ = _local3.mask_;
         this.animatedChar_ = _local3.animatedChar_;
         if(this.effect_ != null) {
            map_.removeObj(this.effect_.objectId_);
            this.effect_ = null;
         }
         if(_local3.effectProps_ != null) {
            this.effect_ = ParticleEffect.fromProps(_local3.effectProps_,this);
            if(map_ != null) {
               map_.addObj(this.effect_,x_,y_);
            }
         }
      }

      public function setTex1(param1:int) : void {
         if(param1 == this.tex1Id_) {
            return;
         }
         this.tex1Id_ = param1;
         this.texturingCache_ = new Dictionary();
         this.portrait_ = null;
      }

      public function setTex2(param1:int) : void {
         if(param1 == this.tex2Id_) {
            return;
         }
         this.tex2Id_ = param1;
         this.texturingCache_ = new Dictionary();
         this.portrait_ = null;
      }

      public function playSound(param1:int) : void {
         SoundEffectLibrary.play(this.props_.sounds_[param1]);
      }

      override public function dispose() : void {
         var _local1:Object = null;
         var _local2:BitmapData = null;
         var _local3:Dictionary = null;
         var _local4:Object = null;
         var _local5:BitmapData = null;
         super.dispose();
         this.texture_ = null;
         if(this.portrait_ != null) {
            this.portrait_.dispose();
            this.portrait_ = null;
         }
         if(this.texturingCache_ != null) {
            for each(_local1 in this.texturingCache_) {
               _local2 = _local1 as BitmapData;
               if(_local2 != null) {
                  _local2.dispose();
               } else {
                  _local3 = _local1 as Dictionary;
                  for each(_local4 in _local3) {
                     _local5 = _local4 as BitmapData;
                     if(_local5 != null) {
                        _local5.dispose();
                     }
                  }
               }
            }
            this.texturingCache_ = null;
         }
         if(this.obj3D_ != null) {
            this.obj3D_.dispose();
            this.obj3D_ = null;
         }
         if(this.object3d_ != null) {
            this.object3d_.dispose();
            this.object3d_ = null;
         }
         this.slotTypes_ = null;
         this.equipment_ = null;
         if(this.nameBitmapData_ != null) {
            this.nameBitmapData_.dispose();
            this.nameBitmapData_ = null;
         }
         this.nameFill_ = null;
         this.namePath_ = null;
         this.bitmapFill_ = null;
         this.path_.commands = null;
         this.path_.data = null;
         this.vS_ = null;
         this.uvt_ = null;
         this.fillMatrix_ = null;
         this.icons_ = null;
         this.iconFills_ = null;
         this.iconPaths_ = null;
         this.shadowGradientFill_ = null;
         if(this.shadowPath_ != null) {
            this.shadowPath_.commands = null;
            this.shadowPath_.data = null;
            this.shadowPath_ = null;
         }
      }

      public function isQuiet() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.QUIET_BIT) != 0;
      }

      public function isWeak() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.WEAK_BIT) != 0;
      }

      public function isSlowed() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.SLOWED_BIT) != 0;
      }

      public function isSick() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.SICK_BIT) != 0;
      }

      public function isDazed() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.DAZED_BIT) != 0;
      }

      public function isStunned() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.STUNNED_BIT) != 0;
      }

      public function isBlind() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.BLIND_BIT) != 0;
      }

      public function isDrunk() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.DRUNK_BIT) != 0;
      }

      public function isConfused() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.CONFUSED_BIT) != 0;
      }

      public function isStunImmune() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.STUN_IMMUNE_BIT) != 0 || Boolean(this.isStunImmune_);
      }

      public function isInvisible() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.INVISIBLE_BIT) != 0;
      }

      public function isParalyzed() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.PARALYZED_BIT) != 0;
      }

      public function isSpeedy() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.SPEEDY_BIT) != 0;
      }

      public function isNinjaSpeedy() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.NINJA_SPEEDY_BIT) != 0;
      }

      public function isHallucinating() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.HALLUCINATING_BIT) != 0;
      }

      public function isHealing() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.HEALING_BIT) != 0;
      }

      public function isDamaging() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.DAMAGING_BIT) != 0;
      }

      public function isBerserk() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.BERSERK_BIT) != 0;
      }

      public function isPaused() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.PAUSED_BIT) != 0;
      }

      public function isStasis() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.STASIS_BIT) != 0;
      }

      public function isInvincible() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.INVINCIBLE_BIT) != 0;
      }

      public function isInvulnerable() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.INVULNERABLE_BIT) != 0;
      }

      public function isArmored() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORED_BIT) != 0;
      }

      public function isArmorBroken() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORBROKEN_BIT) != 0;
      }

      public function isArmorBrokenImmune() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.ARMORBROKEN_IMMUNE_BIT) != 0;
      }

      public function isSlowedImmune() : Boolean {
         return (this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.SLOWED_IMMUNE_BIT) != 0;
      }

      public function isUnstable() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.UNSTABLE_BIT) != 0;
      }

      public function isShowPetEffectIcon() : Boolean {
         return (this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PET_EFFECT_ICON) != 0;
      }

      public function isDarkness() : Boolean {
         return (this.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.DARKNESS_BIT) != 0;
      }

      public function isParalyzeImmune() : Boolean {
         return Boolean(this.isParalyzeImmune_) || (this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PARALYZED_IMMUNE_BIT) != 0;
      }

      public function isDazedImmune() : Boolean {
         return Boolean(this.isDazedImmune_) || (this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.DAZED_IMMUNE_BIT) != 0;
      }

      public function isPetrified() : Boolean {
         return (this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PETRIFIED_BIT) != 0;
      }

      public function isPetrifiedImmune() : Boolean {
         return (this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.PETRIFIED_IMMUNE_BIT) != 0;
      }

      public function isCursed() : Boolean {
         return (this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.CURSE_BIT) != 0;
      }

      public function isCursedImmune() : Boolean {
         return (this.condition_[ConditionEffect.CE_SECOND_BATCH] & ConditionEffect.CURSE_IMMUNE_BIT) != 0;
      }

      public function isSafe(param1:int = 20) : Boolean {
         var _local2:GameObject = null;
         var _local3:int = 0;
         var _local4:int = 0;
         for each(_local2 in map_.goDict_) {
            if(_local2 is Character && Boolean(_local2.props_.nm_)) {
               _local3 = x_ > _local2.x_?int(x_ - _local2.x_):int(_local2.x_ - x_);
               _local4 = y_ > _local2.y_?int(y_ - _local2.y_):int(_local2.y_ - y_);
               if(_local3 < param1 && _local4 < param1) {
                  return false;
               }
            }
         }
         return true;
      }

      public function getName() : String {
         return this.name_ == null || this.name_ == ""?LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToDisplayId_[this.objectType_]:this.name_;
      }

      public function getColor() : uint {
         return BitmapUtil.mostCommonColor(this.texture_);
      }

      public function getBulletId() : uint {
         var _local1:uint = this.nextBulletId_;
         this.nextBulletId_ = (this.nextBulletId_ + 1) % 128;
         return _local1;
      }

      public function distTo(param1:WorldPosData) : Number {
         var _local2:Number = param1.x_ - x_;
         var _local3:Number = param1.y_ - y_;
         return Math.sqrt(_local2 * _local2 + _local3 * _local3);
      }

      public function toggleShockEffect(param1:Boolean) : void {
         if(param1) {
            this.isShocked = true;
         } else {
            this.isShocked = false;
            this.isShockedTransformSet = false;
         }
      }

      public function toggleChargingEffect(param1:Boolean) : void {
         if(param1) {
            this.isCharging = true;
         } else {
            this.isCharging = false;
            this.isChargingTransformSet = false;
         }
      }

      override public function addTo(param1:Map, param2:Number, param3:Number) : Boolean {
         map_ = param1;
         this.posAtTick_.x = this.tickPosition_.x = param2;
         this.posAtTick_.y = this.tickPosition_.y = param3;
         if(!this.moveTo(param2,param3)) {
            map_ = null;
            return false;
         }
         if(this.effect_ != null) {
            map_.addObj(this.effect_,param2,param3);
         }
         return true;
      }

      override public function removeFromMap() : void {
         if(Boolean(this.props_.static_) && square_ != null) {
            if(square_.obj_ == this) {
               square_.obj_ = null;
            }
            square_ = null;
         }
         if(this.effect_ != null) {
            map_.removeObj(this.effect_.objectId_);
         }
         super.removeFromMap();
         this.dispose();
      }

      public function moveTo(param1:Number, param2:Number) : Boolean {
         var _local3:Square = map_.getSquare(param1,param2);
         if(_local3 == null) {
            return false;
         }
         x_ = param1;
         y_ = param2;
         if(this.props_.static_) {
            if(square_ != null) {
               square_.obj_ = null;
            }
            _local3.obj_ = this;
         }
         square_ = _local3;
         if(this.obj3D_ != null) {
            this.obj3D_.setPosition(x_,y_,0,this.props_.rotation_);
         }
         if(this.object3d_ != null) {
            this.object3d_.setPosition(x_,y_,0,this.props_.rotation_);
         }
         return true;
      }

      override public function update(param1:int, param2:int) : Boolean {
         var _local4:int = 0;
         var _local5:Number = NaN;
         var _local6:Number = NaN;
         var _local3:Boolean = false;
         if(!(this.moveVec_.x == 0 && this.moveVec_.y == 0)) {
            if(this.myLastTickId_ < map_.gs_.gsc_.lastTickId_) {
               this.moveVec_.x = 0;
               this.moveVec_.y = 0;
               this.moveTo(this.tickPosition_.x,this.tickPosition_.y);
            } else {
               _local4 = param1 - this.lastTickUpdateTime_;
               _local5 = this.posAtTick_.x + _local4 * this.moveVec_.x;
               _local6 = this.posAtTick_.y + _local4 * this.moveVec_.y;
               this.moveTo(_local5,_local6);
               _local3 = true;
            }
         }
         if(this.props_.whileMoving_ != null) {
            if(!_local3) {
               z_ = this.props_.z_;
               this.flying_ = this.props_.flying_;
            } else {
               z_ = this.props_.whileMoving_.z_;
               this.flying_ = this.props_.whileMoving_.flying_;
            }
         }
         return true;
      }

      public function onGoto(param1:Number, param2:Number, param3:int) : void {
         this.moveTo(param1,param2);
         this.lastTickUpdateTime_ = param3;
         this.tickPosition_.x = param1;
         this.tickPosition_.y = param2;
         this.posAtTick_.x = param1;
         this.posAtTick_.y = param2;
         this.moveVec_.x = 0;
         this.moveVec_.y = 0;
      }

      public function onTickPos(param1:Number, param2:Number, param3:int, param4:int) : void {
         if(this.myLastTickId_ < map_.gs_.gsc_.lastTickId_) {
            this.moveTo(this.tickPosition_.x,this.tickPosition_.y);
         }
         this.lastTickUpdateTime_ = map_.gs_.lastUpdate_;
         this.tickPosition_.x = param1;
         this.tickPosition_.y = param2;
         this.posAtTick_.x = x_;
         this.posAtTick_.y = y_;
         this.moveVec_.x = (this.tickPosition_.x - this.posAtTick_.x) / param3;
         this.moveVec_.y = (this.tickPosition_.y - this.posAtTick_.y) / param3;
         this.myLastTickId_ = param4;
      }

      public function damage(param1:int, param2:int, param3:Vector.<uint>, param4:Boolean, param5:Projectile) : void {
         var _local8:int = 0;
         var _local9:uint = 0;
         var _local10:ConditionEffect = null;
         var _local11:LOEBUILD_862a0e20385d01174a45beed4b836305 = null;
         var _local12:PetsModel = null;
         var _local13:PetVO = null;
         var _local14:String = null;
         var _local15:Boolean = false;
         var _local6:Boolean = false;
         if(param4) {
            this.dead_ = true;
         } else if(param3 != null) {
            _local8 = 0;
            for each(_local9 in param3) {
               _local10 = null;
               if(Boolean(param5 != null) && Boolean(param5.projProps_.isPetEffect_) && Boolean(param5.projProps_.isPetEffect_[_local9])) {
                  _local12 = StaticInjectorContext.getInjector().getInstance(PetsModel);
                  _local13 = _local12.getActivePet();
                  if(_local13 != null) {
                     _local10 = ConditionEffect.effects_[_local9];
                     this.showConditionEffectPet(_local8,_local10.name_);
                     _local8 = _local8 + 500;
                  }
               } else {
                  switch(_local9) {
                     case ConditionEffect.NOTHING:
                        break;
                     case ConditionEffect.QUIET:
                     case ConditionEffect.WEAK:
                     case ConditionEffect.SICK:
                     case ConditionEffect.BLIND:
                     case ConditionEffect.HALLUCINATING:
                     case ConditionEffect.DRUNK:
                     case ConditionEffect.CONFUSED:
                     case ConditionEffect.STUN_IMMUNE:
                     case ConditionEffect.INVISIBLE:
                     case ConditionEffect.SPEEDY:
                     case ConditionEffect.BLEEDING:
                     case ConditionEffect.STASIS:
                     case ConditionEffect.STASIS_IMMUNE:
                     case ConditionEffect.NINJA_SPEEDY:
                     case ConditionEffect.UNSTABLE:
                     case ConditionEffect.DARKNESS:
                     case ConditionEffect.PETRIFIED_IMMUNE:
                        _local10 = ConditionEffect.effects_[_local9];
                        break;
                     case ConditionEffect.SLOWED:
                        if(this.isSlowedImmune()) {
                           _local11 = new LOEBUILD_862a0e20385d01174a45beed4b836305(this,16711680,3000);
                           _local11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                           map_.mapOverlay_.addStatusText(_local11);
                        } else {
                           _local10 = ConditionEffect.effects_[_local9];
                        }
                        break;
                     case ConditionEffect.ARMORBROKEN:
                        if(this.isArmorBrokenImmune()) {
                           _local11 = new LOEBUILD_862a0e20385d01174a45beed4b836305(this,16711680,3000);
                           _local11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                           map_.mapOverlay_.addStatusText(_local11);
                        } else {
                           _local10 = ConditionEffect.effects_[_local9];
                        }
                        break;
                     case ConditionEffect.STUNNED:
                        if(this.isStunImmune()) {
                           _local11 = new LOEBUILD_862a0e20385d01174a45beed4b836305(this,16711680,3000);
                           _local11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                           map_.mapOverlay_.addStatusText(_local11);
                        } else {
                           _local10 = ConditionEffect.effects_[_local9];
                        }
                        break;
                     case ConditionEffect.DAZED:
                        if(this.isDazedImmune()) {
                           _local11 = new LOEBUILD_862a0e20385d01174a45beed4b836305(this,16711680,3000);
                           _local11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                           map_.mapOverlay_.addStatusText(_local11);
                        } else {
                           _local10 = ConditionEffect.effects_[_local9];
                        }
                        break;
                     case ConditionEffect.PARALYZED:
                        if(this.isParalyzeImmune()) {
                           _local11 = new LOEBUILD_862a0e20385d01174a45beed4b836305(this,16711680,3000);
                           _local11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                           map_.mapOverlay_.addStatusText(_local11);
                        } else {
                           _local10 = ConditionEffect.effects_[_local9];
                        }
                        break;
                     case ConditionEffect.PETRIFIED:
                        if(this.isPetrifiedImmune()) {
                           _local11 = new LOEBUILD_862a0e20385d01174a45beed4b836305(this,16711680,3000);
                           _local11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                           map_.mapOverlay_.addStatusText(_local11);
                        } else {
                           _local10 = ConditionEffect.effects_[_local9];
                        }
                        break;
                     case ConditionEffect.CURSE:
                        if(this.isCursedImmune()) {
                           _local11 = new LOEBUILD_862a0e20385d01174a45beed4b836305(this,16711680,3000);
                           _local11.setStringBuilder(new LineBuilder().setParams(TextKey.GAMEOBJECT_IMMUNE));
                           map_.mapOverlay_.addStatusText(_local11);
                        } else {
                           _local10 = ConditionEffect.effects_[_local9];
                        }
                        break;
                     case ConditionEffect.GROUND_DAMAGE:
                        _local6 = true;
                  }
                  if(_local10 != null) {
                     if(_local9 < ConditionEffect.NEW_CON_THREASHOLD) {
                        if((this.condition_[ConditionEffect.CE_FIRST_BATCH] | _local10.bit_) == this.condition_[ConditionEffect.CE_FIRST_BATCH]) {
                           continue;
                        }
                        this.condition_[ConditionEffect.CE_FIRST_BATCH] = this.condition_[ConditionEffect.CE_FIRST_BATCH] | _local10.bit_;
                     } else {
                        if((this.condition_[ConditionEffect.CE_SECOND_BATCH] | _local10.bit_) == this.condition_[ConditionEffect.CE_SECOND_BATCH]) {
                           continue;
                        }
                        this.condition_[ConditionEffect.CE_SECOND_BATCH] = this.condition_[ConditionEffect.CE_SECOND_BATCH] | _local10.bit_;
                     }
                     _local14 = _local10.localizationKey_;
                     this.showConditionEffect(_local8,_local14);
                     _local8 = _local8 + 500;
                  }
               }
            }
         }
         var _local7:Vector.<uint> = BloodComposition.getBloodComposition(this.objectType_,this.texture_,this.props_.bloodProb_,this.props_.bloodColor_);
         if(this.dead_) {
            map_.addObj(new ExplosionEffect(_local7,this.size_,30),x_,y_);
         } else if(param5 != null) {
            map_.addObj(new HitEffect(_local7,this.size_,10,param5.angle_,param5.projProps_.speed_),x_,y_);
         } else {
            map_.addObj(new ExplosionEffect(_local7,this.size_,10),x_,y_);
         }
         if(param2 > 0) {
            _local15 = Boolean(this.isArmorBroken()) || param5 != null && Boolean(param5.projProps_.armorPiercing_) || Boolean(_local6);
            this.showDamageText(param2,_local15);
         }
      }

      public function showConditionEffect(param1:int, param2:String) : void {
         var _local3:LOEBUILD_862a0e20385d01174a45beed4b836305 = new LOEBUILD_862a0e20385d01174a45beed4b836305(this,16711680,3000,param1);
         _local3.setStringBuilder(new LineBuilder().setParams(param2));
         map_.mapOverlay_.addStatusText(_local3);
      }

      public function showConditionEffectPet(param1:int, param2:String) : void {
         var _local3:LOEBUILD_862a0e20385d01174a45beed4b836305 = new LOEBUILD_862a0e20385d01174a45beed4b836305(this,16711680,3000,param1);
         _local3.setStringBuilder(new StaticStringBuilder("Pet " + param2));
         map_.mapOverlay_.addStatusText(_local3);
      }

      public function showDamageText(param1:int, param2:Boolean) : void {
         var _local3:String = "-" + param1 + " HP";
         var _local4:LOEBUILD_862a0e20385d01174a45beed4b836305 = new LOEBUILD_862a0e20385d01174a45beed4b836305(this,!!param2?uint(9437439):uint(16711680),1000);
         _local4.setStringBuilder(new StaticStringBuilder(_local3));
         map_.mapOverlay_.addStatusText(_local4);
      }

      protected function makeNameBitmapData() : BitmapData {
         var _local1:StringBuilder = new StaticStringBuilder(this.name_);
         var _local2:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
         return _local2.make(_local1,16,16777215,true,IDENTITY_MATRIX,true);
      }

      public function drawName(param1:Vector.<IGraphicsData>, param2:Camera) : void {
         if(this.nameBitmapData_ == null) {
            this.nameBitmapData_ = this.makeNameBitmapData();
            this.nameFill_ = new GraphicsBitmapFill(null,new Matrix(),false,false);
            this.namePath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,new Vector.<Number>());
         }
         var _local3:int = this.nameBitmapData_.width / 2 + 1;
         var _local4:int = 30;
         var _local5:Vector.<Number> = this.namePath_.data;
         _local5.length = 0;
         _local5.push(posS_[0] - _local3,posS_[1],posS_[0] + _local3,posS_[1],posS_[0] + _local3,posS_[1] + _local4,posS_[0] - _local3,posS_[1] + _local4);
         this.nameFill_.bitmapData = this.nameBitmapData_;
         var _local6:Matrix = this.nameFill_.matrix;
         _local6.identity();
         _local6.translate(_local5[0],_local5[1]);
         param1.push(this.nameFill_);
         param1.push(this.namePath_);
         param1.push(GraphicsUtil.END_FILL);
      }

      protected function getHallucinatingTexture() : BitmapData {
         if(this.hallucinatingTexture_ == null) {
            this.hallucinatingTexture_ = AssetLibrary.getImageFromSet("lofiChar8x8",int(Math.random() * 239));
         }
         return this.hallucinatingTexture_;
      }

      protected function getTexture(param1:Camera, param2:int) : BitmapData {
         var _local6:Pet = null;
         var _local7:Number = NaN;
         var _local8:int = 0;
         var _local9:MaskedImage = null;
         var _local10:int = 0;
         var _local11:BitmapData = null;
         var _local12:int = 0;
         var _local13:BitmapData = null;
         if(this is Pet) {
            _local6 = Pet(this);
            if(this.condition_[ConditionEffect.CE_FIRST_BATCH] != 0 && !this.isPaused()) {
               if(_local6.skinId != 32912) {
                  _local6.setSkin(32912);
               }
            } else if(!_local6.isDefaultAnimatedChar) {
               _local6.setDefaultSkin();
            }
         }
         var _local3:BitmapData = this.texture_;
         var _local4:int = this.size_;
         var _local5:BitmapData = null;
         if(this.animatedChar_ != null) {
            _local7 = 0;
            _local8 = AnimatedChar.STAND;
            if(param2 < this.attackStart_ + ATTACK_PERIOD) {
               if(!this.props_.dontFaceAttacks_) {
                  this.facing_ = this.attackAngle_;
               }
               _local7 = (param2 - this.attackStart_) % ATTACK_PERIOD / ATTACK_PERIOD;
               _local8 = AnimatedChar.ATTACK;
            } else if(this.moveVec_.x != 0 || this.moveVec_.y != 0) {
               _local10 = 0.5 / this.moveVec_.length;
               _local10 = _local10 + (400 - _local10 % 400);
               if(this.moveVec_.x > ZERO_LIMIT || this.moveVec_.x < NEGATIVE_ZERO_LIMIT || this.moveVec_.y > ZERO_LIMIT || this.moveVec_.y < NEGATIVE_ZERO_LIMIT) {
                  this.facing_ = Math.atan2(this.moveVec_.y,this.moveVec_.x);
                  _local8 = AnimatedChar.WALK;
               } else {
                  _local8 = AnimatedChar.STAND;
               }
               _local7 = param2 % _local10 / _local10;
            }
            _local9 = this.animatedChar_.imageFromFacing(this.facing_,param1,_local8,_local7);
            _local3 = _local9.image_;
            _local5 = _local9.mask_;
         } else if(this.animations_ != null) {
            _local11 = this.animations_.getTexture(param2);
            if(_local11 != null) {
               _local3 = _local11;
            }
         }
         if(Boolean(this.props_.drawOnGround_) || this.obj3D_ != null) {
            return _local3;
         }
         if(param1.isHallucinating_) {
            _local12 = _local3 == null?8:int(_local3.width);
            _local3 = this.getHallucinatingTexture();
            _local5 = null;
            _local4 = this.size_ * Math.min(1.5,_local12 / _local3.width);
         }
         if(Boolean(this.isCursed()) && !(this is Pet)) {
            _local3 = CachingColorTransformer.filterBitmapData(_local3,CURSED_FILTER);
         }
         if((Boolean(this.isStasis()) || Boolean(this.isPetrified())) && !(this is Pet)) {
            _local3 = CachingColorTransformer.filterBitmapData(_local3,PAUSED_FILTER);
         }
         if(this.tex1Id_ == 0 && this.tex2Id_ == 0) {
            _local3 = TextureRedrawer.redraw(_local3,_local4,false,0);
         } else {
            _local13 = null;
            if(this.texturingCache_ == null) {
               this.texturingCache_ = new Dictionary();
            } else {
               _local13 = this.texturingCache_[_local3];
            }
            if(_local13 == null) {
               _local13 = TextureRedrawer.resize(_local3,_local5,_local4,false,this.tex1Id_,this.tex2Id_);
               _local13 = GlowRedrawer.outlineGlow(_local13,0);
               this.texturingCache_[_local3] = _local13;
            }
            _local3 = _local13;
         }
         return _local3;
      }

      public function useAltTexture(param1:String, param2:int) : void {
         this.texture_ = AssetLibrary.getImageFromSet(param1,param2);
         this.sizeMult_ = this.texture_.height / 8;
      }

      public function getPortrait() : BitmapData {
         var _local1:BitmapData = null;
         var _local2:int = 0;
         if(this.portrait_ == null) {
            _local1 = this.props_.portrait_ != null?this.props_.portrait_.getTexture():this.texture_;
            _local2 = 4 / _local1.width * 100;
            this.portrait_ = TextureRedrawer.resize(_local1,this.mask_,_local2,true,this.tex1Id_,this.tex2Id_);
            this.portrait_ = GlowRedrawer.outlineGlow(this.portrait_,0);
         }
         return this.portrait_;
      }

      public function setAttack(param1:int, param2:Number) : void {
         this.attackAngle_ = param2;
         this.attackStart_ = getTimer();
      }

      override public function draw3d(param1:Vector.<Object3DStage3D>) : void {
         if(this.object3d_ != null) {
            param1.push(this.object3d_);
         }
      }
    private var foregroundPath:Vector.<GraphicsPath> = null;

    private var backgroundFill:Vector.<GraphicsSolidFill> = null;

    private var foregroundFill:Vector.<GraphicsSolidFill> = null;

    private var backgroundPath:Vector.<GraphicsPath> = null;

    private var HP_BAR:int = 0;

    private var MP_BAR:int = 1;

    public var maxHp_:int = 200;

    public var hpp_:int = 200;

    public static function green2red(param1:int) : int
    {
        if(param1 > 50)
        {
            return 65280 + 327680 * int(100 - param1);
        }
        return 16776960 - 1280 * int(50 - param1);
    }

    public var _P_c:Vector.<Number>;

      protected function drawHpBar(param1:Vector.<IGraphicsData>, param2:int) : void {
         var _local7:Number = NaN;
         var _local8:Number = NaN;
         if(this.hpbarPath_ == null) {
            this.hpbarBackFill_ = new GraphicsSolidFill();
            this.hpbarBackPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,new Vector.<Number>());
            this.hpbarFill_ = new GraphicsSolidFill(TextKey.HUD_HP_);
            this.hpbarPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,new Vector.<Number>());
         }
         var _local3:Number = this.maxHP_;
         if(this.hp_ <= _local3) {
            _local7 = (_local3 - this.hp_) / _local3;
            this.hpbarBackFill_.color = MoreColorUtil.lerpColor(2368548,16711680,Math.abs(Math.sin(param2 / 300)) * _local7);
         } else {
            this.hpbarBackFill_.color = 2368548;
         }
         var _local4:int = 40; //width
         var _local5:int = 3; //position
         var _local6:int = 8; //height
         var _PushVar:Vector.<Number> = this.hpbarBackPath_.data as Vector.<Number>;
         _PushVar.length = 0;
         _PushVar.push(posS_[0] - _local4,posS_[1] + _local5,posS_[0] + _local4,posS_[1] + _local5,posS_[0] + _local4,posS_[1] + _local5 + _local6,posS_[0] - _local4,posS_[1] + _local5 + _local6);
         param1.push(this.hpbarBackFill_);
         param1.push(this.hpbarBackPath_);
         param1.push(GraphicsUtil.END_FILL);
         if(this.hp_ > 0) {
            _local8 = this.hp_ / this.maxHP_ * 2 * _local4;
            var _PullVar:Vector.<Number> = this.hpbarPath_.data as Vector.<Number>;
            _PullVar.length = 0;
            _PullVar.push(
                    posS_[0] - _local4,
                    posS_[1] + _local5,
                    posS_[0] - _local4 + _local8,
                    posS_[1] + _local5,
                    posS_[0] - _local4 + _local8,
                    posS_[1] + _local5 + _local6,
                    posS_[0] - _local4,
                    posS_[1] + _local5 + _local6);
            param1.push(this.hpbarFill_);
            param1.push(this.hpbarPath_);
            param1.push(GraphicsUtil.END_FILL);
         }
         GraphicsFillExtra.setSoftwareDrawSolid(this.hpbarFill_,true);
         GraphicsFillExtra.setSoftwareDrawSolid(this.hpbarBackFill_,true);
      }

      override public function draw(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : void {
         var _local8:BitmapData = null;
         var _local9:uint = 0;
         var _local10:uint = 0;
         var _local4:BitmapData = this.getTexture(param2,param3);
         if(this.props_.drawOnGround_) {
            if(square_.faces_.length == 0) {
               return;
            }
            this.path_.data = square_.faces_[0].face_.vout_;
            this.bitmapFill_.bitmapData = _local4;
            square_.baseTexMatrix_.calculateTextureMatrix(this.path_.data);
            this.bitmapFill_.matrix = square_.baseTexMatrix_.tToS_;
            param1.push(this.bitmapFill_);
            param1.push(this.path_);
            param1.push(GraphicsUtil.END_FILL);
            return;
         }
         if(this.obj3D_ != null && !LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            this.obj3D_.draw(param1,param2,this.props_.color_,_local4);
            return;
         }
         if(this.obj3D_ != null && Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender())) {
            param1.push(null);
            return;
         }
         var _local5:int = _local4.width;
         var _local6:int = _local4.height;
         var _local7:int = square_.sink_ + this.sinkLevel_;
         if(_local7 > 0 && (Boolean(this.flying_) || square_.obj_ != null && Boolean(square_.obj_.props_.protectFromSink_))) {
            _local7 = 0;
         }
         if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            if(_local7 != 0) {
               GraphicsFillExtra.setSinkLevel(this.bitmapFill_,Math.max(_local7 / _local6 * 1.65 - 0.02,0));
               _local7 = -_local7 + 0.02;
            } else if(_local7 == 0 && GraphicsFillExtra.getSinkLevel(this.bitmapFill_) != 0) {
               GraphicsFillExtra.clearSink(this.bitmapFill_);
            }
         }
         this.vS_.length = 0;
         this.vS_.push(posS_[3] - _local5 / 2,posS_[4] - _local6 + _local7,posS_[3] + _local5 / 2,posS_[4] - _local6 + _local7,posS_[3] + _local5 / 2,posS_[4],posS_[3] - _local5 / 2,posS_[4]);
         this.path_.data = this.vS_;
         if(this.flash_ != null) {
            if(!this.flash_.doneAt(param3)) {
               if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
                  this.flash_.applyGPUTextureColorTransform(_local4,param3);
               } else {
                  _local4 = this.flash_.apply(_local4,param3);
               }
            } else {
               this.flash_ = null;
            }
         }
         if(Boolean(this.isShocked) && !this.isShockedTransformSet) {
            if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
               GraphicsFillExtra.setColorTransform(_local4,new ColorTransform(-1,-1,-1,1,255,255,255,0));
            } else {
               _local8 = _local4.clone();
               _local8.colorTransform(_local8.rect,new ColorTransform(-1,-1,-1,1,255,255,255,0));
               _local8 = CachingColorTransformer.filterBitmapData(_local8,new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix));
               _local4 = _local8;
            }
            this.isShockedTransformSet = true;
         }
         if(Boolean(this.isCharging) && !this.isChargingTransformSet) {
            if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
               GraphicsFillExtra.setColorTransform(_local4,new ColorTransform(1,1,1,1,255,255,255,0));
            } else {
               _local8 = _local4.clone();
               _local8.colorTransform(_local8.rect,new ColorTransform(1,1,1,1,255,255,255,0));
               _local4 = _local8;
            }
            this.isChargingTransformSet = true;
         }
         this.bitmapFill_.bitmapData = _local4;
         this.fillMatrix_.identity();
         this.fillMatrix_.translate(this.vS_[0],this.vS_[1]);
         this.bitmapFill_.matrix = this.fillMatrix_;
         param1.push(this.bitmapFill_);
         param1.push(this.path_);
         param1.push(GraphicsUtil.END_FILL);
         if(Boolean(!this.isPaused() && (this.condition_[ConditionEffect.CE_FIRST_BATCH] || this.condition_[ConditionEffect.CE_SECOND_BATCH])) && Boolean(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.screenShotMode_) && !(this is Pet)) {
            this.drawConditionIcons(param1,param2,param3);
         }
         if(Boolean(this.props_.showName_) && this.name_ != null && this.name_.length != 0) {
            this.drawName(param1,param2);
         }
         if(Boolean(this.props_ && this.props_.plr_ && !this.isInvisible()) && Boolean(!this.isInvulnerable()) && !this.props_.noMiniMap_) {
            _local9 = _local4.getPixel32(_local4.width / 4,_local4.height / 4) | _local4.getPixel32(_local4.width / 2,_local4.height / 2) | _local4.getPixel32(_local4.width * 3 / 4,_local4.height * 3 / 4);
            _local10 = _local9 >> 24;
            if(_local10 != 0) {
               hasShadow_ = true;
               if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.HPBar) {
                  this.drawHpBar(param1,param3);
               }
            } else {
                hasShadow_ = false;
            }
         }/*else if(Boolean(this.props_ && this.props_.nm_ && !this.isInvisible()) && Boolean(!this.isInvulnerable()) && !this.props_.noMiniMap_) {
              _local9 = _local4.getPixel32(_local4.width / 4,_local4.height / 4) | _local4.getPixel32(_local4.width / 2,_local4.height / 2) | _local4.getPixel32(_local4.width * 3 / 4,_local4.height * 3 / 4);
              _local10 = _local9 >> 24;
              if(_local10 != 0) {
                  hasShadow_ = true;
                  if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.HPBar) {
                      this.drawBarEnemy(param1,hp_,maxHp_,this.HP_BAR,16711680,3,3);
                  }
              } else {
                  hasShadow_ = false;
              }
         }*/
      }

      public function drawConditionIcons(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : void {
         var _local9:BitmapData = null;
         var _local10:GraphicsBitmapFill = null;
         var _local11:GraphicsPath = null;
         var _local12:Number = NaN;
         var _local13:Number = NaN;
         var _local14:Matrix = null;
         if(this.icons_ == null) {
            this.icons_ = new Vector.<BitmapData>();
            this.iconFills_ = new Vector.<GraphicsBitmapFill>();
            this.iconPaths_ = new Vector.<GraphicsPath>();
         }
         this.icons_.length = 0;
         var _local4:int = param3 / 500;
         ConditionEffect.getConditionEffectIcons(this.condition_[ConditionEffect.CE_FIRST_BATCH],this.icons_,_local4);
         ConditionEffect.getConditionEffectIcons2(this.condition_[ConditionEffect.CE_SECOND_BATCH],this.icons_,_local4);
         var _local5:Number = posS_[3];
         var _local6:Number = this.vS_[1];
         var _local7:int = this.icons_.length;
         var _local8:int = 0;
         while(_local8 < _local7) {
            _local9 = this.icons_[_local8];
            if(_local8 >= this.iconFills_.length) {
               this.iconFills_.push(new GraphicsBitmapFill(null,new Matrix(),false,false));
               this.iconPaths_.push(new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,new Vector.<Number>()));
            }
            _local10 = this.iconFills_[_local8];
            _local11 = this.iconPaths_[_local8];
            _local10.bitmapData = _local9;
            _local12 = _local5 - _local9.width * _local7 / 2 + _local8 * _local9.width;
            _local13 = _local6 - _local9.height / 2;
            _local11.data.length = 0;
            _local11.data.push(_local12,_local13,_local12 + _local9.width,_local13,_local12 + _local9.width,_local13 + _local9.height,_local12,_local13 + _local9.height);
            _local14 = _local10.matrix;
            _local14.identity();
            _local14.translate(_local12,_local13);
            param1.push(_local10);
            param1.push(_local11);
            param1.push(GraphicsUtil.END_FILL);
            _local8++;
         }
      }

      override public function drawShadow(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : void {
         if(this.shadowGradientFill_ == null) {
            this.shadowGradientFill_ = new GraphicsGradientFill(GradientType.RADIAL,[this.props_.shadowColor_,this.props_.shadowColor_],[0.5,0],null,new Matrix());
            this.shadowPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,new Vector.<Number>());
         }
         var _local4:Number = this.size_ / 100 * (this.props_.shadowSize_ / 100) * this.sizeMult_;
         var _local5:Number = 30 * _local4;
         var _local6:Number = 15 * _local4;
         this.shadowGradientFill_.matrix.createGradientBox(_local5 * 2,_local6 * 2,0,posS_[0] - _local5,posS_[1] - _local6);
         param1.push(this.shadowGradientFill_);
         var _local7:Vector.<Number> = this.shadowPath_.data as Vector.<Number>;
          _local7.length = 0;
          _local7.push(posS_[0] - _local5,posS_[1] - _local6,posS_[0] + _local5,posS_[1] - _local6,posS_[0] + _local5,posS_[1] + _local6,posS_[0] - _local5,posS_[1] + _local6);
         param1.push(this.shadowPath_);
         param1.push(GraphicsUtil.END_FILL);
      }

      public function toString() : String {
         return "[" + getQualifiedClassName(this) + " id: " + objectId_ + " MsgType: " + LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToDisplayId_[this.objectType_] + " pos: " + x_ + ", " + y_ + "]";
      }
   }
}
