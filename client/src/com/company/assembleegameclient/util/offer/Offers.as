package com.company.assembleegameclient.util.offer {
   public class Offers {

      private static const BEST_DEAL:String = "(Best deal)";

      private static const MOST_POPULAR:String = "(Most popular)";

      public var tok:String;

      public var exp:String;

      public var offerList:Vector.<Offer>;

      public function Offers(param1:XML) {
         super();
         this.tok = param1.Tok;
         this.exp = param1.Exp;
         this.makeOffers(param1);
      }

      private function makeOffers(param1:XML) : void {
         this.makeOfferList(param1);
         this.sortOfferList();
         this.defineBonuses();
         this.defineMostPopularTagline();
         this.defineBestDealTagline();
      }

      private function makeOfferList(param1:XML) : void {
         var _local2:XML = null;
         this.offerList = new Vector.<Offer>(0);
         for each(_local2 in param1.Offer) {
            this.offerList.push(this.makeOffer(_local2));
         }
      }

      private function makeOffer(param1:XML) : Offer {
         var _local2:String = param1.Id;
         var _local3:Number = Number(param1.Price);
         var _local4:int = int(param1.RealmGold);
         var _local5:String = param1.CheckoutJWT;
         var _local6:String = param1.Data;
         var _local7:String = !!param1.hasOwnProperty("Currency")?param1.Currency:null;
         return new Offer(_local2,_local3,_local4,_local5,_local6,_local7);
      }

      private function sortOfferList() : void {
         this.offerList.sort(this.sortOffers);
      }

      private function defineBonuses() : void {
         var _local5:int = 0;
         var _local6:int = 0;
         var _local7:Number = NaN;
         var _local8:Number = NaN;
         if(this.offerList.length == 0) {
            return;
         }
         var _local1:int = this.offerList[0].realmGold_;
         var _local2:int = this.offerList[0].price_;
         var _local3:Number = _local1 / _local2;
         var _local4:int = 1;
         while(_local4 < this.offerList.length) {
            _local5 = this.offerList[_local4].realmGold_;
            _local6 = this.offerList[_local4].price_;
            _local7 = _local6 * _local3;
            _local8 = _local5 - _local7;
            this.offerList[_local4].bonus = _local8 / _local6;
            _local4++;
         }
      }

      private function sortOffers(param1:Offer, param2:Offer) : int {
         return param1.price_ - param2.price_;
      }

      private function defineMostPopularTagline() : void {
         var _local1:Offer = null;
         for each(_local1 in this.offerList) {
            if(_local1.price_ == 10) {
               _local1.tagline = MOST_POPULAR;
            }
         }
      }

      private function defineBestDealTagline() : void {
         this.offerList[this.offerList.length - 1].tagline = BEST_DEAL;
      }
   }
}
