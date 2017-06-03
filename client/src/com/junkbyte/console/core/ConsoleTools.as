package com.junkbyte.console.core {
import com.junkbyte.console.Cc;
import com.junkbyte.console.Console;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.utils.ByteArray;
import flash.utils.describeType;
import flash.utils.getQualifiedClassName;

public class ConsoleTools extends ConsoleCore {

      public function ConsoleTools(param1:Console) {
         super(param1);
      }

      public function map(param1:DisplayObjectContainer, param2:uint = 0, param3:String = null) : void {
         var _local5:Boolean = false;
         var _local9:DisplayObject = null;
         var _local10:String = null;
         var _local11:DisplayObjectContainer = null;
         var _local12:int = 0;
         var _local13:int = 0;
         var _local14:DisplayObject = null;
         var _local15:uint = 0;
         var _local16:* = null;
         if(!param1) {
            report("Not a DisplayObjectContainer.",10,true,param3);
            return;
         }
         var _local4:int = 0;
         var _local6:int = 0;
         var _local7:DisplayObject = null;
         var _local8:Array = new Array();
         _local8.push(param1);
         while(_local6 < _local8.length) {
            _local9 = _local8[_local6];
            _local6++;
            if(_local9 is DisplayObjectContainer) {
               _local11 = _local9 as DisplayObjectContainer;
               _local12 = _local11.numChildren;
               _local13 = 0;
               while(_local13 < _local12) {
                  _local14 = _local11.getChildAt(_local13);
                  _local8.splice(_local6 + _local13,0,_local14);
                  _local13++;
               }
            }
            if(_local7) {
               if(_local7 is DisplayObjectContainer && Boolean((_local7 as DisplayObjectContainer).contains(_local9))) {
                  _local4++;
               } else {
                  while(_local7) {
                     _local7 = _local7.parent;
                     if(_local7 is DisplayObjectContainer) {
                        if(_local4 > 0) {
                           _local4--;
                        }
                        if((_local7 as DisplayObjectContainer).contains(_local9)) {
                           _local4++;
                           break;
                        }
                     }
                  }
               }
            }
            _local10 = "";
            _local13 = 0;
            while(_local13 < _local4) {
               _local10 = _local10 + (_local13 == _local4 - 1?" ∟ ":" - ");
               _local13++;
            }
            if(param2 <= 0 || _local4 <= param2) {
               _local5 = false;
               _local15 = console.refs.setLogRef(_local9);
               _local16 = _local9.name;
               if(_local15) {
                  _local16 = "<a href=\'event:cl_" + _local15 + "\'>" + _local16 + "</a>";
               }
               if(_local9 is DisplayObjectContainer) {
                  _local16 = "<b>" + _local16 + "</b>";
               } else {
                  _local16 = "<i>" + _local16 + "</i>";
               }
               _local10 = _local10 + (_local16 + " " + console.refs.makeRefTyped(_local9));
               report(_local10,_local9 is DisplayObjectContainer?5:2,true,param3);
            } else if(!_local5) {
               _local5 = true;
               report(_local10 + "...",5,true,param3);
            }
            _local7 = _local9;
         }
         report(param1.name + ":" + console.refs.makeRefTyped(param1) + " has " + (_local8.length - 1) + " children/sub-children.",9,true,param3);
         if(config.commandLineAllowed) {
            report("Click on the child display\'s name to set scope.",-2,true,param3);
         }
      }

      public function explode(param1:Object, param2:int = 3, param3:int = 9) : String {
         var _local6:XMLList = null;
         var _local7:String = null;
         var _local9:XML = null;
         var _local10:XML = null;
         var _local11:* = null;
         var _local4:* = typeof param1;
         if(param1 == null) {
            return "<p-2>" + param1 + "</p-2>";
         }
         if(param1 is String) {
            return "\"" + LogReferences.EscHTML(param1 as String) + "\"";
         }
         if(_local4 != "object" || param2 == 0 || param1 is ByteArray) {
            return console.refs.makeString(param1);
         }
         if(param3 < 0) {
            param3 = 0;
         }
         var _local5:XML = describeType(param1);
         var _local8:Array = [];
         _local6 = _local5["accessor"];
         for each(_local9 in _local6) {
            _local7 = _local9.@name;
            if(_local9.@access != "writeonly") {
               try {
                  _local8.push(this.stepExp(param1,_local7,param2,param3));
               }
               catch(e:Error) {
               }
            } else {
               _local8.push(_local7);
            }
         }
         _local6 = _local5["variable"];
         for each(_local10 in _local6) {
            _local7 = _local10.@name;
            _local8.push(this.stepExp(param1,_local7,param2,param3));
         }
         try {
            for(_local11 in param1) {
               _local8.push(this.stepExp(param1,_local11,param2,param3));
            }
         }
         catch(e:Error) {
         }
         return "<p" + param3 + ">{" + LogReferences.ShortClassName(param1) + "</p" + param3 + "> " + _local8.join(", ") + "<p" + param3 + ">}</p" + param3 + ">";
      }

      private function stepExp(param1:*, param2:String, param3:int, param4:int) : String {
         return param2 + ":" + this.explode(param1[param2],param3 - 1,param4 - 1);
      }

      public function getStack(param1:int, param2:int) : String {
         var _local3:Error = new Error();
         var _local4:String = !!_local3.hasOwnProperty("getStackTrace")?_local3.getStackTrace():null;
         if(!_local4) {
            return "";
         }
         var _local5:String = "";
         var _local6:Array = _local4.split(new RegExp("\\n\\sat\\s"));
         var _local7:int = _local6.length;
         var _local8:RegExp = new RegExp("Function|" + getQualifiedClassName(Console) + "|" + getQualifiedClassName(Cc));
         var _local9:Boolean = false;
         var _local10:int = 2;
         while(_local10 < _local7) {
            if(!_local9 && _local6[_local10].search(_local8) != 0) {
               _local9 = true;
            }
            if(_local9) {
               _local5 = _local5 + ("\n<p" + param2 + "> @ " + _local6[_local10] + "</p" + param2 + ">");
               if(param2 > 0) {
                  param2--;
               }
               param1--;
               if(param1 <= 0) {
                  break;
               }
            }
            _local10++;
         }
         return _local5;
      }
   }
}
