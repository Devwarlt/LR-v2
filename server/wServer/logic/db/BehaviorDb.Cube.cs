using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using wServer.realm;
using wServer.logic.behaviors;
using wServer.logic.loot;
using wServer.logic.transitions;

namespace wServer.logic
{
    partial class BehaviorDb
    {
        _ CubeGod = () => Behav()
            .Init("Cube God",
                new State(
                    new DropPortalOnDeath("The Ether", percent: 65, dropDelaySec: 2, XAdjustment: 0, YAdjustment: 2, PortalDespawnTimeSec: 70),
                    new StayCloseToSpawn(0.3, range: 7),
                           new Wander(0.5),
                             new Shoot(10, count: 9, predictive: 1, shootAngle: 6.5, coolDown: 250),
                             new Spawn("Cube Overseer", maxChildren: 3, initialSpawn: 1, coolDown: 100000),
                             new Spawn("Cube Defender", maxChildren: 3, initialSpawn: 2, coolDown: 100000),
                             new Spawn("Cube Blaster", maxChildren: 3, initialSpawn: 3, coolDown: 100000)
                ),
                 new MostDamagers(5,
                    LootTemplates.StatIncreasePotionsLoot()
                     ),
                 new MostDamagers(3,
                     new OnlyOne(
                        new ItemLoot("Dirk of Cronus", whitebag),
                        new ItemLoot("Ancient Dirk of Cronus", blackbag)
                         ),
                    new EggLoot(EggRarity.Common, eggbag + goodloot),
                    new EggLoot(EggRarity.Uncommon, eggbag + greatloot),
                    new EggLoot(EggRarity.Rare, eggbag + awesomeloot),
                    new EggLoot(EggRarity.Legendary, eggbag),
                    new TierLoot(3, ItemType.Ring, mediumloot),
                    new TierLoot(4, ItemType.Ring, normalloot),
                    new TierLoot(5, ItemType.Ring, goodloot),
                    new TierLoot(4, ItemType.Ability, normalloot),
                    new TierLoot(5, ItemType.Ability, goodloot),
                    new TierLoot(7, ItemType.Armor, poorloot),
                    new TierLoot(8, ItemType.Weapon, mediumloot),
                    new TierLoot(8, ItemType.Armor, mediumloot),
                    new TierLoot(9, ItemType.Armor, mediumloot),
                    new TierLoot(9, ItemType.Weapon, normalloot),
                    new TierLoot(10, ItemType.Armor, normalloot),
                    new TierLoot(10, ItemType.Weapon, goodloot),
                    new TierLoot(11, ItemType.Armor, goodloot),
                    new TierLoot(11, ItemType.Weapon, goodloot)
                )
            /*
            Cube God (Prod Loot):
            -- init white bag loot
            - dirk of cronus
            -- end white bag loot

            -- init pet bag
            - common
            - uncommon
            - rare
            - legendary
            -- end pet bag

            -- init pot bag
            - att
            - def
            - spd
            - dex
            - vit
            - wis
            -- end pot bag

            -- init normal loot
            - t12 armor
            - t5 ability
            - t5 ring
            - t11 weapon
            - t11 armor
            - t10 armor
            - t10 weapon
            - t4 ring
            - t4 ability
            - t9 armor
            - t9 weapon
            - t8 weapon
            - t8 armor
            - t3 ring
            -- end normal loot

            */
            )
            .Init("Cube Overseer",
                new State(
                    new Orbit(0.25, 7, target: "Cube God"),
                    new Protect(1, "Cube God", protectionRange: 8, acquireRange: 10, reprotectRange: 8),
                    new Shoot(10, count: 4, shootAngle: 10, predictive: 0.9, projectileIndex: 0, coolDown: 500)
                )
            )
            .Init("Cube Defender",
                new State(
                    new AntiOrbit(1, 3, target: "Cube Overseer"),
                    new StayCloseToSpawn(0.5, range: 29),
                    new Protect(1.5, "Cube God", protectionRange: 16, acquireRange: 20, reprotectRange: 16),
                    new Follow(1, acquireRange: 12, range: 8),
                    new Shoot(10, count: 2, shootAngle: 10, coolDown: 1000, predictive: 1, projectileIndex: 0)
                )
            )
            .Init("Cube Blaster",
                new State(
                    new Orbit(2, 4, target: "Cube Defender"),
                    new StayCloseToSpawn(0.5, range: 29),
                    new Protect(1.5, "Cube God", protectionRange: 20, acquireRange: 24, reprotectRange: 20),
                    new Follow(1.5, acquireRange: 14, range: 10),
                    new Shoot(10, count: 2, shootAngle: 10, predictive: 1, projectileIndex: 0, coolDown: 1500),
                    new Shoot(10, count: 1, predictive: 0.9, projectileIndex: 0, coolDown: 1000)
                )
            );
    }
}
