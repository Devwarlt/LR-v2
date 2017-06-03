//#region

//using wServer.logic.behaviors;
//using wServer.logic.loot;
//using wServer.logic.transitions;

//#endregion

//namespace wServer.logic
//{
//    partial class BehaviorDb
//    {
//        private _ Elderrealm = () => Behav()
//        .Init("EWhite Demon",
//                new State(
//                    new Prioritize(
//                        new StayAbove(1, 200),
//                        new Follow(1, range: 7),
//                        new Wander(0.4)
//                        ),
//                    new Shoot(10, 3, 20, predictive: 1, coolDown: 500)
//                    ),
//                new TierLoot(6, ItemType.Weapon, 0.04),
//                new TierLoot(7, ItemType.Weapon, 0.02),
//                new TierLoot(8, ItemType.Weapon, 0.01),
//                new TierLoot(7, ItemType.Armor, 0.04),
//                new TierLoot(8, ItemType.Armor, 0.02),
//                new TierLoot(9, ItemType.Armor, 0.01),
//                new TierLoot(3, ItemType.Ring, 0.015),
//                new TierLoot(4, ItemType.Ring, 0.005),
//                new Threshold(0.18,
//                    new ItemLoot("Potion of Attack", 0.010),
//                    new EggLoot(EggRarity.Common, 0.1),
//                    new EggLoot(EggRarity.Uncommon, 0.05)
//                    )
//            )
//        .Init("Cosmo Crystal",
//                new State(
//                    new Prioritize(
//                        new StayAbove(1, 200),
//                        new Follow(1, range: 7),
//                        new Wander(0.4)
//                        ),
//                    new Shoot(12, projectileIndex: 0, count: 4, shootAngle: 10),
//                    new Shoot(12, projectileIndex: 2, count: 4, shootAngle: 10),
//                    new Grenade(4, 150, 8, coolDown: 3000),
//                    new Shoot(12, 5, 72, projectileIndex: 1, coolDown: 500),
//                    new Shoot(1, 4, coolDown: 10000, fixedAngle: 90, projectileIndex: 3, coolDownOffset: 0, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 100, projectileIndex: 3, coolDownOffset: 200, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 110, projectileIndex: 3, coolDownOffset: 400, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 120, projectileIndex: 3, coolDownOffset: 600, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 130, projectileIndex: 3, coolDownOffset: 800, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 140, projectileIndex: 3, coolDownOffset: 1000, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 150, projectileIndex: 3, coolDownOffset: 1200, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 160, projectileIndex: 3, coolDownOffset: 1400, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 170, projectileIndex: 3, coolDownOffset: 1600, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 180, projectileIndex: 3, coolDownOffset: 1800, shootAngle: 90),
//                     new Shoot(1, 8, coolDown: 10000, fixedAngle: 180, projectileIndex: 3, coolDownOffset: 2000, shootAngle: 45),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 180, projectileIndex: 3, coolDownOffset: 0, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 170, projectileIndex: 3, coolDownOffset: 200, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 160, projectileIndex: 3, coolDownOffset: 400, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 150, projectileIndex: 3, coolDownOffset: 600, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 140, projectileIndex: 3, coolDownOffset: 800, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 130, projectileIndex: 3, coolDownOffset: 1000, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 120, projectileIndex: 3, coolDownOffset: 1200, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 110, projectileIndex: 3, coolDownOffset: 1400, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 100, projectileIndex: 3, coolDownOffset: 1600, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 90, projectileIndex: 3, coolDownOffset: 1800, shootAngle: 90),
//                     new Shoot(1, 4, coolDown: 10000, fixedAngle: 90, projectileIndex: 3, coolDownOffset: 2000, shootAngle: 22.5)
//                    ),
//                new TierLoot(10, ItemType.Weapon, 0.03),
//                new TierLoot(11, ItemType.Weapon, 0.04),
//                new TierLoot(12, ItemType.Weapon, 0.05),
//                new TierLoot(10, ItemType.Armor, 0.03),
//                new TierLoot(11, ItemType.Armor, 0.04),
//                new TierLoot(12, ItemType.Armor, 0.05),
//                new TierLoot(5, ItemType.Ring, 0.015),
//                new TierLoot(6, ItemType.Ring, 0.010),
//                new Threshold(0.18,
//                    new ItemLoot("Red Velvet Tome", 0.007),
//                    new ItemLoot("Bracelet of the Cosmos", 0.009),
//                    new ItemLoot("Seal of Frozen Xmas", 0.008),
//                    new ItemLoot("Greater Potion of Attack", 0.010),
//                    new ItemLoot("Greater Potion of Defense", 0.010),
//                    new ItemLoot("Greater Potion of Dexterity", 0.010),
//                    new ItemLoot("Greater Potion of Speed", 0.010),
//                    new ItemLoot("Greater Potion of Mana", 0.6),
//                    new ItemLoot("Greater Potion of Life", 0.6),
//                    new EggLoot(EggRarity.Legendary, 0.01)
//                    )
//            )
//            .Init("ESprite God",
//                new State(
//                    new Prioritize(
//                        new StayAbove(1, 200),
//                        new Wander(0.4)
//                        ),
//                    new Shoot(12, projectileIndex: 0, count: 4, shootAngle: 10),
//                    new Shoot(10, projectileIndex: 1, predictive: 1),
//                    new Spawn("Sprite Child", maxChildren: 5)
//                    ),
//                new TierLoot(6, ItemType.Weapon, 0.04),
//                new TierLoot(7, ItemType.Weapon, 0.02),
//                new TierLoot(8, ItemType.Weapon, 0.01),
//                new TierLoot(7, ItemType.Armor, 0.04),
//                new TierLoot(8, ItemType.Armor, 0.02),
//                new TierLoot(9, ItemType.Armor, 0.01),
//                new TierLoot(4, ItemType.Ring, 0.02),
//                new TierLoot(4, ItemType.Ability, 0.02),
//                new Threshold(0.18,
//                    new ItemLoot("Potion of Attack", 0.050),
//                    new EggLoot(EggRarity.Common, 0.1),
//                    new EggLoot(EggRarity.Uncommon, 0.05)
//                    )
//            )
//            .Init("ESprite Child",
//                new State(
//                    new Prioritize(
//                        new StayAbove(1, 200),
//                        new Protect(0.4, "Sprite God", protectionRange: 1),
//                        new Wander(0.4)
//                        ),
//                    new DropPortalOnDeath("Dreamscape Portal", 1)
//                    )
//            )
//            .Init("EMedusa",
//                new State(
//                    new Prioritize(
//                        new StayAbove(1, 200),
//                        new Follow(1, range: 7),
//                        new Wander(0.4)
//                        ),
//                    new Shoot(12, 5, 10, coolDown: 1000),
//                    new Grenade(4, 150, 8, coolDown: 3000)
//                    ),
//                new TierLoot(6, ItemType.Weapon, 0.04),
//                new TierLoot(7, ItemType.Weapon, 0.02),
//                new TierLoot(8, ItemType.Weapon, 0.01),
//                new TierLoot(7, ItemType.Armor, 0.04),
//                new TierLoot(8, ItemType.Armor, 0.02),
//                new TierLoot(9, ItemType.Armor, 0.01),
//                new TierLoot(3, ItemType.Ring, 0.015),
//                new TierLoot(4, ItemType.Ring, 0.005),
//                new TierLoot(4, ItemType.Ability, 0.02),
//                new Threshold(0.18,
//                    new ItemLoot("Potion of Speed", 0.010),
//                    new EggLoot(EggRarity.Common, 0.1),
//                    new EggLoot(EggRarity.Uncommon, 0.05)
//                    )
//            )
//            .Init("EEnt God",
//                new State(
//                    new Prioritize(
//                        new StayAbove(1, 200),
//                        new Follow(1, range: 7),
//                        new Wander(0.4)
//                        ),
//                    new Shoot(12, 5, 10, predictive: 1, coolDown: 1250)

