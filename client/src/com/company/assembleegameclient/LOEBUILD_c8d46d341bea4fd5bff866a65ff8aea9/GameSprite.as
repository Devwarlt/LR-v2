package com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9 {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_16908b0605f2645dfcb4c3a8d248cef3.LOEBUILD_9d2c79ff97e2eb8a322026fcdd0bba9c;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_5e926ae2981199c65b99066bd9e14d29;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.Pet;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.Projectile;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.tutorial.Tutorial;
import com.company.assembleegameclient.ui.GuildText;
import com.company.assembleegameclient.ui.RankText;
import com.company.assembleegameclient.ui.menu.PlayerMenu;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.CachingColorTransformer;
import com.company.util.MoreColorUtil;
import com.company.util.MoreObjectUtil;
import com.company.util.PointUtil;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.external.ExternalInterface;
import flash.filters.ColorMatrixFilter;
import flash.utils.ByteArray;
import flash.utils.getTimer;

import kabam.lib.loopedprocs.LoopedCallback;
import kabam.lib.loopedprocs.LoopedProcess;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.arena.view.ArenaTimer;
import kabam.rotmg.arena.view.ArenaWaveCounter;
import kabam.rotmg.chat.view.Chat;
import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.MapModel;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.game.view.CreditDisplay;
import kabam.rotmg.game.view.GiftStatusDisplay;
import kabam.rotmg.game.view.NewsModalButton;
import kabam.rotmg.maploading.signals.HideMapLoadingSignal;
import kabam.rotmg.maploading.signals.MapLoadedSignal;
import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;
import kabam.rotmg.messaging.impl.incoming.MapInfo;
import kabam.rotmg.news.model.NewsModel;
import kabam.rotmg.news.view.NewsTicker;
import kabam.rotmg.packages.services.PackageModel;
import kabam.rotmg.packages.view.PackageButton;
import kabam.rotmg.promotions.model.BeginnersPackageModel;
import kabam.rotmg.promotions.signals.ShowBeginnersPackageSignal;
import kabam.rotmg.promotions.view.BeginnersPackageButton;
import kabam.rotmg.protip.signals.ShowProTipSignal;
import kabam.rotmg.questrewards.view.QuestRewardsPanel;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.stage3D.Renderer;
import kabam.rotmg.ui.UIUtils;
import kabam.rotmg.ui.view.HUDView;

import org.osflash.signals.Signal;

public class GameSprite extends LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1 {

    protected static const PAUSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);

    public const monitor:Signal = new Signal(String, int);

    public const modelInitialized:Signal = new Signal();

    public const drawCharacterWindow:Signal = new Signal(Player);

    public var chatBox_:Chat;

    public var isNexus_:Boolean = false;

    public var idleWatcher_:LOEBUILD_c11ff77a16e23fedc0889a2f7c4b40b6;

    public var rankText_:RankText;

    public var guildText_:GuildText;

    public var creditDisplay_:CreditDisplay;

    public var giftStatusDisplay:GiftStatusDisplay;

    public var newsModalButton:NewsModalButton;

    public var newsTicker:NewsTicker;

    public var arenaTimer:ArenaTimer;

    public var arenaWaveCounter:ArenaWaveCounter;

    public var mapModel:MapModel;

    public var beginnersPackageModel:BeginnersPackageModel;

    public var showBeginnersPackage:ShowBeginnersPackageSignal;

    public var showPackage:Signal;

    public var packageModel:PackageModel;

    private var focus:GameObject;

    private var frameTimeSum_:int = 0;

    private var frameTimeCount_:int = 0;

    private var isGameStarted:Boolean;

    private var displaysPosY:uint = 4;

    private var currentPackage:DisplayObject;

    private var packageY:Number;

    public var chatPlayerMenu:PlayerMenu;

    public function GameSprite(param1:Server, param2:int, param3:Boolean, param4:int, param5:int, param6:ByteArray, param7:PlayerModel, param8:String, param9:Boolean) {
        this.showPackage = new Signal();
        this.currentPackage = new Sprite();
        super();
        model = param7;
        map = new Map(this);
        addChild(map);
        gsc_ = new GameServerConnectionConcrete(this, param1, param2, param3, param4, param5, param6, param8, param9);
        mui_ = new LOEBUILD_e5f69906f41a111ba59048ec6958248a(this);
        this.chatBox_ = new Chat();
        this.chatBox_.list.addEventListener(MouseEvent.MOUSE_DOWN, this.onChatDown);
        this.chatBox_.list.addEventListener(MouseEvent.MOUSE_UP, this.onChatUp);
        addChild(this.chatBox_);
        this.idleWatcher_ = new LOEBUILD_c11ff77a16e23fedc0889a2f7c4b40b6();
    }

    public static function dispatchMapLoaded(param1:MapInfo):void {
        var _local2:MapLoadedSignal = StaticInjectorContext.getInjector().getInstance(MapLoadedSignal);
        _local2 && _local2.dispatch(param1);
    }

    private static function hidePreloader():void {
        var _local1:HideMapLoadingSignal = StaticInjectorContext.getInjector().getInstance(HideMapLoadingSignal);
        _local1 && _local1.dispatch();
    }

    public function onChatDown(param1:MouseEvent):void {
        if (this.chatPlayerMenu != null) {
            this.removeChatPlayerMenu();
        }
        mui_.onMouseDown(param1);
    }

    public function onChatUp(param1:MouseEvent):void {
        mui_.onMouseUp(param1);
    }

    override public function setFocus(param1:GameObject):void {
        param1 = param1 || map.player_;
        this.focus = param1;
    }

    public function addChatPlayerMenu(param1:Player, param2:Number, param3:Number, param4:String = null, param5:Boolean = false, param6:Boolean = false):void {
        this.removeChatPlayerMenu();
        this.chatPlayerMenu = new PlayerMenu();
        if (param4 == null) {
            this.chatPlayerMenu.init(this, param1);
        } else if (param6) {
            this.chatPlayerMenu.initDifferentServer(this, param4, param5, param6);
        } else {
            if (param4.length > 0 && (param4.charAt(0) == "#" || param4.charAt(0) == "*")) {
                return;
            }
            this.chatPlayerMenu.initDifferentServer(this, param4, param5);
        }
        addChild(this.chatPlayerMenu);
        this.chatPlayerMenu.x = param2;
        this.chatPlayerMenu.y = param3 - this.chatPlayerMenu.height;
    }

    public function removeChatPlayerMenu():void {
        if (this.chatPlayerMenu != null && this.chatPlayerMenu.parent != null) {
            removeChild(this.chatPlayerMenu);
            this.chatPlayerMenu = null;
        }
    }

    override public function applyMapInfo(param1:MapInfo):void {
        map.setProps(param1.width_, param1.height_, param1.name_, param1.background_, param1.allowPlayerTeleport_, param1.showDisplays_, param1.music_);
        dispatchMapLoaded(param1);
    }

    public function hudModelInitialized():void {
        hudView = new HUDView();
        hudView.x = 600;
        addChild(hudView);
    }

    override public function initialize():void {
        var _local1:Account;
        var _local4:ShowProTipSignal;
        map.initialize();
        this.modelInitialized.dispatch();
        if (this.evalIsNotInCombatMapArea()) {
            this.showSafeAreaDisplays();
        }
        if (map.name_ == "Arena") {
            this.showTimer();
            this.showWaveCounter();
        }
        _local1 = StaticInjectorContext.getInjector().getInstance(Account);
        this.isNexus_ = map.name_ == Map.NEXUS;
        if (Boolean(this.isNexus_) || map.name_ == Map.DAILY_QUEST_ROOM) {
            this.creditDisplay_ = new CreditDisplay(this, true, true);
        } else {
            this.creditDisplay_ = new CreditDisplay(this);
        }
        this.creditDisplay_.x = 594;
        this.creditDisplay_.y = 0;
        addChild(this.creditDisplay_);

        var _local2:AppEngineClient = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
        var _local3:Object = {
            "game_net_user_id": _local1.gameNetworkUserId(),
            "game_net": _local1.gameNetwork(),
            "play_platform": _local1.playPlatform()
        };
        MoreObjectUtil.addToObject(_local3, _local1.getCredentials());
        if (map.name_ != "Kitchen" && map.name_ != "Tutorial" && map.name_ != "Nexus Explanation" && LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.watchForTutorialExit == true) {
            LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.watchForTutorialExit = false;
            callTracking("rotmg.Marketing.track(\"tutorialComplete\")");
            _local3["fteStepCompleted"] = 9900;
            _local2.sendRequest("/log/logFteStep", _local3);
        }
        if (map.name_ == "Kitchen") {
            _local3["fteStepCompleted"] = 200;
            _local2.sendRequest("/log/logFteStep", _local3);
        }
        if (map.name_ == "Tutorial") {
            if (LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.needsTutorial == true) {
                LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.watchForTutorialExit = true;
                callTracking("rotmg.Marketing.track(\"install\")");
                _local3["fteStepCompleted"] = 100;
                _local2.sendRequest("/log/logFteStep", _local3);
            }
            this.startTutorial();
        } else if (map.name_ != "Arena" && map.name_ != "Kitchen" && map.name_ != "Nexus Explanation" && map.name_ != "Vault Explanation" && map.name_ != "Guild Explanation" && !this.evalIsNotInCombatMapArea() && Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.showProtips)) {
            _local4 = StaticInjectorContext.getInjector().getInstance(ShowProTipSignal);
            _local4 && _local4.dispatch();
        }
        if (map.name_ == "Daily Quest Room") {
            QuestRewardsPanel.checkQuests();
        }
        LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
        hidePreloader();
    }

    private function showSafeAreaDisplays():void {
        this.showRankText();
        this.showGuildText();
        this.setYAndPositionPackage();
        this.showGiftStatusDisplay();
//        this.showNewsUpdate();
        this.showNewsTicker();
    }

    private function showTimer():void {
        this.arenaTimer = new ArenaTimer();
        this.arenaTimer.y = 5;
        addChild(this.arenaTimer);
    }

    private function showWaveCounter():void {
        this.arenaWaveCounter = new ArenaWaveCounter();
        this.arenaWaveCounter.y = 5;
        this.arenaWaveCounter.x = 5;
        addChild(this.arenaWaveCounter);
    }

    private function showNewsTicker():void {
        this.newsTicker = new NewsTicker();
        this.newsTicker.x = 300 - this.newsTicker.width / 2;
        this.newsTicker.y = 5 + UIUtils.NOTIFICATION_SPACE;
        addChild(this.newsTicker);
    }

    private function showGiftStatusDisplay():void {
        this.giftStatusDisplay = new GiftStatusDisplay();
        this.giftStatusDisplay.x = 6;
        this.giftStatusDisplay.y = this.displaysPosY + 2;
        this.displaysPosY = this.displaysPosY + UIUtils.NOTIFICATION_SPACE;
        addChild(this.giftStatusDisplay);
    }

    private function showNewsUpdate(param1:Boolean = true):void {
        var _local3:NewsModalButton;
        var _local2:NewsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
        if (_local2.hasValidModalNews()) {
            _local3 = new NewsModalButton();
            _local3.x = 6;
            _local3.y = 92;
            if (param1) {
                this.displaysPosY = this.displaysPosY + UIUtils.NOTIFICATION_SPACE;
            }
            if (this.newsModalButton != null) {
                removeChild(this.newsModalButton);
            }
            this.newsModalButton = _local3;
            addChild(this.newsModalButton);
        }
    }

    public function refreshNewsUpdateButton():void {
        this.showNewsUpdate(false);
    }

    private function setYAndPositionPackage():void {
        this.packageY = this.displaysPosY + 2;
        this.displaysPosY = this.displaysPosY + UIUtils.NOTIFICATION_SPACE;
        this.positionPackage();
    }

    private function positionPackage():void {
        this.currentPackage.x = 6;
        this.currentPackage.y = this.packageY;
    }

    public function showBeginnersButtonIfSafe():void {
        if (this.evalIsNotInCombatMapArea()) {
            this.addAndPositionPackage(new BeginnersPackageButton());
        }
    }

    public function showPackageButtonIfSafe():void {
        if (this.evalIsNotInCombatMapArea()) {
            this.addAndPositionPackage(new PackageButton());
        }
    }

    private function addAndPositionPackage(param1:DisplayObject):void {
        this.currentPackage = param1;
        addChild(this.currentPackage);
        this.positionPackage();
    }

    private function showGuildText():void {
        this.guildText_ = new GuildText("", -1);
        this.guildText_.x = 64;
        this.guildText_.y = 6;
        addChild(this.guildText_);
    }

    private function showRankText():void {
        this.rankText_ = new RankText(-1, true, false);
        this.rankText_.x = 8;
        this.rankText_.y = this.displaysPosY;
        this.displaysPosY = this.displaysPosY + UIUtils.NOTIFICATION_SPACE;
        addChild(this.rankText_);
    }

    private static function callTracking(param1:String):void {
        if (ExternalInterface.available == false) {
            return;
        }
        try {
            ExternalInterface.call(param1);

        }
        catch (err:Error) {

        }
    }

    private function startTutorial():void {
        tutorial_ = new Tutorial(this);
        addChild(tutorial_);
    }

    private function updateNearestInteractive():void {
        var _local4:Number;
        var _local7:GameObject;
        var _local8:LOEBUILD_5e926ae2981199c65b99066bd9e14d29;
        if (!map || !map.player_) {
            return;
        }
        var _local1:Player = map.player_;
        var _local2:Number = GeneralConstants.MAXIMUM_INTERACTION_DISTANCE;
        var _local3:LOEBUILD_5e926ae2981199c65b99066bd9e14d29;
        var _local5:Number = _local1.x_;
        var _local6:Number = _local1.y_;
        for each(_local7 in map.goDict_) {
            _local8 = _local7 as LOEBUILD_5e926ae2981199c65b99066bd9e14d29;
            if (Boolean(_local8) && (!(_local8 is Pet) || Boolean(this.map.isPetYard))) {
                if (Math.abs(_local5 - _local7.x_) < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE || Math.abs(_local6 - _local7.y_) < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE) {
                    _local4 = PointUtil.distanceXY(_local7.x_, _local7.y_, _local5, _local6);
                    if (_local4 < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE && _local4 < _local2) {
                        _local2 = _local4;
                        _local3 = _local8;
                    }
                }
            }
        }
        this.mapModel.currentInteractiveTarget = _local3;
    }

    public function onScreenResize(_arg1:Event):void {
        var _local2:Boolean = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["uiscale"];
        var _local3:Boolean = true;
        var _local4:Boolean = true;
        var _local5:Boolean = true;
        var _local6:Boolean = true;
        var _local7:Boolean = true;
        var _local8:Boolean = true;
        var _local9:Boolean = true;
        var _local10:Boolean = true;
        var _local11:Boolean = true;
        var _local12:Number = (800 / stage.stageWidth);
        var _local13:Number = (600 / stage.stageHeight);
        if (((!((this.map == null))) && (_local3))) {
            this.map.scaleX = (_local12 * (((stage.scaleMode) != StageScaleMode.EXACT_FIT) ? LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["mscale"] : 1));
            this.map.scaleY = (_local13 * (((stage.scaleMode) != StageScaleMode.EXACT_FIT) ? LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["mscale"] : 1));
        }
        if (this.hudView != null) {
            if (_local2) {
                this.hudView.scaleX = (_local12 / _local13);
                this.hudView.scaleY = 1;
                this.hudView.y = 0;
            } else {
                if (_local4) {
                    this.hudView.scaleX = _local12;
                    this.hudView.scaleY = _local13;
                    this.hudView.y = (300 * (1 - _local13));
                }
            }
            this.hudView.x = (800 - (200 * this.hudView.scaleX));
            if (this.creditDisplay_ != null) {
                this.creditDisplay_.x = (this.hudView.x - (6 * this.creditDisplay_.scaleX));
            }
        }
        if (this.newsModalButton != null) {
            this.newsModalButton.x = ((800 - ((200 * this.hudView.scaleX) + (115 * this.newsModalButton.scaleX))) / 2);
        }
        if (this.chatBox_ != null) {
            if (_local2) {
                this.chatBox_.scaleX = (_local12 / _local13);
                this.chatBox_.scaleY = 1;
            } else {
                if (_local5) {
                    this.chatBox_.scaleX = _local12;
                    this.chatBox_.scaleY = _local13;
                }
            }
            this.chatBox_.y = (300 + (300 * (1 - this.chatBox_.scaleY)));
        }
        if (this.rankText_ != null) {
            if (_local2) {
                this.rankText_.scaleX = (_local12 / _local13);
                this.rankText_.scaleY = 1;
            } else {
                if (_local6) {
                    this.rankText_.scaleX = _local12;
                    this.rankText_.scaleY = _local13;
                }
            }
            this.rankText_.x = (8 * this.rankText_.scaleX);
            this.rankText_.y = (4 * this.rankText_.scaleY);
        }
        if (this.guildText_ != null) {
            if (_local2) {
                this.guildText_.scaleX = (_local12 / _local13);
                this.guildText_.scaleY = 1;
            } else {
                if (_local7) {
                    this.guildText_.scaleX = _local12;
                    this.guildText_.scaleY = _local13;
                }
            }
            this.guildText_.x = (this.guildText_.width + (16 * this.guildText_.scaleX));
            this.guildText_.y = (6 * this.guildText_.scaleY);
        }
        if (this.creditDisplay_ != null) {
            if (_local2) {
                this.creditDisplay_.scaleX = (_local12 / _local13);
                this.creditDisplay_.scaleY = 1;
            } else {
                if (_local8) {
                    this.creditDisplay_.scaleX = _local12;
                    this.creditDisplay_.scaleY = _local13;
                }
            }
        }
        if (this.currentPackage != null) {
            if (_local2) {
                this.currentPackage.scaleX = (_local12 / _local13);
                this.currentPackage.scaleY = 1;
            } else {
                if (_local9) {
                    this.currentPackage.scaleX = _local12;
                    this.currentPackage.scaleY = _local13;
                }
            }
            this.currentPackage.x = (6 * this.currentPackage.scaleX);
            this.currentPackage.y = (34 * this.currentPackage.scaleY);
        }
        if (this.giftStatusDisplay != null) {
            if (_local2) {
                this.giftStatusDisplay.scaleX = (_local12 / _local13);
                this.giftStatusDisplay.scaleY = 1;
            } else {
                if (_local10) {
                    this.giftStatusDisplay.scaleX = _local12;
                    this.giftStatusDisplay.scaleY = _local13;
                }
            }
            this.giftStatusDisplay.x = (6 * this.giftStatusDisplay.scaleX);
            this.giftStatusDisplay.y = (60 * this.giftStatusDisplay.scaleY);
        }
        if (this.newsModalButton != null) {
            if (_local2) {
                this.newsModalButton.scaleX = (_local12 / _local13);
                this.newsModalButton.scaleY = 1;
            } else {
                if (_local11) {
                    this.newsModalButton.scaleX = _local12;
                    this.newsModalButton.scaleY = _local13;
                }
            }
        }
        if (map != null) {
            map.resetOverlays();
        }
    }


    public function connect():void {
        if (!this.isGameStarted) {
            this.isGameStarted = true;
            Renderer.inGame = true;
            gsc_.connect();
            this.idleWatcher_.start(this);
            lastUpdate_ = getTimer();
            stage.addEventListener(LOEBUILD_9d2c79ff97e2eb8a322026fcdd0bba9c.MONEY_CHANGED, this.onMoneyChanged);
            stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            if (LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["mscale"] == undefined){
                LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["mscale"] = "1.0";
                LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
            }
            if (LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["stageScale"] == undefined){
                LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["stageScale"] = StageScaleMode.NO_SCALE;
                LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
            }
            if (LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["uiscale"] == undefined){
                LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["uiscale"] = true;
                LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
            }
            stage.scaleMode = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["stageScale"];
            stage.addEventListener(Event.RESIZE, this.onScreenResize);
            stage.dispatchEvent(new Event(Event.RESIZE));
            LoopedProcess.addProcess(new LoopedCallback(50, this.updateNearestInteractive));
        }
    }

    public function disconnect():void {
        if (this.isGameStarted) {
            this.isGameStarted = false;
            Renderer.inGame = false;
            this.idleWatcher_.stop();
            stage.removeEventListener(LOEBUILD_9d2c79ff97e2eb8a322026fcdd0bba9c.MONEY_CHANGED, this.onMoneyChanged);
            stage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            stage.removeEventListener(Event.RESIZE, this.onScreenResize);
            stage.scaleMode = StageScaleMode.EXACT_FIT;
            stage.dispatchEvent(new Event(Event.RESIZE));
            LoopedProcess.destroyAll();
            contains(map) && removeChild(map);
            map.dispose();
            CachingColorTransformer.clear();
            TextureRedrawer.clearCache();
            Projectile.dispose();
            gsc_.disconnect();
        }
    }

    private function onMoneyChanged(param1:Event):void {
        gsc_.checkCredits();
    }

    override public function evalIsNotInCombatMapArea():Boolean {
        return map.name_ == Map.NEXUS || map.name_ == Map.VAULT || map.name_ == Map.GUILD_HALL || map.name_ == Map.CLOTH_BAZAAR || map.name_ == Map.NEXUS_EXPLANATION || map.name_ == Map.DAILY_QUEST_ROOM;
    }

    private function onEnterFrame(param1:Event):void {
        var _local7:Number;
        var _local2:int = getTimer();
        var _local3:int = _local2 - lastUpdate_;
        if (this.idleWatcher_.update(_local3)) {
            closed.dispatch();
            return;
        }
        LoopedProcess.runProcesses(_local2);
        this.frameTimeSum_ = this.frameTimeSum_ + _local3;
        this.frameTimeCount_ = this.frameTimeCount_ + 1;
        if (this.frameTimeSum_ > 300000) {
            _local7 = int(Math.round(1000 * this.frameTimeCount_ / this.frameTimeSum_));
//            GA.global().trackEvent("performance","frameRate",map.name_,_local7);
            this.frameTimeCount_ = 0;
            this.frameTimeSum_ = 0;
        }
        var _local4:int = getTimer();
        map.update(_local2, _local3);
        this.monitor.dispatch("Map.update", getTimer() - _local4);
        camera_.update(_local3);
        onScreenResize(param1);
        var _local5:Player = map.player_;
        if (this.focus) {
            camera_.configureCamera(this.focus, !!_local5 ? Boolean(_local5.isHallucinating()) : false);
            map.draw(camera_, _local2);
        }
        if (_local5 != null) {
            this.creditDisplay_.draw(_local5.credits_, _local5.fame_, _local5.tokens_);
            this.drawCharacterWindow.dispatch(_local5);
            if (this.evalIsNotInCombatMapArea()) {
                this.rankText_.draw(_local5.numStars_);
                this.guildText_.draw(_local5.guildName_, _local5.guildRank_);
            }
            if (_local5.isPaused()) {
                map.filters = [PAUSED_FILTER];
                hudView.filters = [PAUSED_FILTER];
                map.mouseEnabled = false;
                map.mouseChildren = false;
                hudView.mouseEnabled = false;
                hudView.mouseChildren = false;
            } else if (map.filters.length > 0) {
                map.filters = [];
                hudView.filters = [];
                map.mouseEnabled = true;
                map.mouseChildren = true;
                hudView.mouseEnabled = true;
                hudView.mouseChildren = true;
            }
            moveRecords_.addRecord(_local2, _local5.x_, _local5.y_);
        }
        lastUpdate_ = _local2;
        var _local6:int = getTimer() - _local2;
        this.monitor.dispatch("GameSprite.loop", _local6);
    }

    public function showPetToolTip(param1:Boolean):void {
    }
}
}
