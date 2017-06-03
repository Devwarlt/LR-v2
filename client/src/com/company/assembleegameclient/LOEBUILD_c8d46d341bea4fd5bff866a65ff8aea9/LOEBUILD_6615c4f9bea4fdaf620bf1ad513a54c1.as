package com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9 {
import com.company.assembleegameclient.map.LOEBUILD_fa44c2f4ed610d0a29b25a8fff9d67e7;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.tutorial.Tutorial;

import flash.display.Sprite;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.messaging.impl.incoming.MapInfo;
import kabam.rotmg.ui.view.HUDView;

import org.osflash.signals.Signal;

public class LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1 extends Sprite {

    public const closed:Signal = new Signal();

    public var isEditor:Boolean;

    public var tutorial_:Tutorial;

    public var mui_:LOEBUILD_e5f69906f41a111ba59048ec6958248a;

    public var lastUpdate_:int;

    public var moveRecords_:LOEBUILD_ca1a130cf55eeca137e77c883bf49f98;

    public var map:LOEBUILD_fa44c2f4ed610d0a29b25a8fff9d67e7;

    public var model:PlayerModel;

    public var hudView:HUDView;

    public var camera_:Camera;

    public var gsc_:GameServerConnection;

    public function LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1() {
        this.moveRecords_ = new LOEBUILD_ca1a130cf55eeca137e77c883bf49f98();
        this.camera_ = new Camera();
        super();
    }

    public function initialize():void {
    }

    public function setFocus(param1:GameObject):void {
    }

    public function applyMapInfo(param1:MapInfo):void {
    }

    public function evalIsNotInCombatMapArea():Boolean {
        return false;
    }
}
}