//                    ),
//                new TierLoot(6, ItemType.Weapon, 0.04),
//                new TierLoot(7, ItemType.Weapon, 0.02),
//                new TierLoot(8, ItemType.Weapon, 0.01),
//                new TierLoot(7, ItemType.Armor, 0.04),
//                new TierLoot(8, ItemType.Armor, 0.02),
//                new TierLoot(9, ItemType.Armor, 0.01),
//                new TierLoot(4, ItemType.Ability, 0.02),
//                new Threshold(0.18,
//                    new ItemLoot("Potion of Defense", 0.050),
//                    new EggLoot(EggRarity.Common, 0.1),
//                    new EggLoot(EggRarity.Uncommon, 0.05)
//                    )
//            )
//            .Init("EBeholder",
//                new State(
//                    new Prioritize(
//                        new StayAbove(1, 200),
//                        new Follow(1, range: 7),
//                        new Wander(0.4)
//                        ),
//                    new Shoot(12, projectileIndex: 0, count: 5, shootAngle: 72, predictive: 0.5, coolDown: 750),
//                    new Shoot(10, projectileIndex: 1, predictive: 1)

//                    ),
//                new TierLoot(6, ItemType.Weapon, 0.04),
//                new TierLoot(7, ItemType.Weapon, 0.02),
//                new TierLoot(8, ItemType.Weapon, 0.01),
//                new TierLoot(7, ItemType.Armor, 0.04),
//                new TierLoot(8, ItemType.Armor, 0.02),
//                new TierLoot(9, ItemType.Armor, 0.01),
//                new TierLoot(3, ItemType.Ring, 0.015),
//                new TierLoot(4, ItemType.Ring, 0.005),
//                new Threshold(0.18,
//                    new ItemLoot("Potion of Defense", 0.010),
//                    new EggLoot(EggRarity.Common, 0.1),
//                    new EggLoot(EggRarity.Uncommon, 0.05)
//                    )
//            )
//            .Init("EFlying Brain",
//                new State(
//                    new Prioritize(
//                        new StayAbove(1, 200),
//                        new Follow(1, range: 7),
//                        new Wander(0.4)
//                        ),
//                    new Shoot(12, 5, 72, coolDown: 500)
//                    ),
//                new TierLoot(6, ItemType.Weapon, 0.04),
//                new TierLoot(7, ItemType.Weapon, 0.02),
//                new TierLoot(7, ItemType.Armor, 0.04),
//                new TierLoot(8, ItemType.Armor, 0.02),
//                new TierLoot(3, ItemType.Ring, 0.015),
//                new TierLoot(4, ItemType.Ring, 0.005),
//                new TierLoot(4, ItemType.Ability, 0.02),
//                new Threshold(0.18,
//                    new ItemLoot("Potion of Attack", 0.050),
//                    new EggLoot(EggRarity.Common, 0.1),
//                    new EggLoot(EggRarity.Uncommon, 0.05)
//                    )
//            )
//            .Init("ESlime God",
//                new State(
//                    new Prioritize(
//                        new StayAbove(1, 200),
//                        new Follow(1, range: 7),
//                        new Wander(0.4)
//                        ),
//                    new Shoot(12, projectileIndex: 0, count: 5, shootAngle: 10, predictive: 1, coolDown: 1000),
//                    new Shoot(10, projectileIndex: 1, predictive: 1, coolDown: 650),
//                    new DropPortalOnDeath("Gauntlet Portal", 1)
//                    ),
//                new TierLoot(6, ItemType.Weapon, 0.04),
//                new TierLoot(7, ItemType.Weapon, 0.02),
//                new TierLoot(8, ItemType.Weapon, 0.01),
//                new TierLoot(7, ItemType.Armor, 0.04),
//                new TierLoot(8, ItemType.Armor, 0.02),
//                new TierLoot(9, ItemType.Armor, 0.01),
//                new TierLoot(4, ItemType.Ability, 0.02),
//                new Threshold(0.18,
//                    new ItemLoot("Potion of Defense", 0.050),
//                    new EggLoot(EggRarity.Common, 0.1),
//                    new EggLoot(EggRarity.Uncommon, 0.05)
//                    )
//            )
//            .Init("EGhost God",
//                new State(
//                    new Prioritize(
//                        new StayAbove(1, 200),
//                        new Follow(1, range: 7),
//                        new Wander(0.4)
//                        ),
//                    new Shoot(12, 7, 25, predictive: 0.5, coolDown: 900)
//                    ),
//                new TierLoot(6, ItemType.Weapon, 0.04),
//                new TierLoot(7, ItemType.Weapon, 0.02),
//                new TierLoot(7, ItemType.Armor, 0.04),
//                new TierLoot(8, ItemType.Armor, 0.02),
//                new TierLoot(3, ItemType.Ring, 0.015),
//                new TierLoot(4, ItemType.Ring, 0.005),
//                new TierLoot(4, ItemType.Ability, 0.02),
//                new Threshold(0.18,
//                    new ItemLoot("Potion of Speed", 0.050),
//                    new EggLoot(EggRarity.Common, 0.1),
//                    new EggLoot(EggRarity.Uncommon, 0.05)
//                    )
//            )
//            .Init("ERock Bot",
//                new State(
//                    new Spawn("Paper Bot", 1, 1, 10000),
//                    new Spawn("Steel Bot", 1, 1, 10000),
//                    new Swirl(0.6, 3, targeted: false),
//                    new State("Waiting",
//                        new PlayerWithinTransition(15, "Attacking")
//                        ),
//                    new State("Attacking",
//                        new Shoot(8, coolDown: 2000),
//                        new Heal(8, "Papers", 1000),
//                        new Taunt(0.5, "We are impervious to non-mystic attacks!"),
//                        new TimedTransition(10000, "Waiting")
//                        )
//                    ),
//                new TierLoot(5, ItemType.Weapon, 0.16),
//                new TierLoot(6, ItemType.Weapon, 0.08),
//                new TierLoot(7, ItemType.Weapon, 0.04),
//                new TierLoot(5, ItemType.Armor, 0.16),
//                new TierLoot(6, ItemType.Armor, 0.08),
//                new TierLoot(7, ItemType.Armor, 0.04),
//                new TierLoot(3, ItemType.Ring, 0.05),
//                new TierLoot(3, ItemType.Ability, 0.1),
//                new ItemLoot("Purple Drake Egg", 0.01)
//            )
//            .Init("EPaper Bot",
//                new State(
//                    new Prioritize(
//                        new Orbit(0.4, 3, target: "Rock Bot"),
//                        new Wander(0.8)
//                        ),
//                    new State("Idle",
//                        new PlayerWithinTransition(15, "Attack")
//                        ),
//                    new State("Attack",
//                        new Shoot(8, 3, 20, coolDown: 800),
//                        new Heal(8, "Steels", 1000),
//                        new NoPlayerWithinTransition(30, "Idle"),
//                        new HpLessTransition(0.2, "Explode")
//                        ),
//                    new State("Explode",
//                        new Shoot(0, 10, 36, fixedAngle: 0),
//                        new Decay(0)
//                        )
//                    ),
//                new TierLoot(6, ItemType.Weapon, 0.01),
//                new ItemLoot("Health Potion", 0.04),
//                new ItemLoot("Magic Potion", 0.01),
//                new ItemLoot("Tincture of Life", 0.01)
//            )
//            .Init("ESteel Bot",
//                new State(
//                    new Prioritize(
//                        new Orbit(0.4, 3, target: "Rock Bot"),
//                        new Wander(0.8)
//                        ),
//                    new State("Idle",
//                        new PlayerWithinTransition(15, "Attack")
//                        ),
//                    new State("Attack",
//                        new Shoot(8, 3, 20, coolDown: 800),
//                        new Heal(8, "Rocks", 1000),
//                        new Taunt(0.5, "Silly squishy. We heal our brothers in a circle."),
//                        new NoPlayerWithinTransition(30, "Idle"),
//                        new HpLessTransition(0.2, "Explode")
//                        ),
//                    new State("Explode",
//                        new Shoot(0, 10, 36, fixedAngle: 0),
//                        new Decay(0)
//                        )
//                    ),
//                new TierLoot(6, ItemType.Weapon, 0.01),
//                new ItemLoot("Health Potion", 0.04),
//                new ItemLoot("Magic Potion", 0.01)
//            )
//            .Init("EDjinn",
//                new State(
//                    new State("Idle",
//                        new Prioritize(
//                            new StayAbove(1, 200),
//                            new Wander(0.8)
//                            ),
//                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
//                        new PlayerWithinTransition(8, "Attacking")
//                        ),
//                    new State("Attacking",
//                        new State("Bullet",
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 90, coolDownOffset: 0, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 100, coolDownOffset: 200, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 110, coolDownOffset: 400, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 120, coolDownOffset: 600, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 130, coolDownOffset: 800, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 140, coolDownOffset: 1000, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 150, coolDownOffset: 1200, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 160, coolDownOffset: 1400, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 170, coolDownOffset: 1600, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 180, coolDownOffset: 1800, shootAngle: 90),
//                            new Shoot(1, 8, coolDown: 10000, fixedAngle: 180, coolDownOffset: 2000, shootAngle: 45),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 180, coolDownOffset: 0, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 170, coolDownOffset: 200, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 160, coolDownOffset: 400, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 150, coolDownOffset: 600, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 140, coolDownOffset: 800, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 130, coolDownOffset: 1000, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 120, coolDownOffset: 1200, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 110, coolDownOffset: 1400, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 100, coolDownOffset: 1600, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 90, coolDownOffset: 1800, shootAngle: 90),
//                            new Shoot(1, 4, coolDown: 10000, fixedAngle: 90, coolDownOffset: 2000, shootAngle: 22.5),
//                            new TimedTransition(2000, "Wait")
//                            ),
//                        new State("Wait",
//                            new Follow(0.7, range: 0.5),
//                            new Flash(0xff00ff00, 0.1, 20),
//                            new ConditionalEffect(ConditionEffectIndex.Invulnerable),
//                            new TimedTransition(2000, "Bullet")
//                            ),
//                        new NoPlayerWithinTransition(13, "Idle"),
//                        new HpLessTransition(0.5, "FlashBeforeExplode")
//                        ),
//                    new State("FlashBeforeExplode",
//                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
//                        new Flash(0xff0000, 0.3, 3),
//                        new TimedTransition(1000, "Explode")
//                        ),
//                    new State("Explode",
//                        new Shoot(0, 10, 36, fixedAngle: 0),
//                        new Suicide()
//                        )
//                    ),
//                new TierLoot(6, ItemType.Weapon, 0.04),
//                new TierLoot(7, ItemType.Weapon, 0.02),
//                new TierLoot(7, ItemType.Armor, 0.04),
//                new TierLoot(8, ItemType.Armor, 0.02),
//                new TierLoot(3, ItemType.Ring, 0.015),
//                new TierLoot(4, ItemType.Ring, 0.005),
//                new TierLoot(4, ItemType.Ability, 0.02),
//                new Threshold(0.18,
//                    new ItemLoot("Potion of Speed", 0.050),
//                    new EggLoot(EggRarity.Common, 0.1),
//                    new EggLoot(EggRarity.Uncommon, 0.05)
//                )
//            )
//        .Init("EDM Sprite Child Para",
//                new State(
//                    new Prioritize(
//                        new StayAbove(1, 200),
//                            new Wander(0.8),
//                        new Shoot(12, 7, 25, predictive: 0.5, projectileIndex: 0, coolDown: 1500),
//                         new Shoot(12, 5, 72, coolDown: 1000),
//                        new Wander(0.4)
//                        ),
//                    new DropPortalOnDeath("Glowing Portal", 0)
//             )
//            )
//            .Init("EDM Sprite Child ArmorB",
//                new State(
//                    new Prioritize(
//                         new StayAbove(1, 200),
//                            new Wander(0.8),
//                         new Shoot(12, 5, 72, projectileIndex: 0, coolDown: 190),
//                        new Wander(0.4)
//                        ),
//                    new DropPortalOnDeath("Glowing Portal", 0)
//            )
//            )
//            .Init("EDM Sprite Child BOSS",
//                new State(
//                    new Prioritize(
//                        new StayAbove(1, 200),
//                            new Wander(0.8),
//                        new Protect(0.4, "DreamScape Boss", protectionRange: 1),
//                         new Shoot(12, 7, 25, predictive: 0.5, projectileIndex: 0, coolDown: 900),
//                        new Wander(0.4)
//                        ),
//                    new DropPortalOnDeath("Glowing Portal", 0)
//                        )
//            )
//        .Init("DreamScape Boss",
//            new State(
//                new State("main",
//                    new StayAbove(1, 200),
//                    new StayCloseToSpawn(0.1, 6),
//                    new Wander(0.1),
//                    new Shoot(12, projectileIndex: 0, count: 6, shootAngle: 10),
//                    new Shoot(12, projectileIndex: 1, count: 5, shootAngle: 10),
//                    new Shoot(12, projectileIndex: 2, count: 4, shootAngle: 10),
//                    new Shoot(12, projectileIndex: 3, count: 3, shootAngle: 10),
//                    new Shoot(12, projectileIndex: 4, count: 2, shootAngle: 10),
//                    new Shoot(12, projectileIndex: 5, count: 2, shootAngle: 10),
//                    new Shoot(12, 7, 25, projectileIndex: 6, predictive: 0.5, coolDown: 900),
//                    new Shoot(10, projectileIndex: 6, predictive: 1, coolDown: 500),
//                    new Shoot(10, 3, 20, predictive: 1, projectileIndex: 6, coolDown: 500),
//                    new Spawn("EDM Sprite Child BOSS", maxChildren: 15),
//                    new TossObject("EDM Sprite Child ArmorB", 5, 0, coolDown: 100000, randomToss: false),
//                    new TossObject("EDM Sprite Child ArmorB", 5, 90, coolDown: 100000, randomToss: false),
//                    new TossObject("EDM Sprite Child ArmorB", 5, 180, coolDown: 100000, randomToss: false),
//                    new TossObject("EDM Sprite Child ArmorB", 5, 270, coolDown: 100000, randomToss: false),
//                    new HpLessTransition(0.5, "Attack1")
//                    ),
//                new State("Attack1",
//                    new Follow(0.7, range: 10),
//                    new Flash(0xff00ff00, 0.1, 20),
//                    new Shoot(12, projectileIndex: 0, count: 6, shootAngle: 10),
//                    new Shoot(12, projectileIndex: 1, count: 5, shootAngle: 10),
//                    new Shoot(12, projectileIndex: 2, count: 4, shootAngle: 10),
//                    new Shoot(12, projectileIndex: 3, count: 3, shootAngle: 10),
//                    new Shoot(12, projectileIndex: 4, count: 2, shootAngle: 10),
//                    new Shoot(12, projectileIndex: 5, count: 2, shootAngle: 10),
//                    new Shoot(12, 7, 25, projectileIndex: 6, predictive: 0.5, coolDown: 900),
//                    new Shoot(10, projectileIndex: 6, predictive: 1, coolDown: 500),
//                    new Shoot(10, 3, 20, predictive: 1, projectileIndex: 6, coolDown: 500),
//                    new Spawn("EDM Sprite Child BOSS", maxChildren: 15),
//                    new TossObject("EDM Sprite Child ArmorB", 5, 0, coolDown: 100000, randomToss: false),
//                    new TossObject("EDM Sprite Child ArmorB", 5, 90, coolDown: 100000, randomToss: false),
//                    new TossObject("EDM Sprite Child ArmorB", 5, 180, coolDown: 100000, randomToss: false),
//                    new TossObject("EDM Sprite Child ArmorB", 5, 270, coolDown: 100000, randomToss: false)
//                    )
//                )
//            )
//            .Init("ELeviathan",
//                new State(
//                    new State("pattern walk",
//                        new StayAbove(2, 200),
//                        new Sequence(
//                            new Timed(2000,
//                                new Prioritize(
//                                    new StayBack(1, distance: 8),
//                                    new BackAndForth(1)
//                                    )),
//                            new Timed(2000,
//                                new Prioritize(
//                                    new Orbit(1, 8, 11),
//                                    new Swirl(1, 4, targeted: false)
//                                    )),
//                            new Timed(1000,
//                                new Prioritize(
//                                    new Follow(1, 11, 1),
//                                    new StayCloseToSpawn(1, 1)
//                                    )
//                                )
//                            ),
//                        new State("1",
//                            new Shoot(0, 3, 10, fixedAngle: 0, projectileIndex: 0, coolDown: 300),
//                            new Shoot(0, 3, 10, fixedAngle: 120, projectileIndex: 0, coolDown: 300),
//                            new Shoot(0, 3, 10, fixedAngle: 240, projectileIndex: 0, coolDown: 300),
//                            new TimedTransition(1500, "2")
//                            ),
//                        new State("2",
//                            new Shoot(0, 4, 10, fixedAngle: 40, projectileIndex: 0, coolDown: 300),
//                            new Shoot(0, 4, 10, fixedAngle: 160, projectileIndex: 0, coolDown: 300),
//                            new Shoot(0, 4, 10, fixedAngle: 280, projectileIndex: 0, coolDown: 300),
//                            new TimedTransition(1500, "3")
//                            ),
//                        new State("3",
//                            new Shoot(0, 4, 10, fixedAngle: 80, projectileIndex: 0, coolDown: 300),
//                            new Shoot(0, 4, 10, fixedAngle: 200, projectileIndex: 0, coolDown: 300),
//                            new Shoot(0, 4, 10, fixedAngle: 320, projectileIndex: 0, coolDown: 300),
//                            new TimedTransition(1500, "1")
//                            ),
//                        new TimedTransition(4400, "follow")
//                        ),
//                    new State("follow",
//                        new Prioritize(
//                            new StayAbove(1, 200),
//                            new Orbit(1, 4, 11),
//                            new Wander(1)
//                            ),
//                        new Shoot(11, 2, 15, defaultAngle: 0, angleOffset: 0, projectileIndex: 1, predictive: 1,
//                            coolDown: 900, coolDownOffset: 0),
//                        new Shoot(11, 2, 15, defaultAngle: 0, angleOffset: -10, projectileIndex: 1, predictive: 1,
//                            coolDown: 900, coolDownOffset: 300),
//                        new Shoot(11, 2, 15, defaultAngle: 0, angleOffset: 10, projectileIndex: 1, predictive: 1,
//                            coolDown: 900, coolDownOffset: 600),
//                        new TimedTransition(4500, "pattern walk")
//                        )
//                    ),
//                new TierLoot(6, ItemType.Weapon, 0.01),
//                new ItemLoot("Health Potion", 0.04),
//                new ItemLoot("Magic Potion", 0.01)

