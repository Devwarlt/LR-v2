package com.company.util {
import flash.display.BitmapData;
import flash.media.Sound;
import flash.media.SoundTransform;
import flash.utils.Dictionary;

public class AssetLibrary {

      private static var images_:Dictionary = new Dictionary();

      private static var imageSets_:Dictionary = new Dictionary();

      private static var sounds_:Dictionary = new Dictionary();

      private static var imageLookup_:Dictionary = new Dictionary();

      public function AssetLibrary(param1:StaticEnforcer) {
         super();
      }

      public static function addImage(param1:String, param2:BitmapData) : void {
         images_[param1] = param2;
         imageLookup_[param2] = param1;
      }

      public static function addImageSet(param1:String, param2:BitmapData, param3:int, param4:int) : void {
         images_[param1] = param2;
         var _local5:ImageSet = new ImageSet();
         _local5.addFromBitmapData(param2,param3,param4);
         imageSets_[param1] = _local5;
         var _local6:int = 0;
         while(_local6 < _local5.images_.length) {
            imageLookup_[_local5.images_[_local6]] = [param1,_local6];
            _local6++;
         }
      }

      public static function addToImageSet(param1:String, param2:BitmapData) : void {
         var _local3:ImageSet = imageSets_[param1];
         if(_local3 == null) {
            _local3 = new ImageSet();
            imageSets_[param1] = _local3;
         }
         _local3.add(param2);
         var _local4:int = _local3.images_.length - 1;
         imageLookup_[_local3.images_[_local4]] = [param1,_local4];
      }

      public static function addSound(param1:String, param2:Class) : void {
         var _local3:Array = sounds_[param1];
         if(_local3 == null) {
            sounds_[param1] = new Array();
         }
         sounds_[param1].push(param2);
      }

      public static function lookupImage(param1:BitmapData) : Object {
         return imageLookup_[param1];
      }

      public static function getImage(param1:String) : BitmapData {
         return images_[param1];
      }

      public static function getImageSet(param1:String) : ImageSet {
         return imageSets_[param1];
      }

      public static function getImageFromSet(param1:String, param2:int) : BitmapData {
         var _local3:ImageSet = imageSets_[param1];
         return _local3.images_[param2];
      }

      public static function getSound(param1:String) : Sound {
         var _local2:Array = sounds_[param1];
         var _local3:int = Math.random() * _local2.length;
         return new sounds_[param1][_local3]();
      }

      public static function playSound(param1:String, param2:Number = 1.0) : void {
         var _local3:Array = sounds_[param1];
         var _local4:int = Math.random() * _local3.length;
         var _local5:Sound = new sounds_[param1][_local4]();
         var _local6:SoundTransform = null;
         if(param2 != 1) {
            _local6 = new SoundTransform(param2);
         }
         _local5.play(0,0,_local6);
      }
   }
}

class StaticEnforcer {

   function StaticEnforcer() {
      super();
   }
}
