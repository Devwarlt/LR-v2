package kabam.rotmg.game.view.components {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_40c3a70d9b65b7746c3c75968cc48941;
import com.company.assembleegameclient.ui.icons.IconButton;
import com.company.assembleegameclient.ui.icons.IconButtonFactory;
import com.company.ui.BaseSimpleText;
import com.company.util.GraphicsUtil;

import flash.display.Bitmap;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class TabStripView extends Sprite {

      public var iconButtonFactory:IconButtonFactory;

      public var imageFactory:LOEBUILD_40c3a70d9b65b7746c3c75968cc48941;

      public const tabSelected:Signal = new Signal(String);

      public const WIDTH:Number = 186;

      public const HEIGHT:Number = 153;

      private const tabSprite:Sprite = new Sprite();

      private const background:Sprite = new Sprite();

      private const containerSprite:Sprite = new Sprite();

      private var _width:Number;

      private var _height:Number;

      public var tabs:Vector.<TabView>;

      private var contents:Vector.<Sprite>;

      public var currentTabIndex:int;

      public var friendsBtn:IconButton;

      public function TabStripView(param1:Number = 186, param2:Number = 153) {
         this.tabs = new Vector.<TabView>();
         this.contents = new Vector.<Sprite>();
         super();
         this._width = param1;
         this._height = param2;
         this.tabSprite.addEventListener(MouseEvent.CLICK,this.onTabClicked);
         addChild(this.tabSprite);
         this.drawBackground();
         addChild(this.containerSprite);
         this.containerSprite.y = TabConstants.TAB_TOP_OFFSET;
      }

      public function initFriendList(param1:LOEBUILD_40c3a70d9b65b7746c3c75968cc48941, param2:IconButtonFactory, param3:Function) : void {
         this.friendsBtn = param2.create(param1.getImageFromSet("lofiInterfaceBig",13),"",TextKey.OPTIONS_FRIEND,"");
         this.friendsBtn.x = 160;
         this.friendsBtn.y = 6;
         this.friendsBtn.addEventListener(MouseEvent.CLICK,param3);
         addChild(this.friendsBtn);
      }

      private function onTabClicked(param1:MouseEvent) : void {
         this.selectTab(param1.target.parent as TabView);
      }

      public function setSelectedTab(param1:uint) : void {
         this.selectTab(this.tabs[param1]);
      }

      private function selectTab(param1:TabView) : void {
         var _local2:TabView = null;
         if(param1) {
            _local2 = this.tabs[this.currentTabIndex];
            if(_local2.index != param1.index) {
               _local2.setSelected(false);
               param1.setSelected(true);
               this.showContent(param1.index);
               this.tabSelected.dispatch(this.contents[param1.index].name);
            }
         }
      }

      public function drawBackground() : void {
         var _local1:GraphicsSolidFill = new GraphicsSolidFill(TabConstants.BACKGROUND_COLOR,1);
         var _local2:GraphicsPath = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         var _local3:Vector.<IGraphicsData> = new <IGraphicsData>[_local1,_local2,GraphicsUtil.END_FILL];
         GraphicsUtil.drawCutEdgeRect(0,0,this._width,this._height - TabConstants.TAB_TOP_OFFSET,6,[1,1,1,1],_local2);
         this.background.graphics.drawGraphicsData(_local3);
         this.background.y = TabConstants.TAB_TOP_OFFSET;
         addChild(this.background);
      }

      public function clearTabs() : void {
         var _local1:uint = 0;
         this.currentTabIndex = 0;
         var _local2:uint = this.tabs.length;
         _local1 = 0;
         while(_local1 < _local2) {
            this.tabSprite.removeChild(this.tabs[_local1]);
            this.containerSprite.removeChild(this.contents[_local1]);
            _local1++;
         }
         this.tabs = new Vector.<TabView>();
         this.contents = new Vector.<Sprite>();
      }

      public function addTab(param1:*, param2:Sprite) : void {
         var _local4:TabView = null;
         var _local3:int = this.tabs.length;
         if(param1 is Bitmap) {
            _local4 = this.addIconTab(_local3,param1 as Bitmap);
         } else if(param1 is BaseSimpleText) {
            _local4 = this.addTextTab(_local3,param1 as BaseSimpleText);
         }
         this.tabs.push(_local4);
         this.tabSprite.addChild(_local4);
         this.contents.push(param2);
         this.containerSprite.addChild(param2);
         if(_local3 > 0) {
            param2.visible = false;
         } else {
            _local4.setSelected(true);
            this.showContent(0);
            this.tabSelected.dispatch(param2.name);
         }
      }

      public function removeTab() : void {
      }

      private function addIconTab(param1:int, param2:Bitmap) : TabIconView {
         var _local4:TabIconView = null;
         var _local3:Sprite = new TabBackground();
         _local4 = new TabIconView(param1,_local3,param2);
         _local4.x = param1 * (_local3.width + TabConstants.PADDING);
         _local4.y = TabConstants.TAB_Y_POS;
         return _local4;
      }

      private function addTextTab(param1:int, param2:BaseSimpleText) : TabTextView {
         var _local3:Sprite = new TabBackground();
         var _local4:TabTextView = new TabTextView(param1,_local3,param2);
         _local4.x = param1 * (_local3.width + TabConstants.PADDING);
         _local4.y = TabConstants.TAB_Y_POS;
         return _local4;
      }

      private function showContent(param1:int) : void {
         var _local2:Sprite = null;
         var _local3:Sprite = null;
         if(param1 != this.currentTabIndex) {
            _local2 = this.contents[this.currentTabIndex];
            _local3 = this.contents[param1];
            _local2.visible = false;
            _local3.visible = true;
            this.currentTabIndex = param1;
         }
      }
   }
}
