package kabam.rotmg.news.model {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.news.controller.NewsButtonRefreshSignal;
import kabam.rotmg.news.controller.NewsDataUpdatedSignal;
import kabam.rotmg.news.view.NewsModalPage;

public class NewsModel {

      private static const COUNT:int = 3;

      public static const MODAL_PAGE_COUNT:int = 4;

      [Inject]
      public var update:NewsDataUpdatedSignal;

      [Inject]
      public var updateNoParams:NewsButtonRefreshSignal;

      [Inject]
      public var account:Account;

      public var news:Vector.<NewsCellVO>;

      public var modalPages:Vector.<NewsModalPage>;

      public var modalPageData:Vector.<NewsCellVO>;

      public function NewsModel() {
         super();
      }

      public function initNews() : void {
         this.news = new Vector.<NewsCellVO>(COUNT,true);
         var _local1:int = 0;
         while(_local1 < COUNT) {
            this.news[_local1] = new DefaultNewsCellVO(_local1);
            _local1++;
         }
      }

      public function updateNews(param1:Vector.<NewsCellVO>) : void {
         var _local3:NewsCellVO = null;
         var _local4:int = 0;
         var _local5:int = 0;
         this.initNews();
         var _local2:Vector.<NewsCellVO> = new Vector.<NewsCellVO>();
         this.modalPageData = new Vector.<NewsCellVO>(4,true);
         for each(_local3 in param1) {
            if(_local3.slot <= 3) {
               _local2.push(_local3);
            } else {
               _local4 = _local3.slot - 4;
               _local5 = _local4 + 1;
               this.modalPageData[_local4] = _local3;
               if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["newsTimestamp" + _local5] != _local3.endDate) {
                  LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["newsTimestamp" + _local5] = _local3.endDate;
                  LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["hasNewsUpdate" + _local5] = true;
               }
            }
         }
         this.sortByPriority(_local2);
         this.update.dispatch(this.news);
         this.updateNoParams.dispatch();
      }

      public function hasValidNews() : Boolean {
         return this.news[0] != null && this.news[1] != null && this.news[2] != null;
      }

      public function hasValidModalNews() : Boolean {
         var _local1:int = 0;
         while(_local1 < MODAL_PAGE_COUNT) {
            if(this.modalPageData[_local1] == null) {
               return false;
            }
            _local1++;
         }
         return true;
      }

      private function sortByPriority(param1:Vector.<NewsCellVO>) : void {
         var _local2:NewsCellVO = null;
         for each(_local2 in param1) {
            if(Boolean(this.isNewsTimely(_local2)) && Boolean(this.isValidForPlatform(_local2))) {
               this.prioritize(_local2);
            }
         }
      }

      private function prioritize(param1:NewsCellVO) : void {
         var _local2:uint = param1.slot - 1;
         if(this.news[_local2]) {
            param1 = this.comparePriority(this.news[_local2],param1);
         }
         this.news[_local2] = param1;
      }

      private function comparePriority(param1:NewsCellVO, param2:NewsCellVO) : NewsCellVO {
         return param1.priority < param2.priority?param1:param2;
      }

      private function isNewsTimely(param1:NewsCellVO) : Boolean {
         var _local2:Number = new Date().getTime();
         return param1.startDate < _local2 && _local2 < param1.endDate;
      }

      public function buildModalPages() : void {
         if(!this.hasValidModalNews()) {
            return;
         }
         this.modalPages = new Vector.<NewsModalPage>(MODAL_PAGE_COUNT,true);
         var _local1:int = 0;
         while(_local1 < MODAL_PAGE_COUNT) {
            this.modalPages[_local1] = new NewsModalPage((this.modalPageData[_local1] as NewsCellVO).headline,(this.modalPageData[_local1] as NewsCellVO).linkDetail);
            _local1++;
         }
      }

      public function getModalPage(param1:int) : NewsModalPage {
         if(this.modalPages != null && param1 > 0 && param1 <= this.modalPages.length && this.modalPages[param1 - 1] != null) {
            return this.modalPages[param1 - 1];
         }
         return new NewsModalPage("No new information","Please check back later.");
      }

      private function isValidForPlatform(param1:NewsCellVO) : Boolean {
         var _local2:String = this.account.gameNetwork();
         return param1.networks.indexOf(_local2) != -1;
      }
   }
}
