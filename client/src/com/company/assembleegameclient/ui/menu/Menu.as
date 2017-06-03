package com.company.assembleegameclient.ui.menu {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.util.GraphicsUtil;
import com.company.util.RectangleUtil;

import flash.display.CapsStyle;
import flash.display.DisplayObjectContainer;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;

import kabam.rotmg.ui.view.UnFocusAble;

public class Menu extends Sprite implements UnFocusAble {

    private var backgroundFill_:GraphicsSolidFill;

    private var outlineFill_:GraphicsSolidFill;

    private var lineStyle_:GraphicsStroke;

    private var path_:GraphicsPath;

    private var graphicsData_:Vector.<IGraphicsData>;

    private var background_:uint;

    private var outline_:uint;

    protected var yOffset:int;

    public function Menu(param1:uint, param2:uint) {
        this.backgroundFill_ = new GraphicsSolidFill(0, 1);
        this.outlineFill_ = new GraphicsSolidFill(0, 1);
        this.lineStyle_ = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, this.outlineFill_);
        this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        this.graphicsData_ = new <IGraphicsData>[lineStyle_, backgroundFill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        super();
        this.background_ = param1;
        this.outline_ = param2;
        this.yOffset = 40;
        filters = [new DropShadowFilter(0, 0, 0, 1, 16, 16)];
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    protected function addOption(param1:MenuOption):void {
        param1.x = 8;
        param1.y = this.yOffset;
        addChild(param1);
        this.yOffset = this.yOffset + 28;
    }

    protected function onAddedToStage(param1:Event):void {
        this.draw();
        this.position();
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
    }

    protected function onRemovedFromStage(param1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
    }

    protected function onEnterFrame(param1:Event):void {
        if (stage == null) {
            return;
        }
        var _local2:Rectangle = getRect(stage);
        var _local3:Number = RectangleUtil.pointDist(_local2, stage.mouseX, stage.mouseY);
        if (_local3 > 40) {
            this.remove();
        }
    }

    public function scaleParent(param1:Boolean):void {
        var _local2:DisplayObjectContainer = null;
        if (this.parent is GameSprite) {
            _local2 = this;
        } else {
            _local2 = this.parent;
        }
        var _local3:Number = stage.stageWidth / 800;
        var _local4:Number = stage.stageHeight / 600;
        if (param1) {
            _local2.scaleX = _local4 / _local3;
            _local2.scaleY = 1;
        } else {
            _local2.scaleX = 1 / _local3;
            _local2.scaleY = 1 / _local4;
        }
    }

    private function position():void {
        var _local1:*;
        var _local3:Number;
        if (stage == null) {
            return;
        }
        _local1 = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["uiscale"];
        this.scaleParent(_local1);
        var _local2:Number = stage.mouseX + (stage.stageWidth - 800) / 2;
        _local3 = stage.mouseY + (stage.stageHeight - 600) / 2;
        var _local4:Number = 1;
        var _local5:Number = 1;
        if (_local1) {
            _local2 = _local2 * (600 / stage.stageHeight);
            _local3 = _local3 * (600 / stage.stageHeight);
            if (this.parent is GameSprite) {
                _local4 = 800 / stage.stageWidth / (600 / stage.stageHeight);
            }
        } else if (this.parent is GameSprite) {
            _local4 = 800 / stage.stageWidth;
            _local5 = 600 / stage.stageHeight;
        }
        if (stage.mouseX + stage.stageWidth / 2 - 400 < stage.stageWidth / 2) {
            x = (_local2 + 12) * _local4;
        } else if (!_local1 && this.parent is GameSprite) {
            x = (_local2 - width) * _local4 - 1;
        } else {
            x = _local2 * _local4 - width - 1;
        }
        if (x < 12) {
            x = 12;
        }
        if (stage.mouseY + stage.stageHeight / 2 - 300 < stage.stageHeight / 3) {
            y = (_local3 + 12) * _local5;
        } else if (!_local1 && this.parent is GameSprite) {
            y = (_local3 - height) * _local5 - 1;
        } else {
            y = _local3 * _local5 - height - 1;
        }
        if (y < 12) {
            y = 12;
        }
    }

    protected function onRollOut(param1:Event):void {
        this.remove();
    }

    public function remove():void {
        if (parent != null) {
            parent.removeChild(this);
        }
    }

    protected function draw():void {
        this.backgroundFill_.color = this.background_;
        this.outlineFill_.color = this.outline_;
        graphics.clear();
        GraphicsUtil.clearPath(this.path_);
        GraphicsUtil.drawCutEdgeRect(-6, -6, Math.max(154, width + 12), height + 12, 4, [1, 1, 1, 1], this.path_);
        graphics.drawGraphicsData(this.graphicsData_);
    }
}
}
