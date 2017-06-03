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
        private _ CandyLand = () => Behav()
        .Init("Candy Gnome",
            new State(
                new DropPortalOnDeath("Candyland Portal", percent: 50, PortalDespawnTimeSec: 120),
                new Prioritize(
                    new StayBack(1.5, 55),
                    new Wander(1.4)
                    )
                ),
            new Threshold(0.18,
                new ItemLoot("Red Gumball", 0.5),
                new ItemLoot("Purple Gumball", 0.5),
                new ItemLoot("Blue Gumball", 0.5),
                new ItemLoot("Green Gumball", 0.5),
                new ItemLoot("Yellow Gumball", 0.5)
                )
            )
        .Init("Candyland Spawner",
            new State(
                new State("checkmobs",
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new EntityNotExistsTransition("Big Creampuff", 9999, "despawnbeans")
                    ),
                new State("despawnbeans",
                    new Order(9999, "Candyland Boss Spawner", "spawnbosses"),
                    new Suicide()
                    )
                )
            )
        .Init("Candyland Boss Spawner",
            new State(
                new State("idle",
                    new ConditionalEffect(ConditionEffectIndex.Invincible)
                    ),
                new State("spawnbosses",
                    new Spawn("Gigacorn", 1, 1, coolDown: 999999),
                    new Suicide()
                    )
                )
            )
        .Init("Candy Jelly Bean",
            new State(
                new State("idle",
                    new EntityNotExistsTransition("Big Creampuff", 9999, "despawn")
                    ),
                new State("despawn",
                    new Decay(0)
                    )
                )
            )
            .Init("Desire Troll",
                new State(
                    new HpLessTransition(0.15, "gimmeloot"),
                    new State(
                        new Wander(0.5),
                        new Grenade(6, 200, range: 8, coolDown: 3000),
                        new Shoot(15, 3, 5, angleOffset: 30 / 3, projectileIndex: 0, coolDown: 2100),
                        new Shoot(15, 5, 10, angleOffset: 60 / 3, projectileIndex: 2, coolDown: 1950),
                        new Shoot(15, 1, 0, angleOffset: 30 / 3, projectileIndex: 1, coolDown: 1950)
                        ),
                    new State("gimmeloot",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new Taunt(true, "It's cannot be!"),
                        new TimedTransition(4000, "ripperino")
                        ),
                    new State("ripperino",
                        new Shoot(35, projectileIndex: 1, count: 30),
                        new Suicide()
                        )
                ),
                new MostDamagers(5,
                    new OnlyOne(
                        new ItemLoot("Royal Fairy Plate", superbag),
                        new ItemLoot("Ancient Pixie-Enchanted Sword", blackbag),
                        new ItemLoot("Ancient Fairy Plate", blackbag),
                        new ItemLoot("Candy-Coated Armor", whitebag)
                        ),
                    new ItemLoot("Candy Ring", awesomeloot),
                    new ItemLoot("Fairy Plate", awesomeloot),
                    new ItemLoot("Pixie-Enchanted Sword", awesomeloot),
                    new ItemLoot("Seal of the Enchanted Forest", awesomeloot),
                    new ItemLoot("Ring of Pure Wishes", awesomeloot),
                    new ItemLoot("Peppermint Snail Egg", eggbag + normalloot),
                    new ItemLoot("Wine Cellar Incantation", winecellar),
                    new TierLoot(6, ItemType.Weapon, poorloot),
                    new TierLoot(7, ItemType.Weapon, mediumloot),
                    new TierLoot(7, ItemType.Armor, mediumloot),
                    new TierLoot(8, ItemType.Armor, mediumloot),
                    new TierLoot(3, ItemType.Ring, mediumloot),
                    new TierLoot(4, ItemType.Ring, normalloot),
                    new TierLoot(3, ItemType.Ability, mediumloot),
                    new TierLoot(4, ItemType.Ability, normalloot),
                    new ItemLoot("The Sun Tarot Card", awesomeloot),
                    new ItemLoot("Yellow Gumball", 0.3),
                    new ItemLoot("Green Gumball", 0.3),
                    new ItemLoot("Blue Gumball", 0.3),
                    new ItemLoot("Red Gumball", 0.3),
                    new ItemLoot("Blue Gumball", 0.3)
                    )
            )
            .Init("Gigacorn",
                new State(
                    new TransformOnDeath("Desire Troll", 1, 1, 1, true),
                    //new DropPortalOnDeath("Desire Troll", percent: 35, dropDelaySec: 10, XAdjustment: 0, YAdjustment: 0, PortalDespawnTimeSec: 999999),
                    new HpLessTransition(0.15, "gimmeloot"),
                    new State(
                        new Wander(0.5),
                        new Charge(2.0, 10f, 4000),
                        new Shoot(20, 1, 40, angleOffset: 60 / 3, projectileIndex: 0, coolDown: 2100),
                        new Shoot(20, 1, 40, angleOffset: 60 / 3, projectileIndex: 0, coolDown: 2200),
                        new Shoot(20, 1, 40, angleOffset: 60 / 3, projectileIndex: 0, coolDown: 2300),
                        new Shoot(20, 1, 40, angleOffset: 60 / 3, projectileIndex: 0, coolDown: 2400),
                        new Shoot(20, 3, 15, angleOffset: 40 / 3, projectileIndex: 1, coolDown: 4000),
                        new Shoot(20, 3, 15, angleOffset: 20 / 3, projectileIndex: 1, coolDown: 2000)
                        ),
                    new State("gimmeloot",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new Taunt(true, "No waaaaaaaaay! Good luck if you can spawn Desire Troll, it can spawn before my death..."),
                        new TimedTransition(4000, "ripperino")
                        ),
                    new State("ripperino",
                        new Shoot(35, projectileIndex: 1, count: 30),
                        new Suicide()
                        )
                ),
                new MostDamagers(5,
                    new ItemLoot("Potion of Wisdom", 0.25),
                    new ItemLoot("Potion of Attack", 0.25)
                    ),
                new MostDamagers(5,
                    new OnlyOne(
                        new ItemLoot("Royal Fairy Plate", superbag),
                        new ItemLoot("Ancient Pixie-Enchanted Sword", blackbag),
                        new ItemLoot("Ancient Fairy Plate", blackbag),
                        new ItemLoot("Candy-Coated Armor", whitebag)
                        ),
                    new ItemLoot("Candy Ring", awesomeloot),
                    new ItemLoot("Fairy Plate", awesomeloot),
                    new ItemLoot("Pixie-Enchanted Sword", awesomeloot),
                    new ItemLoot("Seal of the Enchanted Forest", awesomeloot),
                    new ItemLoot("Ring of Pure Wishes", awesomeloot),
                    new ItemLoot("Peppermint Snail Egg", eggbag + normalloot),
                    new ItemLoot("Wine Cellar Incantation", winecellar),
                    new TierLoot(6, ItemType.Weapon, poorloot),
                    new TierLoot(7, ItemType.Weapon, mediumloot),
                    new TierLoot(7, ItemType.Armor, mediumloot),
                    new TierLoot(8, ItemType.Armor, mediumloot),
                    new TierLoot(3, ItemType.Ring, mediumloot),
                    new TierLoot(4, ItemType.Ring, normalloot),
                    new TierLoot(3, ItemType.Ability, mediumloot),
                    new TierLoot(4, ItemType.Ability, normalloot),
                    new ItemLoot("The Sun Tarot Card", awesomeloot),
                    new ItemLoot("Yellow Gumball", 0.3),
                    new ItemLoot("Green Gumball", 0.3),
                    new ItemLoot("Blue Gumball", 0.3),
                    new ItemLoot("Red Gumball", 0.3),
                    new ItemLoot("Blue Gumball", 0.3)
                    )
            
        /*
        All Candyland Bosses (Prod Loot):
        -- init white bag loot
        - candy-coated loot
        -- end white bag loot

        -- init pot loot
        - att (megarototo/gigacorn/spoiled creampuff)
        - wis (megarototo/gigacorn/swoll fairy)
        - def (swoll fairy/spoiled creampuff)
        -- end pot loot

        -- init pet bag
        - peppermint snail egg
        -- end pet bag

        -- init treasure loot
        - wine cellar incantation
        - the sun tarot card (gigacorn)
        -- end treasure loot

        -- init normal loot
        - ring of pure wishes
        - fairy plate
        - seal of the enchanted forest
        - pixie-enchanted sword
        - candy ring
        - t4 ability
        - t4 ring
        - t3 ability
        - t3 ring
        - t8 armor
        - t7 armor
        - t7 weapon
        - t6 weapon
        -- end normal loot

        -- init additional loot
        - red gumball
        - purple gumball
        - blue gumball
        - green gumball
        - yelow gumball
        -- end additional loot
        */
            )
            .Init("Spoiled Creampuff",
                new State(
                    new Shoot(20, 2, 40, angleOffset: 60 / 3, projectileIndex: 0, coolDown: 1500),
                    new Shoot(20, 4, 15, angleOffset: 40 / 3, projectileIndex: 1, coolDown: 1000),
                    new Spawn("Big Creampuff", maxChildren: 2, initialSpawn: 2, coolDown: 5000)
                ),
                new TierLoot(6, ItemType.Weapon, 0.04),
                new TierLoot(7, ItemType.Weapon, 0.02),
                new TierLoot(8, ItemType.Weapon, 0.01),
                new TierLoot(7, ItemType.Armor, 0.04),
                new TierLoot(8, ItemType.Armor, 0.02),
                new TierLoot(9, ItemType.Armor, 0.01),
                new TierLoot(3, ItemType.Ring, 0.015),
                new TierLoot(4, ItemType.Ring, 0.005),
                new Threshold(0.18,
                    new ItemLoot("Potion of Defense", 0.02),
                    new ItemLoot("Potion of Attack", 0.02),
                    new ItemLoot("Yellow Gumball", 0.3),
                    new ItemLoot("Green Gumball", 0.3),
                    new ItemLoot("Blue Gumball", 0.3),
                    new ItemLoot("Red Gumball", 0.3),
                    new ItemLoot("Blue Gumball", 0.3),
                    new ItemLoot("Fairy Plate", 0.009),
                    new ItemLoot("Pixie-Enchanted Sword", 0.009),
                    new ItemLoot("Seal of the Enchanted Forest", 0.009),
                    new ItemLoot("Candy-Coated Armor", 0.01),
                    new ItemLoot("Ring of Pure Wishes", 0.009),
                    new ItemLoot("Potion of Defense", 0.005)
                )
            )
            .Init("Big Creampuff",
                new State(
                    new Follow(0.5, range: 12),
                    new Charge(2, 7, coolDown: 7000),
                    new Shoot(20, 1, 0, angleOffset: 40 / 3, projectileIndex: 0, coolDown: 1000),
                    new Spawn("Small Creampuff", maxChildren: 2, initialSpawn: 0.5, coolDown: 5000)
                )
            )
            .Init("Small Creampuff",
                new State(
                    new Follow(1, range: 6),
                    new Charge(2, 9, coolDown: 7000),
                    new Shoot(20, 3, 30, angleOffset: 40 / 3, projectileIndex: 1, coolDown: 1400)
                )
            );
    }
}
