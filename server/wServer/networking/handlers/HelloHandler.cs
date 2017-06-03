#region

using System;
using System.Linq;
using System.Text;
using db;
using wServer.networking.cliPackets;
using wServer.networking.svrPackets;
using wServer.realm;
using wServer.realm.worlds;
using wServer.realm.entities;
using FailurePacket = wServer.networking.svrPackets.FailurePacket;

#endregion

namespace wServer.networking.handlers
{
    internal class HelloHandler : PacketHandlerBase<HelloPacket>
    {
        public override PacketID ID
        {
            get { return PacketID.HELLO; }
        }

        protected override void HandlePacket(Client client, HelloPacket packet)
        {
            if (Client.SERVER_VERSION != packet.BuildVersion)
            {
                client.SendPacket(new FailurePacket
                {
                    ErrorId = 0,
                    ErrorDescription = "server.update_client"
                });
                client.SendPacket(new FailurePacket
                {
                    ErrorId = 4,
                    ErrorDescription = Client.SERVER_VERSION
                });
                client.SendPacket(new FailurePacket
                {
                    ErrorId = 0,
                    ErrorDescription = "AGCLoEBuild INFO: You are using version " + packet.BuildVersion + " instead of lastest version " + Client.SERVER_VERSION + " to play! If version of your AGCLoEBuild is higher then actual, please wait our developers done the maintenance."
                });
                client.Disconnect();
                return;
            }
            client.Manager.Database.DoActionAsync(db =>
            {
                if ((client.Account = db.Verify(packet.GUID, packet.Password, Manager.GameData)) == null)
                {
                    log.Info(@"Account not verified.");
                    client.Account = Database.CreateGuestAccount(packet.GUID);

                    if (client.Account == null)
                    {
                        client.SendPacket(new FailurePacket
                        {
                            ErrorDescription = "Invalid account."
                        });
                        client.Disconnect();
                        return;
                    }
                }
                if (!client.Account.IsGuestAccount)
                {
                    int? timeout = null;
                    int allowedRank;
                    string daysLeft = "";
                    string double_event = "";
                    bool isTestServer = false;
                    bool isClosedTestServer = false;
                    if(isTestServer == true)
                        allowedRank = 1;
                    else if(isClosedTestServer == true)
                        allowedRank = 2;
                    else
                        allowedRank = 0;

                    #region CLOSED TEST SERVER
                    if((isClosedTestServer == true) && (client.Account.Rank >= allowedRank))
                    {
                        if(isTestServer == true)
                            double_event = "[Test Server] ";
                        if(isClosedTestServer == true)
                            double_event = "[Closed Test Server] ";
                        else
                            double_event = "";
                    
                        string banDaysLeft = "";

                        if(client.Account.Banned == true)
                        {
                            int accWarnings = db.GetWarnings(client.Account);
                            if ((db.CheckBanTime(client.Account, ref banDaysLeft)) && (accWarnings != 5))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "[WARNINGS " + accWarnings + " of 5] Your ban time period is gone! Respect our rules to avoid another banishment!"
                                });
                                db.UpdateUnBan(client.Account);
                            }
                            else if((db.CheckBanTime(client.Account, ref banDaysLeft)) && (accWarnings == 5))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "[WARNINGS " + accWarnings + " of 5] Your account was permanently banned for reached the warnings limit."
                                });
                                client.Disconnect();
                            }
                            else if((!db.CheckBanTime(client.Account, ref banDaysLeft)) && (accWarnings != 5))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "[WARNINGS " + accWarnings + " of 5] Time remaining " + banDaysLeft
                                });
                                client.Disconnect();
                            }
                            else
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "Critical error during Account Auth Sync! Your access to this server was disabled."
                                });
                                client.Disconnect();
                            }
                        }
                        if (DateTime.Now <= Program.WhiteListTurnOff)
                        {
                            if (!IsWhiteListed(client.Account.Rank))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "You are not whitelisted!"
                                });
                                client.Disconnect();
                                return;
                            }
                        }
                        if (client.Account.Rank == 0)
                        {
                            client.SendPacket(new FailurePacket
                            {
                                ErrorId = 0,
                                ErrorDescription = double_event + "Welcome to LoE Realm, " + client.Account.Name + "!"
                            });
                            client.SendPacket(new FailurePacket
                            {
                                ErrorId = 0,
                                ErrorDescription = "Get your VIP account now! Visit our website or click on one of our banners that are located at the entrance of your client or the screen that you choose your character. You can access the following url loerealm.com/donate. We will be happy to assist you at any time. Your donation is important to keep our services active."
                            });
                        }
                        else
                        {
                            if ((db.CheckVIPTime(client.Account, ref daysLeft)) && (client.Account.Rank == 1))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "Your VIP account period is gone! Renew your VIP time and enjoy LoE Realm with your friends!"
                                });
                                db.UpdateVIPtoFREE(client.Account);
                            }
                            else if((!db.CheckVIPTime(client.Account, ref daysLeft)) && (client.Account.Rank == 1))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "[VIP Account - Time Remaining] " + daysLeft
                                });
                            }
                            else
                            {
                                string rank_name = "";
                                if(client.Account.Rank == 2)
                                    rank_name = "community moderator";
                                else if(client.Account.Rank == 3)
                                    rank_name = "administrator";
                                else if(client.Account.Rank == 4)
                                    rank_name = "manager";
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = double_event + "Welcome to LoE Realm, " + client.Account.Name + "! Your are " + rank_name + " of LoE Realm."
                                });
                            }
                        }
                        if (db.CheckAccountInUse(client.Account, ref timeout))
                        {
                            if (timeout == null)
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "Your account is currently in use. You can not log in to multiple servers while you are already logged in to this server."
                                });
                            }
                            else
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "Your account is currently in use. You can not log in to multiple servers while you are already logged in to this server. Please wait " + timeout + " seconds until timeout."
                                });
                            }
                            client.Disconnect();
                            return;
                        }
                    }
                    #endregion
                    
                    #region NORMAL SERVER
                    if(isClosedTestServer == false)
                    {
                        if(isTestServer == true)
                            double_event = "[Test Server] ";
                        if(isClosedTestServer == true)
                            double_event = "[Closed Test Server] ";
                        else
                            double_event = "";
                    
                        string banDaysLeft = "";

                        if(client.Account.Banned == true)
                        {
                            int accWarnings = db.GetWarnings(client.Account);
                            if ((db.CheckBanTime(client.Account, ref banDaysLeft)) && (accWarnings != 5))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "[WARNINGS " + accWarnings + " of 5] Your ban time period is gone! Respect our rules to avoid another banishment!"
                                });
                                db.UpdateUnBan(client.Account);
                            }
                            else if((db.CheckBanTime(client.Account, ref banDaysLeft)) && (accWarnings == 5))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "[WARNINGS " + accWarnings + " of 5] Your account was permanently banned for reached the warnings limit."
                                });
                                client.Disconnect();
                            }
                            else if((!db.CheckBanTime(client.Account, ref banDaysLeft)) && (accWarnings != 5))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "[WARNINGS " + accWarnings + " of 5] Time remaining " + banDaysLeft
                                });
                                client.Disconnect();
                            }
                            else
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "Critical error during Account Auth Sync! Your access to this server was disabled."
                                });
                                client.Disconnect();
                            }
                        }
                        if (DateTime.Now <= Program.WhiteListTurnOff)
                        {
                            if (!IsWhiteListed(client.Account.Rank))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "You are not whitelisted!"
                                });
                                client.Disconnect();
                                return;
                            }
                        }
                        if (client.Account.Rank == 0)
                        {
                            client.SendPacket(new FailurePacket
                            {
                                ErrorId = 0,
                                ErrorDescription = double_event + "Welcome to LoE Realm, " + client.Account.Name + "!"
                            });
                            client.SendPacket(new FailurePacket
                            {
                                ErrorId = 0,
                                ErrorDescription = "Get your VIP account now! Visit our website or click on one of our banners that are located at the entrance of your client or the screen that you choose your character. You can access the following url loerealm.com/donate. We will be happy to assist you at any time. Your donation is important to keep our services active."
                            });
                        }
                        else
                        {
                            if ((db.CheckVIPTime(client.Account, ref daysLeft)) && (client.Account.Rank == 1))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "Your VIP account period is gone! Renew your VIP time and enjoy LoE Realm with your friends!"
                                });
                                db.UpdateVIPtoFREE(client.Account);
                            }
                            else if((!db.CheckVIPTime(client.Account, ref daysLeft)) && (client.Account.Rank == 1))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "[VIP Account - Time Remaining] " + daysLeft
                                });
                            }
                            else
                            {
                                string rank_name = "";
                                if(client.Account.Rank == 2)
                                    rank_name = "community moderator";
                                else if(client.Account.Rank == 3)
                                    rank_name = "administrator";
                                else if(client.Account.Rank == 4)
                                    rank_name = "manager";
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = double_event + "Welcome to LoE Realm, " + client.Account.Name + "! Your are " + rank_name + " of LoE Realm."
                                });
                            }
                        }
                        if (db.CheckAccountInUse(client.Account, ref timeout))
                        {
                            if (timeout == null)
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "Your account is currently in use. You can not log in to multiple servers while you are already logged in to this server."
                                });
                            }
                            else
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "Your account is currently in use. You can not log in to multiple servers while you are already logged in to this server. Please wait " + timeout + " seconds until timeout."
                                });
                            }
                            client.Disconnect();
                            return;
                        }
                    }
                    #endregion
                    
                    #region TEST SERVER
                    if((isTestServer == true) && (client.Account.Rank >= allowedRank))
                    {
                        if(isTestServer == true)
                            double_event = "[Test Server] ";
                        if(isClosedTestServer == true)
                            double_event = "[Closed Test Server] ";
                        else
                            double_event = "";
                    
                        string banDaysLeft = "";

                        if(client.Account.Banned == true)
                        {
                            int accWarnings = db.GetWarnings(client.Account);
                            if ((db.CheckBanTime(client.Account, ref banDaysLeft)) && (accWarnings != 5))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "[WARNINGS " + accWarnings + " of 5] Your ban time period is gone! Respect our rules to avoid another banishment!"
                                });
                                db.UpdateUnBan(client.Account);
                            }
                            else if((db.CheckBanTime(client.Account, ref banDaysLeft)) && (accWarnings == 5))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "[WARNINGS " + accWarnings + " of 5] Your account was permanently banned for reached the warnings limit."
                                });
                                client.Disconnect();
                            }
                            else if((!db.CheckBanTime(client.Account, ref banDaysLeft)) && (accWarnings != 5))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "[WARNINGS " + accWarnings + " of 5] Time remaining " + banDaysLeft
                                });
                                client.Disconnect();
                            }
                            else
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "Critical error during Account Auth Sync! Your access to this server was disabled."
                                });
                                client.Disconnect();
                            }
                        }
                        if (DateTime.Now <= Program.WhiteListTurnOff)
                        {
                            if (!IsWhiteListed(client.Account.Rank))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "You are not whitelisted!"
                                });
                                client.Disconnect();
                                return;
                            }
                        }
                        if (client.Account.Rank == 0)
                        {
                            client.SendPacket(new FailurePacket
                            {
                                ErrorId = 0,
                                ErrorDescription = double_event + "Welcome to LoE Realm, " + client.Account.Name + "!"
                            });
                            client.SendPacket(new FailurePacket
                            {
                                ErrorId = 0,
                                ErrorDescription = "Get your VIP account now! Visit our website or click on one of our banners that are located at the entrance of your client or the screen that you choose your character. You can access the following url loerealm.com/donate. We will be happy to assist you at any time. Your donation is important to keep our services active."
                            });
                        }
                        else
                        {
                            if ((db.CheckVIPTime(client.Account, ref daysLeft)) && (client.Account.Rank == 1))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "Your VIP account period is gone! Renew your VIP time and enjoy LoE Realm with your friends!"
                                });
                                db.UpdateVIPtoFREE(client.Account);
                            }
                            else if((!db.CheckVIPTime(client.Account, ref daysLeft)) && (client.Account.Rank == 1))
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "[VIP Account - Time Remaining] " + daysLeft
                                });
                            }
                            else
                            {
                                string rank_name = "";
                                if(client.Account.Rank == 2)
                                    rank_name = "community moderator";
                                else if(client.Account.Rank == 3)
                                    rank_name = "administrator";
                                else if(client.Account.Rank == 4)
                                    rank_name = "manager";
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = double_event + "Welcome to LoE Realm, " + client.Account.Name + "! Your are " + rank_name + " of LoE Realm."
                                });
                            }
                        }
                        if (db.CheckAccountInUse(client.Account, ref timeout))
                        {
                            if (timeout == null)
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "Your account is currently in use. You can not log in to multiple servers while you are already logged in to this server."
                                });
                            }
                            else
                            {
                                client.SendPacket(new FailurePacket
                                {
                                    ErrorId = 0,
                                    ErrorDescription = "Your account is currently in use. You can not log in to multiple servers while you are already logged in to this server. Please wait " + timeout + " seconds until timeout."
                                });
                            }
                            client.Disconnect();
                            return;
                        }
                    }
                    #endregion

                    else if (((isTestServer == true) || (isClosedTestServer == true)) && (client.Account.Rank < allowedRank))
                    {
                        if(isTestServer == true)
                        {
                            client.SendPacket(new FailurePacket
                            {
                                ErrorId = 0,
                                ErrorDescription = "[Test Server] Only VIPs and Staff members can get in. This server is closed for maintenance, please try again later. We are working on fixing a problem found in our systems. Thank you for your attention, regards LoE Team."
                            });
                            client.Disconnect();
                        }
                        else if(isClosedTestServer == true)
                        {
                            client.SendPacket(new FailurePacket
                            {
                                ErrorId = 0,
                                ErrorDescription = "[Closed Test Server] Only Staff members can get in. This server is closed for maintenance, please try again later. We are working on fixing a problem found in our systems. Thank you for your attention, regards LoE Team."
                            });
                            client.Disconnect();
                        }
                    }
                }
                log.Info(@"Client trying to connect!");
                client.ConnectedBuild = packet.BuildVersion;
                if (!client.Manager.TryConnect(client))
                {
                    client.Account = null;
                    client.SendPacket(new FailurePacket
                    {
                        ErrorDescription = "This server reached the fully capacity of players online! Please wait, we are trying to connect you again in few seconds. Don't go to Menu Screen to avoid Account in Use!"
                    });
                    client.Disconnect();
                }
                else
                {
                    //client.Manager.Logic.AddPendingAction(t =>{
                    log.Info(@"Client loading world");
                    //client.Player.Owner.Timers.Add(new WorldTimer(5000, (w, j) => {
                    if (packet.GameId == World.NEXUS_LIMBO) packet.GameId = World.NEXUS_ID;
                    World world = client.Manager.GetWorld(packet.GameId);
                    if (world == null && packet.GameId == World.TUT_ID) world = client.Manager.AddWorld(new Tutorial(false));
                    if (world == null)
                    {
                        client.SendPacket(new FailurePacket
                        {
                            ErrorId = 1,
                            ErrorDescription = "Invalid world."
                        });
                        client.Disconnect();
                        return;
                    }
                    if (world.NeedsPortalKey)
                    {
                        if (!world.PortalKey.SequenceEqual(packet.Key))
                        {
                            client.SendPacket(new FailurePacket
                            {
                                ErrorId = 1,
                                ErrorDescription = "Portal key expired. Go to main menu to avoid this."
                            });
                            client.Disconnect();
                            return;
                        }
                        if (world.PortalKeyExpired)
                        {
                            client.SendPacket(new FailurePacket
                            {
                                ErrorId = 1,
                                ErrorDescription = "Portal key expired. Go to main menu to avoid this."
                            });
                            client.Disconnect();
                            return;
                        }
                    }
                    log.Info(@"Client joined world " + world.Id);
                    if (packet.MapInfo.Length > 0) //Test World
                        (world as Test).LoadJson(Encoding.Default.GetString(packet.MapInfo));

                    if (world.IsLimbo)
                        world = world.GetInstance(client);
                    client.Random = new wRandom(world.Seed);
                    client.TargetWorld = world.Id;
                    client.SendPacket(new MapInfoPacket
                    {
                        Width = world.Map.Width,
                        Height = world.Map.Height,
                        Name = world.Name,
                        Seed = world.Seed,
                        ClientWorldName = world.ClientWorldName,
                        Difficulty = world.Difficulty,
                        Background = world.Background,
                        AllowTeleport = world.AllowTeleport,
                        ShowDisplays = world.ShowDisplays,
                        Music = world.GetMusic(),
                        ClientXML = world.ClientXml,
                        ExtraXML = Manager.GameData.AdditionXml
                    });
                    client.Stage = ProtocalStage.Handshaked;
                    //}));
                    //}, PendingPriority.Networking);
                }
            });
        }

        private bool IsWhiteListed(int rank)
        {
            if (Program.WhiteList)
            {
                if (rank > 0) return true;
                return false;
            }
            return true;
        }
    }
}
