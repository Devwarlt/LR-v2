#region

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using wServer.networking;
using wServer.networking.svrPackets;
using wServer.realm.entities;
using wServer.realm.entities.player;
using wServer.realm.setpieces;
using wServer.realm.worlds;

#endregion

namespace wServer.realm.commands
{
    internal class TestCommand : Command
    {
        public TestCommand()
            : base("t", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            Entity en = Entity.Resolve(player.Manager, "Zombie Wizard");
            en.Move(player.X, player.Y);
            player.Owner.EnterWorld(en);
            player.UpdateCount++;
            //player.Client.SendPacket(new DeathPacket
            //{
            //    AccountId = player.AccountId,
            //    CharId = player.Client.Character.CharacterId,
            //    Killer = "mountains.beholder",
            //    obf0 = 10000,
            //    obf1 = 10000
            //});
            return true;
        }
    }

    internal class BanCommand : Command
    {
        public BanCommand() : 
            base("ban")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (player.Client.Account.Rank >= 2)
            {
                var playerName = args[0];
                var reason = args[1];
                string reasonResponse = "";
                string SQLReason = "";
                //string reason = string.Join("", args.Skip(1).ToArray());
                //var corp = wServer.logic.BehaviorDb.LoECorporation;
                if(((playerName == "help") && (reason == null)) || ((playerName == null) && (reason == null)))
                {
                    player.SendHelp("To use this command correctly, you must obey the following structuring:");
                    player.SendHelp("/ban <player> <reason number>");
                    player.SendInfo("");
                    player.SendInfo("-- REASON NUMBER LIST --");
                    player.SendInfo("1) Begging, curse intently or bad language. Ban time: 15 minutes + 0 warning.");
                    player.SendInfo("2) Spamming. Ban time: 45 minutes + 0 warning.");
                    player.SendInfo("3) Profanity names. Ban time: 1 hour + 0 warning.");
                    player.SendInfo("4) Racism. Ban time: 3 days + 1 warning.");
                    player.SendInfo("5) Bug abuse or exploit. Ban time: 7 days + 1 warning.");
                    player.SendInfo("6) Hacking. Ban time: 30 days + 1 warning.");
                    return false;
                }
                //Delay 5 hours between datacenter and denver server! 300 min (set it properly).
                //set time_zone="+ or - ??:??"; <- SQL command: set it on database using e.g. MySQLWorkbench, phpMyAdmin, etc.
                else if((playerName != null) && (reason != null)) {
                    if(reason == "1")
                    {
                        SQLReason = "UPDATE accounts SET banned=1, banEnd=DATE_ADD(NOW(), INTERVAL 15 MINUTE) WHERE name=@accId";
                        reasonResponse = "begging to staff member or bad language. This player was banned for 15 minutes.";
                    }
                    else if(reason == "2")
                    {
                        SQLReason = "UPDATE accounts SET banned=1, banEnd=DATE_ADD(NOW(), INTERVAL 45 MINUTE) WHERE name=@accId";
                        reasonResponse = "spamming in chat or disturbing players. This player was banned for 45 minutes.";
                    }
                    else if(reason == "3")
                    {
                        SQLReason = "UPDATE accounts SET banned=1, banEnd=DATE_ADD(NOW(), INTERVAL 60 MINUTE) WHERE name=@accId";
                        reasonResponse = "profanity name. This player was banned for 1 hour.";
                    }
                    else if(reason == "4")
                    {
                        SQLReason = "UPDATE accounts SET banned=1, banEnd=DATE_ADD(NOW(), INTERVAL 4320 MINUTE), accWarnings=(accWarnings+1) WHERE name=@accId";
                        reasonResponse = "racism to another player. This player was banned for 3 days and received 1 account warning.";
                    }
                    else if(reason == "5")
                    {
                        SQLReason = "UPDATE accounts SET banned=1, banEnd=DATE_ADD(NOW(), INTERVAL 10380 MINUTE), accWarnings=(accWarnings+1) WHERE name=@accId";
                        reasonResponse = "bug abuse or exploit. This player was banned for 1 week and received 1 account warning.";
                    }
                    else if(reason == "6")
                    {
                        SQLReason = "UPDATE accounts SET banned=1, banEnd=DATE_ADD(NOW(), INTERVAL 43200 MINUTE), accWarnings=(accWarnings+1) WHERE name=@accId";
                        reasonResponse = "hacking or illegal software to play. This player was banned for 1 month and received 1 account warning.";
                    }
                    foreach (Client j in player.Manager.Clients.Values)
                    {
                        j.SendPacket(new TextPacket
                        {
                            BubbleTime = 0,
                            Stars = -1,
                            Name = "@ANNOUNCEMENT",
                            Text = "Player " + playerName + " has been banned! Reason: " + reasonResponse + ""
                        });
                    }
                    player.Manager.Database.DoActionAsync(db =>
                    {
                        var cmd = db.CreateQuery();
                        cmd.CommandText = SQLReason;
                        cmd.Parameters.AddWithValue("@accId", playerName);
                        cmd.ExecuteNonQuery();
                    });
                    player.SendInfo(playerName + " has been banned!");
                    foreach (KeyValuePair<string, Client> i in player.Manager.Clients)
                    {
                        if (i.Value.Player.Name.EqualsIgnoreCase(playerName))
                        {
                            Packet pkt;
                            pkt = new ReconnectPacket
                            {
                                GameId = World.NEXUS_ID,
                                Host = "",
                                Key = Empty<byte>.Array,
                                Name = "Nexus",
                                Port = Program.Settings.GetValue<int>("port")
                            };
                            player.SendInfo("Player will connect to Nexus to apply banishment.");
                            i.Value.SendPacket(pkt);
                            return true;
                        }
                    }
                }
                #region OLD BAN SYSTEM
                //foreach (string i in corp)
                //{
                //    if (i.Contains(p))
                //    {
                //        player.SendError("Members of LoE Corporation can not unban other members without Devwarlt's permission!");
                //        return false;
                //    }
                //    if ((p == null) && (p1 == null))
                //    {
                //        player.SendError("Insert player name and reason to ban.");
                //        return false;
                //    }
                //    else if (p1 == "loerealm")
                //    {
                //        foreach (Client j in player.Manager.Clients.Values)
                //        {
                //            string mainReason = string.Join("", args.Skip(2).ToArray());
                //            j.SendPacket(new TextPacket
                //            {
                //                BubbleTime = 0,
                //                Stars = -1,
                //                Name = "@ANNOUNCEMENT",
                //                Text = " A LoE Corporation member " + p + " has banned! Reason: " + mainReason + "."
                //            });
                //        }
                //        player.Manager.Database.DoActionAsync(db =>
                //        {
                //            var cmd = db.CreateQuery();
                //            cmd.CommandText = "UPDATE accounts SET banned=1 WHERE name=@accId;";
                //            cmd.Parameters.AddWithValue("@accId", p);
                //            cmd.ExecuteNonQuery();
                //        });
                //        player.SendInfo("A member of LoE Corporation " + p + " has been banned!");
                //        return true;
                //    }
                //    else
                //    {
                //        foreach (Client j in player.Manager.Clients.Values)
                //        {
                //            j.SendPacket(new TextPacket
                //            {
                //                BubbleTime = 0,
                //                Stars = -1,
                //                Name = "@ANNOUNCEMENT",
                //                Text = "Player " + p + " has been banned! Reason: " + reason + "."
                //            });
                //        }
                //        player.Manager.Database.DoActionAsync(db =>
                //        {
                //            var cmd = db.CreateQuery();
                //            cmd.CommandText = "UPDATE accounts SET banned=1 WHERE name=@accId;";
                //            cmd.Parameters.AddWithValue("@accId", p);
                //            cmd.ExecuteNonQuery();
                //        });
                //        player.SendInfo(p + " has been banned!");
                //        return true;
                //    }
                //}
                #endregion
            } else
            {
                player.SendError("You don't have permission to use this command.");
            }
            return true;
        }
    }

    internal class UnBanCommand : Command
    {
        public UnBanCommand() : 
            base("unban")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (player.Client.Account.Rank >= 2)
            {
                var p = args[0];
                var p1 = args[1];
                var corp = wServer.logic.BehaviorDb.LoECorporation;
                foreach (string i in corp)
                {
                    if (i.Contains(p))
                    {
                        player.SendError("Members of LoE Corporation can not unban other members without Devwarlt's permission!");
                        return false;
                    }
                    if ((p == null) && (p1 == null))
                    {
                        player.SendError("Insert player name to unban.");
                        return false;
                    }
                    else if (p1 == "loerealm")
                    {
                        player.Manager.Database.DoActionAsync(db =>
                        {
                            var cmd = db.CreateQuery();
                            cmd.CommandText = "UPDATE accounts SET banned=0 WHERE name=@accId;";
                            cmd.Parameters.AddWithValue("@accId", p);
                            cmd.ExecuteNonQuery();
                        });
                        player.SendInfo("A member of LoE Corporation " + p + " has been unbanned!");
                        return true;
                    }
                    else
                    {
                        player.Manager.Database.DoActionAsync(db =>
                        {
                            var cmd = db.CreateQuery();
                            cmd.CommandText = "UPDATE accounts SET banned=0 WHERE name=@accId;";
                            cmd.Parameters.AddWithValue("@accId", p);
                            cmd.ExecuteNonQuery();
                        });
                        player.SendInfo(p + " has been unbanned!");
                        return true;
                    }
                }
            } else
            {
                player.SendError("You don't have permission to use this command.");
            }
            return true;
        }
    }
    
    internal class AddWorldCommand : Command
    {
        public AddWorldCommand()
            : base("addworld", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            Task.Factory.StartNew(() => GameWorld.AutoName(1, true)).ContinueWith(_ => player.Manager.AddWorld(_.Result), TaskScheduler.Default);
            return true;
        }
    }

    internal class MaxPlayer : Command
        {
            public MaxPlayer()
                : base("maxplayer", 1)
            {
            }

            protected override bool Process(Player player, RealmTime time, string[] args)
            {
                if (string.IsNullOrEmpty(args[0]))
                {
                    player.SendHelp("Usage: /maxplayer <player>");
                    return false;
                }
                var plr = player.Manager.FindPlayer(args[0]);
                if (player.Client.Account.Rank == 4)
                {
                    try
                    {
                        plr.Stats[0] = plr.ObjectDesc.MaxHitPoints;
                        plr.Stats[1] = plr.ObjectDesc.MaxMagicPoints;
                        plr.Stats[2] = plr.ObjectDesc.MaxAttack;
                        plr.Stats[3] = plr.ObjectDesc.MaxDefense;
                        plr.Stats[4] = plr.ObjectDesc.MaxSpeed;
                        plr.Stats[5] = plr.ObjectDesc.MaxHpRegen;
                        plr.Stats[6] = plr.ObjectDesc.MaxMpRegen;
                        plr.Stats[7] = plr.ObjectDesc.MaxDexterity;
                        plr.SaveToCharacter();
                        plr.Client.Save();
                        plr.UpdateCount++;
                        plr.SendInfo(player.Name + " have been maxed you to 8/8!");
                    }
                    catch
                    {
                        player.SendError("Error while maxing players stats!");
                        return false;
                    }   
                }
            else
            {
                player.SendInfo("You don't have rights to use this command.");
            }
                return true;
            }
        }

    internal class GodCommand : Command
    {
        public GodCommand()
            : base("god")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if ((player.Client.Account.Rank > 1) && (player.Client.Account.Rank < 4)) {
                if (player.Owner.Name == "Beachzone") {
                    if (player.HasConditionEffect(ConditionEffectIndex.Invincible))
                    {
                        player.ApplyConditionEffect(new ConditionEffect
                        {
                            Effect = ConditionEffectIndex.Invincible,
                            DurationMS = 0
                        });
                        player.ApplyConditionEffect(new ConditionEffect
                        {
                            Effect = ConditionEffectIndex.Invulnerable,
                            DurationMS = 0
                        });
                        player.SendInfo("LoE Admin Protection OFF!");
                    }
                    else
                    {
                        player.ApplyConditionEffect(new ConditionEffect
                        {
                            Effect = ConditionEffectIndex.Invincible,
                            DurationMS = -1
                        });
                        player.ApplyConditionEffect(new ConditionEffect
                        {
                            Effect = ConditionEffectIndex.Invulnerable,
                            DurationMS = -1
                        });
                        player.SendInfo("LoE Admin Protection ON!");
                    }
                }
                else
                {
                    player.SendInfo("Devwarlt blocked to use this command in any other place, except Beachzone for events.");
                }
            } else if(player.Client.Account.Rank == 4) {
                if (player.HasConditionEffect(ConditionEffectIndex.Invincible))
                {
                    player.ApplyConditionEffect(new ConditionEffect
                    {
                        Effect = ConditionEffectIndex.Invincible,
                        DurationMS = 0
                    });
                    player.ApplyConditionEffect(new ConditionEffect
                    {
                        Effect = ConditionEffectIndex.Invulnerable,
                        DurationMS = 0
                    });
                    player.SendInfo("LoE Admin Protection OFF!");
                }
                else
                {
                    player.ApplyConditionEffect(new ConditionEffect
                    {
                        Effect = ConditionEffectIndex.Invincible,
                        DurationMS = -1
                    });
                    player.ApplyConditionEffect(new ConditionEffect
                    {
                        Effect = ConditionEffectIndex.Invulnerable,
                        DurationMS = -1
                    });
                    player.SendInfo("LoE Admin Protection ON!");
                }
            } else
            {
                player.SendInfo("You don't have rights to use this command.");
            }
            return true;
        }
    }
    


    internal class MassiveSpawnCommand : Command
    {
        public MassiveSpawnCommand()
            : base("mspawn", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            int num;
            if (args.Length > 0 && int.TryParse(args[0], out num)) //multi
            {
                string name = string.Join(" ", args.Skip(1).ToArray());
                ushort objType;
                //creates a new case insensitive dictionary based on the XmlDatas
                Dictionary<string, ushort> icdatas = new Dictionary<string, ushort>(
                    player.Manager.GameData.IdToObjectType,
                    StringComparer.OrdinalIgnoreCase);
                if (!icdatas.TryGetValue(name, out objType) ||
                    !player.Manager.GameData.ObjectDescs.ContainsKey(objType))
                {
                    player.SendInfo("Unknown entity!");
                    return false;
                }
                int c = int.Parse(args[0]);
                if (!(player.Client.Account.Rank > 3) && c > 200)
                {
                    player.SendError("Maximum spawn count is set to 200!");
                    return false;
                }
                if (player.Client.Account.Rank > 3 && c > 200)
                {
                    player.SendInfo("Bypass made!");
                }
                for (int i = 0; i < num; i++)
                {
                    Entity entity = Entity.Resolve(player.Manager, objType);
                    entity.Move(player.X, player.Y);
                    player.Owner.EnterWorld(entity);
                }
                player.SendInfo("Success!");
            }
            else
            {
                string name = string.Join(" ", args);
                ushort objType;
                //creates a new case insensitive dictionary based on the XmlDatas
                Dictionary<string, ushort> icdatas = new Dictionary<string, ushort>(
                    player.Manager.GameData.IdToObjectType,
                    StringComparer.OrdinalIgnoreCase);
                if (!icdatas.TryGetValue(name, out objType) ||
                    !player.Manager.GameData.ObjectDescs.ContainsKey(objType))
                {
                    player.SendHelp("Usage: /mspawn <entityname>");
                    return false;
                }
                Entity entity = Entity.Resolve(player.Manager, objType);
                entity.Move(player.X, player.Y);
                player.Owner.EnterWorld(entity);
            }
            return true;
        }
    }

    internal class SpawnCommand : Command
    {
        public SpawnCommand()
            : base("spawn")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (player.Client.Account.Rank >= 3) {
                
                if (player.Owner.Name == "Beachzone") {
                    string name = string.Join(" ", args);
                    ushort objType;
                    //creates a new case insensitive dictionary based on the XmlDatas
                    Dictionary<string, ushort> icdatas = new Dictionary<string, ushort>(
                        player.Manager.GameData.IdToObjectType,
                        StringComparer.OrdinalIgnoreCase);
                    if (!icdatas.TryGetValue(name, out objType) ||
                        !player.Manager.GameData.ObjectDescs.ContainsKey(objType))
                    {
                        player.SendHelp("Usage: /spawn <entityname>");
                        return false;
                    }
                    Entity entity = Entity.Resolve(player.Manager, objType);
                    entity.Move(player.X, player.Y);
                    player.Owner.EnterWorld(entity);
                }
            else
                {
                    player.SendInfo("Devwarlt blocked to use this command in any other place, except Beachzone for events.");
                }
            } else {
                player.SendInfo("You don't have rights to use this command.");
            }
            return true;
        }
    }

    internal class AddEffCommand : Command
    {
        public AddEffCommand()
            : base("addeff", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (args.Length == 0)
            {
                player.SendHelp("Usage: /addeff <Effectname or Effectnumber>");
                return false;
            }
            try
            {
                player.ApplyConditionEffect(new ConditionEffect
                {
                    Effect = (ConditionEffectIndex)Enum.Parse(typeof(ConditionEffectIndex), args[0].Trim(), true),
                    DurationMS = -1
                });
                {
                    player.SendInfo("Success!");
                }
            }
            catch
            {
                player.SendError("Invalid effect!");
                return false;
            }
            return true;
        }
    }

    internal class RemoveEffCommand : Command
    {
        public RemoveEffCommand()
            : base("remeff", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (args.Length == 0)
            {
                player.SendHelp("Usage: /remeff <Effectname or Effectnumber>");
                return false;
            }
            try
            {
                player.ApplyConditionEffect(new ConditionEffect
                {
                    Effect = (ConditionEffectIndex)Enum.Parse(typeof(ConditionEffectIndex), args[0].Trim(), true),
                    DurationMS = 0
                });
                player.SendInfo("Success!");
            }
            catch
            {
                player.SendError("Invalid effect!");
                return false;
            }
            return true;
        }
    }

    internal class VisitCommand : Command
    {
        public VisitCommand()
            : base("visit", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (args.Length < 1)
            {
                player.SendHelp("Usage: /visit <playername>");
                return false;
            }
            if (player.Client.Account.Rank >= 4) {
                foreach (KeyValuePair<string, Client> i in player.Manager.Clients)
                {
                    if (i.Value.Player.Owner is PetYard)
                    {
                        player.SendInfo("Player is in his Pet Yard you cannot visit him.");
                        return false;
                    }
                    else if (i.Value.Player.Name.EqualsIgnoreCase(args[0]))
                    {
                        if (player.Owner == i.Value.Player.Owner)
                        {
                            player.SendInfo("You are already in the same world as this Player.");
                            return false;
                        }
                        else
                        {
                            player.Client.Reconnect(new ReconnectPacket
                            {
                                GameId = i.Value.Player.Owner.Id,
                                Host = "",
                                IsFromArena = false,
                                Key = i.Value.Player.Owner.PortalKey,
                                KeyTime = -1,
                                Name = i.Value.Player.Owner.Name,
                                Port = -1
                            });
                        }
                        return true;
                    }
                }
            } else
            {
                player.SendError("Player could not be found!");
            }
            return false;
        }
    }

    internal class GiveCommand : Command
    {
        public GiveCommand()
            : base("give", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (args.Length == 0)
            {
                player.SendHelp("Usage: /give <Itemname>");
                return false;
            }
            string name = string.Join(" ", args.ToArray()).Trim();
            ushort objType;
            //creates a new case insensitive dictionary based on the XmlDatas
            Dictionary<string, ushort> icdatas = new Dictionary<string, ushort>(player.Manager.GameData.IdToObjectType,
                StringComparer.OrdinalIgnoreCase);
            if (!icdatas.TryGetValue(name, out objType))
            {
                player.SendError("Unknown type!");
                return false;
            }
            if (!player.Manager.GameData.Items[objType].Secret || player.Client.Account.Rank >= 3)
            {
                for (int i = 0; i < player.Inventory.Length; i++)
                    if (player.Inventory[i] == null)
                    {
                        player.Inventory[i] = player.Manager.GameData.Items[objType];
                        player.UpdateCount++;
                        player.SaveToCharacter();
                        player.SendInfo("Success!");
                        break;
                    }
            }
            else
            {
                player.SendError("Item cannot be given!");
                return false;
            }
            return true;
        }
    }

    internal class TpCommand : Command
    {
        public TpCommand()
            : base("tp", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (args.Length == 0 || args.Length == 1)
            {
                player.SendHelp("Usage: /tp <X coordinate> <Y coordinate>");
            }
            else
            {
                int x, y;
                try
                {
                    x = int.Parse(args[0]);
                    y = int.Parse(args[1]);
                }
                catch
                {
                    player.SendError("Invalid coordinates!");
                    return false;
                }
                player.Move(x + 0.5f, y + 0.5f);
                if (player.Pet != null)
                    player.Pet.Move(x + 0.5f, y + 0.5f);
                player.UpdateCount++;
                player.Owner.BroadcastPacket(new GotoPacket
                {
                    ObjectId = player.Id,
                    Position = new Position
                    {
                        X = player.X,
                        Y = player.Y
                    }
                }, null);
            }
            return true;
        }
    }

    class KillAll : Command
    {
        public KillAll() : base("killAll", permLevel: 1) { }
        
        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            var iterations = 0;
            var lastKilled = -1;
            var killed = 0;

            var mobName = args.Aggregate((s, a) => string.Concat(s, " ", a));
            while (killed != lastKilled)
            {
                lastKilled = killed;
                foreach (var i in player.Owner.Enemies.Values.Where(e =>
                    e.ObjectDesc?.ObjectId != null && e.ObjectDesc.ObjectId.ContainsIgnoreCase(mobName)))
                {
                    i.Death(time);
                    killed++;
                }
                if (++iterations >= 5)
                    break;
            }

            player.SendInfo($"{killed} enemy killed!");
            return true;
        }
    }

    internal class Kick : Command
    {
        public Kick()
            : base("kick")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (args.Length == 0)
            {
                player.SendHelp("Usage: /kick <playername>");
                return false;
            }
            if (player.Client.Account.Rank >= 2) {
                try
                {
                    foreach (KeyValuePair<int, Player> i in player.Owner.Players)
                    {
                        if (i.Value.Name.ToLower() == args[0].ToLower().Trim())
                        {
                            player.SendInfo("Player has been disconnected from this server!");
                            i.Value.Client.Disconnect();
                        }
                    }
                }
                catch
                {
                    player.SendError("Cannot kick!");
                    return false;
                }
            } else
            {
                player.SendInfo("You don't have rights to use this command.");
            }
            return true;
        }
    }

    internal class Mute : Command
    {
        public Mute()
            : base("mute")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (args.Length == 0)
            {
                player.SendHelp("Usage: /mute <playername>");
                return false;
            }
            if (player.Client.Account.Rank >= 2) {

                try
                {
                    foreach (KeyValuePair<int, Player> i in player.Owner.Players)
                    {
                        if (i.Value.Name.ToLower() == args[0].ToLower().Trim())
                        {
                            i.Value.Muted = true;
                            i.Value.Manager.Database.DoActionAsync(db => db.MuteAccount(i.Value.AccountId));
                            player.SendInfo("Player Muted.");
                        }
                    }
                }
                catch
                {
                    player.SendError("Cannot mute!");
                    return false;
                }
            } else
            {
                player.SendInfo("You don't have rights to use this command.");
            }
            return true;
        }
    }

    internal class Max : Command
    {
        public Max()
            : base("max")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (player.Client.Account.Rank > 3)
            {
                try
                {
                    player.Stats[0] = player.ObjectDesc.MaxHitPoints;
                    player.Stats[1] = player.ObjectDesc.MaxMagicPoints;
                    player.Stats[2] = player.ObjectDesc.MaxAttack;
                    player.Stats[3] = player.ObjectDesc.MaxDefense;
                    player.Stats[4] = player.ObjectDesc.MaxSpeed;
                    player.Stats[5] = player.ObjectDesc.MaxHpRegen;
                    player.Stats[6] = player.ObjectDesc.MaxMpRegen;
                    player.Stats[7] = player.ObjectDesc.MaxDexterity;
                    player.SaveToCharacter();
                    player.Client.Save();
                    player.UpdateCount++;
                    player.SendInfo("Success!");
                }
                catch
                {
                    player.SendError("Nothing happen.");
                    return false;
                }
            } else if (player.Client.Account.Rank < 2) {
                player.SendInfo("Use this following command to max your character: /tell mreyeball max.");
            }
            else
            {
                player.SendInfo("You don't have rights to use this command.");
            }
            return true;
        }
    }

    internal class UnMute : Command
    {
        public UnMute()
            : base("unmute")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (args.Length == 0)
            {
                player.SendHelp("Usage: /unmute <playername>");
                return false;
            }
            if (player.Client.Account.Rank >= 2)
            {
                try
                {
                    foreach (KeyValuePair<int, Player> i in player.Owner.Players)
                    {
                        if (i.Value.Name.ToLower() == args[0].ToLower().Trim())
                        {
                            i.Value.Muted = true;
                            i.Value.Manager.Database.DoActionAsync(db => db.UnmuteAccount(i.Value.AccountId));
                            player.SendInfo("Player Unmuted.");
                        }
                    }
                }
                catch
                {
                    player.SendError("Cannot unmute!");
                    return false;
                }
            } else
            {
                player.SendInfo("You don't have rights to use this command.");
            }
            return true;
        }
    }

    internal class GlobalChat : Command
    {
        public GlobalChat()
            : base("global")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (args.Length == 0)
            {
                player.SendHelp("Usage: /global <text>");
                return false;
            }
            string saytext = string.Join(" ", args);
            //player.SendEnemy("Oryx the Mad God", saytext);
            
            foreach (Client i in player.Manager.Clients.Values)
            {
                i.SendPacket(new TextPacket
                {
                    BubbleTime = 5,
                    Stars = player.Stars,
                    Name = "#" + player.Name,
                    Text = " " + saytext
                });
            }
            return true;
        }
    }

    internal class SWhoCommand : Command //get all players from all worlds (this may become too large!)
    {
        public SWhoCommand()
            : base("online")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (player.Client.Account.Rank >= 4) {
                StringBuilder sb = new StringBuilder("All players: ");

                foreach (KeyValuePair<int, World> w in player.Manager.Worlds)
                {
                    World world = w.Value;
                    if (w.Key != 0)
                    {
                        Player[] copy = world.Players.Values.ToArray();
                        if (copy.Length != 0)
                        {
                            for (int i = 0; i < copy.Length; i++)
                            {
                                sb.Append(copy[i].Name);
                                sb.Append(", ");
                            }
                        }
                    }
                }
                string fixedString = sb.ToString().TrimEnd(',', ' '); //clean up trailing ", "s

                player.SendInfo(fixedString);
            } else
            {
                player.SendError("Cannot check who is online on all worlds of server!");
            }
            return true;
        }
    }

    internal class Announcement : Command
    {
        public Announcement()
            : base("announce")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (player.Client.Account.Rank >= 2) {
                if (args.Length == 0)
                {
                    player.SendHelp("Usage: /announce <saytext>");
                    return false;
                }
                string saytext = string.Join(" ", args);

                foreach (Client i in player.Manager.Clients.Values)
                {
                    i.SendPacket(new TextPacket
                    {
                        BubbleTime = 0,
                        Stars = -1,
                        Name = "@ANNOUNCEMENT",
                        Text = " " + saytext
                    });
                }
            } else
            {
                player.SendInfo("You don't have rights to use this command.");
            }
            return true;
        }
    }

    internal class Summon : Command
    {
        public Summon()
            : base("summon", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (player.Owner is Vault || player.Owner is PetYard)
            {
                player.SendInfo("You cant summon in this world.");
                return false;
            }
            foreach (KeyValuePair<string, Client> i in player.Manager.Clients)
            {
                if (i.Value.Player.Name.EqualsIgnoreCase(args[0]))
                {
                    Packet pkt;
                    if (i.Value.Player.Owner == player.Owner)
                    {
                        i.Value.Player.Move(player.X, player.Y);
                        pkt = new GotoPacket
                        {
                            ObjectId = i.Value.Player.Id,
                            Position = new Position(player.X, player.Y)
                        };
                        i.Value.Player.UpdateCount++;
                        player.SendInfo("Player summoned!");
                    }
                    else
                    {
                        pkt = new ReconnectPacket
                        {
                            GameId = player.Owner.Id,
                            Host = "",
                            IsFromArena = false,
                            Key = player.Owner.PortalKey,
                            KeyTime = -1,
                            Name = player.Owner.Name,
                            Port = -1
                        };
                        player.SendInfo("Player will connect to you now!");
                    }

                    i.Value.SendPacket(pkt);

                    return true;
                }
            }
            player.SendError(string.Format("Player '{0}' could not be found!", args));
            return false;
        }
    }

    internal class KillPlayerCommand : Command
    {
        public KillPlayerCommand()
            : base("kill", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            foreach (Client i in player.Manager.Clients.Values)
            {
                if (i.Account.Name.EqualsIgnoreCase(args[0]))
                {
                    i.Player.HP = 0;
                    i.Player.Death("Admin");
                    player.SendInfo("Player killed!");
                    return true;
                }
            }
            player.SendError(string.Format("Player '{0}' could not be found!", args));
            return false;
        }
    }

    internal class RestartCommand : Command
    {
        public RestartCommand()
            : base("restart", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            try
            {
                foreach (KeyValuePair<int, World> w in player.Manager.Worlds)
                {
                    World world = w.Value;
                    if (w.Key != 0)
                    {
                        world.BroadcastPacket(new TextPacket
                        {
                            Name = "@ANNOUNCEMENT",
                            Stars = -1,
                            BubbleTime = 0,
                            Text =
                                "| <MAINTENANCE> Server restarting soon. Please be ready to disconnect. We are doing maintenance on server and necessary to restart server. Wait in Menu Screen to avoid Account in Use. Cordially, LoE Team."
                        }, null);
                    }
                }
            }
            catch
            {
                player.SendError("Cannot say that in announcement!");
                return false;
            }
            return true;
        }
    }
    
    internal class TqCommand : Command
    {
        public TqCommand()
            : base("tq", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (player.Quest == null)
            {
                player.SendError("Player does not have a quest!");
                return false;
            }
            player.Move(player.Quest.X + 0.5f, player.Quest.Y + 0.5f);
            if (player.Pet != null)
                player.Pet.Move(player.Quest.X + 0.5f, player.Quest.Y + 0.5f);
            player.UpdateCount++;
            player.Owner.BroadcastPacket(new GotoPacket
            {
                ObjectId = player.Id,
                Position = new Position
                {
                    X = player.Quest.X,
                    Y = player.Quest.Y
                }
            }, null);
            player.SendInfo("Success!");
            return true;
        }
    }
    
    internal class LevelCommand : Command
    {
        public LevelCommand()
            : base("level", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            try
            {
                if (args.Length == 0)
                {
                    player.SendHelp("Use /level <ammount>");
                    return false;
                }
                if (args.Length == 1)
                {
                    player.Client.Character.Level = int.Parse(args[0]);
                    player.Client.Player.Level = int.Parse(args[0]);
                    player.UpdateCount++;
                    player.SendInfo("Success!");
                }
            }
            catch
            {
                player.SendError("Error!");
                return false;
            }
            return true;
        }
    }

    internal class SetCommand : Command
    {
        public SetCommand()
            : base("setStat", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (args.Length == 2)
            {
                try
                {
                    string stat = args[0].ToLower();
                    int amount = int.Parse(args[1]);
                    switch (stat)
                    {
                        case "health":
                        case "hp":
                            player.Stats[0] = amount;
                            break;
                        case "mana":
                        case "mp":
                            player.Stats[1] = amount;
                            break;
                        case "atk":
                        case "attack":
                            player.Stats[2] = amount;
                            break;
                        case "def":
                        case "defence":
                            player.Stats[3] = amount;
                            break;
                        case "spd":
                        case "speed":
                            player.Stats[4] = amount;
                            break;
                        case "vit":
                        case "vitality":
                            player.Stats[5] = amount;
                            break;
                        case "wis":
                        case "wisdom":
                            player.Stats[6] = amount;
                            break;
                        case "dex":
                        case "dexterity":
                            player.Stats[7] = amount;
                            break;
                        default:
                            player.SendError("Invalid Stat");
                            player.SendHelp("Stats: Health, Mana, Attack, Defence, Speed, Vitality, Wisdom, Dexterity");
                            player.SendHelp("Shortcuts: Hp, Mp, Atk, Def, Spd, Vit, Wis, Dex");
                            return false;
                    }
                    player.SaveToCharacter();
                    player.Client.Save();
                    player.UpdateCount++;
                    player.SendInfo("Success");
                }
                catch
                {
                    player.SendError("Error while setting stat");
                    return false;
                }
                return true;
            }
            else if (args.Length == 3)
            {
                foreach (Client i in player.Manager.Clients.Values)
                {
                    if (i.Account.Name.EqualsIgnoreCase(args[0]))
                    {
                        try
                        {
                            string stat = args[1].ToLower();
                            int amount = int.Parse(args[2]);
                            switch (stat)
                            {
                                case "health":
                                case "hp":
                                    i.Player.Stats[0] = amount;
                                    break;
                                case "mana":
                                case "mp":
                                    i.Player.Stats[1] = amount;
                                    break;
                                case "atk":
                                case "attack":
                                    i.Player.Stats[2] = amount;
                                    break;
                                case "def":
                                case "defence":
                                    i.Player.Stats[3] = amount;
                                    break;
                                case "spd":
                                case "speed":
                                    i.Player.Stats[4] = amount;
                                    break;
                                case "vit":
                                case "vitality":
                                    i.Player.Stats[5] = amount;
                                    break;
                                case "wis":
                                case "wisdom":
                                    i.Player.Stats[6] = amount;
                                    break;
                                case "dex":
                                case "dexterity":
                                    i.Player.Stats[7] = amount;
                                    break;
                                default:
                                    player.SendError("Invalid Stat");
                                    player.SendHelp("Stats: Health, Mana, Attack, Defence, Speed, Vitality, Wisdom, Dexterity");
                                    player.SendHelp("Shortcuts: Hp, Mp, Atk, Def, Spd, Vit, Wis, Dex");
                                    return false;
                            }
                            i.Player.SaveToCharacter();
                            i.Player.Client.Save();
                            i.Player.UpdateCount++;
                            player.SendInfo("Success");
                        }
                        catch
                        {
                            player.SendError("Error while setting stat");
                            return false;
                        }
                        return true;
                    }
                }
                player.SendError(string.Format("Player '{0}' could not be found!", args));
                return false;
            }
            else
            {
                player.SendHelp("Usage: /setStat <Stat> <Amount>");
                player.SendHelp("or");
                player.SendHelp("Usage: /setStat <Player> <Stat> <Amount>");
                player.SendHelp("Shortcuts: Hp, Mp, Atk, Def, Spd, Vit, Wis, Dex");
                return false;
            }
        }
    }

    internal class SetpieceCommand : Command
    {
        public SetpieceCommand()
            : base("setpiece", 1)
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            ISetPiece piece = (ISetPiece)Activator.CreateInstance(Type.GetType(
                "wServer.realm.setpieces." + args[0], true, true));
            piece.RenderSetPiece(player.Owner, new IntPoint((int)player.X + 1, (int)player.Y + 1));
            return true;
        }
    }

    internal class ListCommands : Command
    {
        public ListCommands() : base("commands", permLevel: 1) { }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            Dictionary<string, Command> cmds = new Dictionary<string, Command>();
            Type t = typeof(Command);
            foreach (Type i in t.Assembly.GetTypes())
                if (t.IsAssignableFrom(i) && i != t)
                {
                    Command instance = (Command)Activator.CreateInstance(i);
                    cmds.Add(instance.CommandName, instance);
                }
            StringBuilder sb = new StringBuilder("");
            Command[] copy = cmds.Values.ToArray();
            for (int i = 0; i < copy.Length; i++)
            {
                if (i != 0) sb.Append(", ");
                sb.Append(copy[i].CommandName);
            }

            player.SendInfo(sb.ToString());
            return true;
        }
    }
}