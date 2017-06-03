package kabam.rotmg.arena.service {
import com.company.util.ConversionUtil;

import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.arena.model.CurrentArenaRunModel;
import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.pets.data.PetVO;

public class ArenaLeaderboardFactory {

      [Inject]
      public var classesModel:ClassesModel;

      [Inject]
      public var factory:CharacterFactory;

      [Inject]
      public var currentRunModel:CurrentArenaRunModel;

      public function ArenaLeaderboardFactory() {
         super();
      }

      public function makeEntries(param1:XMLList) : Vector.<ArenaLeaderboardEntry> {
         var _local4:XML = null;
         var _local2:Vector.<ArenaLeaderboardEntry> = new Vector.<ArenaLeaderboardEntry>();
         var _local3:int = 1;
         for each(_local4 in param1) {
            _local2.push(this.makeArenaEntry(_local4,_local3));
            _local3++;
         }
         _local2 = this.removeDuplicateUser(_local2);
         _local2 = this.addCurrentRun(_local2);
         return _local2;
      }

      private function addCurrentRun(param1:Vector.<ArenaLeaderboardEntry>) : Vector.<ArenaLeaderboardEntry> {
         var _local3:Boolean = false;
         var _local4:Boolean = false;
         var _local5:ArenaLeaderboardEntry = null;
         var _local2:Vector.<ArenaLeaderboardEntry> = new Vector.<ArenaLeaderboardEntry>();
         if(this.currentRunModel.hasEntry()) {
            _local3 = false;
            _local4 = false;
            for each(_local5 in param1) {
               if(!_local3 && Boolean(this.currentRunModel.entry.isBetterThan(_local5))) {
                  this.currentRunModel.entry.rank = _local5.rank;
                  _local2.push(this.currentRunModel.entry);
                  _local3 = true;
               }
               if(_local5.isPersonalRecord) {
                  _local4 = true;
               }
               if(_local3) {
                  _local5.rank++;
               }
               _local2.push(_local5);
            }
            if(_local2.length < 20 && !_local3 && !_local4) {
               this.currentRunModel.entry.rank = _local2.length + 1;
               _local2.push(this.currentRunModel.entry);
            }
         }
         return _local2.length > 0?_local2:param1;
      }

      private function removeDuplicateUser(param1:Vector.<ArenaLeaderboardEntry>) : Vector.<ArenaLeaderboardEntry> {
         var _local3:Boolean = false;
         var _local4:ArenaLeaderboardEntry = null;
         var _local5:ArenaLeaderboardEntry = null;
         var _local2:int = -1;
         if(this.currentRunModel.hasEntry()) {
            _local3 = false;
            _local4 = this.currentRunModel.entry;
            for each(_local5 in param1) {
               if(Boolean(_local5.isPersonalRecord) && Boolean(_local4.isBetterThan(_local5))) {
                  _local2 = _local5.rank - 1;
                  _local3 = true;
               } else if(_local3) {
                  _local5.rank--;
               }
            }
         }
         if(_local2 != -1) {
            param1.splice(_local2,1);
         }
         return param1;
      }

      private function makeArenaEntry(param1:XML, param2:int) : ArenaLeaderboardEntry {
         var _local10:PetVO = null;
         var _local11:XML = null;
         var _local3:ArenaLeaderboardEntry = new ArenaLeaderboardEntry();
         _local3.isPersonalRecord = param1.hasOwnProperty("IsPersonalRecord");
         _local3.runtime = param1.Time;
         _local3.name = param1.PlayData.CharacterData.Name;
         _local3.rank = !!param1.hasOwnProperty("Rank")?int(param1.Rank):int(param2);
         var _local4:int = param1.PlayData.CharacterData.Texture;
         var _local5:int = param1.PlayData.CharacterData.Class;
         var _local6:CharacterClass = this.classesModel.getCharacterClass(_local5);
         var _local7:CharacterSkin = _local6.skins.getSkin(_local4);
         var _local8:int = !!param1.PlayData.CharacterData.hasOwnProperty("Tex1")?int(param1.PlayData.CharacterData.Tex1):0;
         var _local9:int = !!param1.PlayData.CharacterData.hasOwnProperty("Tex2")?int(param1.PlayData.CharacterData.Tex2):0;
         _local3.playerBitmap = this.factory.makeIcon(_local7.template,100,_local8,_local9);
         _local3.equipment = ConversionUtil.toIntVector(param1.PlayData.CharacterData.Inventory);
         _local3.slotTypes = _local6.slotTypes;
         _local3.guildName = param1.PlayData.CharacterData.GuildName;
         _local3.guildRank = param1.PlayData.CharacterData.GuildRank;
         _local3.currentWave = param1.WaveNumber;
         if(param1.PlayData.hasOwnProperty("Pet")) {
            _local10 = new PetVO();
            _local11 = new XML(param1.PlayData.Pet);
            _local10.apply(_local11);
            _local3.pet = _local10;
         }
         return _local3;
      }
   }
}
