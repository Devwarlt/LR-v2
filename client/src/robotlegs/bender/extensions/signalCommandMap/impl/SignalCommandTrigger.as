package robotlegs.bender.extensions.signalCommandMap.impl {
import flash.utils.Dictionary;
import flash.utils.describeType;

import org.osflash.signals.ISignal;
import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
import robotlegs.bender.framework.impl.applyHooks;
import robotlegs.bender.framework.impl.guardsApprove;

public class SignalCommandTrigger implements ICommandTrigger {

      private const _mappings:Vector.<ICommandMapping> = new Vector.<ICommandMapping>();

      private var _signal:ISignal;

      private var _signalClass:Class;

      private var _once:Boolean;

      protected var _injector:Injector;

      protected var _signalMap:Dictionary;

      protected var _verifiedCommandClasses:Dictionary;

      public function SignalCommandTrigger(param1:Injector, param2:Class, param3:Boolean = false) {
         super();
         this._injector = param1;
         this._signalClass = param2;
         this._once = param3;
         this._signalMap = new Dictionary(false);
         this._verifiedCommandClasses = new Dictionary(false);
      }

      public function addMapping(param1:ICommandMapping) : void {
         this.verifyCommandClass(param1);
         this._mappings.push(param1);
         if(this._mappings.length == 1) {
            this.addSignal(param1.commandClass);
         }
      }

      public function removeMapping(param1:ICommandMapping) : void {
         var _local2:int = this._mappings.indexOf(param1);
         if(_local2 != -1) {
            this._mappings.splice(_local2,1);
            if(this._mappings.length == 0) {
               this.removeSignal(param1.commandClass);
            }
         }
      }

      protected function verifyCommandClass(param1:ICommandMapping) : void {
         var mapping:ICommandMapping = param1;
         if(this._verifiedCommandClasses[mapping.commandClass]) {
            return;
         }
         if(describeType(mapping.commandClass).factory.method.(@name == "execute").length() == 0) {
            throw new Error("Command Class must expose an execute method");
         }
         this._verifiedCommandClasses[mapping.commandClass] = true;
      }

      protected function routeSignalToCommand(param1:ISignal, param2:Array, param3:Class, param4:Boolean) : void {
         var _local6:ICommandMapping;
         var _local7:Boolean;
         var _local8:Object = null;
         var _local5:Vector.<ICommandMapping> = this._mappings.concat();
         for each(_local6 in _local5) {
            this.mapSignalValues(param1.valueClasses,param2);
            _local7 = guardsApprove(_local6.guards,this._injector);
            if(_local7) {
               this._once && this.removeMapping(_local6);
               this._injector.map(_local6.commandClass).asSingleton();
               _local8 = this._injector.getInstance(_local6.commandClass);
               applyHooks(_local6.hooks,this._injector);
               this._injector.unmap(_local6.commandClass);
            }
            this.unmapSignalValues(param1.valueClasses,param2);
            if(_local7) {
               _local8.execute();
            }
         }
         if(this._once) {
            this.removeSignal(param3);
         }
      }

      protected function mapSignalValues(param1:Array, param2:Array) : void {
         var _local3:uint = 0;
         while(_local3 < param1.length) {
            this._injector.map(param1[_local3]).toValue(param2[_local3]);
            _local3++;
         }
      }

      protected function unmapSignalValues(param1:Array, param2:Array) : void {
         var _local3:uint = 0;
         while(_local3 < param1.length) {
            this._injector.unmap(param1[_local3]);
            _local3++;
         }
      }

      protected function hasSignalCommand(param1:ISignal, param2:Class) : Boolean {
         var _local3:Dictionary = this._signalMap[param1];
         if(_local3 == null) {
            return false;
         }
         var _local4:Function = _local3[param2];
         return _local4 != null;
      }

      private function addSignal(param1:Class) : void {
         var commandClass:Class = param1;
         if(this.hasSignalCommand(this._signal,commandClass)) {
            return;
         }
         this._signal = this._injector.getInstance(this._signalClass);
         this._injector.map(this._signalClass).toValue(this._signal);
         var signalCommandMap:Dictionary = this._signalMap[this._signal] = this._signalMap[this._signal] || new Dictionary(false);
         var callback:Function = function():void {
            routeSignalToCommand(_signal,arguments,commandClass,_once);
         };
         signalCommandMap[commandClass] = callback;
         this._signal.add(callback);
      }

      private function removeSignal(param1:Class) : void {
         var _local2:Dictionary = this._signalMap[this._signal];
         if(_local2 == null) {
            return;
         }
         var _local3:Function = _local2[param1];
         if(_local3 == null) {
            return;
         }
         this._signal.remove(_local3);
         delete _local2[param1];
      }
   }
}
