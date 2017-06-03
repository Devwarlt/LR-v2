package org.osflash.signals.natives {
import flash.errors.IllegalOperationError;
import flash.events.Event;
import flash.events.IEventDispatcher;

import org.osflash.signals.ISlot;
import org.osflash.signals.Slot;
import org.osflash.signals.SlotList;

public class NativeSignal implements INativeDispatcher {

      protected var _target:IEventDispatcher;

      protected var _eventType:String;

      protected var _eventClass:Class;

      protected var _valueClasses:Array;

      protected var slots:SlotList;

      public function NativeSignal(param1:IEventDispatcher = null, param2:String = "", param3:Class = null) {
         super();
         this.slots = SlotList.NIL;
         this.target = param1;
         this.eventType = param2;
         this.eventClass = param3;
      }

      public function get eventType() : String {
         return this._eventType;
      }

      public function set eventType(param1:String) : void {
         this._eventType = param1;
      }

      public function get eventClass() : Class {
         return this._eventClass;
      }

      public function set eventClass(param1:Class) : void {
         this._eventClass = param1 || Event;
         this._valueClasses = [this._eventClass];
      }

      [ArrayElementType(elementType="Class")]
      public function get valueClasses() : Array {
         return this._valueClasses;
      }

      public function set valueClasses(param1:Array) : void {
         this.eventClass = Boolean(param1) && param1.length > 0?param1[0]:null;
      }

      public function get numListeners() : uint {
         return this.slots.length;
      }

      public function get target() : IEventDispatcher {
         return this._target;
      }

      public function set target(param1:IEventDispatcher) : void {
         if(param1 == this._target) {
            return;
         }
         if(this._target) {
            this.removeAll();
         }
         this._target = param1;
      }

      public function add(param1:Function) : ISlot {
         return this.addWithPriority(param1);
      }

      public function addWithPriority(param1:Function, param2:int = 0) : ISlot {
         return this.registerListenerWithPriority(param1,false,param2);
      }

      public function addOnce(param1:Function) : ISlot {
         return this.addOnceWithPriority(param1);
      }

      public function addOnceWithPriority(param1:Function, param2:int = 0) : ISlot {
         return this.registerListenerWithPriority(param1,true,param2);
      }

      public function remove(param1:Function) : ISlot {
         var _local2:ISlot = this.slots.find(param1);
         if(!_local2) {
            return null;
         }
         this._target.removeEventListener(this._eventType,_local2.execute1);
         this.slots = this.slots.filterNot(param1);
         return _local2;
      }

      public function removeAll() : void {
         var _local1:SlotList = this.slots;
         while(_local1.nonEmpty) {
            this.target.removeEventListener(this._eventType,_local1.head.execute1);
            _local1 = _local1.tail;
         }
         this.slots = SlotList.NIL;
      }

      public function dispatch(... rest) : void {
         if(null == rest) {
            throw new ArgumentError("Event object expected.");
         }
         if(rest.length != 1) {
            throw new ArgumentError("No more than one Event object expected.");
         }
         this.dispatchEvent(rest[0] as Event);
      }

      public function dispatchEvent(param1:Event) : Boolean {
         if(!this.target) {
            throw new ArgumentError("Target object cannot be null.");
         }
         if(!param1) {
            throw new ArgumentError("Event object cannot be null.");
         }
         if(!(param1 is this.eventClass)) {
            throw new ArgumentError("Event object " + param1 + " is not an instance of " + this.eventClass + ".");
         }
         if(param1.type != this.eventType) {
            throw new ArgumentError("Event object has incorrect MsgType. Expected <" + this.eventType + "> but was <" + param1.type + ">.");
         }
         return this.target.dispatchEvent(param1);
      }

      protected function registerListenerWithPriority(param1:Function, param2:Boolean = false, param3:int = 0) : ISlot {
         var _local4:ISlot = null;
         if(!this.target) {
            throw new ArgumentError("Target object cannot be null.");
         }
         if(this.registrationPossible(param1,param2)) {
            _local4 = new Slot(param1,this,param2,param3);
            this.slots = this.slots.prepend(_local4);
            this._target.addEventListener(this._eventType,_local4.execute1,false,param3);
            return _local4;
         }
         return this.slots.find(param1);
      }

      protected function registrationPossible(param1:Function, param2:Boolean) : Boolean {
         if(!this.slots.nonEmpty) {
            return true;
         }
         var _local3:ISlot = this.slots.find(param1);
         if(_local3) {
            if(_local3.once != param2) {
               throw new IllegalOperationError("You cannot addOnce() then add() the same listener without removing the relationship first.");
            }
            return false;
         }
         return true;
      }
   }
}
