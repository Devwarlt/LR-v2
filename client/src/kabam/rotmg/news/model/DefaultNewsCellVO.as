package kabam.rotmg.news.model {
   public class DefaultNewsCellVO extends NewsCellVO {

      public function DefaultNewsCellVO(param1:int) {
         super();
         imageURL = "";
         linkDetail = param1 == 0?"http://loerealm.no-ip.org/theserver/donate":"https://github.com/Devwarlt/webclient/commits/gh-pages/AGCLoEBuild_LOWRES.swf";
         headline = param1 == 0?"Support us (donate)!":"Update log!";
         startDate = new Date().getTime() - 1000000000;
         endDate = new Date().getTime() + 1000000000;
         networks = ["kabam.com","kongregate","steam","rotmg"];
         linkType = NewsCellLinkType.OPENS_LINK;
         priority = 999999;
         slot = param1;
      }
   }
}
