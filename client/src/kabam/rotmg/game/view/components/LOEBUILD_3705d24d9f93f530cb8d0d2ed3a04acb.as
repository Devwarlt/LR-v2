package kabam.rotmg.game.view.components
{
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.errors.control.LOEBUILD_5c3fafb478917eee32f80d979a87cb36;
import com.google.analytics.v4.LOEBUILD_9e66824be5912020ae4304d695ae300a;

public class LOEBUILD_3705d24d9f93f530cb8d0d2ed3a04acb implements ApplicationSetup
{

    private const SERVER:String = LOEBUILD_5c3fafb478917eee32f80d979a87cb36.SERVER_IP + ":" + LOEBUILD_5c3fafb478917eee32f80d979a87cb36.SERVER_PORT;

    private const UNENCRYPTED:String = "http://" + SERVER;

    private const ENCRYPTED:String = "https://" + SERVER;

    private const ANALYTICS:String = "UA-11236645-4";

    private const BUILD_LABEL:String = "<b><font color=\'#90EE90\'>AGCLoEBuild [LOW RESOLUTION]</font></b> #{BUILD}.{LABEL}";

    public function LOEBUILD_3705d24d9f93f530cb8d0d2ed3a04acb()
    {
        super();
    }

    public function getAppEngineUrl(_arg1:Boolean = false) : String
    {
        return _arg1?this.ENCRYPTED:this.UNENCRYPTED;
    }

    public function getAnalyticsCode() : String
    {
        return this.ANALYTICS;
    }

    public function getBuildLabel() : String
    {
        return this.BUILD_LABEL.replace("{BUILD}",LOEBUILD_9e66824be5912020ae4304d695ae300a.LOEBUILD_f80f1ecc62a94ff993708804db5bbdbd).replace("{LABEL}",LOEBUILD_9e66824be5912020ae4304d695ae300a.LOEBUILD_bcd70d36f5cceaccaf0481d68e756080);
    }

    public function useLocalTextures() : Boolean
    {
        return false;
    }

    public function isToolingEnabled() : Boolean
    {
        return false;
    }

    public function isGameLoopMonitored() : Boolean
    {
        return false;
    }

    public function useProductionDialogs() : Boolean
    {
        return true;
    }

    public function areErrorsReported() : Boolean
    {
        return false;
    }

    public function areDeveloperHotkeysEnabled() : Boolean
    {
        return false;
    }

    public function isDebug() : Boolean
    {
        return false;
    }
}
}
