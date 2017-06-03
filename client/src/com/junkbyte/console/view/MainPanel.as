package com.junkbyte.console.view {
import com.junkbyte.console.Console;
import com.junkbyte.console.core.LogReferences;
import com.junkbyte.console.core.Remoting;
import com.junkbyte.console.vos.Log;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.geom.ColorTransform;
import flash.geom.Rectangle;
import flash.net.FileReference;
import flash.system.Security;
import flash.system.SecurityPanel;
import flash.system.System;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.ui.Keyboard;

public class MainPanel extends ConsolePanel {

      public static const NAME:String = "mainPanel";

      private static const CL_HISTORY:String = "clhistory";

      private static const VIEWING_CH_HISTORY:String = "viewingChannels";

      private static const IGNORED_CH_HISTORY:String = "ignoredChannels";

      private static const PRIORITY_HISTORY:String = "priority";

      private var _traceField:TextField;

      private var _cmdPrefx:TextField;

      private var _cmdField:TextField;

      private var _hintField:TextField;

      private var _cmdBG:Shape;

      private var _bottomLine:Shape;

      private var _mini:Boolean;

      private var _shift:Boolean;

      private var _ctrl:Boolean;

      private var _alt:Boolean;

      private var _scroll:Sprite;

      private var _scroller:Sprite;

      private var _scrolldelay:uint;

      private var _scrolldir:int;

      private var _scrolling:Boolean;

      private var _scrollHeight:Number;

      private var _selectionStart:int;

      private var _selectionEnd:int;

      private var _viewingChannels:Array;

      private var _ignoredChannels:Array;

      private var _extraMenus:Object;

      private var _cmdsInd:int = -1;

      private var _priority:uint;

      private var _filterText:String;

      private var _filterRegExp:RegExp;

      private var _clScope:String = "";

      private var _needUpdateMenu:Boolean;

      private var _needUpdateTrace:Boolean;

      private var _lockScrollUpdate:Boolean;

      private var _atBottom:Boolean = true;

      private var _enteringLogin:Boolean;

      private var _hint:String;

      private var _cmdsHistory:Array;

      public function MainPanel(param1:Console) {
         this._extraMenus = new Object();
         super(param1);
         var _local2:int = style.menuFontSize;
         console.cl.addCLCmd("filter",this.setFilterText,"Filter LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4 logs to matching string. When done, click on the * (global channel) at top.",true);
         console.cl.addCLCmd("filterexp",this.setFilterRegExp,"Filter LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4 logs to matching regular expression",true);
         console.cl.addCLCmd("clearhistory",this.clearCommandLineHistory,"Clear history of commands you have entered.",true);
         name = NAME;
         minWidth = 50;
         minHeight = 18;
         this._traceField = makeTF("traceField");
         this._traceField.wordWrap = true;
         this._traceField.multiline = true;
         this._traceField.y = _local2;
         this._traceField.addEventListener(Event.SCROLL,this.onTraceScroll);
         addChild(this._traceField);
         txtField = makeTF("menuField");
         txtField.wordWrap = true;
         txtField.multiline = true;
         txtField.autoSize = TextFieldAutoSize.RIGHT;
         txtField.height = _local2 + 6;
         txtField.y = -2;
         registerTFRoller(txtField,this.onMenuRollOver);
         addChild(txtField);
         this._cmdBG = new Shape();
         this._cmdBG.name = "commandBackground";
         this._cmdBG.graphics.beginFill(style.commandLineColor,0.1);
         this._cmdBG.graphics.drawRoundRect(0,0,100,18,_local2,_local2);
         this._cmdBG.scale9Grid = new Rectangle(9,9,80,1);
         addChild(this._cmdBG);
         var _local3:TextFormat = new TextFormat(style.menuFont,style.menuFontSize,style.highColor);
         this._cmdField = new TextField();
         this._cmdField.name = "commandField";
         this._cmdField.type = TextFieldType.INPUT;
         this._cmdField.x = 40;
         this._cmdField.height = _local2 + 6;
         this._cmdField.addEventListener(KeyboardEvent.KEY_DOWN,this.commandKeyDown);
         this._cmdField.addEventListener(KeyboardEvent.KEY_UP,this.commandKeyUp);
         this._cmdField.addEventListener(FocusEvent.FOCUS_IN,this.updateCmdHint);
         this._cmdField.addEventListener(FocusEvent.FOCUS_OUT,this.onCmdFocusOut);
         this._cmdField.defaultTextFormat = _local3;
         addChild(this._cmdField);
         this._hintField = makeTF("hintField",true);
         this._hintField.mouseEnabled = false;
         this._hintField.x = this._cmdField.x;
         this._hintField.autoSize = TextFieldAutoSize.LEFT;
         addChild(this._hintField);
         this.setHints();
         _local3.color = style.commandLineColor;
         this._cmdPrefx = new TextField();
         this._cmdPrefx.name = "commandPrefx";
         this._cmdPrefx.type = TextFieldType.DYNAMIC;
         this._cmdPrefx.x = 2;
         this._cmdPrefx.height = _local2 + 6;
         this._cmdPrefx.selectable = false;
         this._cmdPrefx.defaultTextFormat = _local3;
         this._cmdPrefx.addEventListener(MouseEvent.MOUSE_DOWN,this.onCmdPrefMouseDown);
         this._cmdPrefx.addEventListener(MouseEvent.MOUSE_MOVE,this.onCmdPrefRollOverOut);
         this._cmdPrefx.addEventListener(MouseEvent.ROLL_OUT,this.onCmdPrefRollOverOut);
         addChild(this._cmdPrefx);
         this._bottomLine = new Shape();
         this._bottomLine.name = "blinkLine";
         this._bottomLine.alpha = 0.2;
         addChild(this._bottomLine);
         this._scroll = new Sprite();
         this._scroll.name = "scroller";
         this._scroll.tabEnabled = false;
         this._scroll.y = _local2 + 4;
         this._scroll.buttonMode = true;
         this._scroll.addEventListener(MouseEvent.MOUSE_DOWN,this.onScrollbarDown,false,0,true);
         this._scroller = new Sprite();
         this._scroller.name = "scrollbar";
         this._scroller.tabEnabled = false;
         this._scroller.y = style.controlSize;
         this._scroller.graphics.beginFill(style.controlColor,1);
         this._scroller.graphics.drawRect(-style.controlSize,0,style.controlSize,30);
         this._scroller.graphics.beginFill(0,0);
         this._scroller.graphics.drawRect(-style.controlSize * 2,0,style.controlSize * 2,30);
         this._scroller.graphics.endFill();
         this._scroller.addEventListener(MouseEvent.MOUSE_DOWN,this.onScrollerDown,false,0,true);
         this._scroll.addChild(this._scroller);
         addChild(this._scroll);
         this._cmdField.visible = false;
         this._cmdPrefx.visible = false;
         this._cmdBG.visible = false;
         this.updateCLScope("");
         init(640,100,true);
         registerDragger(txtField);
         if(console.so[CL_HISTORY] is Array) {
            this._cmdsHistory = console.so[CL_HISTORY];
         } else {
            console.so[CL_HISTORY] = this._cmdsHistory = new Array();
         }
         if(Boolean(config.rememberFilterSettings) && console.so[VIEWING_CH_HISTORY] is Array) {
            this._viewingChannels = console.so[VIEWING_CH_HISTORY];
         } else {
            console.so[VIEWING_CH_HISTORY] = this._viewingChannels = new Array();
         }
         if(Boolean(config.rememberFilterSettings) && console.so[IGNORED_CH_HISTORY] is Array) {
            this._ignoredChannels = console.so[IGNORED_CH_HISTORY];
         }
         if(this._viewingChannels.length > 0 || this._ignoredChannels == null) {
            console.so[IGNORED_CH_HISTORY] = this._ignoredChannels = new Array();
         }
         if(Boolean(config.rememberFilterSettings) && console.so[PRIORITY_HISTORY] is uint) {
            this._priority = console.so[PRIORITY_HISTORY];
         }
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,false,0,true);
         addEventListener(TextEvent.LINK,this.linkHandler,false,0,true);
         addEventListener(Event.ADDED_TO_STAGE,this.stageAddedHandle,false,0,true);
         addEventListener(Event.REMOVED_FROM_STAGE,this.stageRemovedHandle,false,0,true);
      }

      public function addMenu(param1:String, param2:Function, param3:Array, param4:String) : void {
         if(param1) {
            param1 = param1.replace(new RegExp("[^\\w]*","g"),"");
            if(param2 == null) {
               delete this._extraMenus[param1];
            } else {
               this._extraMenus[param1] = new Array(param2,param3,param4);
            }
            this._needUpdateMenu = true;
         } else {
            console.report("ERROR: Invalid add menu params.",9);
         }
      }

      private function stageAddedHandle(param1:Event = null) : void {
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDown,true,0,true);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler,false,0,true);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler,false,0,true);
      }

      private function stageRemovedHandle(param1:Event = null) : void {
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDown,true);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
      }

      private function onStageMouseDown(param1:MouseEvent) : void {
         this._shift = param1.shiftKey;
         this._ctrl = param1.ctrlKey;
         this._alt = param1.altKey;
      }

      private function onMouseWheel(param1:MouseEvent) : void {
         var _local2:int = 0;
         if(this._shift) {
            _local2 = console.config.style.traceFontSize + (param1.delta > 0?1:-1);
            if(_local2 > 10 && _local2 < 20) {
               console.config.style.traceFontSize = _local2;
               console.config.style.updateStyleSheet();
               this.updateToBottom();
               param1.stopPropagation();
            }
         }
      }

      private function onCmdPrefRollOverOut(param1:MouseEvent) : void {
         console.panels.tooltip(param1.type == MouseEvent.MOUSE_MOVE?"Current scope::(CommandLine)":"",this);
      }

      private function onCmdPrefMouseDown(param1:MouseEvent) : void {
         try {
            stage.focus = this._cmdField;
            this.setCLSelectionAtEnd();
            return;
         }
         catch(err:Error) {
            return;
         }
      }

      private function keyDownHandler(param1:KeyboardEvent) : void {
         if(param1.keyCode == Keyboard.SHIFT) {
            this._shift = true;
         }
         if(param1.keyCode == Keyboard.CONTROL) {
            this._ctrl = true;
         }
         if(param1.keyCode == 18) {
            this._alt = true;
         }
      }

      private function keyUpHandler(param1:KeyboardEvent) : void {
         if(param1.keyCode == Keyboard.SHIFT) {
            this._shift = false;
         } else if(param1.keyCode == Keyboard.CONTROL) {
            this._ctrl = false;
         } else if(param1.keyCode == 18) {
            this._alt = false;
         }
         if((param1.keyCode == Keyboard.TAB || param1.keyCode == Keyboard.ENTER) && Boolean(parent.visible) && Boolean(visible) && Boolean(this._cmdField.visible)) {
            try {
               stage.focus = this._cmdField;
               this.setCLSelectionAtEnd();
               return;
            }
            catch(err:Error) {
               return;
            }
         }
      }

      public function requestLogin(param1:Boolean = true) : void {
         var _local2:ColorTransform = new ColorTransform();
         if(param1) {
            console.commandLine = true;
            console.report("//",-2);
            console.report("// <b>Enter remoting password</b> in CommandLine below...",-2);
            this.updateCLScope("Password");
            _local2.color = style.controlColor;
            this._cmdBG.transform.colorTransform = _local2;
            this._traceField.transform.colorTransform = new ColorTransform(0.7,0.7,0.7);
         } else {
            this.updateCLScope("");
            this._cmdBG.transform.colorTransform = _local2;
            this._traceField.transform.colorTransform = _local2;
         }
         this._cmdField.displayAsPassword = param1;
         this._enteringLogin = param1;
      }

      public function update(param1:Boolean) : void {
         if(this._bottomLine.alpha > 0) {
            this._bottomLine.alpha = this._bottomLine.alpha - 0.25;
         }
         if(style.showCommandLineScope) {
            if(this._clScope != console.cl.scopeString) {
               this._clScope = console.cl.scopeString;
               this.updateCLScope(this._clScope);
            }
         } else if(this._clScope != null) {
            this._clScope = "";
            this.updateCLScope("");
         }
         if(param1) {
            this._bottomLine.alpha = 1;
            this._needUpdateMenu = true;
            this._needUpdateTrace = true;
         }
         if(this._needUpdateTrace) {
            this._needUpdateTrace = false;
            this._updateTraces(true);
         }
         if(this._needUpdateMenu) {
            this._needUpdateMenu = false;
            this._updateMenu();
         }
      }

      public function updateToBottom() : void {
         this._atBottom = true;
         this._needUpdateTrace = true;
      }

      private function _updateTraces(param1:Boolean = false) : void {
         if(this._atBottom) {
            this.updateBottom();
         } else if(!param1) {
            this.updateFull();
         }
         if(this._selectionStart != this._selectionEnd) {
            if(this._atBottom) {
               this._traceField.setSelection(this._traceField.text.length - this._selectionStart,this._traceField.text.length - this._selectionEnd);
            } else {
               this._traceField.setSelection(this._traceField.text.length - this._selectionEnd,this._traceField.text.length - this._selectionStart);
            }
            this._selectionEnd = -1;
            this._selectionStart = -1;
         }
      }

      private function updateFull() : void {
         var _local1:String = "";
         var _local2:Log = console.logs.first;
         var _local3:* = this._viewingChannels.length != 1;
         var _local4:Boolean = this._priority == 0 && this._viewingChannels.length == 0;
         while(_local2) {
            if(Boolean(_local4) || Boolean(this.lineShouldShow(_local2))) {
               _local1 = _local1 + this.makeLine(_local2,_local3);
            }
            _local2 = _local2.next;
         }
         this._lockScrollUpdate = true;
         this._traceField.htmlText = "<logs>" + _local1 + "</logs>";
         this._lockScrollUpdate = false;
         this.updateScroller();
      }

      public function setPaused(param1:Boolean) : void {
         if(Boolean(param1) && Boolean(this._atBottom)) {
            this._atBottom = false;
            this._updateTraces();
            this._traceField.scrollV = this._traceField.maxScrollV;
         } else if(!param1) {
            this._atBottom = true;
            this.updateBottom();
         }
         this.updateMenu();
      }

      private function updateBottom() : void {
         var _local6:int = 0;
         var _local1:String = "";
         var _local2:int = Math.round(this._traceField.height / style.traceFontSize);
         var _local3:int = Math.round(this._traceField.width * 5 / style.traceFontSize);
         var _local4:Log = console.logs.last;
         var _local5:* = this._viewingChannels.length != 1;
         while(_local4) {
            if(this.lineShouldShow(_local4)) {
               _local6 = Math.ceil(_local4.text.length / _local3);
               if(Boolean(_local4.html) || _local2 >= _local6) {
                  _local1 = this.makeLine(_local4,_local5) + _local1;
                  _local2 = _local2 - _local6;
                  if(_local2 <= 0) {
                     break;
                  }
               } else {
                  _local4 = _local4.clone();
                  _local4.text = _local4.text.substring(Math.max(0,_local4.text.length - _local3 * _local2));
                  _local1 = this.makeLine(_local4,_local5) + _local1;
                  break;
               }
            }
            _local4 = _local4.prev;
         }
         this._lockScrollUpdate = true;
         this._traceField.htmlText = "<logs>" + _local1 + "</logs>";
         this._traceField.scrollV = this._traceField.maxScrollV;
         this._lockScrollUpdate = false;
         this.updateScroller();
      }

      private function lineShouldShow(param1:Log) : Boolean {
         return (this._priority == 0 || param1.priority >= this._priority) && (Boolean(this.chShouldShow(param1.ch)) || Boolean(this._filterText && this._viewingChannels.indexOf(Console.FILTER_CHANNEL) >= 0 && param1.text.toLowerCase().indexOf(this._filterText) >= 0) || Boolean(this._filterRegExp && this._viewingChannels.indexOf(Console.FILTER_CHANNEL) >= 0) && param1.text.search(this._filterRegExp) >= 0);
      }

      private function chShouldShow(param1:String) : Boolean {
         return (this._viewingChannels.length == 0 || this._viewingChannels.indexOf(param1) >= 0) && (this._ignoredChannels.length == 0 || this._ignoredChannels.indexOf(param1) < 0);
      }

      public function get reportChannel() : String {
         return this._viewingChannels.length == 1?this._viewingChannels[0]:Console.CONSOLE_CHANNEL;
      }

      public function setViewingChannels(... rest) : void {
         var _local3:Object = null;
         var _local4:String = null;
         var _local2:Array = new Array();
         for each(_local3 in rest) {
            _local2.push(Console.MakeChannelName(_local3));
         }
         if(this._viewingChannels[0] == LogReferences.INSPECTING_CHANNEL && (!_local2 || _local2[0] != this._viewingChannels[0])) {
            console.refs.exitFocus();
         }
         this._ignoredChannels.splice(0);
         this._viewingChannels.splice(0);
         if(_local2.indexOf(Console.GLOBAL_CHANNEL) < 0 && _local2.indexOf(null) < 0) {
            for each(_local4 in _local2) {
               if(_local4) {
                  this._viewingChannels.push(_local4);
               }
            }
         }
         this.updateToBottom();
         console.panels.updateMenu();
      }

      public function get viewingChannels() : Array {
         return this._viewingChannels;
      }

      public function setIgnoredChannels(... rest) : void {
         var _local3:Object = null;
         var _local4:String = null;
         var _local2:Array = new Array();
         for each(_local3 in rest) {
            _local2.push(Console.MakeChannelName(_local3));
         }
         if(this._viewingChannels[0] == LogReferences.INSPECTING_CHANNEL) {
            console.refs.exitFocus();
         }
         this._ignoredChannels.splice(0);
         this._viewingChannels.splice(0);
         if(_local2.indexOf(Console.GLOBAL_CHANNEL) < 0 && _local2.indexOf(null) < 0) {
            for each(_local4 in _local2) {
               if(_local4) {
                  this._ignoredChannels.push(_local4);
               }
            }
         }
         this.updateToBottom();
         console.panels.updateMenu();
      }

      public function get ignoredChannels() : Array {
         return this._ignoredChannels;
      }

      private function setFilterText(param1:String = "") : void {
         if(param1) {
            this._filterRegExp = null;
            this._filterText = LogReferences.EscHTML(param1.toLowerCase());
            this.startFilter();
         } else {
            this.endFilter();
         }
      }

      private function setFilterRegExp(param1:String = "") : void {
         if(param1) {
            this._filterText = null;
            this._filterRegExp = new RegExp(LogReferences.EscHTML(param1),"gi");
            this.startFilter();
         } else {
            this.endFilter();
         }
      }

      private function startFilter() : void {
         console.clear(Console.FILTER_CHANNEL);
         console.logs.addChannel(Console.FILTER_CHANNEL);
         this.setViewingChannels(Console.FILTER_CHANNEL);
      }

      private function endFilter() : void {
         this._filterRegExp = null;
         this._filterText = null;
         if(this._viewingChannels.length == 1 && this._viewingChannels[0] == Console.FILTER_CHANNEL) {
            this.setViewingChannels(Console.GLOBAL_CHANNEL);
         }
      }

      private function makeLine(param1:Log, param2:Boolean) : String {
         var _local3:String = "<p>";
         if(param2) {
            _local3 = _local3 + param1.chStr;
         }
         if(config.showLineNumber) {
            _local3 = _local3 + param1.lineStr;
         }
         if(config.showTimestamp) {
            _local3 = _local3 + param1.timeStr;
         }
         var _local4:String = "p" + param1.priority;
         return _local3 + "<" + _local4 + ">" + this.addFilterText(param1.text) + "</" + _local4 + "></p>";
      }

      private function addFilterText(param1:String) : String {
         var _local2:Object = null;
         var _local3:int = 0;
         var _local4:String = null;
         var _local5:String = null;
         var _local6:int = 0;
         if(this._filterRegExp) {
            this._filterRegExp.lastIndex = 0;
            _local2 = this._filterRegExp.exec(param1);
            while(_local2 != null) {
               _local3 = _local2.index;
               _local4 = _local2[0];
               if(_local4.search("<|>") >= 0) {
                  this._filterRegExp.lastIndex = this._filterRegExp.lastIndex - (_local4.length - _local4.search("<|>"));
               } else if(param1.lastIndexOf("<",_local3) <= param1.lastIndexOf(">",_local3)) {
                  param1 = param1.substring(0,_local3) + "<u>" + param1.substring(_local3,_local3 + _local4.length) + "</u>" + param1.substring(_local3 + _local4.length);
                  this._filterRegExp.lastIndex = this._filterRegExp.lastIndex + 7;
               }
               _local2 = this._filterRegExp.exec(param1);
            }
         } else if(this._filterText) {
            _local5 = param1.toLowerCase();
            _local6 = _local5.lastIndexOf(this._filterText);
            while(_local6 >= 0) {
               param1 = param1.substring(0,_local6) + "<u>" + param1.substring(_local6,_local6 + this._filterText.length) + "</u>" + param1.substring(_local6 + this._filterText.length);
               _local6 = _local5.lastIndexOf(this._filterText,_local6 - 2);
            }
         }
         return param1;
      }

      private function onTraceScroll(param1:Event = null) : void {
         var _local3:int = 0;
         if(Boolean(this._lockScrollUpdate) || Boolean(this._shift)) {
            return;
         }
         var _local2:* = this._traceField.scrollV >= this._traceField.maxScrollV;
         if(!console.paused && this._atBottom != _local2) {
            _local3 = this._traceField.maxScrollV - this._traceField.scrollV;
            this._selectionStart = this._traceField.text.length - this._traceField.selectionBeginIndex;
            this._selectionEnd = this._traceField.text.length - this._traceField.selectionEndIndex;
            this._atBottom = _local2;
            this._updateTraces();
            this._traceField.scrollV = this._traceField.maxScrollV - _local3;
         }
         this.updateScroller();
      }

      private function updateScroller() : void {
         if(this._traceField.maxScrollV <= 1) {
            this._scroll.visible = false;
         } else {
            this._scroll.visible = true;
            if(this._atBottom) {
               this.scrollPercent = 1;
            } else {
               this.scrollPercent = (this._traceField.scrollV - 1) / (this._traceField.maxScrollV - 1);
            }
         }
      }

      private function onScrollbarDown(param1:MouseEvent) : void {
         if(Boolean(this._scroller.visible) && this._scroller.mouseY > 0 || !this._scroller.visible && this._scroll.mouseY > this._scrollHeight / 2) {
            this._scrolldir = 3;
         } else {
            this._scrolldir = -3;
         }
         this._traceField.scrollV = this._traceField.scrollV + this._scrolldir;
         this._scrolldelay = 0;
         addEventListener(Event.ENTER_FRAME,this.onScrollBarFrame,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onScrollBarUp,false,0,true);
      }

      private function onScrollBarFrame(param1:Event) : void {
         this._scrolldelay++;
         if(this._scrolldelay > 10) {
            this._scrolldelay = 9;
            if(this._scrolldir < 0 && this._scroller.y > this._scroll.mouseY || this._scrolldir > 0 && this._scroller.y + this._scroller.height < this._scroll.mouseY) {
               this._traceField.scrollV = this._traceField.scrollV + this._scrolldir;
            }
         }
      }

      private function onScrollBarUp(param1:Event) : void {
         removeEventListener(Event.ENTER_FRAME,this.onScrollBarFrame);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onScrollBarUp);
      }

      private function get scrollPercent() : Number {
         return (this._scroller.y - style.controlSize) / (this._scrollHeight - 30 - style.controlSize * 2);
      }

      private function set scrollPercent(param1:Number) : void {
         this._scroller.y = style.controlSize + (this._scrollHeight - 30 - style.controlSize * 2) * param1;
      }

      private function onScrollerDown(param1:MouseEvent) : void {
         var _local2:Number = NaN;
         this._scrolling = true;
         if(!console.paused && Boolean(this._atBottom)) {
            this._atBottom = false;
            _local2 = this.scrollPercent;
            this._updateTraces();
            this.scrollPercent = _local2;
         }
         this._scroller.startDrag(false,new Rectangle(0,style.controlSize,0,this._scrollHeight - 30 - style.controlSize * 2));
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onScrollerMove,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onScrollerUp,false,0,true);
         param1.stopPropagation();
      }

      private function onScrollerMove(param1:MouseEvent) : void {
         this._lockScrollUpdate = true;
         this._traceField.scrollV = Math.round(this.scrollPercent * (this._traceField.maxScrollV - 1) + 1);
         this._lockScrollUpdate = false;
      }

      private function onScrollerUp(param1:MouseEvent) : void {
         this._scroller.stopDrag();
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onScrollerMove);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onScrollerUp);
         this._scrolling = false;
         this.onTraceScroll();
      }

      override public function set width(param1:Number) : void {
         this._lockScrollUpdate = true;
         super.width = param1;
         this._traceField.width = param1 - 4;
         txtField.width = param1 - 6;
         this._cmdField.width = width - 15 - this._cmdField.x;
         this._cmdBG.width = param1;
         this._bottomLine.graphics.clear();
         this._bottomLine.graphics.lineStyle(1,style.controlColor);
         this._bottomLine.graphics.moveTo(10,-1);
         this._bottomLine.graphics.lineTo(param1 - 10,-1);
         this._scroll.x = param1;
         this._atBottom = true;
         this.updateCLSize();
         this._needUpdateMenu = true;
         this._needUpdateTrace = true;
         this._lockScrollUpdate = false;
      }

      override public function set height(param1:Number) : void {
         this._lockScrollUpdate = true;
         var _local2:int = style.menuFontSize;
         var _local3:Number = _local2 + 6 + style.traceFontSize;
         if(height != param1) {
            this._mini = param1 < (!!this._cmdField.visible?_local3 + _local2 + 4:_local3);
         }
         super.height = param1;
         var _local4:Boolean = Boolean(this._mini) || !style.topMenu;
         this.updateTraceFHeight();
         this._traceField.y = !!_local4?Number(0):Number(_local2);
         this._traceField.height = param1 - (!!this._cmdField.visible?_local2 + 4:0) - (!!_local4?0:_local2);
         var _local5:Number = param1 - (_local2 + 6);
         this._cmdField.y = _local5;
         this._cmdPrefx.y = _local5;
         this._hintField.y = this._cmdField.y - this._hintField.height;
         this._cmdBG.y = _local5;
         this._bottomLine.y = !!this._cmdField.visible?Number(_local5):Number(param1);
         this._scroll.y = !!_local4?Number(6):Number(_local2 + 4);
         var _local6:uint = style.controlSize;
         this._scrollHeight = this._bottomLine.y - (!!this._cmdField.visible?0:_local6 * 2) - this._scroll.y;
         this._scroller.visible = this._scrollHeight > 40;
         this._scroll.graphics.clear();
         if(this._scrollHeight >= 10) {
            this._scroll.graphics.beginFill(style.controlColor,0.7);
            this._scroll.graphics.drawRect(-_local6,0,_local6,_local6);
            this._scroll.graphics.drawRect(-_local6,this._scrollHeight - _local6,_local6,_local6);
            this._scroll.graphics.beginFill(style.controlColor,0.25);
            this._scroll.graphics.drawRect(-_local6,_local6,_local6,this._scrollHeight - _local6 * 2);
            this._scroll.graphics.beginFill(0,0);
            this._scroll.graphics.drawRect(-_local6 * 2,_local6 * 2,_local6 * 2,this._scrollHeight - _local6 * 2);
            this._scroll.graphics.endFill();
         }
         this._atBottom = true;
         this._needUpdateTrace = true;
         this._lockScrollUpdate = false;
      }

      private function updateTraceFHeight() : void {
         var _local1:Boolean = Boolean(this._mini) || !style.topMenu;
         this._traceField.y = !!_local1?Number(0):Number(txtField.y + txtField.height - 6);
         this._traceField.height = Math.max(0,height - (!!this._cmdField.visible?style.menuFontSize + 4:0) - this._traceField.y);
      }

      public function updateMenu(param1:Boolean = false) : void {
         if(param1) {
            this._updateMenu();
         } else {
            this._needUpdateMenu = true;
         }
      }

      private function _updateMenu() : void {
         var _local2:Boolean = false;
         var _local3:* = null;
         var _local1:* = "<r><high>";
         if(Boolean(this._mini) || !style.topMenu) {
            _local1 = _local1 + "<menu><b> <a href=\"event:show\">‹</a>";
         } else {
            if(!console.panels.channelsPanel) {
               _local1 = _local1 + this.getChannelsLink(true);
            }
            _local1 = _local1 + "<menu> <b>";
            for(_local3 in this._extraMenus) {
               _local1 = _local1 + ("<a href=\"event:external_" + _local3 + "\">" + _local3 + "</a> ");
               _local2 = true;
            }
            if(_local2) {
               _local1 = _local1 + "¦ ";
            }
            _local1 = _local1 + this.doActive("<a href=\"event:fps\">F</a>",console.fpsMonitor > 0);
            _local1 = _local1 + this.doActive(" <a href=\"event:mm\">M</a>",console.memoryMonitor > 0);
            _local1 = _local1 + this.doActive(" <a href=\"event:command\">CL</a>",this.commandLine);
            if(console.remoter.remoting != Remoting.RECIEVER) {
               if(config.displayRollerEnabled) {
                  _local1 = _local1 + this.doActive(" <a href=\"event:roller\">Ro</a>",console.displayRoller);
               }
               if(config.rulerToolEnabled) {
                  _local1 = _local1 + this.doActive(" <a href=\"event:ruler\">RL</a>",console.panels.rulerActive);
               }
            }
            _local1 = _local1 + " ¦</b>";
            _local1 = _local1 + " <a href=\"event:copy\">Sv</a>";
            _local1 = _local1 + (" <a href=\"event:priority\">P" + this._priority + "</a>");
            _local1 = _local1 + this.doActive(" <a href=\"event:pause\">P</a>",console.paused);
            _local1 = _local1 + " <a href=\"event:clear\">C</a> <a href=\"event:close\">X</a> <a href=\"event:hide\">›</a>";
         }
         _local1 = _local1 + " </b></menu></high></r>";
         txtField.htmlText = _local1;
         txtField.scrollH = txtField.maxScrollH;
         this.updateTraceFHeight();
      }

      public function getChannelsLink(param1:Boolean = false) : String {
         var _local7:String = null;
         var _local8:String = null;
         var _local2:* = "<chs>";
         var _local3:Array = console.logs.getChannels();
         var _local4:int = _local3.length;
         if(Boolean(param1) && _local4 > style.maxChannelsInMenu) {
            _local4 = style.maxChannelsInMenu;
         }
         var _local5:Boolean = this._viewingChannels.length > 0 || this._ignoredChannels.length > 0;
         var _local6:int = 0;
         while(_local6 < _local4) {
            _local7 = _local3[_local6];
            _local8 = !_local5 && _local6 == 0 || Boolean(_local5) && _local6 != 0 && Boolean(this.chShouldShow(_local7))?"<ch><b>" + _local7 + "</b></ch>":_local7;
            _local2 = _local2 + ("<a href=\"event:channel_" + _local7 + "\">[" + _local8 + "]</a> ");
            _local6++;
         }
         if(param1) {
            _local2 = _local2 + ("<ch><a href=\"event:channels\"><b>" + (_local3.length > _local4?"...":"") + "</b>^^ </a></ch>");
         }
         _local2 = _local2 + "</chs> ";
         return _local2;
      }

      private function doActive(param1:String, param2:Boolean) : String {
         if(param2) {
            return "<menuHi>" + param1 + "</menuHi>";
         }
         return param1;
      }

      public function onMenuRollOver(param1:TextEvent, param2:ConsolePanel = null) : void {
         var _local4:Array = null;
         var _local5:Object = null;
         if(param2 == null) {
            param2 = this;
         }
         var _local3:* = !!param1.text?param1.text.replace("event:",""):"";
         if(_local3 == "channel_" + Console.GLOBAL_CHANNEL) {
            _local3 = "View all channels";
         } else if(_local3 == "channel_" + Console.DEFAULT_CHANNEL) {
            _local3 = "Default channel::Logs with no channel";
         } else if(_local3 == "channel_" + Console.CONSOLE_CHANNEL) {
            _local3 = "Console\'s channel::Logs generated from Console";
         } else if(_local3 == "channel_" + Console.FILTER_CHANNEL) {
            _local3 = !!this._filterRegExp?String(this._filterRegExp):this._filterText;
            _local3 = "Filtering channel" + "::*" + _local3 + "*";
         } else if(_local3 == "channel_" + LogReferences.INSPECTING_CHANNEL) {
            _local3 = "Inspecting channel";
         } else if(_local3.indexOf("channel_") == 0) {
            _local3 = "Change channel::shift: select multiple\nctrl: ignore channel";
         } else if(_local3 == "pause") {
            if(console.paused) {
               _local3 = "Resume updates";
            } else {
               _local3 = "Pause updates";
            }
         } else if(_local3 == "close" && param2 == this) {
            _local3 = "Close::Type password to show again";
         } else if(_local3.indexOf("external_") == 0) {
            _local4 = this._extraMenus[_local3.substring(9)];
            if(_local4) {
               _local3 = _local4[2];
            }
         } else {
            _local5 = {
               "fps":"Frames Per Second",
               "mm":"Memory Monitor",
               "roller":"Display Roller::Map the display list under your mouse",
               "ruler":"Screen Ruler::Measure the distance and angle between two points on screen.",
               "command":"Command Line",
               "copy":"Save to clipboard::shift: no channel name\nctrl: use viewing filters\nalt: save to file",
               "clear":"Clear log",
               "priority":"Priority filter::shift: previous priority\n(skips unused priorites)",
               "channels":"Expand channels",
               "close":"Close"
            };
            _local3 = _local5[_local3];
         }
         console.panels.tooltip(_local3,param2);
      }

      private function linkHandler(param1:TextEvent) : void {
         var str:String = null;
         var file:FileReference = null;
         var ind:int = 0;
         var menu:Array = null;
         var e:TextEvent = param1;
         txtField.setSelection(0,0);
         stopDrag();
         var t:String = e.text;
         if(t == "pause") {
            if(console.paused) {
               console.paused = false;
            } else {
               console.paused = true;
            }
            console.panels.tooltip(null);
         } else if(t == "hide") {
            console.panels.tooltip();
            this._mini = true;
            console.config.style.topMenu = false;
            this.height = height;
            this.updateMenu();
         } else if(t == "show") {
            console.panels.tooltip();
            this._mini = false;
            console.config.style.topMenu = true;
            this.height = height;
            this.updateMenu();
         } else if(t == "close") {
            console.panels.tooltip();
            visible = false;
            dispatchEvent(new Event(Event.CLOSE));
         } else if(t == "channels") {
            console.panels.channelsPanel = !console.panels.channelsPanel;
         } else if(t == "fps") {
            console.fpsMonitor = !console.fpsMonitor;
         } else if(t == "priority") {
            this.incPriority(this._shift);
         } else if(t == "mm") {
            console.memoryMonitor = !console.memoryMonitor;
         } else if(t == "roller") {
            console.displayRoller = !console.displayRoller;
         } else if(t == "ruler") {
            console.panels.tooltip();
            console.panels.startRuler();
         } else if(t == "command") {
            this.commandLine = !this.commandLine;
         } else if(t == "copy") {
            str = console.logs.getLogsAsString("\r\n",!this._shift,!!this._ctrl?this.lineShouldShow:null);
            if(this._alt) {
               file = new FileReference();
               try {
                  file["save"](str,"log.txt");
               }
               catch(err:Error) {
                  console.report("Save to file is not supported in your flash player.",8);
               }
            } else {
               System.setClipboard(str);
               console.report("Copied log to clipboard.",-1);
            }
         } else if(t == "clear") {
            console.clear();
         } else if(t == "settings") {
            console.report("A new window should open in browser. If not, try searching for \'Flash Player Global Security Settings panel\' online :)",-1);
            Security.showSettings(SecurityPanel.SETTINGS_MANAGER);
         } else if(t == "remote") {
            console.remoter.remoting = Remoting.RECIEVER;
         } else if(t.indexOf("ref") == 0) {
            console.refs.handleRefEvent(t);
         } else if(t.indexOf("channel_") == 0) {
            this.onChannelPressed(t.substring(8));
         } else if(t.indexOf("cl_") == 0) {
            ind = t.indexOf("_",3);
            console.cl.handleScopeEvent(uint(t.substring(3,ind < 0?Number(t.length):Number(ind))));
            if(ind >= 0) {
               this._cmdField.text = t.substring(ind + 1);
            }
         } else if(t.indexOf("external_") == 0) {
            menu = this._extraMenus[t.substring(9)];
            if(menu) {
               menu[0].apply(null,menu[1]);
            }
         }
         txtField.setSelection(0,0);
         e.stopPropagation();
      }

      public function onChannelPressed(param1:String) : void {
         var _local2:Array = null;
         if(Boolean(this._ctrl) && param1 != Console.GLOBAL_CHANNEL) {
            _local2 = this.toggleCHList(this._ignoredChannels,param1);
            this.setIgnoredChannels.apply(this,_local2);
         } else if(Boolean(this._shift) && param1 != Console.GLOBAL_CHANNEL && this._viewingChannels[0] != LogReferences.INSPECTING_CHANNEL) {
            _local2 = this.toggleCHList(this._viewingChannels,param1);
            this.setViewingChannels.apply(this,_local2);
         } else {
            console.setViewingChannels(param1);
         }
      }

      private function toggleCHList(param1:Array, param2:String) : Array {
         param1 = param1.concat();
         var _local3:int = param1.indexOf(param2);
         if(_local3 >= 0) {
            param1.splice(_local3,1);
            if(param1.length == 0) {
               param1.push(Console.GLOBAL_CHANNEL);
            }
         } else {
            param1.push(param2);
         }
         return param1;
      }

      public function set priority(param1:uint) : void {
         this._priority = param1;
         console.so[PRIORITY_HISTORY] = this._priority;
         this.updateToBottom();
         this.updateMenu();
      }

      public function get priority() : uint {
         return this._priority;
      }

      private function incPriority(param1:Boolean) : void {
         var _local3:uint = 0;
         var _local2:uint = 10;
         var _local4:Log = console.logs.last;
         var _local5:int = this._priority;
         this._priority = 0;
         var _local6:uint = 32000;
         while(Boolean(_local4) && _local6 > 0) {
            _local6--;
            if(this.lineShouldShow(_local4)) {
               if(_local4.priority > _local5 && _local2 > _local4.priority) {
                  _local2 = _local4.priority;
               }
               if(_local4.priority < _local5 && _local3 < _local4.priority) {
                  _local3 = _local4.priority;
               }
            }
            _local4 = _local4.prev;
         }
         if(param1) {
            if(_local3 == _local5) {
               _local5 = 10;
            } else {
               _local5 = _local3;
            }
         } else if(_local2 == _local5) {
            _local5 = 0;
         } else {
            _local5 = _local2;
         }
         this.priority = _local5;
      }

      private function clearCommandLineHistory(... rest) : void {
         this._cmdsInd = -1;
         console.updateSO();
         this._cmdsHistory = new Array();
      }

      private function commandKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == Keyboard.TAB) {
            if(this._hint) {
               this._cmdField.text = this._hint;
               this.setCLSelectionAtEnd();
               this.setHints();
            }
         }
      }

      private function commandKeyUp(param1:KeyboardEvent) : void {
         var _local2:String = null;
         var _local3:int = 0;
         if(param1.keyCode == Keyboard.ENTER) {
            this.updateToBottom();
            this.setHints();
            if(this._enteringLogin) {
               console.remoter.login(this._cmdField.text);
               this._cmdField.text = "";
               this.requestLogin(false);
            } else {
               _local2 = this._cmdField.text;
               if(_local2.length > 2) {
                  _local3 = this._cmdsHistory.indexOf(_local2);
                  while(_local3 >= 0) {
                     this._cmdsHistory.splice(_local3,1);
                     _local3 = this._cmdsHistory.indexOf(_local2);
                  }
                  this._cmdsHistory.unshift(_local2);
                  this._cmdsInd = -1;
                  if(this._cmdsHistory.length > 20) {
                     this._cmdsHistory.splice(20);
                  }
                  console.updateSO(CL_HISTORY);
               }
               this._cmdField.text = "";
               if(config.commandLineInputPassThrough != null) {
                  _local2 = config.commandLineInputPassThrough(_local2);
               }
               if(_local2) {
                  console.cl.run(_local2);
               }
            }
         } else if(param1.keyCode == Keyboard.ESCAPE) {
            if(stage) {
               stage.focus = null;
            }
         } else if(param1.keyCode == Keyboard.UP) {
            this.setHints();
            if(Boolean(this._cmdField.text) && this._cmdsInd < 0) {
               this._cmdsHistory.unshift(this._cmdField.text);
               this._cmdsInd++;
            }
            if(this._cmdsInd < this._cmdsHistory.length - 1) {
               this._cmdsInd++;
               this._cmdField.text = this._cmdsHistory[this._cmdsInd];
               this.setCLSelectionAtEnd();
            } else {
               this._cmdsInd = this._cmdsHistory.length;
               this._cmdField.text = "";
            }
         } else if(param1.keyCode == Keyboard.DOWN) {
            this.setHints();
            if(this._cmdsInd > 0) {
               this._cmdsInd--;
               this._cmdField.text = this._cmdsHistory[this._cmdsInd];
               this.setCLSelectionAtEnd();
            } else {
               this._cmdsInd = -1;
               this._cmdField.text = "";
            }
         } else if(param1.keyCode == Keyboard.TAB) {
            this.setCLSelectionAtEnd();
         } else if(!this._enteringLogin) {
            this.updateCmdHint();
         }
      }

      private function setCLSelectionAtEnd() : void {
         this._cmdField.setSelection(this._cmdField.text.length,this._cmdField.text.length);
      }

      private function updateCmdHint(param1:Event = null) : void {
         var _local2:String = this._cmdField.text;
         if(Boolean(_local2) && Boolean(config.commandLineAutoCompleteEnabled) && console.remoter.remoting != Remoting.RECIEVER) {
            try {
               this.setHints(console.cl.getHintsFor(_local2,5));
               return;
            }
            catch(err:Error) {
            }
         }
         this.setHints();
      }

      private function onCmdFocusOut(param1:Event) : void {
         this.setHints();
      }

      private function setHints(param1:Array = null) : void {
         var _local2:Array = null;
         var _local3:Array = null;
         var _local4:Rectangle = null;
         var _local5:String = null;
         var _local6:Boolean = false;
         var _local7:int = 0;
         if(Boolean(param1) && Boolean(param1.length)) {
            this._hint = param1[0][0];
            if(param1.length > 1) {
               _local5 = param1[1][0];
               _local6 = false;
               _local7 = 0;
               while(_local7 < _local5.length) {
                  if(_local5.charAt(_local7) == this._hint.charAt(_local7)) {
                     _local6 = true;
                     _local7++;
                     continue;
                  }
                  if(Boolean(_local6) && this._cmdField.text.length < _local7) {
                     this._hint = this._hint.substring(0,_local7);
                  }
                  break;
               }
            }
            _local2 = new Array();
            for each(_local3 in param1) {
               _local2.push("<p3>" + _local3[0] + "</p3> <p0>" + (!!_local3[1]?_local3[1]:"") + "</p0>");
            }
            this._hintField.htmlText = "<p>" + _local2.reverse().join("\n") + "</p>";
            this._hintField.visible = true;
            _local4 = this._cmdField.getCharBoundaries(this._cmdField.text.length - 1);
            if(!_local4) {
               _local4 = new Rectangle();
            }
            this._hintField.x = this._cmdField.x + _local4.x + _local4.width + 30;
            this._hintField.y = height - this._hintField.height;
         } else {
            this._hintField.visible = false;
            this._hint = null;
         }
      }

      public function updateCLScope(param1:String) : void {
         if(this._enteringLogin) {
            this._enteringLogin = false;
            this.requestLogin(false);
         }
         this._cmdPrefx.autoSize = TextFieldAutoSize.LEFT;
         this._cmdPrefx.text = param1;
         this.updateCLSize();
      }

      private function updateCLSize() : void {
         var _local1:Number = width - 48;
         if(this._cmdPrefx.width > 120 || this._cmdPrefx.width > _local1) {
            this._cmdPrefx.autoSize = TextFieldAutoSize.NONE;
            this._cmdPrefx.width = _local1 > 120?Number(120):Number(_local1);
            this._cmdPrefx.scrollH = this._cmdPrefx.maxScrollH;
         }
         this._cmdField.x = this._cmdPrefx.width + 2;
         this._cmdField.width = width - 15 - this._cmdField.x;
         this._hintField.x = this._cmdField.x;
      }

      public function set commandLine(param1:Boolean) : void {
         if(param1) {
            this._cmdField.visible = true;
            this._cmdPrefx.visible = true;
            this._cmdBG.visible = true;
         } else {
            this._cmdField.visible = false;
            this._cmdPrefx.visible = false;
            this._cmdBG.visible = false;
         }
         this._needUpdateMenu = true;
         this.height = height;
      }

      public function get commandLine() : Boolean {
         return this._cmdField.visible;
      }
   }
}
