package com.junkbyte.console.core {
import com.junkbyte.console.Console;
import com.junkbyte.console.vos.Log;

import flash.events.Event;
import flash.utils.ByteArray;

public class Logs extends ConsoleCore {

      private var _channels:Object;

      private var _repeating:uint;

      private var _lastRepeat:Log;

      private var _newRepeat:Log;

      private var _hasNewLog:Boolean;

      private var _timer:uint;

      public var first:Log;

      public var last:Log;

      private var _length:uint;

      private var _lines:uint;

      public function Logs(param1:Console) {
         var console:Console = param1;
         super(console);
         this._channels = new Object();
         remoter.addEventListener(Event.CONNECT,this.onRemoteConnection);
         remoter.registerCallback("log",function(param1:ByteArray):void {
            registerLog(Log.FromBytes(param1));
         });
      }

      private function onRemoteConnection(param1:Event) : void {
         var _local2:Log = this.first;
         while(_local2) {
            this.send2Remote(_local2);
            _local2 = _local2.next;
         }
      }

      private function send2Remote(param1:Log) : void {
         var _local2:ByteArray = null;
         if(remoter.canSend) {
            _local2 = new ByteArray();
            param1.toBytes(_local2);
            remoter.send("log",_local2);
         }
      }

      public function update(param1:uint) : Boolean {
         this._timer = param1;
         if(this._repeating > 0) {
            this._repeating--;
         }
         if(this._newRepeat) {
            if(this._lastRepeat) {
               this.remove(this._lastRepeat);
            }
            this._lastRepeat = this._newRepeat;
            this._newRepeat = null;
            this.push(this._lastRepeat);
         }
         var _local2:Boolean = this._hasNewLog;
         this._hasNewLog = false;
         return _local2;
      }

      public function add(param1:Log) : void {
         this._lines++;
         param1.line = this._lines;
         param1.time = this._timer;
         this.registerLog(param1);
      }

      private function registerLog(param1:Log) : void {
         this._hasNewLog = true;
         this.addChannel(param1.ch);
         param1.lineStr = param1.line + " ";
         param1.chStr = "[<a href=\"event:channel_" + param1.ch + "\">" + param1.ch + "</a>] ";
         param1.timeStr = config.timeStampFormatter(param1.time) + " ";
         this.send2Remote(param1);
         if(param1.repeat) {
            if(this._repeating > 0 && Boolean(this._lastRepeat)) {
               param1.line = this._lastRepeat.line;
               this._newRepeat = param1;
               return;
            }
            this._repeating = config.maxRepeats;
            this._lastRepeat = param1;
         }
         this.push(param1);
         while(this._length > config.maxLines && config.maxLines > 0) {
            this.remove(this.first);
         }
         if(Boolean(config.tracing) && config.traceCall != null) {
            config.traceCall(param1.ch,param1.plainText(),param1.priority);
         }
      }

      public function clear(param1:String = null) : void {
         var _local2:Log = null;
         if(param1) {
            _local2 = this.first;
            while(_local2) {
               if(_local2.ch == param1) {
                  this.remove(_local2);
               }
               _local2 = _local2.next;
            }
            delete this._channels[param1];
         } else {
            this.first = null;
            this.last = null;
            this._length = 0;
            this._channels = new Object();
         }
      }

      public function getLogsAsString(param1:String, param2:Boolean = true, param3:Function = null) : String {
         var _local4:String = "";
         var _local5:Log = this.first;
         while(_local5) {
            if(param3 == null || Boolean(param3(_local5))) {
               if(this.first != _local5) {
                  _local4 = _local4 + param1;
               }
               _local4 = _local4 + (!!param2?_local5.toString():_local5.plainText());
            }
            _local5 = _local5.next;
         }
         return _local4;
      }

      public function getChannels() : Array {
         var _local3:* = null;
         var _local1:Array = new Array(Console.GLOBAL_CHANNEL);
         this.addIfexist(Console.DEFAULT_CHANNEL,_local1);
         this.addIfexist(Console.FILTER_CHANNEL,_local1);
         this.addIfexist(LogReferences.INSPECTING_CHANNEL,_local1);
         this.addIfexist(Console.CONSOLE_CHANNEL,_local1);
         var _local2:Array = new Array();
         for(_local3 in this._channels) {
            if(_local1.indexOf(_local3) < 0) {
               _local2.push(_local3);
            }
         }
         return _local1.concat(_local2.sort(Array.CASEINSENSITIVE));
      }

      private function addIfexist(param1:String, param2:Array) : void {
         if(this._channels.hasOwnProperty(param1)) {
            param2.push(param1);
         }
      }

      public function cleanChannels() : void {
         this._channels = new Object();
         var _local1:Log = this.first;
         while(_local1) {
            this.addChannel(_local1.ch);
            _local1 = _local1.next;
         }
      }

      public function addChannel(param1:String) : void {
         this._channels[param1] = null;
      }

      private function push(param1:Log) : void {
         if(this.last == null) {
            this.first = param1;
         } else {
            this.last.next = param1;
            param1.prev = this.last;
         }
         this.last = param1;
         this._length++;
      }

      private function remove(param1:Log) : void {
         if(this.first == param1) {
            this.first = param1.next;
         }
         if(this.last == param1) {
            this.last = param1.prev;
         }
         if(param1 == this._lastRepeat) {
            this._lastRepeat = null;
         }
         if(param1 == this._newRepeat) {
            this._newRepeat = null;
         }
         if(param1.next != null) {
            param1.next.prev = param1.prev;
         }
         if(param1.prev != null) {
            param1.prev.next = param1.next;
         }
         this._length--;
      }
   }
}
