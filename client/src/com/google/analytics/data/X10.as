package com.google.analytics.data {
   public class X10 {

      private var _delimEnd:String = ")";

      private var _minimum:int;

      private var _delimSet:String = "*";

      private var _escapeChar:String = "\'";

      private var _delimBegin:String = "(";

      private var _delimNumValue:String = "!";

      private var _key:String = "k";

      private var _set:Array;

      private var _hasData:int;

      private var _escapeCharMap:Object;

      private var _projectData:Object;

      private var _value:String = "v";

      public function X10() {
         _set = [_key,_value];
         super();
         _projectData = {};
         _escapeCharMap = {};
         _escapeCharMap[_escapeChar] = "\'0";
         _escapeCharMap[_delimEnd] = "\'1";
         _escapeCharMap[_delimSet] = "\'2";
         _escapeCharMap[_delimNumValue] = "\'3";
         _minimum = 1;
      }

      private function _setInternal(param1:Number, param2:String, param3:Number, param4:String) : void {
         if(!hasProject(param1)) {
            _projectData[param1] = {};
         }
         if(_projectData[param1][param2] == undefined) {
            _projectData[param1][param2] = [];
         }
         _projectData[param1][param2][param3] = param4;
         _hasData = _hasData + 1;
      }

      private function _renderProject(param1:Object) : String {
         var _local4:int = 0;
         var _local5:Array = null;
         var _local2:String = "";
         var _local3:Boolean = false;
         var _local6:int = _set.length;
         _local4 = 0;
         while(_local4 < _local6) {
            _local5 = param1[_set[_local4]];
            if(_local5) {
               if(_local3) {
                  _local2 = _local2 + _set[_local4];
               }
               _local2 = _local2 + _renderDataType(_local5);
               _local3 = false;
            } else {
               _local3 = true;
            }
            _local4++;
         }
         return _local2;
      }

      public function hasProject(param1:Number) : Boolean {
         return _projectData[param1];
      }

      public function clearKey(param1:Number) : void {
         _clearInternal(param1,_key);
      }

      private function _renderDataType(param1:Array) : String {
         var _local3:String = null;
         var _local4:int = 0;
         var _local2:Array = [];
         _local4 = 0;
         while(_local4 < param1.length) {
            if(param1[_local4] != undefined) {
               _local3 = "";
               if(_local4 != _minimum && param1[_local4 - 1] == undefined) {
                  _local3 = _local3 + _local4.toString();
                  _local3 = _local3 + _delimNumValue;
               }
               _local3 = _local3 + _escapeExtensibleValue(param1[_local4]);
               _local2.push(_local3);
            }
            _local4++;
         }
         return _delimBegin + _local2.join(_delimSet) + _delimEnd;
      }

      public function getKey(param1:Number, param2:Number) : String {
         return _getInternal(param1,_key,param2) as String;
      }

      public function hasData() : Boolean {
         return _hasData > 0;
      }

      public function renderMergedUrlString(param1:X10 = null) : String {
         var _local3:* = null;
         if(!param1) {
            return renderUrlString();
         }
         var _local2:Array = [param1.renderUrlString()];
         for(_local3 in _projectData) {
            if(Boolean(hasProject(Number(_local3))) && !param1.hasProject(Number(_local3))) {
               _local2.push(_local3 + _renderProject(_projectData[_local3]));
            }
         }
         return _local2.join("");
      }

      public function setValue(param1:Number, param2:Number, param3:Number) : Boolean {
         if(Math.round(param3) != param3 || Boolean(isNaN(param3)) || param3 == Infinity) {
            return false;
         }
         _setInternal(param1,_value,param2,param3.toString());
         return true;
      }

      public function renderUrlString() : String {
         var _local2:* = null;
         var _local1:Array = [];
         for(_local2 in _projectData) {
            if(hasProject(Number(_local2))) {
               _local1.push(_local2 + _renderProject(_projectData[_local2]));
            }
         }
         return _local1.join("");
      }

      private function _getInternal(param1:Number, param2:String, param3:Number) : Object {
         if(Boolean(hasProject(param1)) && _projectData[param1][param2] != undefined) {
            return _projectData[param1][param2][param3];
         }
         return undefined;
      }

      public function setKey(param1:Number, param2:Number, param3:String) : Boolean {
         _setInternal(param1,_key,param2,param3);
         return true;
      }

      public function clearValue(param1:Number) : void {
         _clearInternal(param1,_value);
      }

      private function _clearInternal(param1:Number, param2:String) : void {
         var _local3:Boolean = false;
         var _local4:int = 0;
         var _local5:int = 0;
         if(Boolean(hasProject(param1)) && _projectData[param1][param2] != undefined) {
            _projectData[param1][param2] = undefined;
            _local3 = true;
            _local5 = _set.length;
            _local4 = 0;
            while(_local4 < _local5) {
               if(_projectData[param1][_set[_local4]] != undefined) {
                  _local3 = false;
                  break;
               }
               _local4++;
            }
            if(_local3) {
               _projectData[param1] = undefined;
               _hasData = _hasData - 1;
            }
         }
      }

      public function getValue(param1:Number, param2:Number) : * {
         var _local3:* = _getInternal(param1,_value,param2);
         if(_local3 == null) {
            return null;
         }
         return Number(_local3);
      }

      private function _escapeExtensibleValue(param1:String) : String {
         var _local3:int = 0;
         var _local4:String = null;
         var _local5:String = null;
         var _local2:String = "";
         _local3 = 0;
         while(_local3 < param1.length) {
            _local4 = param1.charAt(_local3);
            _local5 = _escapeCharMap[_local4];
            if(_local5) {
               _local2 = _local2 + _local5;
            } else {
               _local2 = _local2 + _local4;
            }
            _local3++;
         }
         return _local2;
      }
   }
}
