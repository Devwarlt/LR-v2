﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using log4net;
using wServer.realm.entities;
using wServer.networking.svrPackets;
using wServer.realm.entities.player;
using wServer.networking;

namespace wServer.realm
{
    public class ChatManager
    {
        static ILog log = LogManager.GetLogger(typeof(ChatManager));

        RealmManager manager;
        public ChatManager(RealmManager manager)
        {
            this.manager = manager;
        }

        public void Say(Player src, string text)
        {
            var byStar = src.Stars;
            var lightBlue = (byStar >= 0) && (byStar <= 13);
            var blue = (byStar >= 14) && (byStar <= 27);
            var red = (byStar >= 28) && (byStar <= 41);
            var orange = (byStar >= 42) && (byStar <= 55);
            var yellow = (byStar >= 56) && (byStar <= 69);
            //var white = (byStar >= 70);
            if(src.Client.Account.Rank == 1)
            {
                src.Owner.BroadcastPacketSync(new TextPacket()
                {
                    Name = (lightBlue ? "!" : blue ? "$" : red  ? "%" : orange ? "+" : yellow ? "&" : "-") + src.Name,
                    ObjectId = src.Id,
                    Stars = src.Stars,
                    BubbleTime = 10,
                    Recipient = "",
                    Text = text.ToSafeText(),
                    CleanText = text.ToSafeText()
                }, p => !p.Ignored.Contains(src.AccountId));
                log.InfoFormat("[{0}({1})] <{2}> {3}", src.Owner.Name, src.Owner.Id, src.Name, text);
                src.Owner.ChatReceived(text);
            }
            else if(src.Client.Account.Rank == 2)
            {
                src.Owner.BroadcastPacketSync(new TextPacket()
                {
                    Name = ";" +src.Name,
                    ObjectId = src.Id,
                    Stars = src.Stars,
                    BubbleTime = 10,
                    Recipient = "",
                    Text = text.ToSafeText(),
                    CleanText = text.ToSafeText()
                }, p => !p.Ignored.Contains(src.AccountId));
                log.InfoFormat("[{0}({1})] <{2}> {3}", src.Owner.Name, src.Owner.Id, src.Name, text);
                src.Owner.ChatReceived(text);
            }
            else if(src.Client.Account.Rank == 3)
            {
                src.Owner.BroadcastPacketSync(new TextPacket()
                {
                    Name = "=" + src.Name,
                    ObjectId = src.Id,
                    Stars = src.Stars,
                    BubbleTime = 10,
                    Recipient = "",
                    Text = text.ToSafeText(),
                    CleanText = text.ToSafeText()
                }, p => !p.Ignored.Contains(src.AccountId));
                log.InfoFormat("[{0}({1})] <{2}> {3}", src.Owner.Name, src.Owner.Id, src.Name, text);
                src.Owner.ChatReceived(text);
            }
            else if(src.Client.Account.Rank == 4)
            {
                src.Owner.BroadcastPacketSync(new TextPacket()
                {
                    Name = "~" +src.Name,
                    ObjectId = src.Id,
                    Stars = src.Stars,
                    BubbleTime = 10,
                    Recipient = "",
                    Text = text.ToSafeText(),
                    CleanText = text.ToSafeText()
                }, p => !p.Ignored.Contains(src.AccountId));
                log.InfoFormat("[{0}({1})] <{2}> {3}", src.Owner.Name, src.Owner.Id, src.Name, text);
                src.Owner.ChatReceived(text);
            }
            else
            {
                src.Owner.BroadcastPacketSync(new TextPacket()
                {
                    Name = "" + src.Name,
                    ObjectId = src.Id,
                    Stars = src.Stars,
                    BubbleTime = 10,
                    Recipient = "",
                    Text = text.ToSafeText(),
                    CleanText = text.ToSafeText()
                }, p => !p.Ignored.Contains(src.AccountId));
                log.InfoFormat("[{0}({1})] <{2}> {3}", src.Owner.Name, src.Owner.Id, src.Name, text);
                src.Owner.ChatReceived(text);
            }
        }

        public void SayGuild(Player src, string text)
        {
            foreach (Client i in src.Manager.Clients.Values)
            {
                if (String.Equals(src.Guild, i.Player.Guild))
                {
                    i.SendPacket(new TextPacket()
                    {
                        Name = src.ResolveGuildChatName(),
                        ObjectId = src.Id,
                        Stars = src.Stars,
                        BubbleTime = 10,
                        Recipient = "*Guild*",
                        Text = text.ToSafeText(),
                        CleanText = text.ToSafeText()
                    });
                }
            }
        }

        public void News(string text)
        {
            foreach (var i in manager.Clients.Values)
                i.SendPacket(new TextPacket()
                {
                    BubbleTime = 0,
                    Stars = -1,
                    Name = "@NEWS",
                    Text = text.ToSafeText()
                });
            log.InfoFormat("<NEWS> {0}", text);
        }

        public void Announce(string text)
        {
            foreach (var i in manager.Clients.Values)
                i.SendPacket(new TextPacket()
                {
                    BubbleTime = 0,
                    Stars = -1,
                    Name = "@Announcement",
                    Text = text.ToSafeText()
                });
            log.InfoFormat("<Announcement> {0}", text);
        }

        public void Oryx(World world, string text)
        {
            world.BroadcastPacket(new TextPacket()
            {
                BubbleTime = 0,
                Stars = -1,
                Name = "#Oryx the Mad God",
                Text = text.ToSafeText()
            }, null);
            log.InfoFormat("[{0}({1})] <Oryx the Mad God> {2}", world.Name, world.Id, text);
        }
    }
}