//            )
//        ;
//    }
//}


/*using wServer.logic.behaviors;
using wServer.logic.transitions;
using wServer.logic.loot;

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ Janus = () => Behav()
        //entity used to change states 
        .Init("md dwGenerator",
            new State(
                new State("nokillswag",
                    new ConditionalEffect(ConditionEffectIndex.Invincible)
                    )
                )
            )
        .Init("md LightKey",
            new State(
                new State("Bullet15",
                    new Shoot(10, count: 15, projectileIndex: 0, coolDown: 800),
                    new EntityExistsTransition("md dwGenerator", 9999, "MoveToJanus")
                    ),
                new State("MoveToJanus",
                    new MoveTo(0, 6, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet8")
                    ),
                new State("Bullet8",
                    new Shoot(10, count: 8, projectileIndex: 1, coolDown: new Cooldown(1500, 500)),
                    new SpecificHeal(20, 2000, "Janus", coolDown: 9999),
                    new EntitiesNotExistsTransition(9999, "MoveAwayJanus", "md dwGenerator")
                    ),
                new State("MoveAwayJanus",
                    new MoveTo(0, -6, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet15")
                    )
                )
            )
        .Init("md LightKey 2",
            new State(
                new State("Bullet15",
                    new Shoot(10, count: 15, projectileIndex: 0, coolDown: 800),
                    new EntityExistsTransition("md dwGenerator", 9999, "MoveToJanus")
                    ),
                new State("MoveToJanus",
                    new MoveTo(0, -6, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet8")
                    ),
                new State("Bullet8",
                    new Shoot(10, count: 8, projectileIndex: 1, coolDown: new Cooldown(1500, 500)),
                    new SpecificHeal(20, 2000, "Janus", coolDown: 9999),
                    new EntitiesNotExistsTransition(9999, "MoveAwayJanus", "md dwGenerator")
                    ),
                new State("MoveAwayJanus",
                    new MoveTo(0, 6, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet15")
                    )
                )
            )
        .Init("md LightKey 3",
            new State(
                new State("Bullet15",
                    new Shoot(10, count: 15, projectileIndex: 0, coolDown: 800),
                    new EntityExistsTransition("md dwGenerator", 9999, "MoveToJanus")
                    ),
                new State("MoveToJanus",
                    new MoveTo(-6, 0, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet8")
                    ),
                new State("Bullet8",
                    new Shoot(10, count: 8, projectileIndex: 1, coolDown: new Cooldown(1500, 500)),
                    new SpecificHeal(20, 2000, "Janus", coolDown: 9999),
                    new EntitiesNotExistsTransition(9999, "MoveAwayJanus", "md dwGenerator")
                    ),
                new State("MoveAwayJanus",
                    new MoveTo(6, 0, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet15")
                    )
                )
            )
        .Init("md LightKey 4",
            new State(
                new State("Bullet15",
                    new Shoot(10, count: 15, projectileIndex: 0, coolDown: 800),
                    new EntityExistsTransition("md dwGenerator", 9999, "MoveToJanus")
                    ),
                new State("MoveToJanus",
                    new MoveTo(6, 0, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet8")
                    ),
                new State("Bullet8",
                    new Shoot(10, count: 8, projectileIndex: 1, coolDown: new Cooldown(1500, 500)),
                    new SpecificHeal(20, 2000, "Janus", coolDown: 9999),
                    new EntitiesNotExistsTransition(9999, "MoveAwayJanus", "md dwGenerator")
                    ),
                new State("MoveAwayJanus",
                    new MoveTo(-6, 0, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet15")
                    )
                )
            )
        .Init("md DarkKey",
            new State(
                new State("Bullet15",
                    new Shoot(10, count: 15, projectileIndex: 0, coolDown: 800),
                    new EntityExistsTransition("md dwGenerator", 9999, "MoveToJanus")
                    ),
                new State("MoveToJanus",
                    new MoveTo(6, 6, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet8")
                    ),
                new State("Bullet8",
                    new Shoot(10, count: 8, projectileIndex: 1, coolDown: new Cooldown(1500, 500)),
                    new SpecificHeal(20, 2000, "Janus", coolDown: 9999),
                    new EntitiesNotExistsTransition(9999, "MoveAwayJanus", "md dwGenerator")
                    ),
                new State("MoveAwayJanus",
                    new MoveTo(-6, -6, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet15")
                    )
                )
            )
        .Init("md DarkKey 2",
            new State(
                new State("Bullet15",
                    new Shoot(10, count: 15, projectileIndex: 0, coolDown: 800),
                    new EntityExistsTransition("md dwGenerator", 9999, "MoveToJanus")
                    ),
                new State("MoveToJanus",
                    new MoveTo(-6, -6, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet8")
                    ),
                new State("Bullet8",
                    new Shoot(10, count: 8, projectileIndex: 1, coolDown: new Cooldown(1000, 100)),
                    new SpecificHeal(20, 2000, "Janus", coolDown: 9999),
                    new EntitiesNotExistsTransition(9999, "MoveAwayJanus", "md dwGenerator")
                    ),
                new State("MoveAwayJanus",
                    new MoveTo(6, 6, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet15")
                    )
                )
            )
        .Init("md DarkKey 3",
            new State(
                new State("Bullet15",
                    new Shoot(10, count: 15, projectileIndex: 0, coolDown: 800),
                    new EntityExistsTransition("md dwGenerator", 9999, "MoveToJanus")
                    ),
                new State("MoveToJanus",
                    new MoveTo(6, -6, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet8")
                    ),
                new State("Bullet8",
                    new Shoot(10, count: 8, projectileIndex: 1, coolDown: new Cooldown(1500, 500)),
                    new SpecificHeal(20, 2000, "Janus", coolDown: 9999),
                    new EntitiesNotExistsTransition(9999, "MoveAwayJanus", "md dwGenerator")
                    ),
                new State("MoveAwayJanus",
                    new MoveTo(-6, 6, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet15")
                    )
                )
            )
        .Init("md DarkKey 4",
            new State(
                new State("Bullet15",
                    new Shoot(10, count: 15, projectileIndex: 0, coolDown: 800),
                    new EntityExistsTransition("md dwGenerator", 9999, "MoveToJanus")
                    ),
                new State("MoveToJanus",
                    new MoveTo(-6, 6, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet8")
                    ),
                new State("Bullet8",
                    new Shoot(10, count: 8, projectileIndex: 1, coolDown: new Cooldown(1500, 500)),
                    new SpecificHeal(20, 2000, "Janus", coolDown: 9999),
                    new EntitiesNotExistsTransition(9999, "MoveAwayJanus", "md dwGenerator")
                    ),
                new State("MoveAwayJanus",
                    new MoveTo(6, -6, speed: 0.5, isMapPosition: false, once: true),
                    new TimedTransition(2000, "Bullet15")
                    )
                )
            )

        .Init("md Janus the Doorwarden",
                new State(
                    new HpLessTransition(0.15, "ragetime"),
                    new State("idle",
                        new PlayerWithinTransition(8, "taunt")
                        ),
                    new State("taunt",
                        new Flash(0xFF0000, 2, 2),
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new Taunt("You bare witness to Janus, Doorwarden of Oryx. You will soon regret your decisions, your soul sealed away -- forever"),
                        new TimedTransition(5000, "tosskeys")
                        ),
                    new State("tosskeys",
                        new Taunt(1.00, "Keys, protect your master"),
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new TossObject("md LightKey 3", 8, 0, coolDown: 9999999, randomToss: false),
                        new TossObject("md DarkKey 2", 10, 45, coolDown: 9999999, randomToss: false),
                        new TossObject("md LightKey 2", 8, 90, coolDown: 9999999, randomToss: false),
                        new TossObject("md DarkKey 3", 10, 135, coolDown: 9999999, randomToss: false),
                        new TossObject("md LightKey 4", 8, 180, coolDown: 9999999, randomToss: false),
                        new TossObject("md DarkKey", 10, 225, coolDown: 9999999, randomToss: false),
                        new TossObject("md LightKey", 8, 270, coolDown: 9999999, randomToss: false),
                        new TossObject("md DarkKey 4", 10, 315, coolDown: 9999999, randomToss: false),
                        new TimedTransition(2000, "ringattacks")
                        ),
                    new State(
                        new EntitiesNotExistsTransition(9999, "warn1", "md DarkKey", "md DarkKey 2", "md DarkKey 3", "md DarkKey 4", "md LightKey", "md LightKey 2", "md LightKey 3", "md LightKey 4"),
                    new State("ringattacks",
                        new RemoveEntity(9999, "md dwGenerator"),
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new Shoot(10, 10, projectileIndex: 0, coolDown: 100),                 
                        new TimedTransition(10000, "keyshelp")
                        ),
                    new State("keyshelp",
                        new Spawn("md dwGenerator", 1, 1, coolDown: 999999),
                        new TimedTransition(11000, "ringattacks")
                        )
                       ),
                    new State("warn1",
                        new Flash(0xFF0000, 1, 2),
                        new Taunt(1.00, "Up and Down!"),
                        new TimedTransition(3000, "UpDown")
                        ),
                    new State("UpDown",
                        new Shoot(10, count: 8, fixedAngle: 0, shootAngle: 6, projectileIndex: 1, coolDown: 50),
                        new Shoot(10, count: 8, fixedAngle: 180, shootAngle: 6, projectileIndex: 1, coolDown: 50),
                        new TimedTransition(5000, "warn2")
                        ),
                    new State("warn2",
                        new Flash(0xFF0000, 1, 2),
                        new Taunt(1.00, "Left and Right!"),
                        new TimedTransition(3000, "LeftRight")
                        ),
                     new State("LeftRight",
                        new Shoot(10, count: 8, fixedAngle: 90, shootAngle: 6, projectileIndex: 1, coolDown: 50),
                        new Shoot(10, count: 8, fixedAngle: 270, shootAngle: 6, projectileIndex: 1, coolDown: 50),
                        new TimedTransition(5000, "warn3")
                        ),
                     new State("warn3",
                        new Flash(0xFF0000, 1, 2),
                        new Taunt(1.00, "Quick! Up and Down!"),
                        new TimedTransition(3000, "UpDown2")
                        ),
                     new State("UpDown2",
                        new Shoot(10, count: 8, fixedAngle: 0, shootAngle: 6, projectileIndex: 1, coolDown: 50),
                        new Shoot(10, count: 8, fixedAngle: 180, shootAngle: 6, projectileIndex: 1, coolDown: 50),
                        new TimedTransition(5000, "warn4")
                        ),
                     new State("warn4",
                        new Flash(0xFF0000, 1, 2),
                        new Taunt(1.00, "Hurry! Left and Right!"),
                        new TimedTransition(3000, "LeftRight2")
                        ),
                     new State("LeftRight2",
                        new Shoot(10, count: 8, fixedAngle: 90, shootAngle: 6, projectileIndex: 1, coolDown: 50),
                        new Shoot(10, count: 8, fixedAngle: 270, shootAngle: 6, projectileIndex: 1, coolDown: 50),
                        new TimedTransition(5000, "tosskeys")
                        ),
                     //spookyrage weird movement
                     new State("ragetime",
                      new State("1",
                        new Prioritize(
                             new Wander(0.4),
                             new Follow(0.6, 8, 1)
                            ),
                        new Shoot(10, 10, projectileIndex: 0, coolDown: new Cooldown(200, 200)),
                        new TimedTransition(6000, "2")
                        ),
                      new State("2",
                        new StayBack(1, 6),
                        new Shoot(10, 10, projectileIndex: 0, coolDown: new Cooldown(100, 100)),
                        new TimedTransition(6000, "1")
                        )
                      )
                    ),
                new MostDamagers(3,
                    new ItemLoot("Potion of Vitality", 1.0)
                ),
                new MostDamagers(1,
                    new ItemLoot("Potion of Speed", 1.0)
                ),
                new Threshold(0.02,
                    new TierLoot(9, ItemType.Weapon, 0.1),
                    new TierLoot(5, ItemType.Ability, 0.1),
                    new TierLoot(9, ItemType.Armor, 0.1),
                    new TierLoot(7, ItemType.Armor, 0.05),
                    new TierLoot(10, ItemType.Weapon, 0.05),
                    new TierLoot(5, ItemType.Ring, 0.025),
                    //new ItemLoot("Thousand Shot", 0.012),
                    new ItemLoot("Wine Cellar Incantation", 0.01)
                )
            )


        ;
    }
}*/