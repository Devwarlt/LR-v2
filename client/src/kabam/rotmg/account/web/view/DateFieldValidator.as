package kabam.rotmg.account.web.view {
import kabam.rotmg.account.ui.components.DateField;

public class DateFieldValidator {

      public function DateFieldValidator() {
         super();
      }

      public static function getPlayerAge(param1:DateField) : uint {
         var _local2:Date = new Date(getBirthDate(param1));
         var _local3:Date = new Date();
         var _local4:uint = Number(_local3.fullYear) - Number(_local2.fullYear);
         if(_local2.month > _local3.month || _local2.month == _local3.month && _local2.date > _local3.date) {
            _local4--;
         }
         return _local4;
      }

      public static function getBirthDate(param1:DateField) : Number {
         var _local2:String = param1.months.text + "/" + param1.days.text + "/" + param1.years.text;
         return Date.parse(_local2);
      }
   }
}
