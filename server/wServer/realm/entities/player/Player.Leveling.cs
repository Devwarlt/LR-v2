#region

using System;
using System.Collections.Generic;
using System.Linq;
using wServer.networking.svrPackets;

#endregion

namespace wServer.realm.entities.player
{
    public partial class Player
    {
        private static readonly Dictionary<string, Tuple<int, int, int>> questDat =
            new Dictionary<string, Tuple<int, int, int>> //Priority, Min, Max
            {
                {"Scorpion Queen", Tuple.Create(1, 1, 6)},
                {"Bandit Leader", Tuple.Create(1, 1, 6)},
                {"Hobbit Mage", Tuple.Create(3, 3, 8)},
                {"Undead Hobbit Mage", Tuple.Create(3, 3, 8)},
                {"Giant Crab", Tuple.Create(3, 3, 8)},
                {"Desert Werewolf", Tuple.Create(3, 3, 8)},
                {"Sandsman King", Tuple.Create(4, 4, 9)},
                {"Goblin Mage", Tuple.Create(4, 4, 9)},
                {"Elf Wizard", Tuple.Create(4, 4, 9)},
                {"Dwarf King", Tuple.Create(5, 5, 10)},
                {"Swarm", Tuple.Create(6, 6, 11)},
                {"Shambling Sludge", Tuple.Create(6, 6, 11)},
                {"Great Lizard", Tuple.Create(7, 7, 12)},
                {"Wasp Queen", Tuple.Create(8, 7, 1000)},
                {"Horned Drake", Tuple.Create(8, 7, 1000)},
                {"Deathmage", Tuple.Create(5, 6, 11)},
                {"Great Coil Snake", Tuple.Create(6, 6, 12)},
                {"Lich", Tuple.Create(9, 6, 1000)},
                {"Actual Lich", Tuple.Create(9, 7, 1000)},
                //{"Ent Ancient", Tuple.Create(10, 7, 1000)},
                //{"Actual Ent Ancient", Tuple.Create(10, 7, 1000)},
                //{"Oasis Giant", Tuple.Create(11, 8, 1000)},
                {"Phoenix Lord", Tuple.Create(11, 9, 1000)},
                //{"Ghost King", Tuple.Create(12, 10, 1000)},
                //{"Actual Ghost King", Tuple.Create(12, 10, 1000)},
                {"Cyclops God", Tuple.Create(13, 10, 1000)},
                {"Red Demon", Tuple.Create(15, 15, 1000)},
                {"Lucky Djinn", Tuple.Create(15, 15, 1000)},
                {"Lucky Ent God", Tuple.Create(15, 15, 1000)},
                {"Skull Shrine", Tuple.Create(16, 15, 1000)},
                {"Pentaract", Tuple.Create(16, 15, 1000)},
                {"Cube God", Tuple.Create(16, 15, 1000)},
                {"Grand Sphinx", Tuple.Create(16, 15, 1000)},
                {"Lord of the Lost Lands", Tuple.Create(16, 15, 1000)},
                {"Hermit God", Tuple.Create(16, 15, 1000)},
                {"Ghost Ship", Tuple.Create(16, 15, 1000)},
                //{"Unknown Giant Golem", Tuple.Create(16, 15, 1000)},
                {"Evil Chicken God", Tuple.Create(999, 1, 1000)},
                {"Bonegrind The Butcher", Tuple.Create(999, 1, 1000)},
                {"Dreadstump the Pirate King", Tuple.Create(999, 1, 1000)},
                {"Arachna the Spider Queen", Tuple.Create(999, 1, 1000)},
                {"Stheno the Snake Queen", Tuple.Create(999, 1, 1000)},
                {"Mixcoatl the Masked God", Tuple.Create(999, 1, 1000)},
                {"Limon the Sprite God", Tuple.Create(999, 1, 1000)},
                {"Septavius the Ghost God", Tuple.Create(999, 1, 1000)},
                {"Davy Jones", Tuple.Create(999, 1, 1000)},
                {"Lord Ruthven", Tuple.Create(999, 1, 1000)},
                {"Archdemon Malphas", Tuple.Create(999, 1, 1000)},
                //{"Mysterious Crystal", Tuple.Create(999, 1, 1000)},
                {"shtrs Defense System", Tuple.Create(999, 1, 1000)},
                {"Thessal the Mermaid Goddess", Tuple.Create(999, 1, 1000)},
                {"Dr Terrible", Tuple.Create(999, 1, 1000)},
                {"Maurth the Succubus Queen", Tuple.Create(999, 1, 1000)},
                {"Masked Party God", Tuple.Create(999, 1, 10000)},
                {"Son of Arachna", Tuple.Create(999, 1, 1000)},
                {"Inactive Sarcophagus", Tuple.Create(999, 1, 1000)},
                {"Active Sarcophagus", Tuple.Create(999, 1, 1000)},
                {"Tomb Attacker", Tuple.Create(999, 1, 1000)},
                {"Tomb Defender", Tuple.Create(999, 1, 1000)},
                {"Tomb Support", Tuple.Create(999, 1, 1000)},
                {"Dragon Head", Tuple.Create(999, 1, 1000)},
                {"NM Red Dragon God", Tuple.Create(999, 1, 1000)},
                {"NM Blue Dragon God", Tuple.Create(999, 1, 1000)},
                {"NM Black Dragon God", Tuple.Create(999, 1, 1000)},
                {"NM Green Dragon God", Tuple.Create(999, 1, 1000)},
                {"lod Ivory Wyvern", Tuple.Create(999, 1, 1000)},
                {"Oryx Stone Guardian Left", Tuple.Create(999, 1, 1000)},
                {"Oryx Stone Guardian Right", Tuple.Create(999, 1, 1000)},
                {"Oryx the Mad God 1", Tuple.Create(999, 1, 1000)},
                {"Oryx the Mad God 2", Tuple.Create(999, 1, 1000)},
                {"Puppet Master v2", Tuple.Create(999, 1, 1000)},
                {"Lord of Death", Tuple.Create(999, 1, 1000)},
                {"Epic Larva", Tuple.Create(999, 1, 1000)},
                {"Epic Mama Megamoth", Tuple.Create(999, 1, 1000)},
                {"Murderous Megamoth", Tuple.Create(999, 1, 1000)},
            };

