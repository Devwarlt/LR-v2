package org.swiftsuspenders.reflection {
import avmplus.LOEBUILD_10a96e304442ef137abf0b4c08905cb5;

import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;

import org.swiftsuspenders.InjectorError;
import org.swiftsuspenders.typedescriptions.ConstructorInjectionPoint;
import org.swiftsuspenders.typedescriptions.MethodInjectionPoint;
import org.swiftsuspenders.typedescriptions.NoParamsConstructorInjectionPoint;
import org.swiftsuspenders.typedescriptions.PostConstructInjectionPoint;
import org.swiftsuspenders.typedescriptions.PreDestroyInjectionPoint;
import org.swiftsuspenders.typedescriptions.PropertyInjectionPoint;
import org.swiftsuspenders.typedescriptions.TypeDescription;

public class DescribeTypeJSONReflector extends ReflectorBase implements Reflector {

      private const _descriptor:LOEBUILD_10a96e304442ef137abf0b4c08905cb5 = new LOEBUILD_10a96e304442ef137abf0b4c08905cb5();

      public function DescribeTypeJSONReflector() {
         super();
      }

      public function typeImplements(param1:Class, param2:Class) : Boolean {
         if(param1 == param2) {
            return true;
         }
         var _local3:String = getQualifiedClassName(param2);
         var _local4:Object = this._descriptor.getInstanceDescription(param1).traits;
         return (_local4.bases as Array).indexOf(_local3) > -1 || (_local4.interfaces as Array).indexOf(_local3) > -1;
      }

      public function describeInjections(param1:Class) : TypeDescription {
         var _local2:Object = null;
         _local2 = this._descriptor.getInstanceDescription(param1);
         var _local3:Object = _local2.traits;
         var _local4:String = _local2.name;
         var _local5:TypeDescription = new TypeDescription(false);
         this.addCtorInjectionPoint(_local5,_local3,_local4);
         this.addFieldInjectionPoints(_local5,_local3.variables);
         this.addFieldInjectionPoints(_local5,_local3.accessors);
         this.addMethodInjectionPoints(_local5,_local3.methods,_local4);
         this.addPostConstructMethodPoints(_local5,_local3.variables,_local4);
         this.addPostConstructMethodPoints(_local5,_local3.accessors,_local4);
         this.addPostConstructMethodPoints(_local5,_local3.methods,_local4);
         this.addPreDestroyMethodPoints(_local5,_local3.methods,_local4);
         return _local5;
      }

      private function addCtorInjectionPoint(param1:TypeDescription, param2:Object, param3:String) : void {
         var _local5:Dictionary = null;
         var _local6:Array = null;
         var _local4:Array = param2.constructor;
         if(!_local4) {
            param1.ctor = param2.bases.length > 0?new NoParamsConstructorInjectionPoint():null;
            return;
         }
         _local5 = this.extractTagParameters("Inject",param2.metadata);
         _local6 = (_local5 && _local5.name || "").split(",");
         var _local7:int = this.gatherMethodParameters(_local4,_local6,param3);
         param1.ctor = new ConstructorInjectionPoint(_local4,_local7,_local5);
      }

      private function addMethodInjectionPoints(param1:TypeDescription, param2:Array, param3:String) : void {
         var _local6:Object = null;
         var _local7:Dictionary = null;
         var _local8:* = false;
         var _local9:Array = null;
         var _local10:Array = null;
         var _local11:uint = 0;
         var _local12:MethodInjectionPoint = null;
         if(!param2) {
            return;
         }
         var _local4:uint = param2.length;
         var _local5:int = 0;
         while(_local5 < _local4) {
            _local6 = param2[_local5];
            _local7 = this.extractTagParameters("Inject",_local6.metadata);
            if(_local7) {
               _local8 = _local7.optional == "true";
               _local9 = (_local7.name || "").split(",");
               _local10 = _local6.parameters;
               _local11 = this.gatherMethodParameters(_local10,_local9,param3);
               _local12 = new MethodInjectionPoint(_local6.name,_local10,_local11,_local8,_local7);
               param1.addInjectionPoint(_local12);
            }
            _local5++;
         }
      }

      private function addPostConstructMethodPoints(param1:TypeDescription, param2:Array, param3:String) : void {
         var _local4:Array = this.gatherOrderedInjectionPointsForTag(PostConstructInjectionPoint,"PostConstruct",param2,param3);
         var _local5:int = 0;
         var _local6:int = _local4.length;
         while(_local5 < _local6) {
            param1.addInjectionPoint(_local4[_local5]);
            _local5++;
         }
      }

      private function addPreDestroyMethodPoints(param1:TypeDescription, param2:Array, param3:String) : void {
         var _local4:Array = this.gatherOrderedInjectionPointsForTag(PreDestroyInjectionPoint,"PreDestroy",param2,param3);
         if(!_local4.length) {
            return;
         }
         param1.preDestroyMethods = _local4[0];
         param1.preDestroyMethods.last = _local4[0];
         var _local5:int = 1;
         var _local6:int = _local4.length;
         while(_local5 < _local6) {
            param1.preDestroyMethods.last.next = _local4[_local5];
            param1.preDestroyMethods.last = _local4[_local5];
            _local5++;
         }
      }

      private function addFieldInjectionPoints(param1:TypeDescription, param2:Array) : void {
         var _local5:Object = null;
         var _local6:Dictionary = null;
         var _local7:String = null;
         var _local8:* = false;
         var _local9:PropertyInjectionPoint = null;
         if(!param2) {
            return;
         }
         var _local3:uint = param2.length;
         var _local4:int = 0;
         while(_local4 < _local3) {
            _local5 = param2[_local4];
            _local6 = this.extractTagParameters("Inject",_local5.metadata);
            if(_local6) {
               _local7 = _local6.name || "";
               _local8 = _local6.optional == "true";
               _local9 = new PropertyInjectionPoint(_local5.type + "|" + _local7,_local5.name,_local8,_local6);
               param1.addInjectionPoint(_local9);
            }
            _local4++;
         }
      }

      private function gatherMethodParameters(param1:Array, param2:Array, param3:String) : uint {
         var _local7:Object = null;
         var _local8:String = null;
         var _local9:String = null;
         var _local4:uint = 0;
         var _local5:uint = param1.length;
         var _local6:int = 0;
         while(_local6 < _local5) {
            _local7 = param1[_local6];
            _local8 = param2[_local6] || "";
            _local9 = _local7.type;
            if(_local9 == "*") {
               if(!_local7.optional) {
                  throw new InjectorError("Error in method definition of injectee \"" + param3 + ". Required LOEBUILD_166e64f6c3677d0c513901242a3e702d can\'t have MsgType \"*\".");
               }
               _local9 = null;
            }
            if(!_local7.optional) {
               _local4++;
            }
            param1[_local6] = _local9 + "|" + _local8;
            _local6++;
         }
         return _local4;
      }

      private function gatherOrderedInjectionPointsForTag(param1:Class, param2:String, param3:Array, param4:String) : Array {
         var _local8:Object = null;
         var _local9:Object = null;
         var _local10:Array = null;
         var _local11:Array = null;
         var _local12:uint = 0;
         var _local13:int = 0;
         var _local5:Array = [];
         if(!param3) {
            return _local5;
         }
         var _local6:uint = param3.length;
         var _local7:int = 0;
         while(_local7 < _local6) {
            _local8 = param3[_local7];
            _local9 = this.extractTagParameters(param2,_local8.metadata);
            if(_local9) {
               _local10 = (_local9.name || "").split(",");
               _local11 = _local8.parameters;
               if(_local11) {
                  _local12 = this.gatherMethodParameters(_local11,_local10,param4);
               } else {
                  _local11 = [];
                  _local12 = 0;
               }
               _local13 = parseInt(_local9.order,10);
               if(_local13.toString(10) != _local9.order) {
                  _local13 = int.MAX_VALUE;
               }
               _local5.push(new param1(_local8.name,_local11,_local12,_local13));
            }
            _local7++;
         }
         if(_local5.length > 0) {
            _local5.sortOn("order",Array.NUMERIC);
         }
         return _local5;
      }

      private function extractTagParameters(param1:String, param2:Array) : Dictionary {
         var _local5:Object = null;
         var _local6:Array = null;
         var _local7:Dictionary = null;
         var _local8:int = 0;
         var _local9:int = 0;
         var _local10:Object = null;
         var _local3:uint = !!param2?uint(param2.length):uint(0);
         var _local4:int = 0;
         while(_local4 < _local3) {
            _local5 = param2[_local4];
            if(_local5.name == param1) {
               _local6 = _local5.value;
               _local7 = new Dictionary();
               _local8 = _local6.length;
               _local9 = 0;
               while(_local9 < _local8) {
                  _local10 = _local6[_local9];
                  _local7[_local10.key] = !!_local7[_local10.key]?_local7[_local10.key] + "," + _local10.value:_local10.value;
                  _local9++;
               }
               return _local7;
            }
            _local4++;
         }
         return null;
      }
   }
}
