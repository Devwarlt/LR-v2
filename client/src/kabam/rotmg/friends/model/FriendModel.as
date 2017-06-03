package kabam.rotmg.friends.model {
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.util.FameUtil;

import flash.utils.Dictionary;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.friends.service.FriendDataRequestTask;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.servers.api.ServerModel;

import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

public class FriendModel {

      [Inject]
      public var serverModel:ServerModel;

      public var task:FriendDataRequestTask;

      private var _onlineFriends:Vector.<FriendVO>;

      private var _offlineFriends:Vector.<FriendVO>;

      private var _friends:Dictionary;

      private var _invitations:Dictionary;

      private var _inProcessFlag:Boolean;

      private var _friendTotal:int;

      private var _invitationTotal:int;

      private var _isFriDataOK:Boolean;

      private var _isInvDataOK:Boolean;

      private var _serverDict:Dictionary;

      private var _currentServer:Server;

      public var errorStr:String;

      public var dataSignal:Signal;

      public function FriendModel() {
         this.dataSignal = new Signal(Boolean);
         super();
         this._friendTotal = 0;
         this._invitationTotal = 0;
         this._invitationTotal = 0;
         this._friends = new Dictionary(true);
         this._onlineFriends = new Vector.<FriendVO>();
         this._offlineFriends = new Vector.<FriendVO>();
         this._inProcessFlag = false;
         this.loadFriendListData();
      }

      public function setCurrentServer(param1:Server) : void {
         this._currentServer = param1;
      }

      public function getCurrentServerName() : String {
         var _local1:String = !!this._currentServer?this._currentServer.name:"";
         return _local1;
      }

      public function loadFriendListData() : void {
         if(this._inProcessFlag) {
            return;
         }
         this._inProcessFlag = true;
         var _local1:Injector = StaticInjectorContext.getInjector();
         this.task = _local1.getInstance(FriendDataRequestTask);
         this.loadList(FriendConstant.getURL(FriendConstant.FRIEND_LIST),this.onFriendListResponse);
      }

      private function loadList(param1:String, param2:Function) : void {
         this.task.requestURL = param1;
         this.task.finished.addOnce(param2);
         this.task.start();
      }

      private function onFriendListResponse(param1:FriendDataRequestTask, param2:Boolean, param3:String = "") : void {
         if(param2) {
            this.seedFriends(param1.xml);
         }
         this._isFriDataOK = param2;
         this.errorStr = param3;
         param1.reset();
         this.loadList(FriendConstant.getURL(FriendConstant.INVITE_LIST),this.onInvitationListResponse);
      }

      private function onInvitationListResponse(param1:FriendDataRequestTask, param2:Boolean, param3:String = "") : void {
         if(param2) {
            this.seedInvitations(param1.xml);
         }
         this._isInvDataOK = param2;
         this.errorStr = param3;
         param1.reset();
         this._inProcessFlag = false;
         this.dataSignal.dispatch(this._isFriDataOK && this._isInvDataOK);
      }

      public function seedFriends(param1:XML) : void {
         var _local2:String = null;
         var _local3:String = null;
         var _local4:String = null;
         var _local5:FriendVO = null;
         var _local6:XML = null;
         this._onlineFriends.length = 0;
         this._offlineFriends.length = 0;
         for each(_local6 in param1.Account) {
            _local2 = _local6.Name;
            _local5 = this._friends[_local2] != null?this._friends[_local2].vo as FriendVO:new FriendVO(Player.fromPlayerXML(_local2,_local6.Character[0]));
            if(_local6.hasOwnProperty("Online")) {
               _local4 = String(_local6.Online);
               _local3 = this.serverNameDictionary()[_local4];
               _local5.online(_local3,_local4);
               this._onlineFriends.push(_local5);
               this._friends[_local5.getName()] = {
                  "vo":_local5,
                  "list":this._onlineFriends
               };
            } else {
               _local5.offline();
               this._offlineFriends.push(_local5);
               this._friends[_local5.getName()] = {
                  "vo":_local5,
                  "list":this._offlineFriends
               };
            }
         }
         this._onlineFriends.sort(this.sortFriend);
         this._offlineFriends.sort(this.sortFriend);
         this._friendTotal = this._onlineFriends.length + this._offlineFriends.length;
      }

      public function seedInvitations(param1:XML) : void {
         var _local2:String = null;
         var _local3:XML = null;
         var _local4:Player = null;
         this._invitations = new Dictionary(true);
         this._invitationTotal = 0;
         for each(_local3 in param1.Account) {
            if(this.starFilter(int(_local3.Character[0].ObjectType),int(_local3.Character[0].CurrentFame),_local3.Stats[0])) {
               _local2 = _local3.Name;
               _local4 = Player.fromPlayerXML(_local2,_local3.Character[0]);
               this._invitations[_local2] = new FriendVO(_local4);
               this._invitationTotal++;
            }
         }
      }

      public function isMyFriend(param1:String) : Boolean {
         return this._friends[param1] != null;
      }

      public function updateFriendVO(param1:String, param2:Player) : void {
         var _local3:Object = null;
         var _local4:FriendVO = null;
         if(this.isMyFriend(param1)) {
            _local3 = this._friends[param1];
            _local4 = _local3.vo as FriendVO;
            _local4.updatePlayer(param2);
         }
      }

      public function getFilterFriends(param1:String) : Vector.<FriendVO> {
         var _local3:FriendVO = null;
         var _local2:RegExp = new RegExp(param1,"gix");
         var _local4:Vector.<FriendVO> = new Vector.<FriendVO>();
         var _local5:int = 0;
         while(_local5 < this._onlineFriends.length) {
            _local3 = this._onlineFriends[_local5];
            if(_local3.getName().search(_local2) >= 0) {
               _local4.push(_local3);
            }
            _local5++;
         }
         _local5 = 0;
         while(_local5 < this._offlineFriends.length) {
            _local3 = this._offlineFriends[_local5];
            if(_local3.getName().search(_local2) >= 0) {
               _local4.push(_local3);
            }
            _local5++;
         }
         return _local4;
      }

      public function ifReachMax() : Boolean {
         return this._friendTotal >= FriendConstant.FRIEMD_MAX_CAP;
      }

      public function getAllFriends() : Vector.<FriendVO> {
         return this._onlineFriends.concat(this._offlineFriends);
      }

      public function getAllInvitations() : Vector.<FriendVO> {
         var _local2:FriendVO = null;
         var _local1:* = new Vector.<FriendVO>();
         for each(_local2 in this._invitations) {
            _local1.push(_local2);
         }
         _local1.sort(this.sortFriend);
         return _local1;
      }

      public function removeFriend(param1:String) : Boolean {
         var _local2:Object = this._friends[param1];
         if(_local2) {
            this.removeFromList(_local2.list,param1);
            this._friends[param1] = null;
            delete this._friends[param1];
            return true;
         }
         return false;
      }

      public function removeInvitation(param1:String) : Boolean {
         if(this._invitations[param1] != null) {
            this._invitations[param1] = null;
            delete this._invitations[param1];
            return true;
         }
         return false;
      }

      private function removeFromList(param1:Vector.<FriendVO>, param2:String) : * {
         var _local3:FriendVO = null;
         var _local4:int = 0;
         while(_local4 < param1.length) {
            _local3 = param1[_local4];
            if(_local3.getName() == param2) {
               param1.slice(_local4,1);
               return;
            }
            _local4++;
         }
      }

      private function sortFriend(param1:FriendVO, param2:FriendVO) : Number {
         if(param1.getName() < param2.getName()) {
            return -1;
         }
         if(param1.getName() > param2.getName()) {
            return 1;
         }
         return 0;
      }

      private function serverNameDictionary() : Dictionary {
         var _local2:Server = null;
         if(this._serverDict) {
            return this._serverDict;
         }
         var _local1:Vector.<Server> = this.serverModel.getServers();
         this._serverDict = new Dictionary(true);
         for each(_local2 in _local1) {
            this._serverDict[_local2.address] = _local2.name;
         }
         return this._serverDict;
      }

      private function starFilter(param1:int, param2:int, param3:XML) : Boolean {
         return FameUtil.numAllTimeStars(param1,param2,param3) >= LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.friendStarRequirement;
      }
   }
}