        public Entity Quest { get; private set; }

        private static int GetFameGoal(int fame)
        {
            if (fame >= 2000) return 0;
            if (fame >= 800) return 2000;
            if (fame >= 400) return 800;
            if (fame >= 150) return 400;
            return fame >= 20 ? 150 : 0;
        }

        public int GetStars()
        {
            var ret = 0;
            foreach (var i in Client.Account.Stats.ClassStates)
            {
                if (i.BestFame >= 2000) ret += 5;
                else if (i.BestFame >= 800) ret += 4;
                else if (i.BestFame >= 400) ret += 3;
                else if (i.BestFame >= 150) ret += 2;
                else if (i.BestFame >= 20) ret += 1;
            }
            return ret;
        }

        private static float Dist(Entity a, Entity b)
        {
            var dx = a.X - b.X;
            var dy = a.Y - b.Y;
            return (float) Math.Sqrt(dx*dx + dy*dy);
        }

        private Entity FindQuest()
        {
            Entity ret = null;
            try
            {
                float bestScore = 0;
                foreach (var i in Owner.Quests.Values
                    .OrderBy(quest => MathsUtils.DistSqr(quest.X, quest.Y, X, Y)).Where(i => i.ObjectDesc != null && i.ObjectDesc.Quest))
                {
                    Tuple<int, int, int> x;
                    if (!questDat.TryGetValue(i.ObjectDesc.ObjectId, out x)) continue;

                    if ((Level < x.Item2 || Level > x.Item3)) continue;
                    var score = (999 - Math.Abs((i.ObjectDesc.Level ?? 0) - Level))*x.Item1 -
                                //priority * level diff
                                Dist(this, i)/100; //minus 1 for every 100 tile distance
                    if (score < 0)
                        score = 1;
                    if (!(score > bestScore)) continue;
                    bestScore = score;
                    ret = i;
                }
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }
            return ret;
        }

