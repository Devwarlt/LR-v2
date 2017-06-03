#region

using System;
using System.Collections.Generic;
using wServer.logic.behaviors;
using db;
using wServer.logic.transitions;

#endregion

/*
3 bots

BlueGhosterino, Samerino and Dankerino

blue (knight)
- Reminds me of american dad!
- First i wanna ask what the topic is?
- Anything?
- Donate to best server!
- Damn hard choice

sam (king knifeula)
- Fear the incubuss King!
- Don't do drugs
- Stay in school
- Give me items, ign: Sam
- Give Dank items to give back to you

dank (father time)
- Free itenz pls
- Sam is bae
- Dankins the boshy guy returns??
- Best Priest World
- Donate to be cool like me
*/

namespace wServer.logic
{
    partial class BehaviorDb
    {
        // (*) not added yet!
        public static readonly string[] LoECorporation = {
                    "devwarlt",
                    "hallow",
                    "bork",
                    "k"
                };
        public const double EventMultipler = eventmultipler;
        public const double GLandPot = glandpot;
        public const double WhiteBag = whitebag;
        public const double BlackBag = blackbag;
        public const double SuperBag = superbag;
        public const double oGLandPot = oglandpot;
        public const double oWhiteBag = owhitebag;
        public const double oBlackBag = oblackbag;
        public const double oSuperBag = osuperbag;
        public const bool special_dotmg_max = false;
        
        public const int ServerCapacity = 50;

        private const double oglandpot = 0.1;
        private const double owhitebag = 0.01456/2;
        private const double oblackbag = 0.00444/2;
        private const double osuperbag = 0.00364/2;

        public const int EXPmultipler = 1;
        private const double winecellar = 0.0182*eventmultipler/2;          //             -       wine cellar incantation       
        private const double eventmultipler = 1;                            //             -       normal loot event over
        private const double glandpot = 0.1*eventmultipler;                 //             -       pot probability in glands
        ////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        ////////////////////////////////////////////////////New Loot System in LoE Realm by Devwarlt\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        ////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        private const double whitebag = 0.01456*eventmultipler/2;           //1.456%       -       White Bag UT
        private const double blackbag = 0.00444*eventmultipler/2;           //0.444%       -       Black Bag LT
        private const double superbag = 0.00364*eventmultipler/2;           //0.364%       -       Super Bag SRT
        private const double eggbag = 0.008125*eventmultipler/2;            //0.8125%      -       Egg Bag
        private const double awesomeloot = 0.01625*eventmultipler/2;        //1.625%       -       T13~14 weapons / T14~15 armors / T7~8 abilities / T7~8 rings / treasures
        private const double greatloot = 0.03125*eventmultipler/2;          //3.125%       -       T12 weapons / T13 armors / T6 abilities / T6 rings
        private const double goodloot = 0.0625*eventmultipler/2;            //6.25%        -       T10-11 weapons / T12 armors / T5 abilities / T5 rings
        private const double normalloot = 0.125*eventmultipler/2;           //12.5%        -       T9 weapons / T10-11 armors / T4 abilities / T4 rings
        private const double mediumloot = 0.25*eventmultipler/2;            //25%          -       T7-8 weapons / T8-9 armors / T3 abilities /T3 rings
        private const double poorloot = 0.4*eventmultipler/2;               //40%          -       T0-6 weapons / T1-7 armors / T0-2 abilities / T1-2 rings
        ////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        ////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        ////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        
        private _ Nexus = () => Behav()
            .Init("XP Gift G",
                new State("Start",
                    new State("Talk",
                        new Taunt("Chicken is good for you! Mmmmm... eat up!"),
                        new TimedTransition(1000, "Wander")
                        ),
                    new State("Wander",
                        new Wander(0.1)
                        )
                    )
            )
            .Init("BlueGhosterino",
                new State("StartBlue",
                    new State("blueone",
                        new Wander(0.1),
                        new Taunt(0.3, true, 10000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(11000, "bluetwo")
                    ),
                    new State("bluetwo",
                        new Taunt(0.3, true, 7000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(8000, "bluethree")
                    ),
                    new State("bluethree",
                        new Taunt(0.3, true, 19000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(20000, "bluefour")
                    ),
                    new State("bluefour",
                        new Wander(0.1),
                        new Taunt(0.3, true, 13000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(14000, "bluefive")
                    ),
                    new State("bluefive",
                        new Taunt(0.3, true, 16000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(17000, "blueone")
                    )
                )
            )
            .Init("Samerino",
                new State("StartSam",
                    new State("samone",
                        new Wander(0.1),
                        new Taunt(0.3, true, 16000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(17000, "samtwo")
                    ),
                    new State("samtwo",
                        new Taunt(0.3, true, 10000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(11000, "samthree")
                    ),
                    new State("samthree",
                        new Taunt(0.3, true, 19000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(20000, "samfour")
                    ),
                    new State("samfour",
                        new Wander(0.1),
                        new Taunt(0.3, true, 7000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(8000, "samfive")
                    ),
                    new State("samfive",
                        new Taunt(0.3, true, 13000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(14000, "samone")
                    )
                )
            )
            .Init("Dankerino",
                new State("StartDank",
                    new State("dankone",
                        new Wander(0.1),
                        new Taunt(0.3, true, 7000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(8000, "danktwo")
                    ),
                    new State("danktwo",
                        new Taunt(0.3, true, 13000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(14000, "dankthree")
                    ),
                    new State("dankthree",
                        new Taunt(0.3, true, 19000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(20000, "dankfour")
                    ),
                    new State("dankfour",
                        new Wander(0.1),
                        new Taunt(0.3, true, 16000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(17000, "dankfive")
                    ),
                    new State("dankfive",
                        new Taunt(0.3, true, 10000,
                            "Welcome to LoE Realm! This is the official server of LoE Team. You will have no more deleting accounts! Can play quiet, your data is in good hands.",
                            "If you want to perform a donation to help us go to the main menu and click on the banner Support us!",
                            "For questions please contact one of our Community Moderators!",
                            "Never tell your password and login data to other players! Or for members of staff!!!",
                            "Use these commands to access one of three servers of Elder Mountains! /em1, /em2 or /em3",
                            "If you want more information ask MrEyeball is very simple use the following command: /tell mreyeball help",
                            "The LoE Realm server is online since 1st October 2015.",
                            "The server automatically restarts every hour (60 minutes). Use the following command: /tell mreyeball uptime.",
                            "Visit our official website www.loerealm.com!"),
                        new TimedTransition(11000, "dankone")
                    )
                )
            )
            ;
    }
}