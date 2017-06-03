using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using wServer.realm;
using wServer.logic.loot;
using wServer.logic.behaviors;
using wServer.logic.transitions;

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ Pentaract = () => Behav()
            .Init("Pentaract",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("Entry",
                        new PentaractStar(1000),
                        new EntitiesNotExistsTransition(50, "Suicide", "Pentaract Tower"),
                        new State("EntryTimer",
                            new TimedTransition(15000, "RespawnTowers")
                        ),
                        new State("RespawnTowers",
                            new Order(50, "Pentaract Tower Corpse", "Respawn"),
                            new TimedTransition(0, "EntryTimer")
                        )
                    ),
                    new State("Suicide",
                        new Suicide()
                    )
                )
            )
            .Init("Pentaract Tower",
                new State(
                    new Spawn("Pentaract Eye", 2, 1, coolDown: 15000000),
                    new Grenade(4, 100, 8, coolDown: 250),
                    new TransformOnDeath("Pentaract Tower Corpse"),
                    new CopyDamageOnDeath("Pentaract Tower Corpse", 2)
                )
            )
            .Init("Pentaract Eye",
                new State(
                    new Swirl(2, 8, targeted: false),
                    new Shoot(10, coolDown: 50)
                )
            )
            .Init("Pentaract Tower Corpse",
                new State(
                    new State("Entry",
                        new ConditionalEffect(ConditionEffectIndex.Invincible, true),
                        new EntitiesNotExistsTransition(50, "Suicide", "Pentaract")
                    ),
                    new State("Respawn",
                        new Transform("Pentaract Tower")
                    ),
                    new State("Suicide",
                        new Suicide()
                    )
                ),
                new MostDamagers(5,
                    LootTemplates.StatIncreasePotionsLoot()
                ),
                new MostDamagers(3,
                    new OnlyOne(
                        new ItemLoot("Ancient Seal of Blasphemous Prayer", blackbag),
                        new ItemLoot("Seal of Blasphemous Prayer", whitebag)
                        ),
                    new EggLoot(EggRarity.Common, eggbag + goodloot),
                    new EggLoot(EggRarity.Uncommon, eggbag + greatloot),
                    new EggLoot(EggRarity.Rare, eggbag + awesomeloot),
                    new EggLoot(EggRarity.Legendary, eggbag),
                    new TierLoot(8, ItemType.Armor, mediumloot),
                    new TierLoot(9, ItemType.Armor, mediumloot),
                    new TierLoot(10, ItemType.Armor, normalloot),
                    new TierLoot(11, ItemType.Armor, normalloot),
                    new TierLoot(12, ItemType.Armor, goodloot),
                    new TierLoot(8, ItemType.Weapon, mediumloot),
                    new TierLoot(9, ItemType.Weapon, normalloot),
                    new TierLoot(10, ItemType.Weapon, goodloot),
                    new TierLoot(11, ItemType.Weapon, goodloot),
                    new TierLoot(4, ItemType.Ability, normalloot),
                    new TierLoot(5, ItemType.Ability, goodloot),
                    new TierLoot(3, ItemType.Ring, mediumloot),
                    new TierLoot(4, ItemType.Ring, normalloot),
                    new TierLoot(5, ItemType.Ring, goodloot)
                )
            );
    }
}
