#region

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using db;
using db.JsonObjects;
using wServer.networking.cliPackets;
using wServer.networking.svrPackets;
using wServer.realm.entities;
using wServer.realm.entities.player;

#endregion

namespace wServer.realm.commands
{
    internal class LeftToMaxCommand : Command
    {
        public LeftToMaxCommand()
            : base("lefttomax")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            player.SendInfo("This command is now part of our new stats verification system, the MrEyeball BOT. Use the following command:");
            player.SendHelp("/tell mreyeball lefttomax");
            /*player.SendInfo(String.Format("You need {0} ({1}) HP, {2} ({3}) MP, {4} ATT, {5} DEF, {6} SPD, {7} DEX, {8} VIT and {9} WIS to max.",
            Math.Abs(player.Stats[0] - player.ObjectDesc.MaxHitPoints),
            Math.Ceiling((decimal)Math.Abs(player.Stats[0] - player.ObjectDesc.MaxHitPoints) / 5),
            Math.Abs(player.Stats[1] - player.ObjectDesc.MaxMagicPoints),
            Math.Ceiling((decimal)Math.Abs(player.Stats[1] - player.ObjectDesc.MaxMagicPoints) / 5),
            Math.Abs(player.Stats[2] - player.ObjectDesc.MaxAttack),
            Math.Abs(player.Stats[3] - player.ObjectDesc.MaxDefense),
            Math.Abs(player.Stats[4] - player.ObjectDesc.MaxSpeed),
            Math.Abs(player.Stats[7] - player.ObjectDesc.MaxDexterity),
            Math.Abs(player.Stats[5] - player.ObjectDesc.MaxHpRegen),
            Math.Abs(player.Stats[6] - player.ObjectDesc.MaxMpRegen)));*/
            return true;
        }
    }

    internal class Godlands : Command
    {
        public Godlands()
            : base("glands")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (player.Owner.Name == "Realm of the Mad God") {
                player.ApplyConditionEffect(new ConditionEffect
                {
                    Effect = ConditionEffectIndex.Invulnerable,
                    DurationMS = 2000
                });
                player.ApplyConditionEffect(new ConditionEffect
                {
                    Effect = ConditionEffectIndex.Invisible,
                    DurationMS = 2000
                });
                player.SendInfo("You have been teleported to God Lands (Mountains)! Take care in this place its not safe for low levels! About it we are giving 2 seconds of Invulnerable and Invisible Effect.");
                player.Move(1000, 1000);
                if (player.Pet != null)
                    player.Pet.Move(1000, 1000);
                player.UpdateCount++;
                player.Owner.BroadcastPacket(new GotoPacket
                {
                    ObjectId = player.Id,
                    Position = new Position
                    {
                        X = player.X,
                        Y = player.Y
                    }
                }
                    ,null);
            } else
            {
                player.SendInfo("You aren't in any Realm of the Mad God to use this command!");
            }
            return true;
        }
    }
    
    internal class ElderMountains_server1Commands : Command
    {
        public ElderMountains_server1Commands()
            : base("em1")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            player.Client.Reconnect(new ReconnectPacket
            {
                Host = "",
                Port = Program.Settings.GetValue<int>("port"),
                GameId = World.ELDER_MONTAINS_SV1,
                Name = "Elder Mountains (Server 1)",
                Key = Empty<byte>.Array,
            });
            return true;
        }
    }
    internal class ElderMountains_server2Commands : Command
    {
        public ElderMountains_server2Commands()
            : base("em2")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            player.Client.Reconnect(new ReconnectPacket
            {
                Host = "",
                Port = Program.Settings.GetValue<int>("port"),
                GameId = World.ELDER_MONTAINS_SV2,
                Name = "Elder Mountains (Server 2)",
                Key = Empty<byte>.Array,
            });
            return true;
        }
    }
    internal class ElderMountains_server3Commands : Command
    {
        public ElderMountains_server3Commands()
            : base("em3")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            player.Client.Reconnect(new ReconnectPacket
            {
                Host = "",
                Port = Program.Settings.GetValue<int>("port"),
                GameId = World.ELDER_MONTAINS_SV3,
                Name = "Elder Mountains (Server 3)",
                Key = Empty<byte>.Array,
            });
            return true;
        }
    }

    internal class TutorialCommand : Command
    {
        public TutorialCommand()
            : base("tutorial")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            player.Client.Reconnect(new ReconnectPacket
            {
                Host = "",
                Port = Program.Settings.GetValue<int>("port"),
                GameId = World.TUT_ID,
                Name = "Tutorial",
                Key = Empty<byte>.Array,
            });
            return true;
        }
    }

    internal class TradeCommand : Command
    {
        public TradeCommand()
            : base("trade")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if(String.IsNullOrWhiteSpace(args[0]))
            {
                player.SendInfo("Usage: /trade <player name>");
                return false;
            }
            player.RequestTrade(time, new RequestTradePacket
            {
                Name = args[0]
            });
            return true;
        }
    }


    internal class WhoCommand : Command
    {
        public WhoCommand()
            : base("who")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            player.SendHelp("Use this following command to know how many players onlines right now: /tell mreyeball online");
            return true;
        }
    }

    internal class ServerCommand : Command
    {
        public ServerCommand()
            : base("server")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            player.SendInfo(player.Owner.Name);
            return true;
        }
    }

    internal class PauseCommand : Command
    {
        public PauseCommand()
            : base("pause")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (player.HasConditionEffect(ConditionEffectIndex.Paused))
            {
                player.ApplyConditionEffect(new ConditionEffect
                {
                    Effect = ConditionEffectIndex.Paused,
                    DurationMS = 0
                });
                player.SendInfo("Game resumed.");
            }
            else
            {
                foreach (Enemy i in player.Owner.EnemiesCollision.HitTest(player.X, player.Y, 8).OfType<Enemy>())
                {
                    if (i.ObjectDesc.Enemy)
                    {
                        player.SendInfo("Not safe to pause.");
                        return false;
                    }
                }
                player.ApplyConditionEffect(new ConditionEffect
                {
                    Effect = ConditionEffectIndex.Paused,
                    DurationMS = -1
                });
                player.SendInfo("Game paused.");
            }
            return true;
        }
    }

    internal class TeleportCommand : Command
    {
        public TeleportCommand()
            : base("teleport")
        {
        }

        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            try
            {
                if (String.Equals(player.Name.ToLower(), args[0].ToLower()))
                {
                    player.SendInfo("You are already at yourself, and always will be!");
                    return false;
                }

                foreach (KeyValuePair<int, Player> i in player.Owner.Players)
                {
                    if (i.Value.Name.ToLower() == args[0].ToLower().Trim())
                    {
                        player.Teleport(time, new TeleportPacket
                        {
                            ObjectId = i.Value.Id
                        });
                        return true;
                    }
                }
                player.SendInfo(string.Format("Cannot teleport, {0} not found!", args[0].Trim()));
            }
            catch
            {
                player.SendHelp("Usage: /teleport <player name>");
            }
            return false;
        }
    }

    class TellCommand : Command
    {
        public TellCommand() : base("tell") { }
        
        protected override bool Process(Player player, RealmTime time, string[] args)
        {
            if (args.Length < 2)
            {
                player.SendInfo("Usage: /tell <player name> <text>");
                return false;
            }

            string playername = args[0].Trim();
            string msg = string.Join(" ", args, 1, args.Length - 1);

            if (String.Equals(player.Name.ToLower(), playername.ToLower()))
            {
                player.SendInfo("Quit telling yourself!");
                return false;
            }

            // MrEyeball Script by Devwarlt and Realmeye
            if ((playername.ToLower() == "mreyeball") || (playername.ToLower() == "MrEyeball"))
            {
                if (msg.ToLower() == "gold")
                {
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    player.Client.SendPacket(new TextPacket()
                    {
                        ObjectId = -1,
                        BubbleTime = 10,
                        Stars = 69,
                        Name = "MrEyeball",
                        Recipient = player.Name,
                        Text = "OK! That's an interesting question, and several players usually make me often. Basically, to get gold without performing donate, you should get a bag that contains treasures. All treasures can be traded with other players, but you can also use them for gold.",
                        CleanText = ""
                    });
                }
                else if (msg.ToLower() == "max") {
                    var special_dotmg = wServer.logic.BehaviorDb.special_dotmg_max;
                    if(special_dotmg == true) {
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
                        player.Client.SendPacket(new TextPacket() //echo to self
                        {
                            ObjectId = player.Id,
                            BubbleTime = 10,
                            Stars = player.Stars,
                            Name = player.Name,
                            Recipient = "MrEyeball",
                            Text = msg.ToSafeText(),
                            CleanText = ""
                        });
                        player.Client.SendPacket(new TextPacket()
                        {
                            ObjectId = -1,
                            BubbleTime = 10,
                            Stars = 69,
                            Name = "MrEyeball",
                            Recipient = player.Name,
                            Text = "Awesome! Now you are with 8/8 stats maxed! Go ahead and fight against nasty creatures!",
                            CleanText = ""
                        });
                    }
                    else if(special_dotmg == false)
                    {
                        player.Client.SendPacket(new TextPacket() //echo to self
                        {
                            ObjectId = player.Id,
                            BubbleTime = 10,
                            Stars = player.Stars,
                            Name = player.Name,
                            Recipient = "MrEyeball",
                            Text = msg.ToSafeText(),
                            CleanText = ""
                        });
                        player.Client.SendPacket(new TextPacket()
                        {
                            ObjectId = -1,
                            BubbleTime = 10,
                            Stars = 69,
                            Name = "MrEyeball",
                            Recipient = player.Name,
                            Text = "Sorry but this feature isn't allowed to use right now.",
                            CleanText = ""
                        });
                    }
                }
                else if (msg.ToLower() == "history")
                {
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    player.Client.SendPacket(new TextPacket()
                    {
                        ObjectId = -1,
                        BubbleTime = 10,
                        Stars = 69,
                        Name = "MrEyeball",
                        Recipient = player.Name,
                        Text = "That's a long story... This project was founded by Devwarlt and Devoceanic creators in mid-October 2015 with the sole intention of bringing a new option Private Server RotMG game. However, after the release to the public, it was not expected so many players in which planned before the release. In just over three months online were able to reach a record 100 players online in this server. During this period, developers have been working to make the final release of the new server and also official LoE Realm project, which is that you are playing now! Currently, the project management is under the LoE Team.",
                        CleanText = ""
                    });
                }
                else if (msg.ToLower() == "rates")
                {
                    var em = wServer.logic.BehaviorDb.EventMultipler;
                    var glp = wServer.logic.BehaviorDb.GLandPot*100;
                    var wb = wServer.logic.BehaviorDb.WhiteBag*100;
                    var bb = wServer.logic.BehaviorDb.BlackBag*100;
                    var sb = wServer.logic.BehaviorDb.SuperBag*100;
                    var oglp = wServer.logic.BehaviorDb.oGLandPot*100;
                    var owb = wServer.logic.BehaviorDb.oWhiteBag*100;
                    var obb = wServer.logic.BehaviorDb.oBlackBag*100;
                    var osb = wServer.logic.BehaviorDb.oSuperBag*100;
                    var expm = wServer.logic.BehaviorDb.EXPmultipler;
                    var textformat = "";
                    if(em == 1)
                        textformat = String.Format("The actual rates of server are" +
                            " {0}% chance to get potions in mountains," +
                            " {1}% chance to get white bag item type," +
                            " {2}% chance to get black bag item type," +
                            " {3}% chance to get super bag item type.", oglp, owb, obb, osb);
                    else if((em > 1) && (em < 2))
                        textformat = String.Format("The actual experience multipler of server is {9}x and rates are" +
                            " {0}x event multipler (Event)," +
                            " {1}% to {2}% chance to get potions in mountains," +
                            " {3}% to {4}% chance to get white bag item type," +
                            " {5}% to {6}% chance to get black bag item type," +
                            " {7}% to {8}% chance to get super bag item type.", em, oglp, glp, owb, wb, obb, bb, osb, sb, expm);
                    else
                        textformat = String.Format("The actual experience multipler of server is {9}x and rates are" +
                            " {0}x event multipler (DotMG Event)," +
                            " {1}% to {2}% chance to get potions in mountains," +
                            " {3}% to {4}% chance to get white bag item type," +
                            " {5}% to {6}% chance to get black bag item type," +
                            " {7}% to {8}% chance to get super bag item type.", em, oglp, glp, owb, wb, obb, bb, osb, sb, expm);
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    player.Client.SendPacket(new TextPacket()
                    {
                        ObjectId = -1,
                        BubbleTime = 10,
                        Stars = 69,
                        Name = "MrEyeball",
                        Recipient = player.Name,
                        Text = textformat,
                        CleanText = ""
                    });
                }
                else if (msg.ToLower() == "details")
                {
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    player.Client.SendPacket(new TextPacket()
                    {
                        ObjectId = -1,
                        BubbleTime = 10,
                        Stars = 69,
                        Name = "MrEyeball",
                        Recipient = player.Name,
                        Text = "This server is located in Denver, Colorado, USA. It has the ability to withstand 150 players online and also an uptime time to 2 hours and 10 minutes until the next automatically restart.",
                        CleanText = ""
                    });
                }
                else if (msg.ToLower() == "uptime")
                {
                    var stringUptime = "";
                    var uptime = DateTime.Now - Program.StartTime;
                    var minutes = uptime.TotalMinutes;
                    string[] uptimeType = {
	                    "HH:mm:ss"
                    };
                    foreach (string x in uptimeType) {
	                    stringUptime = String.Format("Actual server uptime is {0} minutes. Remember server auto restart every hour (60 minutes).", minutes.ToString("0"));
                    }
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    player.Client.SendPacket(new TextPacket()
                    {
                        ObjectId = -1,
                        BubbleTime = 10,
                        Stars = 69,
                        Name = "MrEyeball",
                        Recipient = player.Name,
                        Text = stringUptime,
                        CleanText = ""
                    });
                }
                else if (msg.ToLower() == "online")
                {
                    var k = (player.Manager.Clients.Keys.Count)*1;
                    var q = player.Owner.Players.Keys.Count;
                    var m = (wServer.logic.BehaviorDb.ServerCapacity)*1;
                    var local = "";
                    var global = "";
                    if(k == 1)
                        global = " There is " + k + "/" + m + " player online on this server.";
                    else
                        global = " There are " + k + "/" + m + " players online on this server.";
                    if(q == 1)
                        local = "Only " + q + " player online in this world.";
                    else
                        local = q + " players online in this world.";
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    player.Client.SendPacket(new TextPacket()
                    {
                        ObjectId = -1,
                        BubbleTime = 10,
                        Stars = 69,
                        Name = "MrEyeball",
                        Recipient = player.Name,
                        Text = local + "" + global,
                        CleanText = ""
                    });
                }
                else if (msg.ToLower() == "lefttomax")
                {
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    var stats = 0;
                    var life = Math.Ceiling((decimal)Math.Abs(player.Stats[0] - player.ObjectDesc.MaxHitPoints) / 5);
                    var mana = Math.Ceiling((decimal)Math.Abs(player.Stats[1] - player.ObjectDesc.MaxMagicPoints) / 5);
                    var attack = Math.Abs(player.Stats[2] - player.ObjectDesc.MaxAttack);
                    var defense = Math.Abs(player.Stats[3] - player.ObjectDesc.MaxDefense);
                    var speed = Math.Abs(player.Stats[4] - player.ObjectDesc.MaxSpeed);
                    var dexterity = Math.Abs(player.Stats[7] - player.ObjectDesc.MaxDexterity);
                    var vitality = Math.Abs(player.Stats[5] - player.ObjectDesc.MaxHpRegen);
                    var wisdom = Math.Abs(player.Stats[6] - player.ObjectDesc.MaxMpRegen);
                    var lifemax = "";
                    var manamax = "";
                    var attackmax = "";
                    var defensemax = "";
                    var speedmax = "";
                    var dexteritymax = "";
                    var vitalitymax = "";
                    var wisdommax = " " + wisdom + " WIS.";
                    if((mana == 0) && (attack == 0) && (defense == 0) && (speed == 0) && (dexterity == 0) && (vitality == 0) && (wisdom == 0))
                    {
                        lifemax = " " + life + " life.";
                    } else
                    {
                        lifemax = " " + life + " life,";
                    }
                    if((attack == 0) && (defense == 0) && (speed == 0) && (dexterity == 0) && (vitality == 0) && (wisdom == 0))
                    {
                        manamax = " " + mana + " mana.";
                    } else
                    {
                        manamax = " " + mana + " mana,";
                    }
                    if((defense == 0) && (speed == 0) && (dexterity == 0) && (vitality == 0) && (wisdom == 0))
                    {
                        attackmax = " " + attack + " ATT.";
                    } else
                    {
                        attackmax = " " + attack + " ATT,";
                    }
                    if((speed == 0) && (dexterity == 0) && (vitality == 0) && (wisdom == 0))
                    {
                        defensemax = " " + defense + " DEF.";
                    } else
                    {
                        defensemax = " " + defense + " DEF,";
                    }
                    if((dexterity == 0) && (vitality == 0) && (wisdom == 0))
                    {
                        speedmax = " " + speed + " SPD.";
                    } else
                    {
                        speedmax = " " + speed + " SPD,";
                    }
                    if((vitality == 0) && (wisdom == 0))
                    {
                        dexteritymax = " " + dexterity + " DEX.";
                    } else
                    {
                        dexteritymax = " " + dexterity + " DEX,";
                    }
                    if(wisdom == 0)
                    {
                        vitalitymax = " " + vitality + " VIT.";
                    } else
                    {
                        vitalitymax = " " + vitality + " VIT,";
                    }
                    if(life == 0)
                    {
                        lifemax = "";
                        stats += 1;
                    }
                    if(mana == 0)
                    {
                        manamax = "";
                        stats += 1;
                    }
                    if(attack == 0)
                    {
                        attackmax = "";
                        stats += 1;
                    }
                    if(defense == 0)
                    {
                        defensemax = "";
                        stats += 1;
                    }
                    if(speed == 0)
                    {
                        speedmax = "";
                        stats += 1;
                    }
                    if(dexterity == 0)
                    {
                        dexteritymax = "";
                        stats += 1;
                    }
                    if(vitality == 0)
                    {
                        vitalitymax = "";
                        stats += 1;
                    }
                    if(wisdom == 0)
                    {
                        wisdommax = "";
                        stats += 1;
                    }
                    if(stats != 8)
                    {
                        player.Client.SendPacket(new TextPacket()
                        {
                            ObjectId = -1,
                            BubbleTime = 10,
                            Stars = 69,
                            Name = "MrEyeball",
                            Recipient = player.Name,
                            //+ lifemax + "" + manamax + "" 
                            Text = "You have " + stats + "/6 stats maxed. You need:" + attackmax + "" + defensemax + "" + speedmax + "" + dexteritymax + "" + vitalitymax + "" + wisdommax,
                            CleanText = ""
                        });
                    } else
                    {
                        player.Client.SendPacket(new TextPacket()
                        {
                            ObjectId = -1,
                            BubbleTime = 10,
                            Stars = 69,
                            Name = "MrEyeball",
                            Recipient = player.Name,
                            Text = "You have " + stats + "/8 stats maxed.",
                            CleanText = ""
                        });
                    }
                }
                else if (msg.ToLower() == "vip")
                {
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    if(player.Client.Account.Rank == 1)
                    {
                        player.Client.SendPacket(new TextPacket()
                        {
                            ObjectId = -1,
                            BubbleTime = 10,
                            Stars = 69,
                            Name = "MrEyeball",
                            Recipient = player.Name,
                            Text = "You are VIP. You have +25% Boost on your attack, defense, speed, dexterity, vitality and wisdom formula!",
                            CleanText = ""
                        });
                    } else {
                        player.Client.SendPacket(new TextPacket()
                        {
                            ObjectId = -1,
                            BubbleTime = 10,
                            Stars = 69,
                            Name = "MrEyeball",
                            Recipient = player.Name,
                            Text = "You aren't VIP! You haven't +25% Boost on your attack, defense, speed, dexterity, vitality and wisdom formula.",
                            CleanText = ""
                        });
                    }
                }
                else if (msg.ToLower() == "admin")
                {
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    if(player.Client.Account.Rank >= 3)
                    {
                        player.Client.SendPacket(new TextPacket()
                        {
                            ObjectId = -1,
                            BubbleTime = 10,
                            Stars = 69,
                            Name = "MrEyeball",
                            Recipient = player.Name,
                            Text = "You are admin.",
                            CleanText = ""
                        });
                    } else {
                        player.Client.SendPacket(new TextPacket()
                        {
                            ObjectId = -1,
                            BubbleTime = 10,
                            Stars = 69,
                            Name = "MrEyeball",
                            Recipient = player.Name,
                            Text = "You aren't admin!",
                            CleanText = ""
                        });
                    }
                }
                else if (msg.ToLower() == "mod")
                {
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    if(player.Client.Account.Rank == 2)
                    {
                        player.Client.SendPacket(new TextPacket()
                        {
                            ObjectId = -1,
                            BubbleTime = 10,
                            Stars = 69,
                            Name = "MrEyeball",
                            Recipient = player.Name,
                            Text = "You are community moderator.",
                            CleanText = ""
                        });
                    } else {
                        player.Client.SendPacket(new TextPacket()
                        {
                            ObjectId = -1,
                            BubbleTime = 10,
                            Stars = 69,
                            Name = "MrEyeball",
                            Recipient = player.Name,
                            Text = "You aren't community moderator!",
                            CleanText = ""
                        });
                    }
                }
                else if (msg.ToLower() == "links")
                {
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    player.Client.SendPacket(new TextPacket()
                    {
                        ObjectId = -1,
                        BubbleTime = 10,
                        Stars = 69,
                        Name = "MrEyeball",
                        Recipient = player.Name,
                        Text = "You can access the official website of the following URLs: http://www.loerealm.com/ or http://loerealm.no-ip.org/ or http://216.107.151.108/.",
                        CleanText = ""
                    });
                }
                else if (msg.ToLower() == "donate")
                {
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    player.Client.SendPacket(new TextPacket()
                    {
                        ObjectId = -1,
                        BubbleTime = 10,
                        Stars = 69,
                        Name = "MrEyeball",
                        Recipient = player.Name,
                        Text = "You can access the official website to make donations of the following URLs: http://www.loerealm.com/theserver/donate or http://loerealm.no-ip.org/theserver/donate or http://216.107.151.108/theserver/donate.",
                        CleanText = ""
                    });
                }
                else
                {
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = "MrEyeball",
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    player.Client.SendPacket(new TextPacket()
                    {
                        ObjectId = -1,
                        BubbleTime = 10,
                        Stars = 69,
                        Name = "MrEyeball",
                        Recipient = player.Name,
                        Text = "You can ask me about server rates (rates), players online (online), server live up uptime (uptime), gold (gold), history of LoE Realm (history), server information details (details), how many potions left to max yourself (lefttomax), if you are VIP (vip), if you are admin (admin), if you are moderator (mod), what are the URLs used to play or access official website (links) and how to donate or support this project (donate)! I'm a BOT, so ask me if I know how to answer your questions desmonstrated.",
                        CleanText = ""
                    });
                }
                return true;
            }

            foreach (var i in player.Manager.Clients.Values)
            {
                if (i.Account.NameChosen && i.Account.Name.EqualsIgnoreCase(playername))
                {
                    player.Client.SendPacket(new TextPacket() //echo to self
                    {
                        ObjectId = player.Id,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = i.Account.Name,
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });

                    i.SendPacket(new TextPacket() //echo to /tell player
                    {
                        ObjectId = i.Player.Owner.Id == player.Owner.Id ? player.Id : -1,
                        BubbleTime = 10,
                        Stars = player.Stars,
                        Name = player.Name,
                        Recipient = i.Account.Name,
                        Text = msg.ToSafeText(),
                        CleanText = ""
                    });
                    return true;
                }
            }
            player.SendInfo(string.Format("{0} not found.", playername));
            return false;
        }
    }
}