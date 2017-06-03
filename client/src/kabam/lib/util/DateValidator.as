package kabam.lib.util {
   public class DateValidator {

      private static const DAYS_IN_MONTH:Vector.<int> = Vector.<int>([31,-1,31,30,31,30,31,31,30,31,30,31]);

      private static const FEBRUARY:int = 2;

      private var thisYear:int;

      public function DateValidator() {
         super();
         this.thisYear = new Date().getFullYear();
      }

      public function isValidMonth(param1:int) : Boolean {
         return param1 > 0 && param1 <= 12;
      }

      public function isValidDay(param1:int, param2:int = -1, param3:int = -1) : Boolean {
         return param1 > 0 && param1 <= this.getDaysInMonth(param2,param3);
      }

      public function getDaysInMonth(param1:int = -1, param2:int = -1) : int {
         if(param1 == -1) {
            return 31;
         }
         return param1 == FEBRUARY?int(this.getDaysInFebruary(param2)):int(DAYS_IN_MONTH[param1 - 1]);
      }

      private function getDaysInFebruary(param1:int) : int {
         if(param1 == -1 || Boolean(this.isLeapYear(param1))) {
            return 29;
         }
         return 28;
      }

      public function isLeapYear(param1:int) : Boolean {
         var _local2:* = param1 % 4 == 0;
         var _local3:* = param1 % 100 == 0;
         var _local4:* = param1 % 400 == 0;
         return Boolean(_local2) && (!_local3 || Boolean(_local4));
      }

      public function isValidDate(param1:int, param2:int, param3:int, param4:int) : Boolean {
         return Boolean(this.isValidYear(param3,param4)) && Boolean(this.isValidMonth(param1)) && Boolean(this.isValidDay(param2,param1,param3));
      }

      public function isValidYear(param1:int, param2:int) : Boolean {
         return param1 <= this.thisYear && param1 > this.thisYear - param2;
      }
   }
}
