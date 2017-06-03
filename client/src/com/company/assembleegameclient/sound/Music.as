package com.company.assembleegameclient.sound
{
import flash.media.Sound;
import flash.media.SoundTransform;
import flash.media.SoundChannel;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.errors.control.LOEBUILD_5c3fafb478917eee32f80d979a87cb36;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import flash.net.URLRequest;
import com.company.googleanalytics.GA;

public class Music
{
    public static const menuMusic:Vector.<String> = new <String>["main", "main", "main"];

    private static var newSoundChannel:SoundChannel = null;

    private static var newSoundTransform:SoundTransform = null;

    public static var fadeIn:Number = 0.65;

    public static var fadeOut:Number = 0;

    private static var cMusic_:String = "main";

    private static var music_:Sound = null;

    private static var musicVolumeTransform:SoundTransform;

    private static var musicChannel_:SoundChannel = null;

    private static var volume:Number = 0.3;

    private static const STRING_MUSIC_ORG:String = "/music/sorc.mp3";

    private static const ENTRANCE_MUSIC:String = "https://devwarlt.github.io/webclient/music/main.mp3";

    public function Music()
    {
        super();
    }

    public static function load() : void
    {
        var _local1:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
        var _local2:* = ENTRANCE_MUSIC;
        /*var _local2:* = "https://devwarlt.github.io/webclient/" +*/
        /*" + LOEBUILD_5c3fafb478917eee32f80d979a87cb36.SERVER_IP + ":" + LOEBUILD_5c3fafb478917eee32f80d979a87cb36.SERVER_PORT + "" + STRING_MUSIC_ORG;*/
        volume = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.musicVolume;
        musicVolumeTransform = new SoundTransform(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playMusic?Number(volume):Number(0));
        music_ = new Sound();
        music_.load(new URLRequest(_local2));
        musicChannel_ = music_.play(0,int.MAX_VALUE,musicVolumeTransform);
    }

    public static function randomMenu():String {
        return menuMusic[Math.round(Math.random() * (menuMusic.length - 1))];
    }

    public static function reload(name:String):void {
        if (cMusic_ == name) return;
        cMusic_ = name;
        try {
            if (fadeIn < 0.65 && musicChannel_ != null) {
                endFade();
            }
            music_ = new Sound();
            music_.load(new URLRequest("https://devwarlt.github.io/webclient/music/" + (name == "main" ? randomMenu() : name) + ".mp3"));
            musicVolumeTransform = new SoundTransform(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playMusic?Number(volume):Number(0));
            musicChannel_ = music_.play(0, int.MAX_VALUE, musicVolumeTransform);
        } catch (e:Error) {
            trace(e);
        }
        fadeIn = 0;
        fadeOut = 0.65;
    }

    public static function endFade():void {
        try {
            musicChannel_.stop();
        } catch (er:Error)
        {
            trace(er);
        }
        musicChannel_ = newSoundChannel;
        musicVolumeTransform = newSoundTransform;

        musicVolumeTransform = new SoundTransform(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playMusic?Number(volume):Number(0));
        fadeIn = 0.65;
        fadeOut = 0;
    }

    public static function updateFade():void {
        if (fadeIn >= 0.65) return;
        if (!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playMusic) {
            endFade();
            return;
        }
        try {
            fadeIn += 0.0065;
            fadeOut -= 0.0065;
            if(fadeOut < 0) {
                fadeOut = 0;
            }
            musicVolumeTransform.volume = fadeOut;
            newSoundTransform.volume = fadeIn;
            musicChannel_.soundTransform = musicVolumeTransform;
            newSoundChannel.soundTransform = newSoundTransform;
        } catch (e:Error) {
            trace(e);
        }
        if (fadeIn >= 0.65) endFade();
    }

    public static function setPlayMusic(param1:Boolean) : void
    {
        GA.global().trackEvent("sound",param1?"musicOn":"musicOff");
        LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playMusic = param1;
        LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
        musicVolumeTransform.volume = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playMusic?Number(volume):Number(0);
        musicChannel_.soundTransform = musicVolumeTransform;
    }

    public static function setMusicVolume(param1:Number) : void
    {
        LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.musicVolume = param1;
        LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
        if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playMusic)
        {
            return;
        }
        if(musicVolumeTransform != null)
        {
            musicVolumeTransform.volume = param1;
        }
        else
        {
            musicVolumeTransform = new SoundTransform(param1);
        }
        musicChannel_.soundTransform = musicVolumeTransform;
    }
}
}
