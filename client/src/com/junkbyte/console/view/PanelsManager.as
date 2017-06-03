package com.junkbyte.console.view {
import com.junkbyte.console.Console;
import com.junkbyte.console.vos.GraphGroup;

import flash.events.Event;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

public class PanelsManager {

      private var console:Console;

      private var _mainPanel:MainPanel;

      private var _ruler:Ruler;

      private var _chsPanel:ChannelsPanel;

      private var _fpsPanel:GraphingPanel;

      private var _memPanel:GraphingPanel;

      private var _graphsMap:Object;

      private var _graphPlaced:uint = 0;

      private var _tooltipField:TextField;

      private var _canDraw:Boolean;

      public function PanelsManager(param1:Console) {
         this._graphsMap = {};
         super();
         this.console = param1;
         this._mainPanel = new MainPanel(this.console);
         this._tooltipField = this.mainPanel.makeTF("tooltip",true);
         this._tooltipField.mouseEnabled = false;
         this._tooltipField.autoSize = TextFieldAutoSize.CENTER;
         this._tooltipField.multiline = true;
         this.addPanel(this._mainPanel);
      }

      public function addPanel(param1:ConsolePanel) : void {
         if(this.console.contains(this._tooltipField)) {
            this.console.addChildAt(param1,this.console.getChildIndex(this._tooltipField));
         } else {
            this.console.addChild(param1);
         }
         param1.addEventListener(ConsolePanel.DRAGGING_STARTED,this.onPanelStartDragScale,false,0,true);
         param1.addEventListener(ConsolePanel.SCALING_STARTED,this.onPanelStartDragScale,false,0,true);
      }

      public function removePanel(param1:String) : void {
         var _local2:ConsolePanel = this.console.getChildByName(param1) as ConsolePanel;
         if(_local2) {
            _local2.close();
         }
      }

      public function getPanel(param1:String) : ConsolePanel {
         return this.console.getChildByName(param1) as ConsolePanel;
      }

      public function get mainPanel() : MainPanel {
         return this._mainPanel;
      }

      public function panelExists(param1:String) : Boolean {
         return !!(this.console.getChildByName(param1) as ConsolePanel)?true:false;
      }

      public function setPanelArea(param1:String, param2:Rectangle) : void {
         var _local3:ConsolePanel = this.getPanel(param1);
         if(_local3) {
            _local3.x = param2.x;
            _local3.y = param2.y;
            if(param2.width) {
               _local3.width = param2.width;
            }
            if(param2.height) {
               _local3.height = param2.height;
            }
         }
      }

      public function updateMenu() : void {
         this._mainPanel.updateMenu();
         var _local1:ChannelsPanel = this.getPanel(ChannelsPanel.NAME) as ChannelsPanel;
         if(_local1) {
            _local1.update();
         }
      }

      public function update(param1:Boolean, param2:Boolean) : void {
         this._canDraw = !param1;
         this._mainPanel.update(!param1 && Boolean(param2));
         if(!param1) {
            if(Boolean(param2) && this._chsPanel != null) {
               this._chsPanel.update();
            }
         }
      }

      public function updateGraphs(param1:Array) : void {
         var _local2:Object = null;
         var _local3:GraphGroup = null;
         var _local4:GraphGroup = null;
         var _local5:GraphGroup = null;
         var _local6:* = null;
         var _local7:String = null;
         var _local8:GraphingPanel = null;
         var _local9:Rectangle = null;
         var _local10:Number = NaN;
         var _local11:Number = NaN;
         var _local12:int = 0;
         var _local13:int = 0;
         this._graphPlaced = 0;
         for each(_local5 in param1) {
            if(_local5.type == GraphGroup.FPS) {
               _local3 = _local5;
            } else if(_local5.type == GraphGroup.MEM) {
               _local4 = _local5;
            } else {
               _local7 = _local5.name;
               _local8 = this._graphsMap[_local7] as GraphingPanel;
               if(!_local8) {
                  _local9 = _local5.rect;
                  if(_local9 == null) {
                     _local9 = new Rectangle(NaN,NaN,0,0);
                  }
                  _local10 = 100;
                  if(Boolean(isNaN(_local9.x)) || Boolean(isNaN(_local9.y))) {
                     if(this._mainPanel.width < 150) {
                        _local10 = 50;
                     }
                     _local11 = Math.floor(this._mainPanel.width / _local10) - 1;
                     if(_local11 <= 1) {
                        _local11 = 2;
                     }
                     _local12 = this._graphPlaced % _local11;
                     _local13 = Math.floor(this._graphPlaced / _local11);
                     _local9.x = this._mainPanel.x + _local10 + _local12 * _local10;
                     _local9.y = this._mainPanel.y + _local10 * 0.6 + _local13 * _local10;
                     this._graphPlaced++;
                  }
                  if(_local9.width <= 0 || Boolean(isNaN(_local9.width))) {
                     _local9.width = _local10;
                  }
                  if(_local9.height <= 0 || Boolean(isNaN(_local9.height))) {
                     _local9.height = _local10;
                  }
                  _local8 = new GraphingPanel(this.console,_local9.width,_local9.height);
                  _local8.x = _local9.x;
                  _local8.y = _local9.y;
                  _local8.name = "graph_" + _local7;
                  this._graphsMap[_local7] = _local8;
                  this.addPanel(_local8);
               }
               if(_local2 == null) {
                  _local2 = {};
               }
               _local2[_local7] = true;
               _local8.update(_local5,this._canDraw);
            }
         }
         for(_local6 in this._graphsMap) {
            if(_local2 == null || !_local2[_local6]) {
               this._graphsMap[_local6].close();
               delete this._graphsMap[_local6];
            }
         }
         if(_local3 != null) {
            if(this._fpsPanel == null) {
               this._fpsPanel = new GraphingPanel(this.console,80,40,GraphingPanel.FPS);
               this._fpsPanel.name = GraphingPanel.FPS;
               this._fpsPanel.x = this._mainPanel.x + this._mainPanel.width - 160;
               this._fpsPanel.y = this._mainPanel.y + 15;
               this.addPanel(this._fpsPanel);
               this._mainPanel.updateMenu();
            }
            this._fpsPanel.update(_local3,this._canDraw);
         } else if(this._fpsPanel != null) {
            this.removePanel(GraphingPanel.FPS);
            this._fpsPanel = null;
         }
         if(_local4 != null) {
            if(this._memPanel == null) {
               this._memPanel = new GraphingPanel(this.console,80,40,GraphingPanel.MEM);
               this._memPanel.name = GraphingPanel.MEM;
               this._memPanel.x = this._mainPanel.x + this._mainPanel.width - 80;
               this._memPanel.y = this._mainPanel.y + 15;
               this.addPanel(this._memPanel);
               this._mainPanel.updateMenu();
            }
            this._memPanel.update(_local4,this._canDraw);
         } else if(this._memPanel != null) {
            this.removePanel(GraphingPanel.MEM);
            this._memPanel = null;
         }
         this._canDraw = false;
      }

      public function removeGraph(param1:GraphGroup) : void {
         var _local2:GraphingPanel = null;
         if(Boolean(this._fpsPanel) && param1 == this._fpsPanel.group) {
            this._fpsPanel.close();
            this._fpsPanel = null;
         } else if(Boolean(this._memPanel) && param1 == this._memPanel.group) {
            this._memPanel.close();
            this._memPanel = null;
         } else {
            _local2 = this._graphsMap[param1.name];
            if(_local2) {
               _local2.close();
               delete this._graphsMap[param1.name];
            }
         }
      }

      public function get displayRoller() : Boolean {
         return !!(this.getPanel(RollerPanel.NAME) as RollerPanel)?true:false;
      }

      public function set displayRoller(param1:Boolean) : void {
         var _local2:RollerPanel = null;
         if(this.displayRoller != param1) {
            if(param1) {
               if(this.console.config.displayRollerEnabled) {
                  _local2 = new RollerPanel(this.console);
                  _local2.x = this._mainPanel.x + this._mainPanel.width - 180;
                  _local2.y = this._mainPanel.y + 55;
                  this.addPanel(_local2);
               } else {
                  this.console.report("Display roller is disabled in config.",9);
               }
            } else {
               this.removePanel(RollerPanel.NAME);
            }
            this._mainPanel.updateMenu();
         }
      }

      public function get channelsPanel() : Boolean {
         return this._chsPanel != null;
      }

      public function set channelsPanel(param1:Boolean) : void {
         if(this.channelsPanel != param1) {
            this.console.logs.cleanChannels();
            if(param1) {
               this._chsPanel = new ChannelsPanel(this.console);
               this._chsPanel.x = this._mainPanel.x + this._mainPanel.width - 332;
               this._chsPanel.y = this._mainPanel.y - 2;
               this.addPanel(this._chsPanel);
               this._chsPanel.update();
               this.updateMenu();
            } else {
               this.removePanel(ChannelsPanel.NAME);
               this._chsPanel = null;
            }
            this.updateMenu();
         }
      }

      public function get memoryMonitor() : Boolean {
         return this._memPanel != null;
      }

      public function get fpsMonitor() : Boolean {
         return this._fpsPanel != null;
      }

      public function tooltip(param1:String = null, param2:ConsolePanel = null) : void {
         var _local3:Array = null;
         var _local4:Rectangle = null;
         var _local5:Rectangle = null;
         var _local6:Number = NaN;
         var _local7:Number = NaN;
         var _local8:Number = NaN;
         if(Boolean(param1) && !this.rulerActive) {
            _local3 = param1.split("::");
            param1 = _local3[0];
            if(_local3.length > 1) {
               param1 = param1 + ("<br/><low>" + _local3[1] + "</low>");
            }
            this.console.addChild(this._tooltipField);
            this._tooltipField.wordWrap = false;
            this._tooltipField.htmlText = "<tt>" + param1 + "</tt>";
            if(this._tooltipField.width > 120) {
               this._tooltipField.width = 120;
               this._tooltipField.wordWrap = true;
            }
            this._tooltipField.x = this.console.mouseX - this._tooltipField.width / 2;
            this._tooltipField.y = this.console.mouseY + 20;
            if(param2) {
               _local4 = this._tooltipField.getBounds(this.console);
               _local5 = new Rectangle(param2.x,param2.y,param2.width,param2.height);
               _local6 = _local4.bottom - _local5.bottom;
               if(_local6 > 0) {
                  if(this._tooltipField.y - _local6 > this.console.mouseY + 15) {
                     this._tooltipField.y = this._tooltipField.y - _local6;
                  } else if(_local5.y < this.console.mouseY - 24 && _local4.y > _local5.bottom) {
                     this._tooltipField.y = this.console.mouseY - this._tooltipField.height - 15;
                  }
               }
               _local7 = _local4.left - _local5.left;
               _local8 = _local4.right - _local5.right;
               if(_local7 < 0) {
                  this._tooltipField.x = this._tooltipField.x - _local7;
               } else if(_local8 > 0) {
                  this._tooltipField.x = this._tooltipField.x - _local8;
               }
            }
         } else if(this.console.contains(this._tooltipField)) {
            this.console.removeChild(this._tooltipField);
         }
      }

      public function startRuler() : void {
         if(this.rulerActive) {
            return;
         }
         this._ruler = new Ruler(this.console);
         this._ruler.addEventListener(Event.COMPLETE,this.onRulerExit,false,0,true);
         this.console.addChild(this._ruler);
         this._mainPanel.updateMenu();
      }

      public function get rulerActive() : Boolean {
         return Boolean(this._ruler) && Boolean(this.console.contains(this._ruler))?true:false;
      }

      private function onRulerExit(param1:Event) : void {
         if(Boolean(this._ruler) && Boolean(this.console.contains(this._ruler))) {
            this.console.removeChild(this._ruler);
         }
         this._ruler = null;
         this._mainPanel.updateMenu();
      }

      private function onPanelStartDragScale(param1:Event) : void {
         var _local3:Array = null;
         var _local4:Array = null;
         var _local5:int = 0;
         var _local6:int = 0;
         var _local7:ConsolePanel = null;
         var _local2:ConsolePanel = param1.currentTarget as ConsolePanel;
         if(this.console.config.style.panelSnapping) {
            _local3 = [0];
            _local4 = [0];
            if(this.console.stage) {
               _local3.push(this.console.stage.stageWidth);
               _local4.push(this.console.stage.stageHeight);
            }
            _local5 = this.console.numChildren;
            _local6 = 0;
            while(_local6 < _local5) {
               _local7 = this.console.getChildAt(_local6) as ConsolePanel;
               if(Boolean(_local7) && Boolean(_local7.visible)) {
                  _local3.push(_local7.x,_local7.x + _local7.width);
                  _local4.push(_local7.y,_local7.y + _local7.height);
               }
               _local6++;
            }
            _local2.registerSnaps(_local3,_local4);
         }
      }
   }
}
