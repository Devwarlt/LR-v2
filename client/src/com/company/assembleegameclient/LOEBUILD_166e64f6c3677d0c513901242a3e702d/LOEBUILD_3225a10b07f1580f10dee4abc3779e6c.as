package com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d {
import com.company.assembleegameclient.map.Map;
import com.company.util.KeyCodes;
import com.company.util.MoreDateUtil;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.net.SharedObject;
import flash.system.Capabilities;
import flash.utils.Dictionary;

import kabam.rotmg.errors.control.LOEBUILD_5c3fafb478917eee32f80d979a87cb36;

public class LOEBUILD_3225a10b07f1580f10dee4abc3779e6c {

    public static const ENABLE_ENCRYPTION:Boolean = true;

    public static const PORT:int = 2050;

    public static const ALLOW_SCREENSHOT_MODE:Boolean = false;

    public static const FELLOW_GUILD_COLOR:uint = 15621186;

    public static const NAME_CHOSEN_COLOR:uint = 16761125;

    public static var root:DisplayObject;

    public static const PLAYER_ROTATE_SPEED:Number = 0.003;

    public static const BREATH_THRESH:int = 20;

    public static const SERVER_CHAT_NAME:String = "";

    public static const CLIENT_CHAT_NAME:String = "*Client*";

    public static const ERROR_CHAT_NAME:String = "*Error*";

    public static const HELP_CHAT_NAME:String = "*Help*";

    public static const GUILD_CHAT_NAME:String = "*Guild*";

    public static const LIGHTBLUE_STAR:String = "!";

    public static const BLUE_STAR:String = "$";

    public static const RED_STAR:String = "%";

    public static const ORANGE_STAR:String = "+";

    public static const YELLOW_STAR:String = "&";

    public static const WHITE_STAR:String = "-";

    public static const MODERATOR:String = ";";

    public static const ADMINISTRATOR:String = "=";

    public static const DEVWARLT:String = "~";

    public static const NEWS_TIMESTAMP_DEFAULT:Number = 1.1;

    public static const NAME_CHANGE_PRICE:int = 1000;

    public static const GUILD_CREATION_PRICE:int = 1000;

    public static var data_:Object = null;

    public static var GPURenderError:Boolean = false;

    public static var blendType_:int = 1;

    public static var projColorType_:int = 0;

    public static var drawProj_:Boolean = true;

    public static var screenShotMode_:Boolean = false;

    public static var screenShotSlimMode_:Boolean = false;

    public static var sendLogin_:Boolean = true;

    public static const TUTORIAL_GAMEID:int = -1;

    public static const NEXUS_GAMEID:int = -2;

    public static const RANDOM_REALM_GAMEID:int = -3;

    public static const MAPTEST_GAMEID:int = -6;

    public static const MAX_SINK_LEVEL:Number = 18;

    public static const TERMS_OF_USE_URL:String = "http://legal.decagames.io/tos";

    public static const PRIVACY_POLICY_URL:String = "http://legal.decagames.io/privacy";

    public static const RSA_PUBLIC_KEY:String = "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCbqweYUxzW0IiCwuBAzx6HtskrhWW+B0iX4LMu2xqRh4gh52HUVu9nNiXso7utTKCv/HNK19v5xoWp3Cne23sicp2oVGgKMFSowBFbtr+fhsq0yHv+JxixkL3WLnXcY3xREz7LOzVMoybUCmJzzhnzIsLPiIPdpI1PxFDcnFbdRQIDAQAB\n-----END PUBLIC KEY-----";

    private static var savedOptions_:SharedObject = null;

    private static var keyNames_:Dictionary = new Dictionary();

    public static var swAccel:Boolean = false;

    public static var forceSoftwareRender:Boolean = false;

    public function LOEBUILD_3225a10b07f1580f10dee4abc3779e6c() {
        super();
    }

    public static function hwAccel() : Boolean
    {
        return !forceSoftwareRender && !swAccel && data_.GPURender;
    }

    public static function load():void {
        try {
            savedOptions_ = SharedObject.getLocal("AssembleeGameClientOptions", "/");
            data_ = savedOptions_.data;
        }
        catch (error:Error) {
            data_ = {};
        }
        setDefaults();
        save();
    }

    public static function save():void {
        try {
            if (savedOptions_ != null) {
                savedOptions_.flush();
            }

        }
        catch (error:Error) {

        }
    }

    private static function setDefaultKey(param1:String, param2:uint):void {
        if (!data_.hasOwnProperty(param1)) {
            data_[param1] = param2;
        }
        keyNames_[param1] = true;
    }

    public static function setKey(param1:String, param2:uint):void {
        var _local3:*;
        for (_local3 in keyNames_) {
            if (data_[_local3] == param2) {
                data_[_local3] = KeyCodes.UNSET;
            }
        }
        data_[param1] = param2;
    }

    private static function setDefault(param1:String, param2:*):void {
        if (!data_.hasOwnProperty(param1)) {
            data_[param1] = param2;
        }
    }

    public static function isGpuRender():Boolean {
        return !GPURenderError && Boolean(data_.GPURender) && !Map.forceSoftwareRender;
    }

    public static function clearGpuRenderEvent(param1:Event):void {
        clearGpuRender();
    }

    public static function clearGpuRender():void {
        GPURenderError = true;
    }

    private static function _1wP_(param1:String, param2:*) : void
    {
        if(!data_.hasOwnProperty(param1))
        {
            data_[param1] = param2;
        }
    }

    public static function setDefaults():void {
        setDefaultKey("moveLeft", KeyCodes.A);
        setDefaultKey("moveRight", KeyCodes.D);
        setDefaultKey("moveUp", KeyCodes.W);
        setDefaultKey("moveDown", KeyCodes.S);
        setDefaultKey("rotateLeft", KeyCodes.Q);
        setDefaultKey("rotateRight", KeyCodes.E);
        setDefaultKey("useSpecial", KeyCodes.SPACE);
        setDefaultKey("interact", KeyCodes.NUMBER_0);
        setDefaultKey("useInvSlot1", KeyCodes.NUMBER_1);
        setDefaultKey("useInvSlot2", KeyCodes.NUMBER_2);
        setDefaultKey("useInvSlot3", KeyCodes.NUMBER_3);
        setDefaultKey("useInvSlot4", KeyCodes.NUMBER_4);
        setDefaultKey("useInvSlot5", KeyCodes.NUMBER_5);
        setDefaultKey("useInvSlot6", KeyCodes.NUMBER_6);
        setDefaultKey("useInvSlot7", KeyCodes.NUMBER_7);
        setDefaultKey("useInvSlot8", KeyCodes.NUMBER_8);
        setDefaultKey("escapeToNexus2", KeyCodes.F5);
        setDefaultKey("escapeToNexus", KeyCodes.R);
        setDefaultKey("autofireToggle", KeyCodes.I);
        setDefaultKey("scrollChatUp", KeyCodes.PAGE_UP);
        setDefaultKey("scrollChatDown", KeyCodes.PAGE_DOWN);
        setDefaultKey("miniMapZoomOut", KeyCodes.MINUS);
        setDefaultKey("miniMapZoomIn", KeyCodes.EQUAL);
        setDefaultKey("resetToDefaultCameraAngle", KeyCodes.Z);
        setDefaultKey("togglePerformanceStats", KeyCodes.UNSET);
        setDefaultKey("options", KeyCodes.O);
        setDefaultKey("toggleCentering", KeyCodes.UNSET);
        setDefaultKey("chat", KeyCodes.ENTER);
        setDefaultKey("chatCommand", KeyCodes.SLASH);
        setDefaultKey("tell", KeyCodes.TAB);
        setDefaultKey("guildChat", KeyCodes.G);
        setDefaultKey("globalChat", KeyCodes.K)
        setDefaultKey("testOne", KeyCodes.PERIOD);
        setDefaultKey("toggleFullscreen", KeyCodes.UNSET);
        setDefaultKey("useHealthPotion", KeyCodes.F);
        setDefaultKey("GPURenderToggle", KeyCodes.UNSET);
        setDefaultKey("friendList", KeyCodes.UNSET);
        setDefaultKey("useMagicPotion", KeyCodes.V);
        setDefaultKey("switchTabs", KeyCodes.B);
        setDefaultKey("particleEffect", KeyCodes.P);
        setDefaultKey("toggleHPBar", KeyCodes.H);
        if(Capabilities.playerType == "Desktop")
        {
            _1wP_("GPURender",false);
        }
        else
        {
            _1wP_("GPURender",false);
        }
        setDefault("playerObjectType", 782);
        setDefault("playMusic", true);
        setDefault("playSFX", true);
        setDefault("playPewPew", true);
        setDefault("centerOnPlayer", true);
        setDefault("preferredServer", null);
        setDefault("needsTutorial", false);
        setDefault("needsRandomRealm", false);
        setDefault("cameraAngle", 7 * Math.PI / 4);
        setDefault("defaultCameraAngle", 7 * Math.PI / 4);
        setDefault("showQuestPortraits", true);
        setDefault("fullscreenMode", false);
        setDefault("showProtips", false);
        setDefault("protipIndex", 0);
        setDefault("joinDate", MoreDateUtil.getDayStringInPT());
        setDefault("lastDailyAnalytics", null);
        setDefault("allowRotation", false);
        setDefault("allowMiniMapRotation", false);
        setDefault("charIdUseMap", {});
        setDefault("drawShadows", false);
        setDefault("textBubbles", true);
        setDefault("showTradePopup", true);
        setDefault("paymentMethod", null);
        setDefault("filterLanguage", true);
        setDefault("showGuildInvitePopup", true);
        setDefault("showBeginnersOffer", true);
        setDefault("beginnersOfferTimeLeft", 30);
        setDefault("beginnersOfferShowNow", true);
        setDefault("beginnersOfferShowNowTime", 30);
        setDefault("watchForTutorialExit", false);
        setDefault("clickForGold", false);
        setDefault("contextualPotionBuy", true);
        setDefault("inventorySwap", true);
        setDefault("particleEffect", false);
        setDefault("cursorSelect", "10");
        setDefault("friendListDisplayFlag", false);
        setDefault("forceChatQuality", true);
        setDefault("hidePlayerChat", false);
        setDefault("chatStarRequirement", 0);
        setDefault("chatAll", true);
        setDefault("chatWhisper", true);
        setDefault("chatGuild", true);
        setDefault("chatTrade", true);
        setDefault("toggleBarText", false);
        setDefault("particleEffect", true);
        setDefault("friendList", KeyCodes.UNSET);
        setDefault("tradeWithFriends", false);
        setDefault("chatFriend", false);
        setDefault("friendStarRequirement", 0);
        setDefault("HPBar", true);

        setDefault("graphicsQuality", "Low");
        setDefault("outline", true);
        setDefault("allyProjs", true);


        if (Boolean(data_.hasOwnProperty("playMusic")) && data_.playMusic == true) {
            setDefault("musicVolume", 1);
        } else {
            setDefault("musicVolume", 0);
        }
        if (Boolean(data_.hasOwnProperty("playSFX")) && data_.playMusic == true) {
            setDefault("SFXVolume", 1);
        } else {
            setDefault("SFXVolume", 0);
        }

    }
}
}
