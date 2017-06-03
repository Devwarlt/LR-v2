package kabam.rotmg.application.impl
{
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.errors.control.LOEBUILD_5c3fafb478917eee32f80d979a87cb36;
import com.google.analytics.v4.LOEBUILD_9e66824be5912020ae4304d695ae300a;

public class PrivateSetup implements ApplicationSetup
{

    private const SERVER:String = "rotmgtesting.appspot.com";

    private const UNENCRYPTED:String = "http://" + SERVER;

    private const ENCRYPTED:String = "https://" + SERVER;

    private const ANALYTICS:String = "UA-99999999-1";

    private const BUILD_LABEL:String = "<font color=\'#FFEE00\'>TESTING APP ENGINE, PRIVATE SERVER</font> #{LABEL}";

    public function PrivateSetup()
    {
        super();
    }

    public function getAppEngineUrl(param1:Boolean = false) : String
    {
        return param1?this.UNENCRYPTED:this.ENCRYPTED;
    }

    public function getAnalyticsCode() : String
    {
        return this.ANALYTICS;
    }

    public function getBuildLabel() : String
    {
        var _local1:String = LOEBUILD_9e66824be5912020ae4304d695ae300a.LOEBUILD_f80f1ecc62a94ff993708804db5bbdbd + "." + LOEBUILD_9e66824be5912020ae4304d695ae300a.LOEBUILD_bcd70d36f5cceaccaf0481d68e756080;
        return this.BUILD_LABEL.replace("{LABEL}",_local1);
    }

    public function useLocalTextures() : Boolean
    {
        return true;
    }

    public function isToolingEnabled() : Boolean
    {
        return true;
    }

    public function isGameLoopMonitored() : Boolean
    {
        return true;
    }

    public function useProductionDialogs() : Boolean
    {
        return false;
    }

    public function areErrorsReported() : Boolean
    {
        return false;
    }

    public function areDeveloperHotkeysEnabled() : Boolean
    {
        return true;
    }

    public function isDebug() : Boolean
    {
        return true;
    }
}
}
