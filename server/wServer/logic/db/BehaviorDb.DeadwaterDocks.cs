using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using wServer.logic.behaviors;
using wServer.logic.transitions;
using wServer.logic.loot;

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ DeadwaterDocks = () => Behav()
              .Init("Deadwater Docks Parrot",
                  new State(
                    //SpawnParrots        
                    new Prioritize(
                        new Shoot(8, 1, 10, projectileIndex: 0, coolDown: 3500),
                        new Orbit(0.55, 2, 5, "Parrot Cage"),
                        new Wander(0.12)
                        ),
                    //new EntityNotExistsTransition("Jon Bilgewater the Pirate King", 90000, "rip"),
                    new State("CircleOrWander",
                        new Order(99, "Parrot Cage", "SpawnParrots"),
                        new TimedTransition(8000, "Orbit&HealJon")
                        ),
                    new State("Orbit&HealJon",
                        new SpecificHeal(2, 1000, "JonBilgewater", coolDown: 2850),
                        new TimedTransition(10000, "CircleOrWander")
                    ),
                    new State("rip",
                        new Suicide()
                    )
                 ),
                  new MostDamagers(1,
                    new TierLoot(11, ItemType.Weapon, blackbag),
                    new TierLoot(10, ItemType.Weapon, whitebag)
                        )
            /*
            Deadwater Docks Parrot (Prod Loot):
            -- init pot bag
            - dex
            -- end pot bag

            -- init normal loot
            - t11 weapon
            - t10 weapon
            - t9 weapon
            -- end normal loot
            */
              )

        .Init("md1 Loot Balloon Shaitan",
                new State(
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect")
                ),
                new MostDamagers(5,
                    LootTemplates.StatIncreasePotionsLoot()
                    ),
                new MostDamagers(3,
                    new OnlyOne(
                            new ItemLoot("Pirate King's Cutlass", whitebag)
                        ),
                    new EggLoot(EggRarity.Common, eggbag + goodloot),
                    new EggLoot(EggRarity.Uncommon, eggbag + greatloot),
                    new EggLoot(EggRarity.Rare, eggbag + awesomeloot),
                    new EggLoot(EggRarity.Legendary, eggbag),
                    new ItemLoot("Wine Cellar Incantation", winecellar),
                    new TierLoot(12, ItemType.Weapon, greatloot),
                    new TierLoot(9, ItemType.Weapon, normalloot),
                    new TierLoot(8, ItemType.Weapon, mediumloot),
                    new TierLoot(13, ItemType.Armor, greatloot),
                    new TierLoot(12, ItemType.Armor, goodloot),
                    new TierLoot(11, ItemType.Armor, normalloot),
                    new TierLoot(10, ItemType.Armor, normalloot),
                    new TierLoot(8, ItemType.Armor, mediumloot),
                    new TierLoot(4, ItemType.Ability, normalloot)
                    )
            )
              .Init("Parrot Cage",
                  new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("NoSpawn",
                        //new Flash(0xfFF0000, flashRepeats: 100, flashPeriod: 0.1)
                        new Flash(0xFFFFFF, 0.2, 5)
                        ),
                    new State("SpawnParrots",
                        new EntityNotExistsTransition("Deadwater Docks Parrot", 99, "spawn"),
                        new EntityExistsTransition("Deadwater Docks Parrot", 99, "NoSpawn")
                    ),
                    new State("spawn",
                        new Spawn("Deadwater Docks Parrot", 5, 1, 9999999)
                        )
                 )
              )
             .Init("Bottled Evil Water",
                 new State(
                    new State("water",
                    //new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new TimedTransition(2000, "drop")
                        ),
                    new State("drop",
                       new ApplySetpiece("BottledEvil"),
                       new TransformOnDeath("Deadwater Docks Parrot")
                       //new Suicide()
                    )))
          .Init("Deadwater Docks Lieutenant",
                new State(
                    new Follow(1, 8, 1),
                    new Shoot(8, 1, 10, coolDown: 1000),
                    new TossObject("Bottled Evil Water", angle: null, coolDown: 6750)
                    ),
                new ItemLoot("Health Potion", 0.1),
                new ItemLoot("Magic Potion", 0.1)
            )
          .Init("Deadwater Docks Veteran",
                new State(
                    new Follow(0.8, 8, 1),
                    new Shoot(8, 1, 10, coolDown: 500)
                    ),
                new TierLoot(10, ItemType.Weapon, 0.05),
                new ItemLoot("Health Potion", 0.1),
                new ItemLoot("Magic Potion", 0.1)
            )
          .Init("Deadwater Docks Admiral",
                new State(
                    new Follow(0.6, 8, 1),
                    new Shoot(8, 3, 10, coolDown: 1325)
                    ),
                new ItemLoot("Health Potion", 0.1),
                new ItemLoot("Magic Potion", 0.1)
            )
          .Init("Deadwater Docks Brawler",
                new State(
                    new Follow(1.12, 8, 1),
                    new Shoot(8, 1, 10, coolDown: 350)
                    ),
                new ItemLoot("Health Potion", 0.1),
                new ItemLoot("Magic Potion", 0.1)
            )
          .Init("Deadwater Docks Sailor",
                new State(
                    new Follow(0.9, 8, 1),
                    new Shoot(8, 1, 10, coolDown: 525)
                    ),
                new ItemLoot("Health Potion", 0.1),
                new ItemLoot("Magic Potion", 0.1)
            )
          .Init("Deadwater Docks Commander",
                new State(
                    new Follow(0.90, 8, 1),
                    new Shoot(8, 1, 10, coolDown: 900),
                    new TossObject("Bottled Evil Water", angle: null, coolDown: 8750)
                    ),
                new ItemLoot("Health Potion", 0.1),
                new ItemLoot("Magic Potion", 0.1)
            )
          .Init("Deadwater Docks Captain",
                new State(
                    new Follow(0.47, 8, 1),
                    new Shoot(8, 1, 10, coolDown: 3500)
                    ),
                new ItemLoot("Health Potion", 0.1),
                new ItemLoot("Magic Potion", 0.1)
            )

          .Init("Jon Bilgewater the Pirate King",
                new State(
                    new TransformOnDeath("md1 Loot Balloon Shaitan", 1, 1, 1),
                    new RealmPortalDrop(),
                    new State("default",
                        new PlayerWithinTransition(8, "coinphase")
                        ),
                  new State(
                    new HpLessTransition(0.25, "vaidormir"),
                    new DamageTakenTransition(32500, "gotoSpawn"),
                    new State("coinphase",
                        new Order(90, "Parrot Cage", "SpawnParrots"),
                        new Wander(0.11),
                        new Shoot(10, count: 1, projectileIndex: 0, coolDown: 1000),
                        new TimedTransition(4500, "cannonballs")
                        ),
                    new State("cannonballs",
                        new Follow(0.32, 8, coolDown: 1000),
                        new Shoot(10, count: 7, shootAngle: 30, projectileIndex: 1, coolDown: 1150),
                        new TimedTransition(5000, "coinphase")
                        ),
                    new State("gotoSpawn",
                        new ReturnToSpawn(once: false, speed: 1),
                        new ConditionalEffect(ConditionEffectIndex.StunImmune),
                        //new Spawn("Deadwater Docks Parrot", 5, 1, 2500),
                        new TimedTransition(3500, "blastcannonballs")
                        ),
                    new State("blastcannonballs",
                        new ConditionalEffect(ConditionEffectIndex.StunImmune),
                        new Order(90, "Deadwater Docks Parrot", "CircleOrWander"),
                        new Charge(4, 10, 4000),
                        new Spawn("Deadwater Docks Parrot", 1, 1, 4000),
                        new Shoot(10, count: 7, shootAngle: 30, projectileIndex: 1, coolDown: 750),
                        new TimedTransition(6000, "parrotcircle")
                        ),
                    new State("parrotcircle",
                        new ConditionalEffect(ConditionEffectIndex.StunImmune),
                        new Order(90, "Deadwater Docks Parrot", "Orbit&HealJon"),
                        new TimedTransition(6000, "blastcannonballs")
                        ),
                    new State("vaidormir",
                        new CopyDamageOnDeath("md1 Loot Balloon Shaitan"),
                        new Taunt("IMPOSSIBLE! I can't protect my treasure anymore..."),
                        new TimedTransition(5000, "doemeu")
                        ),
                    new State("doemeu",
                        new Shoot(35, projectileIndex: 1, count: 30),
                        new Suicide()
                        )
                      )
                    )
                )
        /*
        Jon Bilgewater the Pirate King (Prod Loot):
        -- init white bag loot
        - pirate king's cutlass
        -- end white bag loot

        -- init pet bag
        - common
        - uncommon
        - rare
        - legendary
        -- end pet bag

        -- init treasure bag
        - wine cellar incantation
        -- end treasure bag

        -- init normal loot
        - t13 armor
        - t12 weapon
        - t12 armor
        - t11 armor
        - t10 armor
        - t4 ability
        - t9 weapon
        - t8 armor
        - t8 weapon
        -- end normal loot
        */
            ;
    }
}
