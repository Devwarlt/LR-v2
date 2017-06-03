package kabam.rotmg.application.model
{
import flash.display.DisplayObjectContainer;
import flash.system.Capabilities;
import flash.display.LoaderInfo;

public class PlatformModel
{

    private static var platform:kabam.rotmg.application.model.PlatformType;

    [Inject]
    public var root:DisplayObjectContainer;

    private const DESKTOP:String = "Desktop";

    public function PlatformModel()
    {
        super();
    }

    public function isWeb() : Boolean
    {
        return Capabilities.playerType != this.DESKTOP;
    }

    public function isDesktop() : Boolean
    {
        return Capabilities.playerType == this.DESKTOP;
    }

    public function getPlatform() : kabam.rotmg.application.model.PlatformType
    {
        return platform = platform || this.determinePlatform();
    }

    private function determinePlatform() : kabam.rotmg.application.model.PlatformType
    {
        var _local1:Object = LoaderInfo(this.root.stage.root.loaderInfo).parameters;
        if(this.isKongregate(_local1))
        {
            return PlatformType.KONGREGATE;
        }
        if(this.isSteam(_local1))
        {
            return PlatformType.STEAM;
        }
        if(this.isKabam(_local1))
        {
            return PlatformType.KABAM;
        }
        return PlatformType.WEB;
    }

    private function isKongregate(param1:Object) : Boolean
    {
        return param1.kongregate_api_path != null;
    }

    private function isSteam(param1:Object) : Boolean
    {
        return param1.steam_api_path != null;
    }

    private function isKabam(param1:Object) : Boolean
    {
        return param1.kabam_signed_request != null;
    }
}
}
