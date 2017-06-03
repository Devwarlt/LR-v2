package com.google.analytics.core {
import com.google.analytics.debug.DebugConfiguration;
import com.google.analytics.ecommerce.Transaction;

public class Ecommerce {

      private var _debug:DebugConfiguration;

      private var _trans:Array;

      public function Ecommerce(param1:DebugConfiguration) {
         super();
         this._debug = param1;
         _trans = new Array();
      }

      public function getTransLength() : Number {
         return _trans.length;
      }

      public function getTransFromArray(param1:Number) : Transaction {
         return _trans[param1];
      }

      public function addTransaction(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String) : Transaction {
         var _local9:Transaction = null;
         _local9 = getTransaction(param1);
         if(_local9 == null) {
            _local9 = new Transaction(param1,param2,param3,param4,param5,param6,param7,param8);
            _trans.push(_local9);
         } else {
            _local9.affiliation = param2;
            _local9.total = param3;
            _local9.tax = param4;
            _local9.shipping = param5;
            _local9.city = param6;
            _local9.state = param7;
            _local9.country = param8;
         }
         return _local9;
      }

      public function getTransaction(param1:String) : Transaction {
         var _local2:Number = NaN;
         _local2 = 0;
         while(_local2 < _trans.length) {
            if(_trans[_local2].id == param1) {
               return _trans[_local2];
            }
            _local2++;
         }
         return null;
      }
   }
}
