package com.company.assembleegameclient.map {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.TextureData;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a;
import com.company.util.BitmapUtil;

import flash.display.BitmapData;

public class LOEBUILD_a8ee717b4dbde6fa2f5932b7421c41aa {

      public var type_:int;

      public var id_:String;

      public var noWalk_:Boolean = true;

      public var minDamage_:int = 0;

      public var maxDamage_:int = 0;

      public var animate_:LOEBUILD_463df66a32ccee700fe56a1531ecc43e;

      public var blendPriority_:int = -1;

      public var compositePriority_:int = 0;

      public var speed_:Number = 1.0;

      public var xOffset_:Number = 0;

      public var yOffset_:Number = 0;

      public var slideAmount_:Number = 0;

      public var push_:Boolean = false;

      public var sink_:Boolean = false;

      public var sinking_:Boolean = false;

      public var randomOffset_:Boolean = false;

      public var hasEdge_:Boolean = false;

      private var edgeTD_:TextureData = null;

      private var cornerTD_:TextureData = null;

      private var innerCornerTD_:TextureData = null;

      private var edges_:Vector.<BitmapData> = null;

      private var innerCorners_:Vector.<BitmapData> = null;

      public var sameTypeEdgeMode_:Boolean = false;

      public var topTD_:TextureData = null;

      public var topAnimate_:LOEBUILD_463df66a32ccee700fe56a1531ecc43e = null;

      public function LOEBUILD_a8ee717b4dbde6fa2f5932b7421c41aa(param1:XML) {
         this.animate_ = new LOEBUILD_463df66a32ccee700fe56a1531ecc43e();
         super();
         this.type_ = int(param1.@type);
         this.id_ = String(param1.@id);
         this.noWalk_ = param1.hasOwnProperty("NoWalk");
         if(param1.hasOwnProperty("MinDamage")) {
            this.minDamage_ = int(param1.MinDamage);
         }
         if(param1.hasOwnProperty("MaxDamage")) {
            this.maxDamage_ = int(param1.MaxDamage);
         }
         this.push_ = param1.hasOwnProperty("Push");
         if(param1.hasOwnProperty("Animate")) {
            this.animate_.parseXML(XML(param1.Animate));
         }
         if(param1.hasOwnProperty("BlendPriority")) {
            this.blendPriority_ = int(param1.BlendPriority);
         }
         if(param1.hasOwnProperty("CompositePriority")) {
            this.compositePriority_ = int(param1.CompositePriority);
         }
         if(param1.hasOwnProperty("Speed")) {
            this.speed_ = Number(param1.Speed);
         }
         if(param1.hasOwnProperty("SlideAmount")) {
            this.slideAmount_ = Number(param1.SlideAmount);
         }
         this.xOffset_ = !!param1.hasOwnProperty("XOffset")?Number(Number(param1.XOffset)):Number(0);
         this.yOffset_ = !!param1.hasOwnProperty("YOffset")?Number(Number(param1.YOffset)):Number(0);
         this.push_ = param1.hasOwnProperty("Push");
         this.sink_ = param1.hasOwnProperty("Sink");
         this.sinking_ = param1.hasOwnProperty("Sinking");
         this.randomOffset_ = param1.hasOwnProperty("RandomOffset");
         if(param1.hasOwnProperty("Edge")) {
            this.hasEdge_ = true;
            this.edgeTD_ = new LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a(XML(param1.Edge));
            if(param1.hasOwnProperty("Corner")) {
               this.cornerTD_ = new LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a(XML(param1.Corner));
            }
            if(param1.hasOwnProperty("InnerCorner")) {
               this.innerCornerTD_ = new LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a(XML(param1.InnerCorner));
            }
         }
         this.sameTypeEdgeMode_ = param1.hasOwnProperty("SameTypeEdgeMode");
         if(param1.hasOwnProperty("Top")) {
            this.topTD_ = new LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a(XML(param1.Top));
            this.topAnimate_ = new LOEBUILD_463df66a32ccee700fe56a1531ecc43e();
            if(param1.hasOwnProperty("TopAnimate")) {
               this.topAnimate_.parseXML(XML(param1.TopAnimate));
            }
         }
      }

      public function getEdges() : Vector.<BitmapData> {
         if(!this.hasEdge_ || this.edges_ != null) {
            return this.edges_;
         }
         this.edges_ = new Vector.<BitmapData>(9);
         this.edges_[3] = this.edgeTD_.getTexture(0);
         this.edges_[1] = BitmapUtil.rotateBitmapData(this.edges_[3],1);
         this.edges_[5] = BitmapUtil.rotateBitmapData(this.edges_[3],2);
         this.edges_[7] = BitmapUtil.rotateBitmapData(this.edges_[3],3);
         if(this.cornerTD_ != null) {
            this.edges_[0] = this.cornerTD_.getTexture(0);
            this.edges_[2] = BitmapUtil.rotateBitmapData(this.edges_[0],1);
            this.edges_[8] = BitmapUtil.rotateBitmapData(this.edges_[0],2);
            this.edges_[6] = BitmapUtil.rotateBitmapData(this.edges_[0],3);
         }
         return this.edges_;
      }

      public function getInnerCorners() : Vector.<BitmapData> {
         if(this.innerCornerTD_ == null || this.innerCorners_ != null) {
            return this.innerCorners_;
         }
         this.innerCorners_ = this.edges_.concat();
         this.innerCorners_[0] = this.innerCornerTD_.getTexture(0);
         this.innerCorners_[2] = BitmapUtil.rotateBitmapData(this.innerCorners_[0],1);
         this.innerCorners_[8] = BitmapUtil.rotateBitmapData(this.innerCorners_[0],2);
         this.innerCorners_[6] = BitmapUtil.rotateBitmapData(this.innerCorners_[0],3);
         return this.innerCorners_;
      }
   }
}
