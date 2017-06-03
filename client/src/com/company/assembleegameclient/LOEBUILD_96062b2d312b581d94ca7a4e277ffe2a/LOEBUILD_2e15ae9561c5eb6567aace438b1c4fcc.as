package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.map.LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5;
import com.company.util.MoreStringUtil;

class LOEBUILD_2e15ae9561c5eb6567aace438b1c4fcc extends LOEBUILD_241f7212fc0a9d7d79ce54e77768ee0b {

      function LOEBUILD_2e15ae9561c5eb6567aace438b1c4fcc() {
         var _local1:* = null;
         var _local3:int = 0;
         var _local4:LOEBUILD_825952f3c03896b4449907b17896e209 = null;
         super(LOEBUILD_359b71e88f40029251366609358a302f.GROUND);
         var _local2:Vector.<String> = new Vector.<String>();
         for(_local1 in LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.idToType_) {
            _local2.push(_local1);
         }
         _local2.sort(MoreStringUtil.cmp);
         for each(_local1 in _local2) {
            _local3 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.idToType_[_local1];
            _local4 = new LOEBUILD_825952f3c03896b4449907b17896e209(LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.xmlLibrary_[_local3]);
            addElement(_local4);
         }
      }
   }
}
