package com.junkbyte.console.vos {
import flash.utils.Dictionary;

public class WeakRef {

      private var _val;

      private var _strong:Boolean;

      public function WeakRef(param1:*, param2:Boolean = false) {
         super();
         this._strong = param2;
         this.reference = param1;
      }

      public function get reference() : * {
         var _local1:* = undefined;
         if(this._strong) {
            return this._val;
         }
         for(_local1 in this._val) {
            return _local1;
         }
         return null;
      }

      public function set reference(param1:*) : void {
         if(this._strong) {
            this._val = param1;
         } else {
            this._val = new Dictionary(true);
            this._val[param1] = null;
         }
      }

      public function get strong() : Boolean {
         return this._strong;
      }
   }
}
