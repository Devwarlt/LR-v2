package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.util.MoreStringUtil;

class LOEBUILD_ead4523cc11ab3fa9d1e2395ae0ffeb0 extends LOEBUILD_241f7212fc0a9d7d79ce54e77768ee0b {

      function LOEBUILD_ead4523cc11ab3fa9d1e2395ae0ffeb0() {
         var _local1:* = null;
         var _local3:int = 0;
         var _local4:XML = null;
         var _local5:LOEBUILD_6b2a19f9efe051a753df4dbf1c22af39 = null;
         super(LOEBUILD_359b71e88f40029251366609358a302f.OBJECT);
         var _local2:Vector.<String> = new Vector.<String>();
         for(_local1 in LOEBUILD_efda783509bc93eea698457c87bbee3f.idToType_) {
            _local2.push(_local1);
         }
         _local2.sort(MoreStringUtil.cmp);
         for each(_local1 in _local2) {
            _local3 = LOEBUILD_efda783509bc93eea698457c87bbee3f.idToType_[_local1];
            _local4 = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[_local3];
            if(!(Boolean(_local4.hasOwnProperty("Item")) || Boolean(_local4.hasOwnProperty("Player")) || _local4.Class == "Projectile")) {
               _local5 = new LOEBUILD_6b2a19f9efe051a753df4dbf1c22af39(_local4);
               addElement(_local5);
            }
         }
      }
   }
}
