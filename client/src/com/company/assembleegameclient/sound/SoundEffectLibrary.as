package com.company.assembleegameclient.sound
{
import flash.utils.Dictionary;
import flash.media.Sound;
import flash.events.IOErrorEvent;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;
import flash.net.URLRequest;
import flash.media.SoundTransform;
import flash.media.SoundChannel;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import flash.events.Event;
import kabam.rotmg.errors.control.LOEBUILD_5c3fafb478917eee32f80d979a87cb36;

public class SoundEffectLibrary
{

    private static var urlBase:String = "http://" + LOEBUILD_5c3fafb478917eee32f80d979a87cb36.SERVER_IP + ":" + LOEBUILD_5c3fafb478917eee32f80d979a87cb36.SERVER_PORT;

    private static const URL_PATTERN:String = "{URLBASE}/sfx/{NAME}.mp3";

    public static var nameMap_:Dictionary = new Dictionary();

    private static var activeSfxList_:Dictionary = new Dictionary(true);

    public function SoundEffectLibrary()
    {
        super();
    }

    public static function load(param1:String) : Sound
    {
        return nameMap_[param1] = nameMap_[param1] || makeSound(param1);
    }

    public static function makeSound(param1:String) : Sound
    {
        var _local2:Sound = new Sound();
        _local2.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
        _local2.load(makeSoundRequest(param1));
        return _local2;
    }

    private static function getUrlBase() : String
    {
        var setup:ApplicationSetup = null;
        var base:String = "";
        try
        {
            setup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
            base = setup.getAppEngineUrl(true);
        }
        catch(error:Error)
        {
            base = "localhost";
        }
        return base;
    }

    private static function makeSoundRequest(param1:String) : URLRequest
    {
        urlBase = urlBase || getUrlBase();
        var _local2:String = URL_PATTERN.replace("{URLBASE}",urlBase).replace("{NAME}",param1);
        return new URLRequest(_local2);
    }

    public static function play(param1:String, param2:Number = 1.0, param3:Boolean = true) : void
    {
        var actualVolume:Number = NaN;
        var trans:SoundTransform = null;
        var channel:SoundChannel = null;
        var name:String = param1;
        var volumeMultiplier:Number = param2;
        var isFX:Boolean = param3;
        var sound:Sound = load(name);
        var volume:* = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.SFXVolume * volumeMultiplier;
        try
        {
            actualVolume = Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playSFX) && Boolean(isFX) || Boolean(!isFX) && Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playPewPew)?Number(volume):Number(0);
            trans = new SoundTransform(actualVolume);
            channel = sound.play(0,0,trans);
            channel.addEventListener(Event.SOUND_COMPLETE,onSoundComplete,false,0,true);
            activeSfxList_[channel] = volume;
            return;
        }
        catch(error:Error)
        {
            return;
        }
    }

    private static function onSoundComplete(param1:Event) : void
    {
        var _local2:SoundChannel = param1.target as SoundChannel;
        delete activeSfxList_[_local2];
    }

    public static function updateVolume(param1:Number) : void
    {
        var _local2:SoundChannel = null;
        var _local3:SoundTransform = null;
        for each(_local2 in activeSfxList_)
        {
            activeSfxList_[_local2] = param1;
            _local3 = _local2.soundTransform;
            _local3.volume = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playSFX?Number(activeSfxList_[_local2]):Number(0);
            _local2.soundTransform = _local3;
        }
    }

    public static function updateTransform() : void
    {
        var _local1:SoundChannel = null;
        var _local2:SoundTransform = null;
        for each(_local1 in activeSfxList_)
        {
            _local2 = _local1.soundTransform;
            _local2.volume = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playSFX?Number(activeSfxList_[_local1]):Number(0);
            _local1.soundTransform = _local2;
        }
    }

    public static function onIOError(param1:IOErrorEvent) : void
    {
    }
}
}
