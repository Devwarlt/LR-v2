package com.google.analytics.ecommerce {
import com.google.analytics.utils.Variables;

public class Transaction {

      private var _items:Array;

      private var _total:String;

      private var _vars:Variables;

      private var _shipping:String;

      private var _city:String;

      private var _state:String;

      private var _country:String;

      private var _tax:String;

      private var _affiliation:String;

      private var _id:String;

      public function Transaction(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String) {
         super();
         this._id = param1;
         this._affiliation = param2;
         this._total = param3;
         this._tax = param4;
         this._shipping = param5;
         this._city = param6;
         this._state = param7;
         this._country = param8;
         _items = new Array();
      }

      public function get total() : String {
         return _total;
      }

      public function getItemFromArray(param1:Number) : Item {
         return _items[param1];
      }

      public function set total(param1:String) : void {
         _total = param1;
      }

      public function getItem(param1:String) : Item {
         var _local2:Number = NaN;
         _local2 = 0;
         while(_local2 < _items.length) {
            if(_items[_local2].sku == param1) {
               return _items[_local2];
            }
            _local2++;
         }
         return null;
      }

      public function getItemsLength() : Number {
         return _items.length;
      }

      public function addItem(param1:String, param2:String, param3:String, param4:String, param5:String) : void {
         var _local6:Item = null;
         _local6 = getItem(param1);
         if(_local6 == null) {
            _local6 = new Item(_id,param1,param2,param3,param4,param5);
            _items.push(_local6);
         } else {
            _local6.name = param2;
            _local6.category = param3;
            _local6.price = param4;
            _local6.quantity = param5;
         }
      }

      public function set shipping(param1:String) : void {
         _shipping = param1;
      }

      public function get country() : String {
         return _country;
      }

      public function get state() : String {
         return _state;
      }

      public function set tax(param1:String) : void {
         _tax = param1;
      }

      public function set affiliation(param1:String) : void {
         _affiliation = param1;
      }

      public function set state(param1:String) : void {
         _state = param1;
      }

      public function get id() : String {
         return _id;
      }

      public function get tax() : String {
         return _tax;
      }

      public function toGifParams() : Variables {
         var _local1:Variables = new Variables();
         _local1.URIencode = true;
         _local1.utmt = "tran";
         _local1.utmtid = id;
         _local1.utmtst = affiliation;
         _local1.utmtto = total;
         _local1.utmttx = tax;
         _local1.utmtsp = shipping;
         _local1.utmtci = city;
         _local1.utmtrg = state;
         _local1.utmtco = country;
         _local1.post = ["utmtid","utmtst","utmtto","utmttx","utmtsp","utmtci","utmtrg","utmtco"];
         return _local1;
      }

      public function get affiliation() : String {
         return _affiliation;
      }

      public function get city() : String {
         return _city;
      }

      public function get shipping() : String {
         return _shipping;
      }

      public function set id(param1:String) : void {
         _id = param1;
      }

      public function set city(param1:String) : void {
         _city = param1;
      }

      public function set country(param1:String) : void {
         _country = param1;
      }
   }
}
