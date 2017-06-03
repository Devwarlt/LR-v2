#region

using System;
using System.Collections.Generic;
using System.Linq;
using db.data;
using log4net;

#endregion

namespace wServer.realm.entities
{
    internal class MerchantLists
    {
        public static int[] AccessoryClothList;
        public static int[] AccessoryDyeList;
        public static int[] ClothingClothList;
        public static int[] ClothingDyeList;

        public static Dictionary<int, Tuple<int, CurrencyType>> prices = new Dictionary<int, Tuple<int, CurrencyType>>
        {
            {0xb41, new Tuple<int, CurrencyType>(0, CurrencyType.Fame)},
            {0xbab, new Tuple<int, CurrencyType>(0, CurrencyType.Fame)},
            {0xbad, new Tuple<int, CurrencyType>(0, CurrencyType.Fame)},
            
            //WEAPONS
            {0xaf6, new Tuple<int, CurrencyType>(900, CurrencyType.Gold)}, //Wand Of Recompence T12
            {0xa87, new Tuple<int, CurrencyType>(450, CurrencyType.Gold)}, //Wand Of Ancient Warning T11
            {0xa86, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //Wand Of Shadow T10
            {0xa85, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Wand Of Deep Sorcery T9
            {0xa07, new Tuple<int, CurrencyType>(51, CurrencyType.Gold)}, //Wand Of Death T8
            {0xb02, new Tuple<int, CurrencyType>(900, CurrencyType.Gold)}, //Bow Of Covert Havens T12
            {0xa8d, new Tuple<int, CurrencyType>(450, CurrencyType.Gold)}, //Bow Of Innocent Blood T11
            {0xa8c, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //Bow Of fey Magic T10
            {0xa8b, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Verdant Bow T9
            {0xa1e, new Tuple<int, CurrencyType>(51, CurrencyType.Gold)}, //Golden Bow T8
            {0xb08, new Tuple<int, CurrencyType>(900, CurrencyType.Gold)}, //Staff of the cosmicWhole T12
            {0xaa2, new Tuple<int, CurrencyType>(450, CurrencyType.Gold)}, //Staff of Astral Knowledge T11
            {0xaa1, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //Staff of Diabolical Secrets T10
            {0xaa0, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Staff Of Necrotic Arcana T9
            {0xa9f, new Tuple<int, CurrencyType>(51, CurrencyType.Gold)}, //Staff of Horror T8
            {0xb0b, new Tuple<int, CurrencyType>(900, CurrencyType.Gold)}, //Sword of Acclaim T12
            {0xa47, new Tuple<int, CurrencyType>(450, CurrencyType.Gold)}, //Skysplitter Sword T11
            {0xa84, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //Achron Sword T10
            {0xa83, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Dragonsoul Sword T9
            {0xa82, new Tuple<int, CurrencyType>(51, CurrencyType.Gold)}, //Raven Heart Sword T8
            {0xaff, new Tuple<int, CurrencyType>(900, CurrencyType.Gold)}, //Dagger Of Maleovence T12
            {0xa8a, new Tuple<int, CurrencyType>(450, CurrencyType.Gold)}, //Agate Claw Dagger T11
            {0xa89, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //Emeraldshard Dagger T10
            {0xa88, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Ragetalon Dagger T9
            {0xa19, new Tuple<int, CurrencyType>(51, CurrencyType.Gold)}, //Firedagger T8
            {0xc50, new Tuple<int, CurrencyType>(850, CurrencyType.Gold)}, //Masamune T12
            {0xc4f, new Tuple<int, CurrencyType>(450, CurrencyType.Gold)}, //Murmasa T11
            {0xc4e, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //Ichimonj T10
            {0xc4d, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Jewel Eye Katana T9
            {0xc4c, new Tuple<int, CurrencyType>(51, CurrencyType.Gold)}, //Demon Edge T8

            //SKINS
            {0x227a, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Gentleman Skin
            {0x226e, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Archer Skin
            {0x226f, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Brigand Skin
            {0x227b, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //Agent Skin
            {0x227c, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Knight Skin
            {0x227d, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Priest Skin
            {0x229a, new Tuple<int, CurrencyType>(24, CurrencyType.FortuneTokens)}, //Nun Skin
            {0x229b, new Tuple<int, CurrencyType>(24, CurrencyType.FortuneTokens)}, //Witch Doctor Skin
            {0x229c, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //Sorceress Skin
            {0x229d, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //Artemis Skin
            {0x224d, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Shoveguy Skin
            {0x226c, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Scarlett Skin
            {0x258f, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Ninja Skin
            {0x2292, new Tuple<int, CurrencyType>(2, CurrencyType.FortuneTokens)}, //Slime Wizard Skin
            {0x2293, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Deadly Vixen Skin
            {0x2298, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Stanley the Spring Bunny Skin
            {0x2321, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Nexus no Miko Skin
            {0x2323, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Drow Trickster Skin
            {0x2317, new Tuple<int, CurrencyType>(64, CurrencyType.FortuneTokens)}, //B.B. Wolf Skin
            {0x2318, new Tuple<int, CurrencyType>(24, CurrencyType.FortuneTokens)}, //Lil Red Skin
            {0x224f, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Holy Avenger Skin
            {0x225c, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //Ranger Skin
            {0x2319, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //King Knifeula Skin
            {0x2333, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //Witch Skin
            {0x2314, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Platinum Knight Skin
            {0x2315, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Platinum Warrior Skin
            {0x2316, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Platinum Rogye Skin
            {0x2349, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Sorcerer Skin
            {0x234A, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Trickster Skin
            {0x234B, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Mystic Skin
            {0x234C, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Huntress Skin
            {0x234D, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Necromancer Skin
            {0x234E, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Assassin Skin
            {0x234F, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Paladin Skin
            {0x2350, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Rogue Skin
            {0x2351, new Tuple<int, CurrencyType>(4, CurrencyType.FortuneTokens)}, //Slime Warrior Skin
            {0x2372, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Ghost Huntress Skin
            {0x2373, new Tuple<int, CurrencyType>(56, CurrencyType.FortuneTokens)}, //Skeleton Warrior Skin
            {0x747B, new Tuple<int, CurrencyType>(56, CurrencyType.FortuneTokens)}, //Huntsman Skin
            {0x747C, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //Demon Spawn Skin
            {0x747D, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Hunchback Skin
            {0x747E, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //Vampiress Skin
            {0x747F, new Tuple<int, CurrencyType>(64, CurrencyType.FortuneTokens)}, //Frankensteins Monster Skin
            {0x7480, new Tuple<int, CurrencyType>(64, CurrencyType.FortuneTokens)}, //Jack the Ripper Skin
            {0x7481, new Tuple<int, CurrencyType>(64, CurrencyType.FortuneTokens)}, //Death Skin
            {0x7482, new Tuple<int, CurrencyType>(24, CurrencyType.FortuneTokens)}, //Tiny Avatar Skin
            {0x7483, new Tuple<int, CurrencyType>(24, CurrencyType.FortuneTokens)}, //Zombie Nurse Skin
            {0x7484, new Tuple<int, CurrencyType>(24, CurrencyType.FortuneTokens)}, //Ascended Sorcerer Skin
            {0x7485, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //Mischievous Imp Skin
            {0x7486, new Tuple<int, CurrencyType>(24, CurrencyType.FortuneTokens)}, //Vampire Skin
            {0x7487, new Tuple<int, CurrencyType>(24, CurrencyType.FortuneTokens)}, //Poltergeist Skin
            {0x7488, new Tuple<int, CurrencyType>(24, CurrencyType.FortuneTokens)}, //Dark Elf Huntress Skin
            {0x2374, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //Infected Skin
            {0xcf0, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //Santa Skin
            {0xcf1, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //Litle Helper Skin
            {0xcf8, new Tuple<int, CurrencyType>(48, CurrencyType.FortuneTokens)}, //Iceman Skin
            {0x515a, new Tuple<int, CurrencyType>(24, CurrencyType.FortuneTokens)}, //Happy Clown Skin
            {0x515b, new Tuple<int, CurrencyType>(32, CurrencyType.FortuneTokens)}, //Uzumaki Naruto Skin

            //Rings
            {0xabf, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Ring of Para Attack T4
            {0xac0, new Tuple<int, CurrencyType>(120, CurrencyType.Gold)}, //Ring of para def T4
            {0xac1, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Ring Of Para Spd T4
            {0xac2, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Ring Of Para Vit T4
            {0xac3, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Ring Of Para Wis T4
            {0xac4, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Ring Of Para Dex T4
            {0xac5, new Tuple<int, CurrencyType>(120, CurrencyType.Gold)}, //Ring Of Para health T4
            {0xac6, new Tuple<int, CurrencyType>(120, CurrencyType.Gold)}, //Ring Of Para Magic T4
            {0xac7, new Tuple<int, CurrencyType>(200, CurrencyType.Gold)}, //Ring Of Exaled Att T5
            {0xac8, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Ring Of Exaled Def T5
            {0xac9, new Tuple<int, CurrencyType>(200, CurrencyType.Gold)}, //Ring Of Exaled Spd T5
            {0xaca, new Tuple<int, CurrencyType>(200, CurrencyType.Gold)}, //Ring Of Exaled Vit T5
            {0xacb, new Tuple<int, CurrencyType>(200, CurrencyType.Gold)}, //Ring Of Exaled Wis T5
            {0xacc, new Tuple<int, CurrencyType>(200, CurrencyType.Gold)}, //Ring Of Exaled Dex T5
            {0xacd, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Ring Of Exaled Health T5
            {0xace, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Ring Of Exaled Magic T5

            //ARMORS
            {0x9cf, new Tuple<int, CurrencyType>(1775, CurrencyType.Gold)}, //Robe of The Star Mother T14
            {0x9c4, new Tuple<int, CurrencyType>(1775, CurrencyType.Gold)}, //Dominion Armor T14
            {0x9c1, new Tuple<int, CurrencyType>(1775, CurrencyType.Gold)}, //Wyrmhide Armor T14
            {0x9c8, new Tuple<int, CurrencyType>(1775, CurrencyType.Gold)}, //Sword of Splendor T13
            {0x9d1, new Tuple<int, CurrencyType>(1775, CurrencyType.Gold)}, //Staff of the Vital Unity T13
            {0x9ca, new Tuple<int, CurrencyType>(1775, CurrencyType.Gold)}, //Wand of Evocation T13
            {0x9c6, new Tuple<int, CurrencyType>(1775, CurrencyType.Gold)}, //Dagger of Sinister Deeds T13
            {0x9cc, new Tuple<int, CurrencyType>(1775, CurrencyType.Gold)}, //Bow of Mystical Energy T13

            {0xb05, new Tuple<int, CurrencyType>(900, CurrencyType.Gold)}, //Robe of The Grand Sorc T13
            {0xa96, new Tuple<int, CurrencyType>(425, CurrencyType.Gold)}, //Robe of the Elder Warlock T12
            {0xa95, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //robe of the moon wizard T11
            {0xa94, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Robe of the Shadow Magus T10
            {0xa60, new Tuple<int, CurrencyType>(51, CurrencyType.Gold)}, //Robe of the Master T9
            {0xafc, new Tuple<int, CurrencyType>(900, CurrencyType.Gold)}, //Acropolis Armor T13
            {0xa93, new Tuple<int, CurrencyType>(450, CurrencyType.Gold)}, //Abyssal Armor t12
            {0xa92, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //Vengance Armor T11
            {0xa91, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Desolation Armor T10
            {0xa13, new Tuple<int, CurrencyType>(51, CurrencyType.Gold)}, //Dragonscale Armor t9
            {0xaf9, new Tuple<int, CurrencyType>(900, CurrencyType.Gold)}, //Hydra Skin Armor T13
            {0xa90, new Tuple<int, CurrencyType>(450, CurrencyType.Gold)}, //Griffion Hide T12
            {0xa8f, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //HippoGriff Armor t11
            {0xa8e, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Roc Leather Armor T10
            {0xad3, new Tuple<int, CurrencyType>(51, CurrencyType.Gold)}, //Drake Hide Armor T9

            //ABILITIES
            {0xb25, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Tome Of Holy Guideance T6
            {0xa5b, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //Tome of Divine favor T5
            {0xb22, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Colosuss Shield T6
            {0xa0c, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //Mithril Sheild T5
            {0xb24, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Elemental Detonation Spell T6
            {0xa30, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //Magic Nova Spell T5
            {0xb26, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Seal of the blessed Champion T6
            {0xa55, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //Seal of the Holy Warrior T5
            {0xb27, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Cloak of the Ghostly Consealment T6
            {0xae1, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //Cloak of Endless Twilight T5
            {0xb28, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Quiver of Elvish Mastery T6
            {0xa65, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //Golden Quiver T5
            {0xb29, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Helm of the Great General T6
            {0xa6b, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //Gold Helm T5
            {0xb2a, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //BaneSerpent Poison T6
            {0xaa8, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //NightWing Venom T5
            {0xb2b, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //BloodSucker Skull T6
            {0xaaf, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //Life Drinker Skull T5
            {0xb2c, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Giant Catcher Trap T6
            {0xab6, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, // DragonStalker Trap T5
            {0xb2d, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //PlaneFetter Orb T6
            {0xa46, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //Banishment Orb T5
            {0xb23, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Prism of Apparations T6
            {0xb20, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //Prism of Phantoms T5
            {0xb33, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Secpter of Storms T6
            {0xb32, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //Scepter Of Skybolts T5
            {0xc59, new Tuple<int, CurrencyType>(400, CurrencyType.Gold)}, //Doom Circle T6
            {0xc58, new Tuple<int, CurrencyType>(175, CurrencyType.Gold)}, //Ice Star T5

            //PET FOOD
            {0xccc, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //Ambrosia fp: 5000 -1
            {0xccb, new Tuple<int, CurrencyType>(65, CurrencyType.Gold)}, //Fries fp: 250 -8
            {0xcca, new Tuple<int, CurrencyType>(460, CurrencyType.Gold)}, //Grapes Of Wraith fp:1500 -4
            {0xcc9, new Tuple<int, CurrencyType>(25, CurrencyType.Gold)}, //Soft Drink fp: 100 -9
            {0xcc8, new Tuple<int, CurrencyType>(720, CurrencyType.Gold)}, //SuperBurger fp: 2000 -3
            {0xcc7, new Tuple<int, CurrencyType>(950, CurrencyType.Gold)}, //Double Cheese Burger Deluxe fp: 3000 -2
            {0xcc6, new Tuple<int, CurrencyType>(140, CurrencyType.Gold)}, //Great Taco fp: 500 -7
            {0xcc5, new Tuple<int, CurrencyType>(200, CurrencyType.Gold)}, //Power Pizza fp: 750 -6
            {0xcc4, new Tuple<int, CurrencyType>(285, CurrencyType.Gold)}, //Chocolate icecream sandwitch fp: 1111 -5

            //EGGS
            {0xc86, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon feline egg
            {0xc87, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare feline egg
            {0xc8a, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon canine egg
            {0xc8b, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare canine egg
            {0xc8e, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon avian egg
            {0xc8f, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare avian egg
            {0xc92, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon exotic egg
            {0xc93, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare exotic egg
            {0xc96, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon farm egg
            {0xc97, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare farm egg
            {0xc9a, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon woodland egg
            {0xc9b, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare woodland egg
            {0xc9e, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon reptile egg
            {0xc9f, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare reptile egg
            {0xca2, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon insect egg
            {0xca3, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare insect egg
            {0xca6, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon pinguin egg
            {0xca7, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare pinguin egg
            {0xcaa, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon aquatic egg
            {0xcab, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare aquatic egg
            {0xcae, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon spooky egg
            {0xcaf, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare spooky egg
            {0xcb2, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon humanoid egg
            {0xcb3, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare humanoid egg
            {0xcb6, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon ???? egg
            {0xcb7, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare ???? egg
            {0xcba, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //uncommon automaton egg
            {0xcbb, new Tuple<int, CurrencyType>(1200, CurrencyType.Gold)}, //rare automaton egg
            {0xcbe, new Tuple<int, CurrencyType>(200, CurrencyType.Gold)}, //uncommon mystery egg
            {0xcbf, new Tuple<int, CurrencyType>(1000, CurrencyType.Gold)}, //rare mystery egg
            {0xcc0, new Tuple<int, CurrencyType>(3000, CurrencyType.Gold)}, //Legendary mystery egg
            {0xcb4, new Tuple<int, CurrencyType>(0, CurrencyType.Gold)}, //Legendary Humanoid Egg

            //KEYS
            {0x2290, new Tuple<int, CurrencyType>(250, CurrencyType.Fame)}, //Bella's Key
            {0x701, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Undead lair key
            {0x705, new Tuple<int, CurrencyType>(51, CurrencyType.Gold)}, //Pirate cave key
            {0x70a, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Abyss of demons key
            {0x70b, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //Snake pit key
            {0x710, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //(250)Tomb of the ancients key
            {0x71f, new Tuple<int, CurrencyType>(51, CurrencyType.Gold)}, //Sprite World Key
            {0xc11, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //(250)Ocean Trench Key
            {0xc19, new Tuple<int, CurrencyType>(999, CurrencyType.Gold)}, //Totem Key
            {0xc23, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //(1)Manor Key
            {0xc2e, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //(100)Davy's Key
            {0xc2f, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //(100)Lab Key
            {0xcce, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //(100)Deadwater docks key
            {0xccf, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //(100)Woodland Labyrinth Key
            {0xcd4, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //(250)Draconis Key
            {0xc62, new Tuple<int, CurrencyType>(240, CurrencyType.Gold)}, //(240)Candy Key
            {0x2352, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //(100)Theatre Key
            {0x2294, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //(100)Shaitan's key
            {0x748C, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //(250)Ice Cave Key
            {0xcda, new Tuple<int, CurrencyType>(100, CurrencyType.Gold)}, //(100)The crawling depths key
            {0xcdd, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //(250)Shatters key
            {0xc6f, new Tuple<int, CurrencyType>(230, CurrencyType.Gold)}, //(230)Haunted Cemetery
            {0x5177, new Tuple<int, CurrencyType>(250, CurrencyType.Gold)}, //(230)The Ether



            //Loot Pots 0xc68 e 0xc69
            {0xc68, new Tuple<int, CurrencyType>(2, CurrencyType.FortuneTokens)}, //Tier
            {0xc69, new Tuple<int, CurrencyType>(3, CurrencyType.FortuneTokens)}, //Drop

            //Effusion
            //0xb11 0xb12
            {0xb11, new Tuple<int, CurrencyType>(500, CurrencyType.Fame)}, //Life
            {0xb12, new Tuple<int, CurrencyType>(650, CurrencyType.Fame)}, //Mana

            //0xc6c
            //BACKPACK
            {0xc6c, new Tuple<int, CurrencyType>(1000, CurrencyType.Fame)}, //BACKPACK

            //0xcc2
            {0xcc2, new Tuple<int, CurrencyType>(99, CurrencyType.Gold)}, //Lucky Clover
            
            {0xc6a, new Tuple<int, CurrencyType>(9000, CurrencyType.Fame)}, //XP Booster 1 hour
            {0xc6b, new Tuple<int, CurrencyType>(4000, CurrencyType.Fame)}, //XP Booster 20 minutes

            {0x2368, new Tuple<int, CurrencyType>(61, CurrencyType.Gold)}, //Greater ATT x7 att
            {0x2369, new Tuple<int, CurrencyType>(59, CurrencyType.Gold)}, //Greater DEF x8 def
            {0x236A, new Tuple<int, CurrencyType>(27, CurrencyType.Gold)}, //Greater SPD x24 spd
            {0x236B, new Tuple<int, CurrencyType>(27, CurrencyType.Gold)}, //Greater VIT x24 vit
            {0x236C, new Tuple<int, CurrencyType>(43, CurrencyType.Gold)}, //Greater WIS x16 wis
            {0x236D, new Tuple<int, CurrencyType>(27, CurrencyType.Gold)}, //Greater DEX x24 dex
            {0x236E, new Tuple<int, CurrencyType>(135, CurrencyType.Gold)}, //Greater LIFE
            {0x236F, new Tuple<int, CurrencyType>(87, CurrencyType.Gold)}, //Greater MANA x4 mana
        };

        public static int[] store10List = {0xb41, 0xbab, 0xbad, 0xbac};
        public static int[] store11List = {0xb41, 0xbab, 0xbad, 0xbac};
        public static int[] store12List = {0xb41, 0xbab, 0xbad, 0xbac};
        public static int[] store13List = {0xb41, 0xbab, 0xbad, 0xbac};
        public static int[] store14List = {0xb41, 0xbab, 0xbad, 0xbac};
        public static int[] store15List = {0xb41, 0xbab, 0xbad, 0xbac};
        public static int[] store16List = {0xb41, 0xbab, 0xbad, 0xbac};
        public static int[] store17List = {0xb41, 0xbab, 0xbad, 0xbac};
        public static int[] store18List = {0xb41, 0xbab, 0xbad, 0xbac};
        public static int[] store19List = {0xb41, 0xbab, 0xbad, 0xbac};
        //keys
        public static int[] store1List =
        {
            0xcda, 0xccf, 0xcce, 0xc2f, 0xc2e, 0xc23, 0xc11, 0x71f, 0x710, 0xcdd, 0xc6f,
            0x5177, 0x70b, 0x70a, 0x705, 0x701, 0x2290, 0xcd4, 0x2294, 0xc62, 0x2352, 0x748C
        };

        public static int[] store20List = {0xb41, 0xbab, 0xbad, 0xbac};

        //keys need to add etcetc
        public static int[] store2List =
        {
            //0xcb4, 
            0xcbf, 0xcbe, 0xcbb, 0xcba, 0xcb7, 0xcb6, 0xcb2, 0xcb3, 0xcae, 0xcaf, 0xcab, 0xcbe, 0xcbf, 0xcc0,
            0xcaa, 0xca7, 0xca6, 0xca3, 0xca2, 0xc9f, 0xc9e, 0xc9b, 0xc9a, 0xc97, 0xc96, 0xc93, 0xc92, 0xc8f, 0xc8e,
            0xc8b, 0xc8a, 0xc87, 0xc86
        };

        //pet eggs
        public static int[] store3List = {
            0xccc, 0xccb, 0xcca, 0xcc9, 0xcc8, 0xcc7, 0xcc6, 0xcc5, 0xcc4
        };

        //pet food
        public static int[] store4List =
        {
            0xb25, 0xa5b, 0xb22, 0xa0c, 0xb24, 0xa30, 0xb26, 0xa55, 0xb27, 0xae1, 0xb28,
            0xa65, 0xb29, 0xa6b, 0xb2a, 0xaa8, 0xb2b, 0xaaf, 0xb2c, 0xab6, 0xb2d, 0xa46, 0xb23, 0xb20, 0xb33, 0xb32,
            0xc59, 0xc58
        };

        //abilities
        public static int[] store5List =
        {
            0xb05, 0xa96, 0xa95, 0xa94, 0xa60,
            0xafc, 0xa93, 0xa92, 0xa91, 0xa13,
            0xaf9, 0xa90, 0xa8f, 0xa8e, 0xad3,
            0x9cf, 0x9c4, 0x9c1
        };

        //armors
        public static int[] store6List =
        {
            0x226e, 0x226f, 0x227b, 0x227c, 0x227d, 0x229a, 0x229b, 0x229c, 0x229d, 0x224d, 0x226c,
            0x258f, 0x2292, 0x2293, 0x2298, 0x2321, 0x2323, 0x2317, 0x2318, 0x224f, 0x225c, 0x2319,
            0x2333, 0x2314, 0x2315, 0x2316, 0x2349, 0x234A, 0x234B, 0x234C, 0x234D, 0x234E, 0x234F,
            0x2350, 0x2351, 0x2372, 0x2373, 0x747B, 0x747C, 0x747D, 0x747E, 0x747F, 0x7480, 0x7481,
            0x7482, 0x7483, 0x7484, 0x7485, 0x7486, 0x7487, 0x7488, 0x2374, 0xcf0, 0xcf1, 0xcf8,
            0x227a, 0x515b, 0x515a
        };

        //Wands&staves&bows
        public static int[] store7List =
        {
            0xb0b, 0xa47, 0xa84, 0xa83, 0xa82, 0xaff, 0xa8a, 0xa89, 0xa88, 0xa19, 0xc50,
            0xc4f, 0xc4e, 0xc4d, 0xc4c, 0xaf6, 0xa87, 0xa86, 0xa85, 0xa07, 0xb02, 0xa8d,
            0xa8c, 0xa8b, 0xa1e, 0xb08, 0xaa2, 0xaa1, 0xaa0, 0xa9f, 0x9c8, 0x9d1, 0x9ca,
            0x9c6, 0x9cc
        };

        //Swords&daggers&samurai shit
        public static int[] store8List =
        {
            0xabf, 0xac0, 0xac1, 0xac2, 0xac3, 0xac4, 0xac5, 0xac6, 0xac7, 0xac8, 0xac9,
            0xaca, 0xacb, 0xacc, 0xacd, 0xace
        };

        // rings
        public static int[] store9List = {
            0xc6a, 0xc6b, 0xc6c, 0xc68, 0xc69, 0xcc2, 0xb11, 0xb12
            //0x2368, 0x2369, 0x236A, 0x236B, 0x236C, 0x236D, 0x236E, 0x236F
        };

        private static readonly ILog log = LogManager.GetLogger(typeof (MerchantLists));

        public static void InitMerchatLists(XmlData data)
        {
            log.Info("Loading merchant lists...");
            List<int> accessoryDyeList = new List<int>();
            List<int> clothingDyeList = new List<int>();
            List<int> accessoryClothList = new List<int>();
            List<int> clothingClothList = new List<int>();

            foreach (KeyValuePair<ushort, Item> item in data.Items.Where(_ => noShopCloths.All(i => i != _.Value.ObjectId)))
            {
                if (item.Value.Texture1 != 0 && item.Value.ObjectId.Contains("Clothing") && item.Value.Class == "Dye")
                {
                    prices.Add(item.Value.ObjectType, new Tuple<int, CurrencyType>(51, CurrencyType.Fame));
                    clothingDyeList.Add(item.Value.ObjectType);
                }

                if (item.Value.Texture2 != 0 && item.Value.ObjectId.Contains("Accessory") && item.Value.Class == "Dye")
                {
                    prices.Add(item.Value.ObjectType, new Tuple<int, CurrencyType>(51, CurrencyType.Fame));
                    accessoryDyeList.Add(item.Value.ObjectType);
                }

                if (item.Value.Texture1 != 0 && item.Value.ObjectId.Contains("Cloth") &&
                    item.Value.ObjectId.Contains("Large"))
                {
                    prices.Add(item.Value.ObjectType, new Tuple<int, CurrencyType>(160, CurrencyType.Fame));
                    clothingClothList.Add(item.Value.ObjectType);
                }

                if (item.Value.Texture2 != 0 && item.Value.ObjectId.Contains("Cloth") &&
                    item.Value.ObjectId.Contains("Small"))
                {
                    prices.Add(item.Value.ObjectType, new Tuple<int, CurrencyType>(160, CurrencyType.Fame));
                    accessoryClothList.Add(item.Value.ObjectType);
                }
            }

            ClothingDyeList = clothingDyeList.ToArray();
            ClothingClothList = clothingClothList.ToArray();
            AccessoryClothList = accessoryClothList.ToArray();
            AccessoryDyeList = accessoryDyeList.ToArray();
            log.Info("Merchat lists added.");
        }

        private static readonly string[] noShopCloths =
        {
            "Large Ivory Dragon Scale Cloth", "Small Ivory Dragon Scale Cloth",
            "Large Green Dragon Scale Cloth", "Small Green Dragon Scale Cloth",
            "Large Midnight Dragon Scale Cloth", "Small Midnight Dragon Scale Cloth",
            "Large Blue Dragon Scale Cloth", "Small Blue Dragon Scale Cloth",
            "Large Red Dragon Scale Cloth", "Small Red Dragon Scale Cloth",
            "Large Jester Argyle Cloth", "Small Jester Argyle Cloth",
            "Large Alchemist Cloth", "Small Alchemist Cloth",
            "Large Mosaic Cloth", "Small Mosaic Cloth",
            "Large Spooky Cloth", "Small Spooky Cloth",
            "Large Flame Cloth", "Small Flame Cloth",
            "Large Heavy Chainmail Cloth", "Small Heavy Chainmail Cloth",
        };
    }
}