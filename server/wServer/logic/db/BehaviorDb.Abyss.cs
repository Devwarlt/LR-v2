using wServer.logic.behaviors;
using wServer.logic.transitions;
using wServer.logic.loot;

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ Abyss = () => Behav()
            .Init("Archdemon Malphas",
                new State(
                    new OnDeathBehavior(new ApplySetpiece("AbyssDeath")),
                    new State("default",
                        new PlayerWithinTransition(8, "basic")
                        ),
                    new State("basic",
                        new Prioritize(
                            new Follow(0.3),
                            new Wander(0.2)
                            ),
                        new Reproduce("Malphas Missile", densityMax: 1, spawnRadius: 1, coolDown: 1000),
                        new Shoot(10, predictive: 1, coolDown: 800),
                        new TimedTransition(10000, "shrink")
                        ),
                    new State("shrink",
                        new Wander(0.4),
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new ChangeSize(-15, 25),
                        new TimedTransition(1000, "smallAttack")
                        ),
                    new State("smallAttack",
                        new Prioritize(
                            new Follow(1, acquireRange: 15, range: 8),
                            new Wander(1)
                            ),
                        new Shoot(10, predictive: 1, coolDown: 750),
                        new Shoot(10, 6, projectileIndex: 1, predictive: 1, coolDown: 1000),
                        new TimedTransition(10000, "grow")
                        ),
                    new State("grow",
                        new Wander(0.1),
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new ChangeSize(35, 200),
                        new TimedTransition(1050, "bigAttack")
                        ),
                    new State("bigAttack",
                        new Prioritize(
                            new Follow(0.2),
                            new Wander(0.1)
                            ),
                        new Shoot(10, projectileIndex: 2, predictive: 1, coolDown: 2000),
                        new Shoot(10, projectileIndex: 2, predictive: 1, coolDownOffset: 300, coolDown: 2000),
                        new Shoot(10, 3, projectileIndex: 3, predictive: 1, coolDownOffset: 100, coolDown: 2000),
                        new Shoot(10, 3, projectileIndex: 3, predictive: 1, coolDownOffset: 400, coolDown: 2000),
                        new TimedTransition(10000, "normalize")
                        ),
                    new State("normalize",
                        new Wander(0.3),
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new ChangeSize(-20, 100),
                        new TimedTransition(1000, "basic")
                        )
                    ),
                //LootTemplates.DefaultEggLoot(EggRarity.Legendary),
                new MostDamagers(5,
                    new ItemLoot("Potion of Vitality", 1)
                ),
                new MostDamagers(3,
                    new OnlyOne(
                        new ItemLoot("Ancient Sword of Illumination", blackbag),
                        new ItemLoot("The Rusher Skin", blackbag),
                        new ItemLoot("Arch-demon Blade", blackbag)
                        ),
                    new ItemLoot("Sword of Illumination", whitebag),
                    new ItemLoot("Potion of Defense", 1),
                    new ItemLoot("Demon Blade", whitebag),
                    new ItemLoot("Demon Frog Egg", eggbag + mediumloot),
                    new ItemLoot("Wine Cellar Incantation", winecellar),
                    new ItemLoot("Golden Ribcage", awesomeloot),
                    new ItemLoot("Golden Femur", awesomeloot),
                    new ItemLoot("Golden Skull", awesomeloot),
                    new TierLoot(10, ItemType.Armor, normalloot),
                    new TierLoot(10, ItemType.Weapon, goodloot),
                    new TierLoot(4, ItemType.Ring, normalloot),
                    new TierLoot(4, ItemType.Ability, normalloot),
                    new TierLoot(3, ItemType.Ring, mediumloot),
                    new TierLoot(3, ItemType.Ability, mediumloot),
                    new TierLoot(9, ItemType.Armor, mediumloot),
                    new TierLoot(9, ItemType.Weapon, normalloot),
                    new TierLoot(7, ItemType.Armor, poorloot),
                    new TierLoot(7, ItemType.Weapon, mediumloot),
                    new TierLoot(6, ItemType.Armor, poorloot)
                )
            /*
            Archdemon Malphas (Prod Loot):
            -- init white bag loot
            - demon blade
            - sword of illumination
            -- end white bag loot

            -- init pot loot
            - vit
            - def
            -- end pot loot

            -- init pet bag
            - demon frog egg
            -- end pet bag

            -- init treasure loot
            - wine cellar incantation
            - golden ribcage
            - golden femur
            - golden skull
            -- end treasure loot

            -- init normal loot
            - t10 armor
            - t10 weapon
            - t9 armor
            - t9 weapon
            - t4 ring
            - t3 ring
            - t4 ability
            - t3 ability
            - t7 armor
            - t7 weapon
            - t6 weapon
            -- end normal loot
            */
            )
        
            .Init("Abyss Idol",
                new State(
                    //new OnDeathBehavior(new ApplySetpiece("AbyssDeath")),
                    new State("default",
                        new PlayerWithinTransition(8, "basic")
                        ),
                    new State("basic",
                        new Reproduce("Brute of the Abyss", densityMax: 1, spawnRadius: 1, coolDown: 500),
                        new Shoot(10, predictive: 1, coolDown: 400),
                        new TimedTransition(10000, "shrink")
                        ),
                    new State("shrink",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(1000, "smallAttack")
                        ),
                    new State("smallAttack",
                        new Shoot(10, predictive: 1, coolDown: 325),
                        new Shoot(10, 6, projectileIndex: 1, predictive: 1, coolDown: 500),
                        new TimedTransition(10000, "grow")
                        ),
                    new State("grow",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(1050, "bigAttack")
                        ),
                    new State("bigAttack",
                        new Shoot(10, projectileIndex: 2, predictive: 1, coolDown: 1000),
                        new Shoot(10, projectileIndex: 2, predictive: 1, coolDownOffset: 300, coolDown: 1000),
                        new Shoot(10, 3, projectileIndex: 3, predictive: 1, coolDownOffset: 100, coolDown: 1000),
                        new Shoot(10, 3, projectileIndex: 3, predictive: 1, coolDownOffset: 400, coolDown: 1000),
                        new TimedTransition(10000, "normalize")
                        ),
                    new State("normalize",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(1000, "basic")
                        )
                    ),
                //LootTemplates.DefaultEggLoot(EggRarity.Legendary),
                new MostDamagers(5,
                    new ItemLoot("Potion of Vitality", 1)
                ),
                new MostDamagers(3,
                    new OnlyOne(
                        new ItemLoot("Ancient Sword of Illumination", blackbag),
                        new ItemLoot("The Rusher Skin", blackbag),
                        new ItemLoot("Arch-demon Blade", blackbag)
                        ),
                    new ItemLoot("Sword of Illumination", whitebag),
                    new ItemLoot("Potion of Defense", 1),
                    new ItemLoot("Demon Blade", whitebag),
                    new ItemLoot("Demon Frog Egg", eggbag + mediumloot),
                    new ItemLoot("Wine Cellar Incantation", winecellar),
                    new ItemLoot("Golden Ribcage", awesomeloot),
                    new ItemLoot("Golden Femur", awesomeloot),
                    new ItemLoot("Golden Skull", awesomeloot),
                    new TierLoot(10, ItemType.Armor, normalloot),
                    new TierLoot(10, ItemType.Weapon, goodloot),
                    new TierLoot(4, ItemType.Ring, normalloot),
                    new TierLoot(4, ItemType.Ability, normalloot),
                    new TierLoot(3, ItemType.Ring, mediumloot),
                    new TierLoot(3, ItemType.Ability, mediumloot),
                    new TierLoot(9, ItemType.Armor, mediumloot),
                    new TierLoot(9, ItemType.Weapon, normalloot),
                    new TierLoot(7, ItemType.Armor, poorloot),
                    new TierLoot(7, ItemType.Weapon, mediumloot),
                    new TierLoot(6, ItemType.Armor, poorloot)
                )
            /*
            Archdemon Malphas (Prod Loot):
            -- init white bag loot
            - demon blade
            - sword of illumination
            -- end white bag loot

            -- init pot loot
            - vit
            - def
            -- end pot loot

            -- init pet bag
            - demon frog egg
            -- end pet bag

            -- init treasure loot
            - wine cellar incantation
            - golden ribcage
            - golden femur
            - golden skull
            -- end treasure loot

            -- init normal loot
            - t10 armor
            - t10 weapon
            - t9 armor
            - t9 weapon
            - t4 ring
            - t3 ring
            - t4 ability
            - t3 ability
            - t7 armor
            - t7 weapon
            - t6 weapon
            -- end normal loot
            */
            )
            .Init("Malphas Missile",
                new State(
                    new State(
                        new Prioritize(
                            new Follow(0.4, range: 4),
                            new Wander(0.5)
                        ),
                        new HpLessTransition(0.5, "die"),
                        new TimedTransition(2000, "die")
                    ),
                    new State("die",
                        new Flash(0xFFFFFF, 0.2, 5),
                        new TimedTransition(1000, "explode")
                        ),
                    new State("explode",
                        new Shoot(10, 8),
                        new Decay(100)
                        )
                    )
            )
            .Init("Imp of the Abyss",
                new State(
                    new Wander(0.875),
                    new Shoot(8, 5, 10, coolDown: 1000)
                    ),
                new ItemLoot("Health Potion", 0.1),
                new ItemLoot("Magic Potion", 0.1),
                new Threshold(0.5,
                    new ItemLoot("Cloak of the Red Agent", 0.01),
                    new ItemLoot("Felwasp Toxin", 0.01)
                    )
            )
            .Init("Demon of the Abyss",
                new State(
                    new Prioritize(
                        new Follow(1, 8, 5),
                        new Wander(0.25)
                        ),
                    new Shoot(8, 3, shootAngle: 10, coolDown: 1000)
                    ),
                new ItemLoot("Fire Bow", 0.05),
                new Threshold(0.5,
                    new ItemLoot("Mithril Armor", 0.01)
                    )
            )
            .Init("Demon Warrior of the Abyss",
                new State(
                    new Prioritize(
                        new Follow(1, 8, 5),
                        new Wander(0.25)
                        ),
                    new Shoot(8, 3, shootAngle: 10, coolDown: 1000)
                    ),
                new ItemLoot("Fire Sword", 0.025),
                new ItemLoot("Steel Shield", 0.025)
            )
            .Init("Demon Mage of the Abyss",
                new State(
                    new Prioritize(
                        new Follow(1, 8, 5),
                        new Wander(0.25)
                        ),
                    new Shoot(8, 3, shootAngle: 10, coolDown: 1000)
                    ),
                new ItemLoot("Fire Nova Spell", 0.02),
                new Threshold(0.1,
                    new ItemLoot("Wand of Dark Magic", 0.01),
                    new ItemLoot("Avenger Staff", 0.01),
                    new ItemLoot("Robe of the Invoker", 0.01),
                    new ItemLoot("Essence Tap Skull", 0.01),
                    new ItemLoot("Demonhunter Trap", 0.01)
                    )
            )
            .Init("Brute of the Abyss",
                new State(
                    new Prioritize(
                        new Follow(1.5, 8, 1),
                        new Wander(0.25)
                        ),
                    new Shoot(8, 3, shootAngle: 10, coolDown: 500)
                    ),
                new ItemLoot("Health Potion", 0.1),
                new Threshold(0.1,
                    new ItemLoot("Obsidian Dagger", 0.02),
                    new ItemLoot("Steel Helm", 0.02)
                    )
            )
            .Init("Brute Warrior of the Abyss",
                new State(
                    new Prioritize(
                        new Follow(1, 8, 1),
                        new Wander(0.25)
                        ),
                    new Shoot(8, 3, shootAngle: 10, coolDown: 500)
                    ),
                new ItemLoot("Spirit Salve Tome", 0.02),
                new Threshold(0.5,
                    new ItemLoot("Glass Sword", 0.01),
                    new ItemLoot("Ring of Greater Dexterity", 0.01),
                    new ItemLoot("Magesteel Quiver", 0.01)
                    )
            )
            ;
    }
}