package kabam.rotmg.game.view.components {
import kabam.rotmg.assets.model.Player;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;

import kabam.rotmg.game.model.StatModel;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.natives.NativeSignal;

public class StatsView extends Sprite {

    private static const statsModel:Array = [new StatModel(TextKey.STAT_MODEL_ATTACK_SHORT, TextKey.STAT_MODEL_ATTACK_LONG, TextKey.STAT_MODEL_ATTACK_DESCRIPTION, true), new StatModel(TextKey.STAT_MODEL_DEFENSE_SHORT, TextKey.STAT_MODEL_DEFENSE_LONG, TextKey.STAT_MODEL_DEFENSE_DESCRIPTION, false), new StatModel(TextKey.STAT_MODEL_SPEED_SHORT, TextKey.STAT_MODEL_SPEED_LONG, TextKey.STAT_MODEL_SPEED_DESCRIPTION, true), new StatModel(TextKey.STAT_MODEL_DEXTERITY_SHORT, TextKey.STAT_MODEL_DEXTERITY_LONG, TextKey.STAT_MODEL_DEXTERITY_DESCRIPTION, true), new StatModel(TextKey.STAT_MODEL_VITALITY_SHORT, TextKey.STAT_MODEL_VITALITY_LONG, TextKey.STAT_MODEL_VITALITY_DESCRIPTION, true), new StatModel(TextKey.STAT_MODEL_WISDOM_SHORT, TextKey.STAT_MODEL_WISDOM_LONG, TextKey.STAT_MODEL_WISDOM_DESCRIPTION, true)];

    public static const ATTACK:int = 0;

    public static const DEFENSE:int = 1;

    public static const SPEED:int = 2;

    public static const DEXTERITY:int = 3;

    public static const VITALITY:int = 4;

    public static const WISDOM:int = 5;

    public static const STATE_UNDOCKED:String = "state_undocked";

    public static const STATE_DOCKED:String = "state_docked";

    public static const STATE_DEFAULT:String = STATE_DOCKED;

    private const WIDTH:int = 191;

    private const HEIGHT:int = 45;

    private var background:Sprite;

    public var stats_:Vector.<StatView>;

    public var containerSprite:Sprite;

    public var mouseDown:NativeSignal;

    public var currentState:String = "state_docked";

    public function StatsView() {
        this.background = this.createBackground();
        this.stats_ = new Vector.<StatView>();
        this.containerSprite = new Sprite();
        super();
        this.createStats();
        addChild(this.background);
        addChild(this.containerSprite);
        mouseChildren = false;
        this.mouseDown = new NativeSignal(this, MouseEvent.MOUSE_DOWN, MouseEvent);
    }

    private function createStats():void {
        var _local3:StatView = null;
        var _local1:int = 0;
        var _local2:int = 0;
        while (_local2 < statsModel.length) {
            _local3 = this.createStat(_local2, _local1);
            this.stats_.push(_local3);
            this.containerSprite.addChild(_local3);
            _local1 = _local1 + _local2 % 2;
            _local2++;
        }
    }

    private function createStat(param1:int, param2:int):StatView {
        var _local4:StatView = null;
        var _local3:StatModel = statsModel[param1];
        _local4 = new StatView(_local3.name, _local3.abbreviation, _local3.description, _local3.redOnZero);
        _local4.x = param1 % 2 * this.WIDTH / 2;
        _local4.y = param2 * (this.HEIGHT / 3);
        return _local4;
    }

    public function draw(param1:Player):void {
        if (param1) {
            this.setBackgroundVisibility();
            this.drawStats(param1);
        }
//        this.containerSprite.x = (this.WIDTH - this.containerSprite.width) / 2;
    }

    public function drawStats(param1:Player):void {
        this.stats_[ATTACK].draw(param1.attack_, param1.attackBoost_, param1.attackMax_);
        this.stats_[DEFENSE].draw(param1.defense_, param1.defenseBoost_, param1.defenseMax_);
        this.stats_[SPEED].draw(param1.speed_, param1.speedBoost_, param1.speedMax_);
        this.stats_[DEXTERITY].draw(param1.dexterity_, param1.dexterityBoost_, param1.dexterityMax_);
        this.stats_[VITALITY].draw(param1.vitality_, param1.vitalityBoost_, param1.vitalityMax_);
        this.stats_[WISDOM].draw(param1.wisdom_, param1.wisdomBoost_, param1.wisdomMax_);
    }

    public function dock():void {
        this.currentState = STATE_DOCKED;
    }

    public function undock():void {
        this.currentState = STATE_UNDOCKED;
    }

    private function createBackground():Sprite {
        this.background = new Sprite();
        this.background.graphics.clear();
        this.background.graphics.beginFill(3552822);
        this.background.graphics.lineStyle(2, 16777215);
        this.background.graphics.drawRoundRect(-5, -5, this.WIDTH + 10, this.HEIGHT + 13, 10);
        this.background.filters = [new GlowFilter(0, 1, 10, 10, 1, 3)];
        return this.background;
    }

    private function setBackgroundVisibility():void {
        if (this.currentState == STATE_UNDOCKED) {
            this.background.alpha = 1;
        } else if (this.currentState == STATE_DOCKED) {
            this.background.alpha = 0;
        }
    }
}
}
