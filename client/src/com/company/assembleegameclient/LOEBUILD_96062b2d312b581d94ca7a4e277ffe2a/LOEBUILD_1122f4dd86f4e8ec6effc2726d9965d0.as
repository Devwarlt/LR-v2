package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.editor.LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c;
import com.company.assembleegameclient.editor.LOEBUILD_ac8fb6f9c8d2ab59fcbef3b4aea6d1df;
import com.company.assembleegameclient.editor.LOEBUILD_d8c235d417345612d45a6cc3a3c2efad;
import com.company.util.KeyCodes;

public class LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0 extends LOEBUILD_ac8fb6f9c8d2ab59fcbef3b4aea6d1df {

      public static const NONE_COMMAND:int = 0;

      public static const DRAW_COMMAND:int = 1;

      public static const ERASE_COMMAND:int = 2;

      public static const SAMPLE_COMMAND:int = 3;

      public static const EDIT_COMMAND:int = 4;

      public static const CUT_COMMAND:int = 5;

      public static const COPY_COMMAND:int = 6;

      public static const PASTE_COMMAND:int = 7;

      public function LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0() {
         super();
         addCommandMenuItem("(D)raw",KeyCodes.D,this.select,DRAW_COMMAND);
         addCommandMenuItem("(E)rase",KeyCodes.E,this.select,ERASE_COMMAND);
         addCommandMenuItem("S(A)mple",KeyCodes.A,this.select,SAMPLE_COMMAND);
         addCommandMenuItem("Ed(I)t",KeyCodes.I,this.select,EDIT_COMMAND);
         addCommandMenuItem("(U)ndo",KeyCodes.U,this.onUndo,NONE_COMMAND);
         addCommandMenuItem("(R)edo",KeyCodes.R,this.onRedo,NONE_COMMAND);
         addCommandMenuItem("(C)lear",KeyCodes.C,this.onClear,NONE_COMMAND);
         addCommandMenuItem("Cut",-1,this.select,CUT_COMMAND);
         addCommandMenuItem("Copy",-1,this.select,COPY_COMMAND);
         addCommandMenuItem("Paste",-1,this.select,PASTE_COMMAND);
         addCommandMenuItem("(L)oad",KeyCodes.L,this.onLoad,NONE_COMMAND);
         addCommandMenuItem("(S)ave",KeyCodes.S,this.onSave,NONE_COMMAND);
         //addCommandMenuItem("(T)est",KeyCodes.T,this.onTest,NONE_COMMAND);
      }

      private function select(param1:LOEBUILD_d8c235d417345612d45a6cc3a3c2efad) : void {
         setSelected(param1);
         dispatchEvent(new LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.SELECT_COMMAND_EVENT));
      }

      private function onUndo(param1:LOEBUILD_d8c235d417345612d45a6cc3a3c2efad) : void {
         dispatchEvent(new LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.UNDO_COMMAND_EVENT));
      }

      private function onRedo(param1:LOEBUILD_d8c235d417345612d45a6cc3a3c2efad) : void {
         dispatchEvent(new LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.REDO_COMMAND_EVENT));
      }

      private function onClear(param1:LOEBUILD_d8c235d417345612d45a6cc3a3c2efad) : void {
         dispatchEvent(new LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.CLEAR_COMMAND_EVENT));
      }

      private function onLoad(param1:LOEBUILD_d8c235d417345612d45a6cc3a3c2efad) : void {
         dispatchEvent(new LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.LOAD_COMMAND_EVENT));
      }

      private function onSave(param1:LOEBUILD_d8c235d417345612d45a6cc3a3c2efad) : void {
         dispatchEvent(new LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.SAVE_COMMAND_EVENT));
      }

      private function onTest(param1:LOEBUILD_d8c235d417345612d45a6cc3a3c2efad) : void {
         dispatchEvent(new LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.TEST_COMMAND_EVENT));
      }
   }
}