        private void HandleQuest(RealmTime time)
        {
            if (time.tickCount%500 != 0 && Quest?.Owner != null) return;
            var newQuest = FindQuest();
            if (newQuest == null || newQuest == Quest) return;
            Owner.Timers.Add(new WorldTimer(5000, (w, t) =>
            {
                Client.SendPacket(new QuestObjIdPacket
                {
                    ObjectId = newQuest.Id
                });
            }));
            Quest = newQuest;
        }

        private void CalculateFame()
        {
            int newFame;
            if (Experience < 250) newFame = Experience/10000;
            else newFame = Experience/10000;
            if (newFame == Fame) return;
            Fame = newFame;
            int newGoal;
            var state =
                Client.Account.Stats.ClassStates.SingleOrDefault(_ => Utils.FromString(_.ObjectType) == ObjectType);
            if (state != null && state.BestFame > Fame)
                newGoal = GetFameGoal(state.BestFame);
            else
                newGoal = GetFameGoal(Fame);
            if (newGoal > FameGoal)
            {
                Owner.BroadcastPacket(new NotificationPacket
                {
                    ObjectId = Id,
                    Color = new ARGB(0xFF00FF00),
                    Text = "{\"key\":\"blank\",\"tokens\":{\"data\":\"Class Quest Complete!\"}}",
                }, null);
                Stars = GetStars();
            }
            FameGoal = newGoal;
            UpdateCount++;
        }

        //EXP for next level or EXP goal
        //OLD EXP FORMULA:
        //return 50 + (level - 1)*100;
        private static int GetExpGoal(int level)
        {
            var nextlevel = level + 1;
            if (level == 1) return 100;
            return (50*nextlevel*nextlevel*nextlevel - 150*nextlevel*nextlevel + 400*nextlevel)/3;
        }

        //EXP for actual level
        //OLD EXP FORMULA:
        //return 50*(level - 1) + (level - 2)*(level - 1)*50;
        private static int GetLevelExp(int level)
        {
            if (level == 1) return 0;
            return (50*level*level*level - 150*level*level + 400*level)/3;
        }

