package org.osflash.signals.natives {
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.utils.getQualifiedClassName;

import org.osflash.signals.SlotList;

public class NativeMappedSignal extends NativeRelaySignal {

      private var _mappingFunction:Function = null;

      public function NativeMappedSignal(param1:IEventDispatcher, param2:String, param3:Class = null, ... rest) {
         super(param1,param2,param3);
         this.valueClasses = rest;
      }

      protected function get mappingFunction() : Function {
         return this._mappingFunction;
      }

      override public function get eventClass() : Class {
         return _eventClass;
      }

      override public function set eventClass(param1:Class) : void {
         _eventClass = param1;
      }

      override public function set valueClasses(param1:Array) : void {
         _valueClasses = !!param1?param1.slice():[];
         var _local2:int = _valueClasses.length;
         while(_local2--) {
            if(!(_valueClasses[_local2] is Class)) {
               throw new ArgumentError("Invalid valueClasses argument: " + "item at index " + _local2 + " should be a Class but was:<" + _valueClasses[_local2] + ">." + getQualifiedClassName(_valueClasses[_local2]));
            }
         }
      }

      public function mapTo(... rest) : NativeMappedSignal {
         var objectListOrFunction:Array = rest;
         if(objectListOrFunction.length == 1 && objectListOrFunction[0] is Function) {
            this._mappingFunction = objectListOrFunction[0] as Function;
            if(this._mappingFunction.length > 1) {
               throw new ArgumentError("Mapping function has " + this._mappingFunction.length + " arguments but it needs zero or one of MsgType Event");
            }
         } else {
            this._mappingFunction = function():Object {
               return objectListOrFunction;
            };
         }
         return this;
      }

      protected function mapEvent(param1:Event) : Object {
         if(this.mappingFunction != null) {
            if(this.mappingFunction.length == 1) {
               return this.mappingFunction(param1);
            }
            return this.mappingFunction();
         }
         if(valueClasses.length == 0) {
            return [];
         }
         throw new ArgumentError("There are valueClasses set to be dispatched <" + valueClasses + "> but mappingFunction is null.");
      }

      override public function dispatchEvent(param1:Event) : Boolean {
         var _local4:Array = null;
         var _local5:Object = null;
         var _local6:Class = null;
         var _local7:int = 0;
         var _local2:Object = this.mapEvent(param1);
         var _local3:int = valueClasses.length;
         if(_local2 is Array) {
            _local4 = _local2 as Array;
            _local7 = 0;
            while(_local7 < _local3) {
               _local5 = _local4[_local7];
               _local6 = valueClasses[_local7];
               if(_local5 === null || _local5 is _local6) {
                  _local7++;
                  continue;
               }
               throw new ArgumentError("Value object <" + _local5 + "> is not an instance of <" + _local6 + ">.");
            }
         } else {
            if(_local3 > 1) {
               throw new ArgumentError("Expected more than one value.");
            }
            if(!(_local2 is valueClasses[0])) {
               throw new ArgumentError("Mapping returned " + getQualifiedClassName(_local2) + ", expected " + valueClasses[0] + ".");
            }
         }
         return super.dispatchEvent(param1);
      }

      override protected function onNativeEvent(param1:Event) : void {
         var _local4:Array = null;
         var _local2:Object = this.mapEvent(param1);
         var _local3:SlotList = slots;
         if(_local2 is Array) {
            if(valueClasses.length == 1 && valueClasses[0] == Array) {
               while(_local3.nonEmpty) {
                  _local3.head.execute1(_local2);
                  _local3 = _local3.tail;
               }
            } else {
               _local4 = _local2 as Array;
               while(_local3.nonEmpty) {
                  _local3.head.execute(_local4);
                  _local3 = _local3.tail;
               }
            }
         } else {
            while(_local3.nonEmpty) {
               _local3.head.execute1(_local2);
               _local3 = _local3.tail;
            }
         }
      }
   }
}
