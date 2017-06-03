package com.company.assembleegameclient.screens.events {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_7ebef6bdf3535c86294f666e62e89578;

import flash.events.Event;

public class DeleteCharacterEvent extends Event {

      public static const DELETE_CHARACTER_EVENT:String = "DELETE_CHARACTER_EVENT";

      public var savedChar_:LOEBUILD_7ebef6bdf3535c86294f666e62e89578;

      public function DeleteCharacterEvent(param1:LOEBUILD_7ebef6bdf3535c86294f666e62e89578) {
         super(DELETE_CHARACTER_EVENT);
         this.savedChar_ = param1;
      }
   }
}