        private bool CheckLevelUp()
        {
            if(Experience == ExperienceGoal)
            {
                Level++;
                SaveToCharacter();
                UpdateCount++;
            }
            //if(Experience >= ExperienceGoal)
            if (Experience >= ExperienceGoal && Level < 351)
            {
                Level++;
                ExperienceGoal = GetExpGoal(Level);
                foreach (var i in Manager.GameData.ObjectTypeToElement[ObjectType].Elements("LevelIncrease"))
                {
                    var rand = new Random();
                    var min = int.Parse(i.Attribute("min").Value);
                    var max = int.Parse(i.Attribute("max").Value) + 1;
                    var xElement = Manager.GameData.ObjectTypeToElement[ObjectType].Element(i.Value);
                    if (xElement == null) continue;
                    var limit =
                        int.Parse(
                            xElement.Attribute("max").Value);
                    var idx = StatsManager.StatsNameToIndex(i.Value);
                    Stats[idx] += rand.Next(min, max);
                    if (Stats[idx] > limit) Stats[idx] = limit;
                }
                HP = Stats[0] + Boost[0];
                Mp = Stats[1] + Boost[1];

                SaveToCharacter();
                UpdateCount++;

                if (Level == 100)
                {
                    foreach (var i in Owner.Players.Values)
                        i.SendInfo("Congratulations " + Name + "! You achieved level 100.");
                    XpBoosted = false;
                    XpBoostTimeLeft = 0;
                }
                else if (Level == 200)
                {
                    foreach (var i in Owner.Players.Values)
                        i.SendInfo("Congratulations " + Name + "! You achieved level 200.");
                    XpBoosted = false;
                    XpBoostTimeLeft = 0;
                }
                else if (Level == 300)
                {
                    foreach (var i in Owner.Players.Values)
                        i.SendInfo("Congratulations " + Name + "! You achieved level 300.");
                    XpBoosted = false;
                    XpBoostTimeLeft = 0;
                }
                else if (Level == 400)
                {
                    foreach (var i in Owner.Players.Values)
                        i.SendInfo("Congratulations " + Name + "! You achieved level 400.");
                    XpBoosted = false;
                    XpBoostTimeLeft = 0;
                }
                else if (Level == 500)
                {
                    foreach (var i in Owner.Players.Values)
                        i.SendInfo("Congratulations " + Name + "! You achieved level 500.");
                    XpBoosted = false;
                    XpBoostTimeLeft = 0;
                }
                else if (Level == 600)
                {
                    foreach (var i in Owner.Players.Values)
                        i.SendInfo("Congratulations " + Name + "! You achieved level 600.");
                    XpBoosted = false;
                    XpBoostTimeLeft = 0;
                }
                else if (Level == 700)
                {
                    foreach (var i in Owner.Players.Values)
                        i.SendInfo("Congratulations " + Name + "! You achieved level 700.");
                    XpBoosted = false;
                    XpBoostTimeLeft = 0;
                }
                else if (Level == 800)
                {
                    foreach (var i in Owner.Players.Values)
                        i.SendInfo("Congratulations " + Name + "! You achieved level 800.");
                    XpBoosted = false;
                    XpBoostTimeLeft = 0;
                }
                else if (Level == 900)
                {
                    foreach (var i in Owner.Players.Values)
                        i.SendInfo("Congratulations " + Name + "! You achieved level 900.");
                    XpBoosted = false;
                    XpBoostTimeLeft = 0;
                }
                else if (Level == 1000)
                {
                    foreach (var i in Owner.Players.Values)
                        i.SendInfo("Congratulations " + Name + "! You achieved level 1000.");
                    XpBoosted = false;
                    XpBoostTimeLeft = 0;
                }
                Quest = null;
                return true;
            }
            CalculateFame();
            return false;
        }

        public bool EnemyKilled(Enemy enemy, int exp, bool killer)
        {
            var expm = wServer.logic.BehaviorDb.EXPmultipler;
            if (enemy == Quest)
                Owner.BroadcastPacket(new NotificationPacket
                {
                    ObjectId = Id,
                    Color = new ARGB(0xFF00FF00),
                    Text = "{\"key\":\"blank\",\"tokens\":{\"data\":\"World Quest Complete!\"}}",
                }, null);
            if (exp > 0)
            {
                if(XpBoosted)
                    Experience += exp * 2 * expm;
                else if(Client.Account.Rank == 1)
                    Experience += (exp + exp/2) * expm;
                else
                    Experience += exp * expm;
                UpdateCount++;
                foreach (var i in Owner.PlayersCollision.HitTest(X, Y, 15).Where(i => i != this).OfType<Player>())
                {
                    try
                    {
                        i.Experience += i.XpBoosted ? exp * 2 * expm : exp * expm;
                        i.UpdateCount++;
                        i.CheckLevelUp();
                        if (Random.Next(1, 100000) <= 50)
                            Client.GiftCodeReceived("LevelUp");
                    }
                    catch// (Exception ex)
                    {
                        i.Experience += 0;
                        i.UpdateCount++;
                        //log.Error(ex);
                    }
                }
            }
            FameCounter.Killed(enemy, killer);
            return CheckLevelUp();
        }
    }
}