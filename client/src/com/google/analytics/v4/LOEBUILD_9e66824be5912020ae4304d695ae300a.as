package com.google.analytics.v4
{
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;

public class LOEBUILD_9e66824be5912020ae4304d695ae300a extends Sprite
{

    public static const LOEBUILD_f80f1ecc62a94ff993708804db5bbdbd:String = "7.32"; // this is the major version

    public static const LOEBUILD_bcd70d36f5cceaccaf0481d68e756080:String = "451X3"; // this is the minor verson

    private static const BAD_DOMAIN_TEXT:String = "<p align=\"center\"><font color=\"#FFFFFF\">Play online at: " + "<br/></font><font color=\"#7777EE\">" + "<a href=\"https://devwarlt.github.io/AGCLoEBuild.swf?server=e139d5cdbc18f23a522f86dd40490eaa\">" + "www.loerealm.com</font></a></p>";

    public function LOEBUILD_9e66824be5912020ae4304d695ae300a()
    {
        super();
        var _local1:TextField = new TextField();
        _local1.selectable = false;
        var _local2:TextFormat = new TextFormat();
        _local2.size = 20;
        _local2.bold = true;
        _local1.defaultTextFormat = _local2;
        _local1.htmlText = BAD_DOMAIN_TEXT;
        _local1.width = 800;
        _local1.y = 600 / 2 - _local1.height / 2;
        addChild(_local1);
    }
}
}
