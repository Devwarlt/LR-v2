package org.swiftsuspenders.typedescriptions {
import avmplus.getQualifiedClassName;

import flash.utils.Dictionary;

import org.swiftsuspenders.Injector;
import org.swiftsuspenders.dependencyproviders.DependencyProvider;
import org.swiftsuspenders.errors.InjectorMissingMappingError;
import org.swiftsuspenders.utils.SsInternal;

public class MethodInjectionPoint extends InjectionPoint {

      private static const _parameterValues:Array = [];

      protected var _parameterMappingIDs:Array;

      protected var _requiredParameters:int;

      private var _isOptional:Boolean;

      private var _methodName:String;

      public function MethodInjectionPoint(param1:String, param2:Array, param3:uint, param4:Boolean, param5:Dictionary) {
         super();
         this._methodName = param1;
         this._parameterMappingIDs = param2;
         this._requiredParameters = param3;
         this._isOptional = param4;
         this.injectParameters = param5;
      }

      override public function applyInjection(param1:Object, param2:Class, param3:Injector) : void {
         var _local4:Array = this.gatherParameterValues(param1,param2,param3);
         if(_local4.length >= this._requiredParameters) {
            (param1[this._methodName] as Function).apply(param1,_local4);
         }
         _local4.length = 0;
      }

      protected function gatherParameterValues(param1:Object, param2:Class, param3:Injector) : Array {
         var _local7:String = null;
         var _local8:DependencyProvider = null;
         var _local4:int = this._parameterMappingIDs.length;
         var _local5:Array = _parameterValues;
         _local5.length = _local4;
         var _local6:int = 0;
         while(_local6 < _local4) {
            _local7 = this._parameterMappingIDs[_local6];
            _local8 = param3.SsInternal::getProvider(_local7);
            if(!_local8) {
               if(_local6 >= this._requiredParameters || Boolean(this._isOptional)) {
                  break;
               }
               throw new InjectorMissingMappingError("Injector is missing a mapping to handle injection into target \"" + param1 + "\" of MsgType \"" + getQualifiedClassName(param2) + "\". \t\t\t\t\t\tTarget dependency: " + _local7 + ", method: " + this._methodName + ", parameter: " + (_local6 + 1));
            }
            _local5[_local6] = _local8.apply(param2,param3,injectParameters);
            _local6++;
         }
         return _local5;
      }
   }
}
