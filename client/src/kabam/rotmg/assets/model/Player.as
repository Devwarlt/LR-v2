package kabam.rotmg.assets.model {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.*;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.map.LOEBUILD_4a218ca1436fee34076fdca93698bac4.LOEBUILD_862a0e20385d01174a45beed4b836305;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.HealingEffect;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles.LevelUpEffect;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.tutorial.Tutorial;
import com.company.assembleegameclient.tutorial.doneAction;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.ConditionEffect;
import com.company.assembleegameclient.util.FameUtil;
import com.company.assembleegameclient.util.FreeList;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.CachingColorTransformer;
import com.company.util.ConversionUtil;
import com.company.util.GraphicsUtil;
import com.company.util.IntPoint;
import com.company.util.MoreColorUtil;
import com.company.util.PointUtil;
import com.company.util.Trig;

import flash.display.BitmapData;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import flash.utils.getTimer;

import kabam.rotmg.errors.control.LOEBUILD_5c3fafb478917eee32f80d979a87cb36;

import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.constants.ActivationType;
import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.constants.UseType;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.model.PotionInventoryModel;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.game.view.components.QueuedStatusText;
import kabam.rotmg.stage3D.GraphicsFillExtra;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.ui.model.TabStripModel;

import org.swiftsuspenders.Injector;

public class Player extends Character {

    public static const MS_BETWEEN_TELEPORT:int = 10000;

    private static const MOVE_THRESHOLD:Number = 0.4;

    public static var isAdmin:Boolean = false;

    private static const NEARBY:Vector.<Point> = new <Point>[new Point(0, 0), new Point(1, 0), new Point(0, 1), new Point(1, 1)];

    private static var newP:Point = new Point();

    private static const RANK_OFFSET_MATRIX:Matrix = new Matrix(1, 0, 0, 1, 2, 2);

    private static const NAME_OFFSET_MATRIX:Matrix = new Matrix(1, 0, 0, 1, 20, 1);

    private static const MIN_MOVE_SPEED:Number = 0.004;

    private static const MAX_MOVE_SPEED:Number = 0.0096;

    private static const MIN_ATTACK_FREQ:Number = 0.0015;

    private static const MAX_ATTACK_FREQ:Number = 0.008;

    private static const MIN_ATTACK_MULT:Number = 0.5;

    private static const MAX_ATTACK_MULT:Number = 2;

    public var xpTimer:int;

    public var skinId:int;

    public var skin:AnimatedChar;

    public var isShooting:Boolean;

    public var accountId_:String = "";

    public var credits_:int = 0;

    public var tokens_:int = 0;

    public var numStars_:int = 0;

    public var fame_:int = 0;

    public var nameChosen_:Boolean = false;

    public var currFame_:int = 0;

    public var nextClassQuestFame_:int = -1;

    public var legendaryRank_:int = -1;

    public var guildName_:String = null;

    public var guildRank_:int = -1;

    public var isFellowGuild_:Boolean = false;

    public var breath_:int = -1;

    public var maxMP_:int = 200;

    public var mp_:Number = 0;

    public var nextLevelExp_:int = 1000;

    public var exp_:int = 0;

    public var attack_:int = 0;

    public var speed_:int = 0;

    public var dexterity_:int = 0;

    public var vitality_:int = 0;

    public var wisdom_:int = 0;

    public var maxHPBoost_:int = 0;

    public var maxMPBoost_:int = 0;

    public var attackBoost_:int = 0;

    public var defenseBoost_:int = 0;

    public var speedBoost_:int = 0;

    public var vitalityBoost_:int = 0;

    public var wisdomBoost_:int = 0;

    public var dexterityBoost_:int = 0;

    public var xpBoost_:int = 0;

    public var healthPotionCount_:int = 0;

    public var magicPotionCount_:int = 0;

    public var attackMax_:int = 0;

    public var defenseMax_:int = 0;

    public var speedMax_:int = 0;

    public var dexterityMax_:int = 0;

    public var vitalityMax_:int = 0;

    public var wisdomMax_:int = 0;

    public var maxHPMax_:int = 0;

    public var maxMPMax_:int = 0;

    public var hasBackpack_:Boolean = false;

    public var starred_:Boolean = false;

    public var ignored_:Boolean = false;

    public var distSqFromThisPlayer_:Number = 0;

    protected var rotate_:Number = 0;

    protected var relMoveVec_:Point = null;

    protected var moveMultiplier_:Number = 1;

    public var attackPeriod_:int = 0;

    public var nextAltAttack_:int = 0;

    public var nextTeleportAt_:int = 0;

    public var dropBoost:int = 0;

    public var tierBoost:int = 0;

    protected var healingEffect_:HealingEffect = null;

    protected var nearestMerchant_:Merchant = null;

    public var isDefaultAnimatedChar:Boolean = true;

    public var projectileIdSetOverrideNew:String = "";

    public var projectileIdSetOverrideOld:String = "";

    private var addTextLine:AddTextLineSignal;

    private var factory:CharacterFactory;

    private var ip_:IntPoint;

    private var breathBackFill_:GraphicsSolidFill = null;

    private var breathBackPath_:GraphicsPath = null;

    private var breathFill_:GraphicsSolidFill = null;

    private var breathPath_:GraphicsPath = null;

    public function Player(param1:XML) {
        this.ip_ = new IntPoint();
        var _local2:Injector = StaticInjectorContext.getInjector();
        this.addTextLine = _local2.getInstance(AddTextLineSignal);
        this.factory = _local2.getInstance(CharacterFactory);
        super(param1);
        this.attackMax_ = int(param1.Attack.@max);
        this.defenseMax_ = int(param1.Defense.@max);
        this.speedMax_ = int(param1.Speed.@max);
        this.dexterityMax_ = int(param1.Dexterity.@max);
        this.vitalityMax_ = int(param1.HpRegen.@max);
        this.wisdomMax_ = int(param1.MpRegen.@max);
        this.maxHPMax_ = int(param1.MaxHitPoints.@max);
        this.maxMPMax_ = int(param1.MaxMagicPoints.@max);
        texturingCache_ = new Dictionary();
    }

    public static function fromPlayerXML(param1:String, param2:XML):Player {
        var _local3:int = int(param2.ObjectType);
        var _local4:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[_local3];
        var _local5:Player = new Player(_local4);
        _local5.name_ = param1;
        _local5.level_ = int(param2.Level);
        _local5.exp_ = int(param2.Exp);
        _local5.equipment_ = ConversionUtil.toIntVector(param2.Equipment);
        _local5.maxHP_ = int(param2.MaxHitPoints);
        _local5.hp_ = int(param2.HitPoints);
        _local5.maxMP_ = int(param2.MaxMagicPoints);
        _local5.mp_ = int(param2.MagicPoints);
        _local5.attack_ = int(param2.Attack);
        _local5.defense_ = int(param2.Defense);
        _local5.speed_ = int(param2.Speed);
        _local5.dexterity_ = int(param2.Dexterity);
        _local5.vitality_ = int(param2.HpRegen);
        _local5.wisdom_ = int(param2.MpRegen);
        _local5.tex1Id_ = int(param2.Tex1);
        _local5.tex2Id_ = int(param2.Tex2);
        return _local5;
    }

    public function setRelativeMovement(param1:Number, param2:Number, param3:Number):void {
        var _local4:Number = NaN;
        if (this.relMoveVec_ == null) {
            this.relMoveVec_ = new Point();
        }
        this.rotate_ = param1;
        this.relMoveVec_.x = param2;
        this.relMoveVec_.y = param3;
        if (isConfused()) {
            _local4 = this.relMoveVec_.x;
            this.relMoveVec_.x = -this.relMoveVec_.y;
            this.relMoveVec_.y = -_local4;
            this.rotate_ = -this.rotate_;
        }
    }

    public function setCredits(param1:int):void {
        this.credits_ = param1;
    }

    public function setTokens(param1:int):void {
        this.tokens_ = param1;
    }

    public function setGuildName(param1:String):void {
        var _local3:GameObject = null;
        var _local4:Player = null;
        var _local5:Boolean = false;
        this.guildName_ = param1;
        var _local2:Player = map_.player_;
        if (_local2 == this) {
            for each(_local3 in map_.goDict_) {
                _local4 = _local3 as Player;
                if (_local4 != null && _local4 != this) {
                    _local4.setGuildName(_local4.guildName_);
                }
            }
        } else {
            _local5 = _local2 != null && _local2.guildName_ != null && _local2.guildName_ != "" && _local2.guildName_ == this.guildName_;
            if (_local5 != this.isFellowGuild_) {
                this.isFellowGuild_ = _local5;
                nameBitmapData_ = null;
            }
        }
    }

    public static function isTeleportEligible(param1:Player):Boolean {
        return !(Boolean(param1.isPaused()) || Boolean(param1.isInvisible()));
    }

    public function msUtilTeleport():int {
        var _local1:int = getTimer();
        return Math.max(0, this.nextTeleportAt_ - _local1);
    }

    public function teleportTo(param1:Player):Boolean {
        if (isPaused()) {
            this.addTextLine.dispatch(makeErrorMessage(TextKey.PLAYER_NOTELEPORTWHILEPAUSED));
            return false;
        }
        var _local2:int = this.msUtilTeleport();
        if (_local2 > 0) {
            this.addTextLine.dispatch(makeErrorMessage(TextKey.PLAYER_TELEPORT_COOLDOWN, {"seconds": int(_local2 / 1000 + 1)}));
            return false;
        }
        if (!isTeleportEligible(param1)) {
            if (param1.isInvisible()) {
                this.addTextLine.dispatch(makeErrorMessage(TextKey.TELEPORT_INVISIBLE_PLAYER, {"player": param1.name_}));
            } else {
                this.addTextLine.dispatch(makeErrorMessage(TextKey.PLAYER_TELEPORT_TO_PLAYER, {"player": param1.name_}));
            }
            return false;
        }
        map_.gs_.gsc_.teleport(param1.objectId_);
        this.nextTeleportAt_ = getTimer() + MS_BETWEEN_TELEPORT;
        return true;
    }

    private static function makeErrorMessage(param1:String, param2:Object = null):ChatMessage {
        return ChatMessage.make(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ERROR_CHAT_NAME, param1, -1, -1, "", false, param2);
    }

    public function levelUpEffect(param1:String, param2:Boolean = true):void {
        if (param2) {
            this.levelUpParticleEffect();
        }
        var _local3:QueuedStatusText = new QueuedStatusText(this, new LineBuilder().setParams(param1), 65280, 2000);
        map_.mapOverlay_.addQueuedText(_local3);
    }

    public function handleLevelUp(param1:Boolean):void {
        SoundEffectLibrary.play("level_up");
        if (param1) {
            this.levelUpEffect(TextKey.PLAYER_NEWCLASSUNLOCKED, false);
            this.levelUpEffect(TextKey.PLAYER_LEVELUP);
        } else {
            this.levelUpEffect(TextKey.PLAYER_LEVELUP);
        }
    }

    public function levelUpParticleEffect(param1:uint = 4.27825536E9):void {
        map_.addObj(new LevelUpEffect(this, param1, 20), x_, y_);
    }

    public function handleExpUp(param1:int):void {
        /*if (level_ == 20) {
            return;
        }*/
        var _local2:LOEBUILD_862a0e20385d01174a45beed4b836305 = new LOEBUILD_862a0e20385d01174a45beed4b836305(this, 65280, 1000);
        _local2.setStringBuilder(new LineBuilder().setParams(TextKey.PLAYER_EXP, {"exp": param1}));
        map_.mapOverlay_.addStatusText(_local2);
    }

    private function getNearbyMerchant():Merchant {
        var _local3:Point;
        var _local4:Merchant;
        var _local1:int = x_ - int(x_) > 0.5 ? 1 : -1;
        var _local2:int = y_ - int(y_) > 0.5 ? 1 : -1;
        for each(_local3 in NEARBY) {
            this.ip_.x_ = x_ + _local1 * _local3.x;
            this.ip_.y_ = y_ + _local2 * _local3.y;
            _local4 = map_.merchLookup_[this.ip_];
            if (_local4 != null) {
                return PointUtil.distanceSquaredXY(_local4.x_, _local4.y_, x_, y_) < 1 ? _local4 : null;
            }
        }
        return null;
    }

    public function walkTo(param1:Number, param2:Number):Boolean {
        this.modifyMove(param1, param2, newP);
        return this.moveTo(newP.x, newP.y);
    }

    override public function moveTo(param1:Number, param2:Number):Boolean {
        var _local3:Boolean = super.moveTo(param1, param2);
        if (map_.gs_.evalIsNotInCombatMapArea()) {
            this.nearestMerchant_ = this.getNearbyMerchant();
        }
        return _local3;
    }

    public function modifyMove(param1:Number, param2:Number, param3:Point):void {
        if (Boolean(isParalyzed()) || Boolean(isPetrified())) {
            param3.x = x_;
            param3.y = y_;
            return;
        }
        var _local4:Number = param1 - x_;
        var _local5:Number = param2 - y_;
        if (_local4 < MOVE_THRESHOLD && _local4 > -MOVE_THRESHOLD && _local5 < MOVE_THRESHOLD && _local5 > -MOVE_THRESHOLD) {
            this.modifyStep(param1, param2, param3);
            return;
        }
        var _local6:Number = MOVE_THRESHOLD / Math.max(Math.abs(_local4), Math.abs(_local5));
        var _local7:Number = 0;
        param3.x = x_;
        param3.y = y_;
        var _local8:Boolean = false;
        while (!_local8) {
            if (_local7 + _local6 >= 1) {
                _local6 = 1 - _local7;
                _local8 = true;
            }
            this.modifyStep(param3.x + _local4 * _local6, param3.y + _local5 * _local6, param3);
            _local7 = _local7 + _local6;
        }
    }

    public function modifyStep(param1:Number, param2:Number, param3:Point):void {
        var _local6:Number = NaN;
        var _local7:Number = NaN;
        var _local4:Boolean = x_ % 0.5 == 0 && param1 != x_ || int(x_ / 0.5) != int(param1 / 0.5);
        var _local5:Boolean = y_ % 0.5 == 0 && param2 != y_ || int(y_ / 0.5) != int(param2 / 0.5);
        if (!_local4 && !_local5 || Boolean(this.isValidPosition(param1, param2))) {
            param3.x = param1;
            param3.y = param2;
            return;
        }
        if (_local4) {
            _local6 = param1 > x_ ? Number(int(param1 * 2) / 2) : Number(int(x_ * 2) / 2);
            if (int(_local6) > int(x_)) {
                _local6 = _local6 - 0.01;
            }
        }
        if (_local5) {
            _local7 = param2 > y_ ? Number(int(param2 * 2) / 2) : Number(int(y_ * 2) / 2);
            if (int(_local7) > int(y_)) {
                _local7 = _local7 - 0.01;
            }
        }
        if (!_local4) {
            param3.x = param1;
            param3.y = _local7;
            if (square_ != null && square_.props_.slideAmount_ != 0) {
                this.resetMoveVector(false);
            }
            return;
        }
        if (!_local5) {
            param3.x = _local6;
            param3.y = param2;
            if (square_ != null && square_.props_.slideAmount_ != 0) {
                this.resetMoveVector(true);
            }
            return;
        }
        var _local8:Number = param1 > x_ ? Number(param1 - _local6) : Number(_local6 - param1);
        var _local9:Number = param2 > y_ ? Number(param2 - _local7) : Number(_local7 - param2);
        if (_local8 > _local9) {
            if (this.isValidPosition(param1, _local7)) {
                param3.x = param1;
                param3.y = _local7;
                return;
            }
            if (this.isValidPosition(_local6, param2)) {
                param3.x = _local6;
                param3.y = param2;
                return;
            }
        } else {
            if (this.isValidPosition(_local6, param2)) {
                param3.x = _local6;
                param3.y = param2;
                return;
            }
            if (this.isValidPosition(param1, _local7)) {
                param3.x = param1;
                param3.y = _local7;
                return;
            }
        }
        param3.x = _local6;
        param3.y = _local7;
    }

    private function resetMoveVector(param1:Boolean):void {
        moveVec_.scaleBy(-0.5);
        if (param1) {
            moveVec_.y = moveVec_.y * -1;
        } else {
            moveVec_.x = moveVec_.x * -1;
        }
    }

    public function isValidPosition(param1:Number, param2:Number):Boolean {
        var _local3:Square = map_.getSquare(param1, param2);
        if (square_ != _local3 && (_local3 == null || !_local3.isWalkable())) {
            return false;
        }
        var _local4:Number = param1 - int(param1);
        var _local5:Number = param2 - int(param2);
        if (_local4 < 0.5) {
            if (this.isFullOccupy(param1 - 1, param2)) {
                return false;
            }
            if (_local5 < 0.5) {
                if (Boolean(this.isFullOccupy(param1, param2 - 1)) || Boolean(this.isFullOccupy(param1 - 1, param2 - 1))) {
                    return false;
                }
            } else if (_local5 > 0.5) {
                if (Boolean(this.isFullOccupy(param1, param2 + 1)) || Boolean(this.isFullOccupy(param1 - 1, param2 + 1))) {
                    return false;
                }
            }
        } else if (_local4 > 0.5) {
            if (this.isFullOccupy(param1 + 1, param2)) {
                return false;
            }
            if (_local5 < 0.5) {
                if (Boolean(this.isFullOccupy(param1, param2 - 1)) || Boolean(this.isFullOccupy(param1 + 1, param2 - 1))) {
                    return false;
                }
            } else if (_local5 > 0.5) {
                if (Boolean(this.isFullOccupy(param1, param2 + 1)) || Boolean(this.isFullOccupy(param1 + 1, param2 + 1))) {
                    return false;
                }
            }
        } else if (_local5 < 0.5) {
            if (this.isFullOccupy(param1, param2 - 1)) {
                return false;
            }
        } else if (_local5 > 0.5) {
            if (this.isFullOccupy(param1, param2 + 1)) {
                return false;
            }
        }
        return true;
    }

    public function isFullOccupy(param1:Number, param2:Number):Boolean {
        var _local3:Square = map_.lookupSquare(param1, param2);
        return _local3 == null || _local3.tileType_ == 255 || _local3.obj_ != null && Boolean(_local3.obj_.props_.fullOccupy_);
    }

    override public function update(param1:int, param2:int):Boolean {
        var _local3:Number = NaN;
        var _local4:Number = NaN;
        var _local5:Number = NaN;
        var _local6:Vector3D = null;
        var _local7:Number = NaN;
        var _local8:int = 0;
        var _local9:Vector.<uint> = null;
        if (Boolean(this.tierBoost) && !isPaused()) {
            this.tierBoost = this.tierBoost - param2;
            if (this.tierBoost < 0) {
                this.tierBoost = 0;
            }
        }
        if (Boolean(this.dropBoost) && !isPaused()) {
            this.dropBoost = this.dropBoost - param2;
            if (this.dropBoost < 0) {
                this.dropBoost = 0;
            }
        }
        if (Boolean(this.xpTimer) && !isPaused()) {
            this.xpTimer = this.xpTimer - param2;
            if (this.xpTimer < 0) {
                this.xpTimer = 0;
            }
        }
        if (Boolean(isHealing()) && !isPaused()) {
            if (this.healingEffect_ == null) {
                this.healingEffect_ = new HealingEffect(this);
                map_.addObj(this.healingEffect_, x_, y_);
            }
        } else if (this.healingEffect_ != null) {
            map_.removeObj(this.healingEffect_.objectId_);
            this.healingEffect_ = null;
        }
        if (map_.player_ == this && Boolean(isPaused())) {
            return true;
        }
        if (this.relMoveVec_ != null) {
            _local3 = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.cameraAngle;
            if (this.rotate_ != 0) {
                _local3 = _local3 + param2 * LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.PLAYER_ROTATE_SPEED * this.rotate_;
                LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.cameraAngle = _local3;
            }
            if (this.relMoveVec_.x != 0 || this.relMoveVec_.y != 0) {
                _local4 = this.getMoveSpeed();
                _local5 = Math.atan2(this.relMoveVec_.y, this.relMoveVec_.x);
                if (square_.props_.slideAmount_ > 0) {
                    _local6 = new Vector3D();
                    _local6.x = _local4 * Math.cos(_local3 + _local5);
                    _local6.y = _local4 * Math.sin(_local3 + _local5);
                    _local6.z = 0;
                    _local7 = _local6.length;
                    _local6.scaleBy(-1 * (square_.props_.slideAmount_ - 1));
                    moveVec_.scaleBy(square_.props_.slideAmount_);
                    if (moveVec_.length < _local7) {
                        moveVec_ = moveVec_.add(_local6);
                    }
                } else {
                    moveVec_.x = _local4 * Math.cos(_local3 + _local5);
                    moveVec_.y = _local4 * Math.sin(_local3 + _local5);
                }
            } else if (moveVec_.length > 0.00012 && square_.props_.slideAmount_ > 0) {
                moveVec_.scaleBy(square_.props_.slideAmount_);
            } else {
                moveVec_.x = 0;
                moveVec_.y = 0;
            }
            if (square_ != null && Boolean(square_.props_.push_)) {
                moveVec_.x = moveVec_.x - square_.props_.animate_.dx_ / 1000;
                moveVec_.y = moveVec_.y - square_.props_.animate_.dy_ / 1000;
            }
            this.walkTo(x_ + param2 * moveVec_.x, y_ + param2 * moveVec_.y);
        } else if (!super.update(param1, param2)) {
            return false;
        }
        if (map_.player_ == this && square_.props_.maxDamage_ > 0 && square_.lastDamage_ + 500 < param1 && !isInvincible() && (square_.obj_ == null || !square_.obj_.props_.protectFromGroundDamage_)) {
            _local8 = map_.gs_.gsc_.getNextDamage(square_.props_.minDamage_, square_.props_.maxDamage_);
            _local9 = new Vector.<uint>();
            _local9.push(ConditionEffect.GROUND_DAMAGE);
            damage(-1, _local8, _local9, hp_ <= _local8, null);
            map_.gs_.gsc_.groundDamage(param1, x_, y_);
            square_.lastDamage_ = param1;
        }
        return true;
    }

    public function onMove():void {
        if (map_ == null) {
            return;
        }
        var _local1:Square = map_.getSquare(x_, y_);
        if (_local1.props_.sinking_) {
            sinkLevel_ = Math.min(sinkLevel_ + 1, LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.MAX_SINK_LEVEL);
            this.moveMultiplier_ = 0.1 + (1 - sinkLevel_ / LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.MAX_SINK_LEVEL) * (_local1.props_.speed_ - 0.1);
        } else {
            sinkLevel_ = 0;
            this.moveMultiplier_ = _local1.props_.speed_;
        }
    }

    override protected function makeNameBitmapData():BitmapData {
        var _local1:StringBuilder = new StaticStringBuilder(name_);
        var _local2:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
        var _local3:BitmapData = _local2.make(_local1, 16, this.getNameColor(), true, NAME_OFFSET_MATRIX, true);
        _local3.draw(FameUtil.numStarsToIcon(this.numStars_), RANK_OFFSET_MATRIX);
        return _local3;
    }

    private function getNameColor():uint {
        if (this.isFellowGuild_)
            return LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.FELLOW_GUILD_COLOR;

        if (name_ == "Devwarlt")
            return 52685;

        if (isAdmin)
            return 1869550;

        if (this.nameChosen_)
            return LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.NAME_CHOSEN_COLOR;

        return 16777215;
    }

    protected function drawBreathBar(param1:Vector.<IGraphicsData>, param2:int):void {
        var _local7:Number = NaN;
        var _local8:Number = NaN;
        if (this.breathPath_ == null) {
            this.breathBackFill_ = new GraphicsSolidFill();
            this.breathBackPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
            this.breathFill_ = new GraphicsSolidFill(2542335);
            this.breathPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
        }
        if (this.breath_ <= LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.BREATH_THRESH) {
            _local7 = (LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.BREATH_THRESH - this.breath_) / LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.BREATH_THRESH;
            this.breathBackFill_.color = MoreColorUtil.lerpColor(2368548, 16711680, Math.abs(Math.sin(param2 / 300)) * _local7);
        } else {
            this.breathBackFill_.color = 2368548;
        }
        var _local3:int = 20;
        var _local4:int = 8;
        var _local5:int = 6;
        var _local6:Vector.<Number> = this.breathBackPath_.data as Vector.<Number>;
        _local6.length = 0;
        _local6.push(posS_[0] - _local3, posS_[1] + _local4, posS_[0] + _local3, posS_[1] + _local4, posS_[0] + _local3, posS_[1] + _local4 + _local5, posS_[0] - _local3, posS_[1] + _local4 + _local5);
        param1.push(this.breathBackFill_);
        param1.push(this.breathBackPath_);
        param1.push(GraphicsUtil.END_FILL);
        if (this.breath_ > 0) {
            _local8 = this.breath_ / 100 * 2 * _local3;
            this.breathPath_.data.length = 0;
            _local6 = this.breathPath_.data as Vector.<Number>;
            _local6.length = 0;
            _local6.push(posS_[0] - _local3, posS_[1] + _local4, posS_[0] - _local3 + _local8, posS_[1] + _local4, posS_[0] - _local3 + _local8, posS_[1] + _local4 + _local5, posS_[0] - _local3, posS_[1] + _local4 + _local5);
            param1.push(this.breathFill_);
            param1.push(this.breathPath_);
            param1.push(GraphicsUtil.END_FILL);
        }
        GraphicsFillExtra.setSoftwareDrawSolid(this.breathFill_, true);
        GraphicsFillExtra.setSoftwareDrawSolid(this.breathBackFill_, true);
    }

    override public function draw(param1:Vector.<IGraphicsData>, param2:Camera, param3:int):void {
        super.draw(param1, param2, param3);
        if (this != map_.player_) {
            if (!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.screenShotMode_) {
                drawName(param1, param2);
            }
        } else if (this.breath_ >= 0) {
            this.drawBreathBar(param1, param3);
        }
    }

    private function getMoveSpeed():Number {
        if (isSlowed()) {
            return MIN_MOVE_SPEED * this.moveMultiplier_;
        }
        var _local1:Number = MIN_MOVE_SPEED + this.speed_ / 75 * (MAX_MOVE_SPEED - MIN_MOVE_SPEED);
        if (Boolean(isSpeedy()) || Boolean(isNinjaSpeedy())) {
            _local1 = _local1 * 1.5;
        }
        _local1 = _local1 * this.moveMultiplier_;
        return _local1;
    }

    public function attackFrequency():Number {
        if (isDazed()) {
            return MIN_ATTACK_FREQ;
        }
        var _local1:Number = MIN_ATTACK_FREQ + this.dexterity_ / 75 * (MAX_ATTACK_FREQ - MIN_ATTACK_FREQ);
        if (isBerserk()) {
            _local1 = _local1 * 1.5;
        }
        return _local1;
    }

    private function attackMultiplier():Number {
        if (isWeak()) {
            return MIN_ATTACK_MULT;
        }
        var _local1:Number = MIN_ATTACK_MULT + this.attack_ / 75 * (MAX_ATTACK_MULT - MIN_ATTACK_MULT);
        if (isDamaging()) {
            _local1 = _local1 * 1.5;
        }
        return _local1;
    }

    private function makeSkinTexture():void {
        var _local1:MaskedImage = this.skin.imageFromAngle(0, AnimatedChar.STAND, 0);
        animatedChar_ = this.skin;
        texture_ = _local1.image_;
        mask_ = _local1.mask_;
        this.isDefaultAnimatedChar = true;
    }

    private function setToRandomAnimatedCharacter():void {
        var _local1:Vector.<XML> = LOEBUILD_efda783509bc93eea698457c87bbee3f.hexTransforms_;
        var _local2:uint = Math.floor(Math.random() * _local1.length);
        var _local3:int = _local1[_local2].@type;
        var _local4:TextureData = LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToTextureData_[_local3];
        texture_ = _local4.texture_;
        mask_ = _local4.mask_;
        animatedChar_ = _local4.animatedChar_;
        this.isDefaultAnimatedChar = false;
    }

    override protected function getTexture(param1:Camera, param2:int):BitmapData {
        var _local5:MaskedImage = null;
        var _local10:int = 0;
        var _local11:Dictionary = null;
        var _local12:Number = NaN;
        var _local13:int = 0;
        var _local14:ColorTransform = null;
        var _local3:Number = 0;
        var _local4:int = AnimatedChar.STAND;
        if (Boolean(this.isShooting) || param2 < attackStart_ + this.attackPeriod_) {
            facing_ = attackAngle_;
            _local3 = (param2 - attackStart_) % this.attackPeriod_ / this.attackPeriod_;
            _local4 = AnimatedChar.ATTACK;
        } else if (moveVec_.x != 0 || moveVec_.y != 0) {
            _local10 = 3.5 / this.getMoveSpeed();
            if (moveVec_.y != 0 || moveVec_.x != 0) {
                facing_ = Math.atan2(moveVec_.y, moveVec_.x);
            }
            _local3 = param2 % _local10 / _local10;
            _local4 = AnimatedChar.WALK;
        }
        if (this.isHexed()) {
            this.isDefaultAnimatedChar && this.setToRandomAnimatedCharacter();
        } else if (!this.isDefaultAnimatedChar) {
            this.makeSkinTexture();
        }
        if (param1.isHallucinating_) {
            _local5 = new MaskedImage(getHallucinatingTexture(), null);
        } else {
            _local5 = animatedChar_.imageFromFacing(facing_, param1, _local4, _local3);
        }
        var _local6:int = tex1Id_;
        var _local7:int = tex2Id_;
        var _local8:BitmapData = null;
        if (this.nearestMerchant_) {
            _local11 = texturingCache_[this.nearestMerchant_];
            if (_local11 == null) {
                texturingCache_[this.nearestMerchant_] = new Dictionary();
            } else {
                _local8 = _local11[_local5];
            }
            _local6 = this.nearestMerchant_.getTex1Id(tex1Id_);
            _local7 = this.nearestMerchant_.getTex2Id(tex2Id_);
        } else {
            _local8 = texturingCache_[_local5];
        }
        if (_local8 == null) {
            _local8 = TextureRedrawer.resize(_local5.image_, _local5.mask_, size_, false, _local6, _local7);
            if (this.nearestMerchant_ != null) {
                texturingCache_[this.nearestMerchant_][_local5] = _local8;
            } else {
                texturingCache_[_local5] = _local8;
            }
        }
        if (hp_ < maxHP_ * 0.2) {
            _local12 = int(Math.abs(Math.sin(param2 / 200)) * 10) / 10;
            _local13 = 128;
            _local14 = new ColorTransform(1, 1, 1, 1, _local12 * _local13, -_local12 * _local13, -_local12 * _local13);
            _local8 = CachingColorTransformer.transformBitmapData(_local8, _local14);
        }
        var _local9:BitmapData = texturingCache_[_local8];
        if (_local9 == null) {
            _local9 = GlowRedrawer.outlineGlow(_local8, this.legendaryRank_ == -1 ? uint(0) : uint(16711680));
            texturingCache_[_local8] = _local9;
        }
        if (Boolean(isPaused()) || Boolean(isStasis()) || Boolean(isPetrified())) {
            _local9 = CachingColorTransformer.filterBitmapData(_local9, PAUSED_FILTER);
        } else if (isInvisible()) {
            _local9 = CachingColorTransformer.alphaBitmapData(_local9, 0.4);
        }
        return _local9;
    }

    override public function getPortrait():BitmapData {
        var _local1:MaskedImage = null;
        var _local2:int = 0;
        if (portrait_ == null) {
            _local1 = animatedChar_.imageFromDir(AnimatedChar.RIGHT, AnimatedChar.STAND, 0);
            _local2 = 4 / _local1.image_.width * 100;
            portrait_ = TextureRedrawer.resize(_local1.image_, _local1.mask_, _local2, true, tex1Id_, tex2Id_);
            portrait_ = GlowRedrawer.outlineGlow(portrait_, 0);
        }
        return portrait_;
    }

    public function useAltWeapon(param1:Number, param2:Number, param3:int):Boolean {
        var _local7:XML;
        var _local8:int;
        var _local9:Number = NaN;
        var _local10:int = 0;
        var _local11:int = 0;
        if (map_ == null || Boolean(isPaused())) {
            return false;
        }
        var _local4:int = equipment_[1];
        if (_local4 == -1) {
            return false;
        }
        var _local5:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[_local4];
        if (_local5 == null || !_local5.hasOwnProperty("Usable")) {
            return false;
        }
        var _local6:Point = map_.pSTopW(param1, param2);
        if (_local6 == null) {
            SoundEffectLibrary.play("error");
            return false;
        }
        for each(_local7 in _local5.Activate) {
            if (_local7.toString() == ActivationType.TELEPORT) {
                if (!this.isValidPosition(_local6.x, _local6.y)) {
                    SoundEffectLibrary.play("error");
                    return false;
                }
            }
        }
        _local8 = getTimer();
        if (param3 == UseType.START_USE) {
            if (_local8 < this.nextAltAttack_) {
                SoundEffectLibrary.play("error");
                return false;
            }
            _local10 = int(_local5.MpCost);
            if (_local10 > this.mp_) {
                SoundEffectLibrary.play("no_mana");
                return false;
            }
            _local11 = 500;
            if (_local5.hasOwnProperty("Cooldown")) {
                _local11 = Number(_local5.Cooldown) * 1000;
            }
            this.nextAltAttack_ = _local8 + _local11;
            map_.gs_.gsc_.useItem(_local8, objectId_, 1, _local4, _local6.x, _local6.y, param3);
            if (_local5.Activate == ActivationType.SHOOT) {
                _local9 = Math.atan2(param2, param1);
                this.doShoot(_local8, _local4, _local5, LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.cameraAngle + _local9, false);
            }
        } else if (_local5.hasOwnProperty("MultiPhase")) {
            map_.gs_.gsc_.useItem(_local8, objectId_, 1, _local4, _local6.x, _local6.y, param3);
            _local10 = int(_local5.MpEndCost);
            if (_local10 <= this.mp_) {
                _local9 = Math.atan2(param2, param1);
                this.doShoot(_local8, _local4, _local5, LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.cameraAngle + _local9, false);
            }
        }
        return true;
    }

    public function attemptAttackAngle(param1:Number):void {
        this.shoot(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.cameraAngle + param1);
    }

    override public function setAttack(param1:int, param2:Number):void {
        var _local3:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[param1];
        if (_local3 == null || !_local3.hasOwnProperty(LOEBUILD_5c3fafb478917eee32f80d979a87cb36.rf)) {
            return;
        }
        var _local4:Number = Number(_local3.RateOfFire);
        this.attackPeriod_ = LOEBUILD_5c3fafb478917eee32f80d979a87cb36.qntity / this.attackFrequency() * (LOEBUILD_5c3fafb478917eee32f80d979a87cb36.qntity / _local4);
        super.setAttack(param1, param2);
    }

    private function shoot(param1:Number):void {
        if (map_ == null || Boolean(isStunned()) || Boolean(isPaused()) || Boolean(isPetrified())) {
            return;
        }
        var _local2:int = equipment_[0];
        if (_local2 == -1) {
            this.addTextLine.dispatch(ChatMessage.make(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ERROR_CHAT_NAME, TextKey.PLAYER_NO_WEAPON_EQUIPPED));
            return;
        }
        var _local3:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[_local2];
        var _local4:int = getTimer();
        var _local5:Number = Number(_local3.RateOfFire);
        this.attackPeriod_ = LOEBUILD_5c3fafb478917eee32f80d979a87cb36.qntity / this.attackFrequency() * (LOEBUILD_5c3fafb478917eee32f80d979a87cb36.qntity / _local5);
        if (_local4 < attackStart_ + this.attackPeriod_) {
            return;
        }
        doneAction(map_.gs_, Tutorial.ATTACK_ACTION);
        attackAngle_ = param1;
        attackStart_ = _local4;
        this.doShoot(attackStart_, _local2, _local3, attackAngle_, true);
    }

    private function doShoot(param1:int, param2:int, param3:XML, param4:Number, param5:Boolean):void {
        var _local11:uint = 0;
        var _local12:Projectile = null;
        var _local13:int = 0;
        var _local14:int = 0;
        var _local15:Number = NaN;
        var _local16:int = 0;
        var _local6:int = !!param3.hasOwnProperty(LOEBUILD_5c3fafb478917eee32f80d979a87cb36.np) ? int(int(param3.NumProjectiles)) : LOEBUILD_5c3fafb478917eee32f80d979a87cb36.qntity;
        var _local7:Number = (!!param3.hasOwnProperty(LOEBUILD_5c3fafb478917eee32f80d979a87cb36.ag) ? Number(param3.ArcGap) : 11.25) * Trig.toRadians;
        var _local8:Number = _local7 * (_local6 - 1);
        var _local9:Number = param4 - _local8 / 2;
        this.isShooting = param5;
        var _local10:int = 0;
        while (_local10 < _local6) {
            _local11 = getBulletId();
            _local12 = FreeList.newObject(Projectile) as Projectile;
            if (Boolean(param5) && this.projectileIdSetOverrideNew != "") {
                _local12.reset(param2, 0, objectId_, _local11, _local9, param1, this.projectileIdSetOverrideNew, this.projectileIdSetOverrideOld);
            } else {
                _local12.reset(param2, 0, objectId_, _local11, _local9, param1);
            }
            _local13 = int(_local12.projProps_.minDamage_);
            _local14 = int(_local12.projProps_.maxDamage_);
            _local15 = !!param5 ? Number(this.attackMultiplier()) : Number(1);
            _local16 = map_.gs_.gsc_.getNextDamage(_local13, _local14) * _local15;
            if (param1 > map_.gs_.moveRecords_.lastClearTime_ + 600) {
                _local16 = 0;
            }
            _local12.setDamage(_local16);
            if (_local10 == 0 && _local12.sound_ != null) {
                SoundEffectLibrary.play(_local12.sound_, 0.75, false);
            }
            map_.addObj(_local12, x_ + Math.cos(param4) * 0.3, y_ + Math.sin(param4) * 0.3);
            map_.gs_.gsc_.playerShoot(param1, _local12);
            _local9 = _local9 + _local7;
            _local10++;
        }
    }

    public function isHexed():Boolean {
        return (condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.HEXED_BIT) != 0;
    }

    public function isInventoryFull():Boolean {
        var _local1:int = equipment_.length;
        var _local2:uint = 4;
        while (_local2 < _local1) {
            if (equipment_[_local2] <= 0) {
                return false;
            }
            _local2++;
        }
        return true;
    }

    public function nextAvailableInventorySlot():int {
        var _local1:int = !!this.hasBackpack_ ? int(equipment_.length) : int(equipment_.length - GeneralConstants.NUM_INVENTORY_SLOTS);
        var _local2:uint = 4;
        while (_local2 < _local1) {
            if (equipment_[_local2] <= 0) {
                return _local2;
            }
            _local2++;
        }
        return -1;
    }

    public function numberOfAvailableSlots():int {
        var _local1:int = !!this.hasBackpack_ ? int(equipment_.length) : int(equipment_.length - GeneralConstants.NUM_INVENTORY_SLOTS);
        var _local2:int = 0;
        var _local3:uint = 4;
        while (_local3 < _local1) {
            if (equipment_[_local3] <= 0) {
                _local2++;
            }
            _local3++;
        }
        return _local2;
    }

    public function swapInventoryIndex(param1:String):int {
        var _local2:int = 0;
        var _local3:int = 0;
        if (!this.hasBackpack_) {
            return -1;
        }
        if (param1 == TabStripModel.BACKPACK) {
            _local2 = GeneralConstants.NUM_EQUIPMENT_SLOTS;
            _local3 = GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS;
        } else {
            _local2 = GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS;
            _local3 = equipment_.length;
        }
        var _local4:uint = _local2;
        while (_local4 < _local3) {
            if (equipment_[_local4] <= 0) {
                return _local4;
            }
            _local4++;
        }
        return -1;
    }

    public function getPotionCount(param1:int):int {
        switch (param1) {
            case PotionInventoryModel.HEALTH_POTION_ID:
                return this.healthPotionCount_;
            case PotionInventoryModel.MAGIC_POTION_ID:
                return this.magicPotionCount_;
            default:
                return 0;
        }
    }

    public function getTex1():int {
        return tex1Id_;
    }

    public function getTex2():int {
        return tex2Id_;
    }
}
}
