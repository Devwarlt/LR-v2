package kabam.rotmg.maploading.view {
import com.company.util.GTween;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.core.view.ConfirmEmailModal;
import kabam.rotmg.account.web.view.WebLoginDialogForced;
import kabam.rotmg.account.web.view.WebRegisterDialog;
import kabam.rotmg.assets.model.Animation;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.TitleView;

public class MapLoadingView extends Sprite {

    public static const MAX_DIFFICULTY:int = 5;

    public static const FADE_OUT_TIME:Number = 0.85;

    private var screen:DisplayObjectContainer;

    private var mapNameField:TextFieldDisplayConcrete;

    private var indicators:Vector.<DisplayObject>;

    private var diffRow:MovieClip;

    private var mapName:String;

    private var difficulty:int;

    private var animation:Animation;

//    public function MapLoadingView() {
//        super();
//        this.addBackground();
//        this.makeLoadingScreen();
//        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
//    }
//
//   private function addBackground():void {
//        var _local1:Sprite = new Sprite();
//        _local1.graphics.beginFill(0, 1);
//        _local1.graphics.drawRect(0, 0, 800, 600);
//        _local1.graphics.endFill();
//        addChild(_local1);
//    }
//
//    private function makeLoadingScreen():void {
//        var _local1:MovieClip;
//        this.screen = new MapLoadingScreen();
//        _local1 = this.screen.getChildByName("mapNameContainer") as MovieClip;
//        this.mapNameField = new TextFieldDisplayConcrete().setSize(30).setColor(16777215);
//        this.mapNameField.setBold(true);
//        this.mapNameField.setAutoSize(TextFieldAutoSize.CENTER);
//        this.mapNameField.x = _local1.x;
//        this.mapNameField.y = _local1.y;
//        this.screen.addChild(this.mapNameField);
//        this.diffRow = this.screen.getChildByName("difficulty_indicators") as MovieClip;
//        this.indicators = new Vector.<DisplayObject>(MAX_DIFFICULTY);
//        var _local2:int = 1;
//        while (_local2 <= MAX_DIFFICULTY) {
//            this.indicators[_local2 - 1] = this.diffRow.getChildByName("indicator_" + _local2);
//            _local2++;
//        }
//        addChild(this.screen);
//        this.setValues();
//    }
//
//    public function showMap(param1:String, param2:int):void {
//        this.mapName = !!param1 ? param1 : "";
//        this.difficulty = param2;
//        this.setValues();
//    }
//
//    private function setValues():void {
//        var _local1:int = 0;
//        if (this.screen) {
//            this.mapNameField.setStringBuilder(new LineBuilder().setParams(this.mapName));
//            if (this.difficulty <= 0) {
//                this.screen.getChildByName("bgGroup").visible = false;
//                this.diffRow.visible = false;
//            } else {
//                this.screen.getChildByName("bgGroup").visible = true;
//                this.diffRow.visible = true;
//                _local1 = 0;
//                while (_local1 < MAX_DIFFICULTY) {
//                    this.indicators[_local1].visible = _local1 < this.difficulty;
//                    _local1++;
//                }
//            }
//        }
//    }
//
//    public function showAnimation(param1:Animation):void {
//        this.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b = param1;
//        addChild(param1);
//        param1.start();
//        param1.x = 399.5 - param1.width * 0.5 + 5;
//        param1.y = 245.85 - param1.height * 0.5;
//    }
//
//    public function disable():void {
//        this.beginFadeOut();
//    }
//
//    public function disableNoFadeOut():void {
//        parent && parent.removeChild(this);
//    }
//
//    private function beginFadeOut():void {
//        if (TitleView.queueEmailConfirmation) {
//            StaticInjectorContext.getInjector().getInstance(OpenDialogSignal).dispatch(new ConfirmEmailModal());
//            TitleView.queueEmailConfirmation = false;
//        } else if (TitleView.queuePasswordPrompt) {
//            StaticInjectorContext.getInjector().getInstance(OpenDialogSignal).dispatch(new WebLoginDialogForced());
//            TitleView.queuePasswordPrompt = false;
//        } else if (TitleView.queuePasswordPromptFull) {
//            StaticInjectorContext.getInjector().getInstance(OpenDialogSignal).dispatch(new WebLoginDialogForced(true));
//            TitleView.queuePasswordPromptFull = false;
//        } else if (TitleView.queueRegistrationPrompt) {
//            StaticInjectorContext.getInjector().getInstance(OpenDialogSignal).dispatch(new WebRegisterDialog());
//            TitleView.queueRegistrationPrompt = false;
//        }
//        var _local1:GTween = new GTween(this, FADE_OUT_TIME, {"alpha": 0});
//        _local1.onComplete = this.onFadeOutComplete;
//        mouseEnabled = false;
//        mouseChildren = false;
//    }
//
//    private function onFadeOutComplete():void {
//        parent && parent.removeChild(this);
//    }
//
//    private function onRemovedFromStage(param1:Event):void {
//        onFadeOutComplete();
//        this.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b.dispose();
//    }
}
}
