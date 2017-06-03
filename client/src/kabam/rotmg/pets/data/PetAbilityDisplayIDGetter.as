package kabam.rotmg.pets.data {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;

public class PetAbilityDisplayIDGetter {

      public function PetAbilityDisplayIDGetter() {
         super();
      }

      public function getID(param1:int) : String {
         return LOEBUILD_efda783509bc93eea698457c87bbee3f.getPetDataXMLByType(param1).DisplayId;
      }
   }
}
