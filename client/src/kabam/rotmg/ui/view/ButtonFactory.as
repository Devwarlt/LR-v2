package kabam.rotmg.ui.view {
import com.company.assembleegameclient.LOEBUILD_93fb40ec02c008121fa9199899b31202.LOEBUILD_2362742ab4407cb8a5feed3a3a43e749;
import com.company.assembleegameclient.screens.TitleMenuOption;

import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class ButtonFactory {

      public static const BUTTON_SIZE_LARGE:uint = 36;

      public static const BUTTON_SIZE_SMALL:uint = 22;

      private static const LEFT:String = TextFieldAutoSize.LEFT;

      private static const CENTER:String = TextFieldAutoSize.CENTER;

      private static const RIGHT:String = TextFieldAutoSize.RIGHT;

      private static var playButton:TitleMenuOption;

      private static var serversButton:TitleMenuOption;

      private static var accountButton:TitleMenuOption;

      private static var legendsButton:TitleMenuOption;

      private static var languagesButton:TitleMenuOption;

      private static var supportButton:TitleMenuOption;

      private static var editorButton:TitleMenuOption;

      private static var quitButton:TitleMenuOption;

      private static var doneButton:TitleMenuOption;

      private static var mainButton:TitleMenuOption;

      private static var classesButton:TitleMenuOption;

      private static var transferAccountButton:TitleMenuOption;

      public function ButtonFactory() {
         super();
      }

      public static function getPlayButton() : TitleMenuOption {
         return playButton = playButton || makeButton(LOEBUILD_2362742ab4407cb8a5feed3a3a43e749.PLAY,BUTTON_SIZE_LARGE,CENTER,true);
      }

      public static function getClassesButton() : TitleMenuOption {
         return classesButton = classesButton || makeButton(TextKey.SCREENS_CLASSES,BUTTON_SIZE_SMALL,LEFT);
      }

      public static function getMainButton() : TitleMenuOption {
         return mainButton = mainButton || makeButton(TextKey.SCREENS_MAIN,BUTTON_SIZE_SMALL,RIGHT);
      }

      public static function getDoneButton() : TitleMenuOption {
         return doneButton = doneButton || makeButton(TextKey.DONE_TEXT,BUTTON_SIZE_LARGE,CENTER);
      }

      public static function getAccountButton() : TitleMenuOption {
         return accountButton = accountButton || makeButton(LOEBUILD_2362742ab4407cb8a5feed3a3a43e749.ACCOUNT,BUTTON_SIZE_SMALL,LEFT);
      }

      public static function getLegendsButton() : TitleMenuOption {
         return legendsButton = legendsButton || makeButton(LOEBUILD_2362742ab4407cb8a5feed3a3a43e749.LEGENDS,BUTTON_SIZE_SMALL,LEFT);
      }

      public static function getServersButton() : TitleMenuOption {
         return serversButton = serversButton || makeButton(LOEBUILD_2362742ab4407cb8a5feed3a3a43e749.SERVERS,BUTTON_SIZE_SMALL,RIGHT);
      }

      public static function getLanguagesButton() : TitleMenuOption {
         return languagesButton = languagesButton || makeButton(LOEBUILD_2362742ab4407cb8a5feed3a3a43e749.LANGUAGES,BUTTON_SIZE_SMALL,RIGHT);
      }

      public static function getSupportButton() : TitleMenuOption {
         return supportButton = supportButton || makeButton(LOEBUILD_2362742ab4407cb8a5feed3a3a43e749.SUPPORT,BUTTON_SIZE_SMALL,RIGHT);
      }

      public static function getEditorButton() : TitleMenuOption {
         return editorButton = editorButton || makeButton(LOEBUILD_2362742ab4407cb8a5feed3a3a43e749.EDITOR,BUTTON_SIZE_SMALL,RIGHT);
      }

      public static function getQuitButton() : TitleMenuOption {
         return quitButton = quitButton || makeButton(LOEBUILD_2362742ab4407cb8a5feed3a3a43e749.QUIT,BUTTON_SIZE_SMALL,LEFT);
      }

      public static function getTransferButton() : TitleMenuOption {
         return transferAccountButton = transferAccountButton || makeButton(LOEBUILD_2362742ab4407cb8a5feed3a3a43e749.TRANSFER_ACCOUNT,BUTTON_SIZE_SMALL,RIGHT);
      }

      private static function makeButton(param1:String, param2:int, param3:String, param4:Boolean = false) : TitleMenuOption {
         var _local5:TitleMenuOption = new TitleMenuOption(param1,param2,param4);
         _local5.setAutoSize(param3);
         _local5.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
         return _local5;
      }
   }
}
