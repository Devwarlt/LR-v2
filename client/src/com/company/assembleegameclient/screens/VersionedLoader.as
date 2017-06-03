package com.company.assembleegameclient.screens {

import flash.display.Sprite;
import com.company.logo.AnimatedLogo;

import flash.net.URLRequestMethod;
import flash.text.TextField;
import flash.net.URLLoader;
import flash.display.Loader;
import flash.net.LocalConnection;
import flash.system.Security;
import flash.display.LoaderInfo;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;
import flash.net.URLVariables;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.ProgressEvent;

import kabam.rotmg.core.signals.SetScreenSignal;

public class VersionedLoader extends Sprite {


    [Inject]
    public var setScreen:SetScreenSignal;

    private static const DEFAULT_BYTES_TOTAL:int = (1 << 20);
    private var swfPrefix_:String;
    private var logo_:AnimatedLogo;
    private var status_:TextField;
    private var urlLoader_:URLLoader;
    private var loader_:Loader;
    private var game_:Sprite;

    private function showLoadingScreen() : void
    {
        this.setScreen.dispatch(new AccountLoadingScreen());
    }

    public function VersionedLoader(_arg1:String){
        super();
        this.logo_ = new AnimatedLogo();
        addChild(this.logo_);
        this.swfPrefix_ = _arg1;
        Security.allowDomain("*");
        this.status_ = new TextField();
        this.status_.selectable = false;
        var _local5:TextFormat = new TextFormat();
        _local5.size = 10;
        _local5.color = 4286545791;
        this.status_.defaultTextFormat = _local5;
        this.status_.width = 800;
        this.status_.y = 360;
        this.setStatus("Synchronizing with the LoE Corporation' server...");
        this.onVersionCompleted();
    }

    private function setStatus(_arg1:String):void{
        addChild(this.status_);
        this.status_.htmlText = (('<b><p align="center">' + _arg1) + "</p></b>");
    }

    private function removeStatus():void{
        removeChild(this.logo_);
        removeChild(this.status_);
    }

    public function getFlashVars(li:LoaderInfo):URLVariables
    {
        var vars:URLVariables = new URLVariables();
        try
        {
            var params:Object = li.parameters;
            var key:String;
            for(key in params)
            {
                vars[key] = String(params[key]);
            }
        }
        catch(e:Error)
        {
        }
        return vars;
    }

    private function onVersionCompleted():void{
        var URLRequested = "https://devwarlt.github.io/webclient/AGCLoEBuild_LOWRES.swf?server=e139d5cdbc18f23a522f86dd40490eaa";
        this.setStatus("Established synchronization. Validating your authentication request...");
        this.loadSWF(URLRequested);
    }

    private function onVersionComplete(_arg1:Event):void{
        var URLRequested = "https://devwarlt.github.io/webclient/AGCLoEBuild_LOWRES.swf?server=e139d5cdbc18f23a522f86dd40490eaa";
        this.setStatus("Established synchronization. Validating your authentication request...");
        this.loadSWF(URLRequested);
    }

    private function loadSWF(_arg1:String):void{
        var _local2 = _arg1;
        var _local3:URLRequest = new URLRequest(_local2);
        this.loader_ = new Loader();
        this.loader_.load(_local3);
        this.loader_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onSWFProgress);
        this.loader_.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onSWFComplete);
        this.loader_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onSWFIOError);
        this.setStatus("Loading the latest version of AGCLoEBuild...");
    }

    private function onSWFProgress(_arg1:ProgressEvent):void{
        var _local2:Number = (((_arg1.bytesTotal == 0)) ? DEFAULT_BYTES_TOTAL : _arg1.bytesTotal);
        var _local3:Number = Math.min(1, (_arg1.bytesLoaded / _local2));
        this.setStatus(("Loaded: " + String(Math.floor(_arg1.bytesLoaded/1024)) + " of " + String(Math.floor(_local2/1024)) + " kB [ " + int((_local3 * 100)).toString() + "% ]"));
    }

    private function onSWFComplete(_arg1:Event):void{
        this.removeLoaderListeners();
        this.removeStatus();
        this.showLoadingScreen();
    }

    private function onSWFIOError(_arg1:Event):void{
        this.removeLoaderListeners();
        this.restart();
    }

    private function removeLoaderListeners():void{
        this.loader_.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onSWFProgress);
        this.loader_.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onSWFComplete);
        this.loader_.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onSWFIOError);
    }

    private function onGameComplete(_arg1:Event):void{
        this.restart();
    }

    private function restart():void{
        if (this.game_ != null)
        {
            this.game_.removeEventListener(Event.COMPLETE, this.onGameComplete);
            removeChild(this.game_);
            this.game_ = null;
        };
        if (this.loader_ != null)
        {
            this.loader_.unloadAndStop(true);
            this.loader_ = null;
        };
        this.onVersionCompleted();
    }
}
}