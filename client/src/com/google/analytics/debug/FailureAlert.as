package com.google.analytics.debug {
   public class FailureAlert extends Alert {

      public function FailureAlert(param1:DebugConfiguration, param2:String, param3:Array) {
         var _local4:Align = Align.bottomLeft;
         var _local5:Boolean = true;
         var _local6:Boolean = false;
         if(param1.verbose) {
            param2 = "<u><span class=\"uiAlertTitle\">Failure</span>" + spaces(18) + "</u>\n\n" + param2;
            _local4 = Align.center;
            _local5 = false;
            _local6 = true;
         }
         super(param2,param3,"uiFailure",Style.failureColor,_local4,_local5,_local6);
      }
   }
}
