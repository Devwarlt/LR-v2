package robotlegs.bender.extensions.localEventMap.impl {
import flash.events.Event;
import flash.events.IEventDispatcher;

import robotlegs.bender.extensions.localEventMap.api.IEventMap;

public class EventMap implements IEventMap {

      private var _eventDispatcher:IEventDispatcher;

      private const _listeners:Vector.<EventMapConfig> = new Vector.<EventMapConfig>();

      private const _suspendedListeners:Vector.<EventMapConfig> = new Vector.<EventMapConfig>();

      private var _suspended:Boolean = false;

      public function EventMap(param1:IEventDispatcher) {
         super();
         this._eventDispatcher = param1;
      }

      public function mapListener(param1:IEventDispatcher, param2:String, param3:Function, param4:Class = null, param5:Boolean = false, param6:int = 0, param7:Boolean = true) : void {
         var eventConfig:EventMapConfig = null;
         var callback:Function = null;
         var dispatcher:IEventDispatcher = param1;
         var eventString:String = param2;
         var listener:Function = param3;
         var eventClass:Class = param4;
         var useCapture:Boolean = param5;
         var priority:int = param6;
         var useWeakReference:Boolean = param7;
         eventClass = eventClass || Event;
         var currentListeners:Vector.<EventMapConfig> = !!this._suspended?this._suspendedListeners:this._listeners;
         var i:int = currentListeners.length;
         while(i--) {
            eventConfig = currentListeners[i];
            if(eventConfig.dispatcher == dispatcher && eventConfig.eventString == eventString && eventConfig.listener == listener && eventConfig.useCapture == useCapture && eventConfig.eventClass == eventClass) {
               return;
            }
         }
         if(eventClass != Event) {
            callback = function(param1:Event):void {
               routeEventToListener(param1,listener,eventClass);
            };
         } else {
            callback = listener;
         }
         eventConfig = new EventMapConfig(dispatcher,eventString,listener,eventClass,callback,useCapture);
         currentListeners.push(eventConfig);
         if(!this._suspended) {
            dispatcher.addEventListener(eventString,callback,useCapture,priority,useWeakReference);
         }
      }

      public function unmapListener(param1:IEventDispatcher, param2:String, param3:Function, param4:Class = null, param5:Boolean = false) : void {
         var _local6:EventMapConfig = null;
         param4 = param4 || Event;
         var _local7:Vector.<EventMapConfig> = !!this._suspended?this._suspendedListeners:this._listeners;
         var _local8:int = _local7.length;
         while(_local8--) {
            _local6 = _local7[_local8];
            if(_local6.dispatcher == param1 && _local6.eventString == param2 && _local6.listener == param3 && _local6.useCapture == param5 && _local6.eventClass == param4) {
               if(!this._suspended) {
                  param1.removeEventListener(param2,_local6.callback,param5);
               }
               _local7.splice(_local8,1);
               return;
            }
         }
      }

      public function unmapListeners() : void {
         var _local2:EventMapConfig = null;
         var _local3:IEventDispatcher = null;
         var _local1:Vector.<EventMapConfig> = !!this._suspended?this._suspendedListeners:this._listeners;
         while(_local2 = _local1.pop()) {
            if(!this._suspended) {
               _local3 = _local2.dispatcher;
               _local3.removeEventListener(_local2.eventString,_local2.callback,_local2.useCapture);
            }
         }
      }

      public function suspend() : void {
         var _local1:EventMapConfig = null;
         var _local2:IEventDispatcher = null;
         if(this._suspended) {
            return;
         }
         this._suspended = true;
         while(_local1 = this._listeners.pop()) {
            _local2 = _local1.dispatcher;
            _local2.removeEventListener(_local1.eventString,_local1.callback,_local1.useCapture);
            this._suspendedListeners.push(_local1);
         }
      }

      public function resume() : void {
         var _local1:EventMapConfig = null;
         var _local2:IEventDispatcher = null;
         if(!this._suspended) {
            return;
         }
         this._suspended = false;
         while(_local1 = this._suspendedListeners.pop()) {
            _local2 = _local1.dispatcher;
            _local2.addEventListener(_local1.eventString,_local1.callback,_local1.useCapture);
            this._listeners.push(_local1);
         }
      }

      private function routeEventToListener(param1:Event, param2:Function, param3:Class) : void {
         if(param1 is param3) {
            param2(param1);
         }
      }
   }
}
