package com.company.assembleegameclient.map {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.background.Background;
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1;
import com.company.assembleegameclient.map.LOEBUILD_4a218ca1436fee34076fdca93698bac4.LOEBUILD_2f05f88d589905f707225941d764de4a;
import com.company.assembleegameclient.map.LOEBUILD_8640380935243b4a9c3cbd5e4ae3bef6.LOEBUILD_991b09fca81e41ffa4e060448ae08469;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.BasicObject;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_094a173d3b32f44f5b5c996e8710ae28;
import kabam.rotmg.assets.model.Player;

import flash.display.Sprite;
import flash.geom.Point;
import flash.utils.Dictionary;

import org.osflash.signals.Signal;

public class LOEBUILD_fa44c2f4ed610d0a29b25a8fff9d67e7 extends Sprite {

    public var goDict_:Dictionary;

    public var gs_:LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1;

    public var name_:String;

    public var player_:Player = null;

    public var commune:GameObject;

    public var showDisplays_:Boolean;

    public var width_:int;

    public var height_:int;

    public var back_:int;

    protected var allowPlayerTeleport_:Boolean;

    public var background_:Background = null;

    public var map_:Sprite;

    public var hurtOverlay_:LOEBUILD_f06c851ce2d9a81f297bdf8e78e4e2e9 = null;

    public var mapOverlay_:LOEBUILD_2f05f88d589905f707225941d764de4a = null;

    public var partyOverlay_:LOEBUILD_991b09fca81e41ffa4e060448ae08469 = null;

    public var squareList_:Vector.<Square>;

    public var squares_:Vector.<Square>;

    public var boDict_:Dictionary;

    public var merchLookup_:Object;

    public var party_:LOEBUILD_094a173d3b32f44f5b5c996e8710ae28 = null;

    public var quest_:Quest = null;

    public var signalRenderSwitch:Signal;

    protected var wasLastFrameGpu:Boolean = false;

    public var isPetYard:Boolean = false;

    public function LOEBUILD_fa44c2f4ed610d0a29b25a8fff9d67e7() {
        this.goDict_ = new Dictionary();
        this.map_ = new Sprite();
        this.squareList_ = new Vector.<Square>();
        this.squares_ = new Vector.<Square>();
        this.boDict_ = new Dictionary();
        this.merchLookup_ = new Object();
        this.signalRenderSwitch = new Signal(Boolean);
        super();
    }

    public function setProps(param1:int, param2:int, param3:String, param4:int, param5:Boolean, param6:Boolean, param7:String):void {
    }

    public function addObj(param1:BasicObject, param2:Number, param3:Number):void {
    }

    public function setGroundTile(param1:int, param2:int, param3:uint):void {
    }

    public function initialize():void {
    }

    public function resetOverlays():void {

    }

    public function dispose():void {
    }

    public function update(param1:int, param2:int):void {
    }

    public function pSTopW(param1:Number, param2:Number):Point {
        return null;
    }

    public function removeObj(param1:int):void {
    }

    public function draw(param1:Camera, param2:int):void {
    }

    public function allowPlayerTeleport():Boolean {
        return this.name_ != Map.NEXUS && Boolean(this.allowPlayerTeleport_);
    }
}
}
