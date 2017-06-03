#region

using wServer.logic.behaviors;
using wServer.logic.transitions;
using wServer.logic.loot;

#endregion

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ LairofDraconis = () => Behav()
            .Init("NM Altar of Draconis",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("Normal or Hardmode",
                    new TimedTransition(1000, "normal", true),
                    new TimedTransition(1000, "hardmode", true)
                    ),
                new State("normal",
                    new Taunt(true, "Choose the Dragon Soul you wish to commune with!"),
                    new ChatTransition("blue check normal", "blue"),
                    new ChatTransition("red check normal", "red"),
                    new ChatTransition("green check normal", "green"),
                    new ChatTransition("black check normal", "black")
                    ),
                new State("normal2",
                    new EntitiesNotExistsTransition(999, "RealmPortal", "NM Blue Dragon Spawner", "NM Red Dragon Spawner", "NM Green Dragon Spawner", "NM Black Dragon Spawner"),
                    new ChatTransition("blue check normal", "blue"),
                    new ChatTransition("red check normal", "red"),
                    new ChatTransition("green check normal", "green"),
                    new ChatTransition("black check normal", "black")
                    ),
                new State("hardmode",
                    new Taunt(true, "Choose the Dragon Soul you wish to commune with!"),
                    new ChatTransition("blue check hardmode", "blue"),
                    new ChatTransition("red check hardmode", "red"),
                    new ChatTransition("green check hardmode", "green"),
                    new ChatTransition("black check hardmode", "black")
                    ),
                new State("hardmode2",
                    new EntitiesNotExistsTransition(999, "Ivory Wyvern Portal", "NM Blue Dragon Spawner", "NM Red Dragon Spawner", "NM Green Dragon Spawner", "NM Black Dragon Spawner"),
                    new ChatTransition("blue check hardmode", "blue"),
                    new ChatTransition("red check hardmode", "red"),
                    new ChatTransition("green check hardmode", "green"),
                    new ChatTransition("black check hardmode", "black")
                    ),
                new State("RealmPortal",
                    new DropPortalOnDeath("Ivory Wyvern Portal", 25, 0, 8, 2, 120),
                    new DropPortalOnDeath("Realm Portal", 100, 0, 6, 0, 120),
                    new Suicide()
                    ),
                new State("Ivory Wyvern Portal",
                    new DropPortalOnDeath("Ivory Wyvern Portal", 100, 0, 6, 0, 120),
                    new Suicide()
                    ),
                new State("blue check normal",
                    new EntitiesNotExistsTransition(999, "normal2", "NM Blue Dragon Spawner"),
                    new EntityExistsTransition("NM Blue Dragon Spawner", 999, "blue normal")
                    ),
                new State("blue normal",
                    new Taunt(true, "Do not let the tranquil surroundigps fool you!"),
                    new Order(99, "NM Blue Dragon Soul", "despawn"),
                    new Order(999, "NM Blue Dragon Spawner", "normal"),
                    new Order(999, "NM Blue Open Wall", "1"),
                    new TimedTransition(1000, "blue death normal check")
                    ),
                new State("blue death normal check",
                    new EntityExistsTransition("NM Blue Dragon Dead", 9999, "normal2")
                    ),
                new State("blue check hardmode",
                    new EntitiesNotExistsTransition(999, "hardmode2", "NM Blue Dragon Spawner"),
                    new EntityExistsTransition("NM Blue Dragon Spawner", 999, "blue hardmode")
                    ),
                new State("blue hardmode",
                    new Taunt(true, "Do not let the tranquil surroundigps fool you!"),
                    new Order(99, "NM Blue Dragon Soul", "despawn"),
                    new Order(999, "NM Blue Dragon Spawner", "hardmode"),
                    new Order(999, "NM Blue Open Wall", "1"),
                    new TimedTransition(1000, "blue death hardmode check")
                    ),
                new State("blue death hardmode check",
                    new EntityExistsTransition("NM Blue Dragon Dead", 9999, "hardmode2")
                    ),
                new State("red check normal",
                    new EntitiesNotExistsTransition(999, "normal2", "NM Red Dragon Spawner"),
                    new EntityExistsTransition("NM Red Dragon Spawner", 999, "red normal")
                    ),
                new State("red normal",
                    new Taunt(true, "Burns!!! Pyyr will rend your flesh and char your bones!"),
                    new Order(99, "NM Red Dragon Soul", "despawn"),
                    new Order(999, "NM Red Dragon Spawner", "normal"),
                    new Order(999, "NM Red Open Wall", "1"),
                    new TimedTransition(500, "red death normal check")
                    ),
                new State("red death normal check",
                    new EntityExistsTransition("NM Red Dragon Dead", 9999, "normal2")
                    ),
                new State("red check hardmode",
                    new EntitiesNotExistsTransition(999, "hardmode2", "NM Red Dragon Spawner"),
                    new EntityExistsTransition("NM Red Dragon Spawner", 999, "red hardmode")
                    ),
                new State("red hardmode",
                    new Taunt(true, "Burns!!! Pyyr will rend your flesh and char your bones!"),
                    new Order(99, "NM Red Dragon Soul", "despawn"),
                    new Order(999, "NM Red Dragon Spawner", "hardmode"),
                    new Order(999, "NM Red Open Wall", "1"),
                    new TimedTransition(1000, "red death hardmode check")
                    ),
                new State("red death hardmode check",
                    new EntityExistsTransition("NM Red Dragon Dead", 9999, "hardmode2")
                    ),
                new State("green check normal",
                    new EntitiesNotExistsTransition(999, "normal2", "NM Green Dragon Spawner"),
                    new EntityExistsTransition("NM Green Dragon Spawner", 999, "green normal")
                    ),
                new State("green normal",
                    new Taunt(true, "Limoz is the nicest of the lot, but he still hates all sub creatures!"),
                    new Order(99, "NM Green Dragon Soul", "despawn"),
                    new Order(999, "NM Green Dragon Spawner", "normal"),
                    new Order(999, "NM Green Open Wall", "1"),
                    new TimedTransition(1000, "green death normal check")
                    ),
                new State("green death normal check",
                    new EntityExistsTransition("NM Green Dragon Dead", 9999, "normal2")
                    ),
                new State("green check hardmode",
                    new EntitiesNotExistsTransition(999, "hardmode2", "NM Green Dragon Spawner"),
                    new EntityExistsTransition("NM Green Dragon Spawner", 999, "green hardmode")
                    ),
                new State("green hardmode",
                    new Taunt(true, "Limoz is the nicest of the lot, but he still hates all sub creatures!"),
                    new Order(99, "NM Green Dragon Soul", "despawn"),
                    new Order(999, "NM Green Dragon Spawner", "hardmode"),
                    new Order(999, "NM Green Open Wall", "1"),
                    new TimedTransition(1000, "green death hardmode check")
                    ),
                new State("green death hardmode check",
                    new EntityExistsTransition("NM Green Dragon Dead", 9999, "hardmode2")
                    ),
                new State("black check normal",
                    new EntitiesNotExistsTransition(999, "normal2", "NM Black Dragon Spawner"),
                    new EntityExistsTransition("NM Black Dragon Spawner", 999, "black normal")
                    ),
                new State("black normal",
                    new Taunt(true, "Gaze into the darkness... Feargus will consume you!"),
                    new Order(99, "NM Black Dragon Soul", "despawn"),
                    new Order(999, "NM Black Dragon Spawner", "normal"),
                    new Order(999, "NM Black Dragon Minion", "2"),
                    new Order(999, "NM Black Open Wall", "1"),
                    new TimedTransition(1000, "black death normal check")
                    ),
                new State("black death normal check",
                    new EntityExistsTransition("NM Black Dragon Dead", 9999, "normal2")
                    ),
                new State("black check hardmode",
                    new EntitiesNotExistsTransition(999, "hardmode2", "NM Black Dragon Spawner"),
                    new EntityExistsTransition("NM Black Dragon Spawner", 999, "black hardmode")
                    ),
                new State("black hardmode",
                    new Taunt(true, "Gaze into the darkness... Feargus will consume you!"),
                    new Order(99, "NM Black Dragon Soul", "despawn"),
                    new Order(999, "NM Black Dragon Spawner", "hardmode"),
                    new Order(999, "NM Black Dragon Minion", "2"),
                    new Order(999, "NM Black Open Wall", "1"),
                    new TimedTransition(1000, "black death hardmode check")
                    ),
                new State("black death hardmode check",
                    new EntityExistsTransition("NM Black Dragon Dead", 9999, "hardmode2")
                    )
                )
            )
            .Init("NM Blue Dragon Soul",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("Orbit",
                        new Orbit(0.3, 4, 10, "NM Altar of Draconis")
                        ),
                    new State("despawn",
                        new Aoe(1, false, 0, 0, false, 0xFFFFFF),
                        new Decay(0)
                        )
                    )
            )
            .Init("NM Red Dragon Soul",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("Orbit",
                        new Orbit(0.3, 4, 10, "NM Altar of Draconis")
                        ),
                    new State("despawn",
                        new Aoe(1, false, 0, 0, false, 0xFFFFFF),
                        new Decay(0)
                        )
                    )
            )
            .Init("NM Green Dragon Soul",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("Orbit",
                        new Orbit(0.3, 4, 10, "NM Altar of Draconis")
                        ),
                    new State("despawn",
                        new Aoe(1, false, 0, 0, false, 0xFFFFFF),
                        new Decay(0)
                        )
                    )
            )
            .Init("NM Black Dragon Soul",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("Orbit",
                        new Orbit(0.3, 4, 10, "NM Altar of Draconis")
                        ),
                    new State("despawn",
                        new Aoe(1, false, 0, 0, false, 0xFFFFFF),
                        new Decay(0)
                        )
                    )
            )
            .Init("NM Blue Open Wall",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("nothin"),
                    new State("1",
                    new ApplySetpiece("BlueOpenWall")
                        )
                    )
                )
            .Init("NM Blue Dragon God",
                new State(
                    new SetAltTexture(1),
                    new StayCloseToSpawn(0.5, 24),
                    new HpLessTransition(0.05, "20"),
                    new TransformOnDeath("lod Blue Loot Balloon"),
                    new OnDeathBehavior(new Order(99, "NM Blue Dragon Spawner", "despawn")),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("1",
                            new PlayerWithinTransition(3, "pre_2")
                            ),
                        new State("pre_2",
                            new Order(999, "drac wall blue", "spawn"),
                            new TimedTransition(500, "2")
                            ),
                        new State("2",
                            new Flash(0xFFFFFF, 0.2, 12),
                            new TimedTransition(2500, "3")
                            ),
                        new State("3",
                            new SetAltTexture(0),
                            new Taunt("My children will feast on your soul!"),
                            new TimedTransition(1000, "3_spawn")
                            ),
                        new State("3_spawn",
                            new Order(99, "NM Blue Minion Spawner", "spawn"),
                            new TimedTransition(0, "4")
                            )
                        ),
                    new State("4",
                        new HpLessTransition(0.75, "8"),
                        new Prioritize(
                            new Follow(0.3, 20, 1)
                            ),
                        new Shoot(20, 4, 45, 1, 0, 90, coolDown: 2000),
                        new Shoot(20, 4, 15, 2, 0, 90, coolDown: 2000),
                        new Shoot(20, 6, 30, 4, 0, 315, coolDown: 2500),
                        new State("5",
                            new Shoot(20, 6, 25, 3, 0, 0),
                            new Shoot(20, 6, 15, 5, 0, 315),
                            new TimedTransition(500, "6")
                            ),
                        new State("6",
                            new Shoot(20, 6, 25, 3, 0, 90),
                            new Shoot(20, 6, 15, 5, 0, 270),
                            new TimedTransition(500, "7")
                            ),
                        new State("7",
                            new Shoot(20, 6, 15, 5, 0, 225),
                            new Shoot(20, 6, 15, 5, 0, 135),
                            new TimedTransition(500, "5")
                            )
                        ),
                    new State("8",
                        new ReturnToSpawn(true, 0.7),
                        new Flash(0xFFFFFF, 0.2, 12),
                        new Taunt("Look out! My minions will help me!"),
                        new Order(99, "NM Blue Dragon Minion", "Protect"),
                        new HpLessTransition(0.5, "12"),
                        new Shoot(20, 4, 45, 1, 0, 90, coolDown: 2000),
                        new Shoot(20, 4, 15, 2, 0, 90, coolDown: 2000),
                        new Shoot(20, 6, 30, 4, 0, 315, coolDown: 2500),
                        new Shoot(20, 1, projectileIndex: 0, coolDown: 1000),
                        new State("9",
                            new Shoot(20, 6, 25, 3, 0, 0),
                            new Shoot(20, 6, 15, 5, 0, 315),
                            new TimedTransition(500, "10")
                            ),
                        new State("10",
                            new Shoot(20, 6, 25, 3, 0, 90),
                            new Shoot(20, 6, 15, 5, 0, 270),
                            new TimedTransition(500, "11")
                            ),
                        new State("11",
                            new Shoot(20, 6, 15, 5, 0, 225),
                            new Shoot(20, 6, 15, 5, 0, 135),
                            new TimedTransition(500, "9")
                            )
                        ),
                    new State("12",
                        new Flash(0xFFFFFF, 0.2, 12),
                        new Taunt("You're a nasty little pest!"),
                        new Prioritize(
                            new Follow(0.3, 20, 1)
                            ),
                        new HpLessTransition(0.25, "16"),
                        new Shoot(20, 4, 45, 1, 0, 90, coolDown: 2000),
                        new Shoot(20, 4, 15, 2, 0, 90, coolDown: 2000),
                        new Shoot(20, 6, 30, 4, 0, 315, coolDown: 2500),
                        new Shoot(20, 1, projectileIndex: 0, coolDown: 1000),
                        new State("13",
                            new Shoot(20, 6, 25, 3, 0, 0),
                            new Shoot(20, 6, 15, 5, 0, 315),
                            new TimedTransition(500, "14")
                            ),
                        new State("14",
                            new Shoot(20, 6, 25, 3, 0, 90),
                            new Shoot(20, 6, 15, 5, 0, 270),
                            new TimedTransition(500, "15")
                            ),
                        new State("15",
                            new Shoot(20, 6, 15, 5, 0, 225),
                            new Shoot(20, 6, 15, 5, 0, 135),
                            new TimedTransition(500, "13")
                            )
                        ),
                    new State("16",
                        new Flash(0xFFFFFF, 0.2, 12),
                        new Taunt("You cannot handle the full power of my onslaught!"),
                        new Prioritize(
                            new Wander(0.6)
                            ),
                        new HpLessTransition(0.05, "20"),
                        new Shoot(20, 4, 45, 1, 0, 90, coolDown: 2000),
                        new Shoot(20, 4, 15, 2, 0, 90, coolDown: 2000),
                        new Shoot(20, 6, 30, 4, 0, 315, coolDown: 2500),
                        new Shoot(20, 1, projectileIndex: 0, coolDown: 1000),
                        new Shoot(20, 24, 15, 3, 0, coolDown: 2000),
                        new State("spawn2",
                            new Order(99, "NM Blue Minion Spawner", "spawn2"),
                            new TimedTransition(100, "17")
                            ),
                        new State("17",
                            new Shoot(20, 6, 15, 5, 0, 315),
                            new TimedTransition(500, "18")
                            ),
                        new State("18",
                            new Shoot(20, 6, 15, 5, 0, 270),
                            new TimedTransition(500, "19")
                            ),
                        new State("19",
                            new Shoot(20, 6, 15, 5, 0, 225),
                            new Shoot(20, 6, 15, 5, 0, 135),
                            new TimedTransition(500, "17")
                            )
                        ),
                    new State("20",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new ReturnToSpawn(true, 0.6),
                        new Taunt("Nooooooo! This cannot be! i have underestimated your power..."),
                        new TimedTransition(3000, "21")
                        ),
                    new State("21",
                        new Suicide()
                        )
                    )
            )
        .Init("NM Blue Minion Spawner",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("Waiting"),
                new State("spawn",
                    new Spawn("NM Blue Dragon Minion", 2, 0),
                    new TimedTransition(100, "Wait1")
                    ),
                new State("Wait1"),
                new State("spawn2",
                    new Spawn("NM Blue Dragon Minion", 2, 0),
                    new TimedTransition(100, "Wait1")
                    )
                )
            )
        .Init("NM Blue Dragon Minion",
            new State(
                new EntitiesNotExistsTransition(99, "Die", "NM Blue Dragon God", "NM Blue Dragon God Hardmode"),
                new State("1",
                    new Orbit(0.4, 6, 10, null),
                    new Wander(0.2),
                    new Shoot(10, 1, projectileIndex: 2, coolDown: 1000)
                    ),
                new State("Protect",
                    new Protect(0.6, "NM Blue Dragon God", 99, 4),
                    new Protect(0.6, "NM Blue Dragon God Hardmode", 99, 4),
                    new Wander(0.2),
                    new Shoot(10, 1, projectileIndex: 2, coolDown: 1000)
                    ),
                new State("Die",
                    new Suicide()
                    )
                )
            )
        .Init("drac floor blue",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible)
                )
            )
        .Init("drac wall blue",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("nothin"),
                new State("spawn",
                    new ApplySetpiece("BlueCloseWall1"),
                    new TimedTransition(3000, "spawn2")
                    ),
                new State("spawn2",
                    new ApplySetpiece("BlueCloseWall2"),
                    new TimedTransition(3000, "spawn3")
                    ),
                new State("spawn3",
                    new ApplySetpiece("BlueCloseWall3"),
                    new TimedTransition(3000, "spawn4")
                    ),
                new State("spawn4",
                    new ApplySetpiece("BlueCloseWall4"),
                    new TimedTransition(3000, "spawn5")
                    ),
                new State("spawn5",
                    new ApplySetpiece("BlueCloseWall5")
                    )
                )
            )
        .Init("Ice Cave Wall",
            new State(
                new State("2",
                    new EntityExistsTransition("lod Blue Loot Balloon", 999, "3_1"),
                    new EntityExistsTransition("lod Blue HM Loot Balloon", 999, "3_2")
                    ),
                new State("3_1",
                    new EntityNotExistsTransition("lod Blue Loot Balloon", 999, "despawn")
                    ),
                new State("3_2",
                    new EntityNotExistsTransition("lod Blue HM Loot Balloon", 999, "despawn")
                    ),
                new State("despawn",
                    new Decay(0)
                    )
                )
            )
        .Init("NM Blue Dragon Spawner",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("nothin"),
                new State("normal",
                    new Spawn("NM Blue Dragon God", 1, 0)
                    ),
                new State("hardmode",
                    new Spawn("NM Blue Dragon God Hardmode", 1, 0)
                    ),
                new State("despawn",
                    //new Decay(0)
                    new Suicide()
                    )
                )
            )
            .Init("lod Blue Loot Balloon",
                new State(
                    new TransformOnDeath("NM Blue Dragon Dead"),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect",
                        new ThrowProjectile(0xcd5, 4, 0, 5000),
                        new ThrowProjectile(0x722, 4, 120, 5000),
                        new ThrowProjectile(0x7563, 4, 240, 5000)
                        )
                ),
                new MostDamagers(5,
                    new TierLoot(2, ItemType.Potion, 1),
                    new TierLoot(12, ItemType.Weapon, 0.03),
                    new TierLoot(11, ItemType.Weapon, 0.04),
                    new TierLoot(10, ItemType.Weapon, 0.05),
                    new TierLoot(13, ItemType.Armor, 0.03),
                    new TierLoot(12, ItemType.Armor, 0.04),
                    new TierLoot(11, ItemType.Armor, 0.05),
                    new ItemLoot("Ivory Wyvern Key", 0.008),
                    new ItemLoot("Large Blue Dragon Scale Cloth", 0.08),
                    new ItemLoot("Small Blue Dragon Scale Cloth", 0.08),
                    new ItemLoot("Potion of Mana", 0.03),
                    new ItemLoot("Wine Cellar Incantation", 0.008),
                    new ItemLoot("Water Dragon Silk Robe", 0.008)
                    )
            )
            .Init("NM Blue Dragon God Hardmode",
                new State(
                    new SetAltTexture(1),
                    new StayCloseToSpawn(0.5, 24),
                    new HpLessTransition(0.05, "20"),
                    new TransformOnDeath("lod Blue HM Loot Balloon"),
                    new OnDeathBehavior(new Order(99, "NM Blue Dragon Spawner", "despawn")),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("1",
                            new PlayerWithinTransition(3, "pre_2")
                            ),
                        new State("pre_2",
                            new Order(999, "drac wall blue", "spawn"),
                            new TimedTransition(500, "2")
                            ),
                        new State("2",
                            new Flash(0xFFFFFF, 0.2, 12),
                            new TimedTransition(2500, "3")
                            ),
                        new State("3",
                            new SetAltTexture(0),
                            new Taunt("My children will feast on your soul!"),
                            new TimedTransition(1000, "3_spawn")
                            ),
                        new State("3_spawn",
                            new Order(99, "NM Blue Minion Spawner", "spawn"),
                            new TimedTransition(0, "4")
                            )
                        ),
                    new State("4",
                        new HpLessTransition(0.75, "8"),
                        new Prioritize(
                            new Follow(0.3, 20, 1)
                            ),
                        new Shoot(20, 1, projectileIndex: 4, coolDown: 1000),
                        new Shoot(20, 4, 45, 1, 0, 90, coolDown: 2000),
                        new Shoot(20, 4, 15, 2, 0, 90, coolDown: 2000),
                        new Shoot(20, 6, 30, 5, 0, 315, coolDown: 2500),
                        new State("5",
                            new Shoot(20, 6, 25, 3, 0, 0),
                            new Shoot(20, 6, 15, 5, 0, 315),
                            new TimedTransition(500, "6")
                            ),
                        new State("6",
                            new Shoot(20, 6, 25, 3, 0, 90),
                            new Shoot(20, 6, 15, 6, 0, 270),
                            new TimedTransition(500, "7")
                            ),
                        new State("7",
                            new Shoot(20, 6, 15, 6, 0, 225),
                            new Shoot(20, 6, 15, 6, 0, 135),
                            new TimedTransition(500, "5")
                            )
                        ),
                    new State("8",
                        new ReturnToSpawn(true, 0.7),
                        new Flash(0xFFFFFF, 0.2, 12),
                        new Taunt("Look out! My minions will help me!"),
                        new Order(99, "NM Blue Dragon Minion", "Protect"),
                        new HpLessTransition(0.5, "12"),
                        new Shoot(20, 1, projectileIndex: 4, coolDown: 1000),
                        new Shoot(20, 4, 45, 1, 0, 90, coolDown: 2000),
                        new Shoot(20, 4, 15, 2, 0, 90, coolDown: 2000),
                        new Shoot(20, 6, 30, 5, 0, 315, coolDown: 2500),
                        new Shoot(20, 1, projectileIndex: 0, coolDown: 1000),
                        new State("9",
                            new Shoot(20, 6, 25, 3, 0, 0),
                            new Shoot(20, 6, 15, 6, 0, 315),
                            new TimedTransition(500, "10")
                            ),
                        new State("10",
                            new Shoot(20, 6, 25, 3, 0, 90),
                            new Shoot(20, 6, 15, 6, 0, 270),
                            new TimedTransition(500, "11")
                            ),
                        new State("11",
                            new Shoot(20, 6, 15, 6, 0, 225),
                            new Shoot(20, 6, 15, 6, 0, 135),
                            new TimedTransition(500, "9")
                            )
                        ),
                    new State("12",
                        new Flash(0xFFFFFF, 0.2, 12),
                        new Taunt("You're a nasty little pest!"),
                        new Prioritize(
                            new Follow(0.3, 20, 1)
                            ),
                        new HpLessTransition(0.25, "16"),
                        new Shoot(20, 1, projectileIndex: 4, coolDown: 1000),
                        new Shoot(20, 4, 45, 1, 0, 90, coolDown: 2000),
                        new Shoot(20, 4, 15, 2, 0, 90, coolDown: 2000),
                        new Shoot(20, 6, 30, 5, 0, 315, coolDown: 2500),
                        new Shoot(20, 1, projectileIndex: 0, coolDown: 1000),
                        new State("13",
                            new Shoot(20, 6, 25, 3, 0, 0),
                            new Shoot(20, 6, 15, 6, 0, 315),
                            new TimedTransition(500, "14")
                            ),
                        new State("14",
                            new Shoot(20, 6, 25, 3, 0, 90),
                            new Shoot(20, 6, 15, 6, 0, 270),
                            new TimedTransition(500, "15")
                            ),
                        new State("15",
                            new Shoot(20, 6, 15, 6, 0, 225),
                            new Shoot(20, 6, 15, 6, 0, 135),
                            new TimedTransition(500, "13")
                            )
                        ),
                    new State("16",
                        new Flash(0xFFFFFF, 0.2, 12),
                        new Taunt("You cannot handle the full power of my onslaught!"),
                        new Prioritize(
                            new Wander(0.6)
                            ),
                        new HpLessTransition(0.05, "20"),
                        new Shoot(20, 1, projectileIndex: 4, coolDown: 1000),
                        new Shoot(20, 4, 45, 1, 0, 90, coolDown: 2000),
                        new Shoot(20, 4, 15, 2, 0, 90, coolDown: 2000),
                        new Shoot(20, 6, 30, 5, 0, 315, coolDown: 2500),
                        new Shoot(20, 1, projectileIndex: 0, coolDown: 1000),
                        new Shoot(20, 24, 15, 3, 0, coolDown: 2000),
                        new State("spawn2",
                            new Order(99, "NM Blue Minion Spawner", "spawn2"),
                            new TimedTransition(100, "17")
                            ),
                        new State("17",
                            new Shoot(20, 6, 15, 6, 0, 315),
                            new TimedTransition(500, "18")
                            ),
                        new State("18",
                            new Shoot(20, 6, 15, 6, 0, 270),
                            new TimedTransition(500, "19")
                            ),
                        new State("19",
                            new Shoot(20, 6, 15, 6, 0, 225),
                            new Shoot(20, 6, 15, 6, 0, 135),
                            new TimedTransition(500, "17")
                            )
                        ),
                    new State("20",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new ReturnToSpawn(true, 0.6),
                        new Taunt("Nooooooo! This cannot be! i have underestimated your power..."),
                        new TimedTransition(3000, "21")
                        ),
                    new State("21",
                        new Suicide()
                        )
                    )
            )
            .Init("lod Blue HM Loot Balloon",
                new State(
                    new TransformOnDeath("NM Blue Dragon Dead"),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect",
                        new ThrowProjectile(0xcd5, 4, 0, 5000),
                        new ThrowProjectile(0x722, 4, 120, 5000),
                        new ThrowProjectile(0x7563, 4, 240, 5000)
                        )
                ),
                new MostDamagers(5,
                    new TierLoot(2, ItemType.Potion, 1),
                    new TierLoot(12, ItemType.Weapon, 0.05),
                    new TierLoot(11, ItemType.Weapon, 0.06),
                    new TierLoot(10, ItemType.Weapon, 0.07),
                    new TierLoot(13, ItemType.Armor, 0.05),
                    new TierLoot(12, ItemType.Armor, 0.06),
                    new TierLoot(11, ItemType.Armor, 0.07),
                    new ItemLoot("Ivory Wyvern Key", 0.01),
                    new ItemLoot("Large Blue Dragon Scale Cloth", 0.1),
                    new ItemLoot("Small Blue Dragon Scale Cloth", 0.1),
                    new ItemLoot("Potion of Mana", 0.05),
                    new ItemLoot("Wine Cellar Incantation", 0.01),
                    new ItemLoot("Water Dragon Silk Robe", 0.01)
                    )
            )
        .Init("NM Red Dragon Spawner",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("nothin"),
                new State("normal",
                    new Spawn("NM Red Dragon God", 1, 0)
                    ),
                new State("hardmode",
                    new Spawn("NM Red Dragon God Hardmode", 1, 0)
                    ),
                new State("despawn",
                    //new Decay(0)
                    new Suicide()
                    )
                )
            )
            .Init("NM Red Dragon God",
                new State(
                    new SetAltTexture(1),
                    new StayCloseToSpawn(0.5, 24),
                    new HpLessTransition(0.05, "23"),
                    new TransformOnDeath("lod Red Loot Balloon"),
                    new OnDeathBehavior(new Order(99, "NM Red Dragon Spawner", "despawn")),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("1",
                            new PlayerWithinTransition(3, "2")
                            ),
                        new State("2",
                            new Flash(0xFFFFFF, 0.2, 12),
                            new TimedTransition(2500, "pre_3")
                            ),
                        new State("pre_3",
                            new Order(999, "drac wall red", "spawn"),
                            new TimedTransition(0, "3")
                            ),
                        new State("3",
                            new SetAltTexture(0),
                            new TimedTransition(1000, "4")
                            ),
                        new State("4",
                            new Order(99, "NM Red Minion Spawner", "1"),
                            new Order(99, "NM Red Fake Egg", "1"),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 0),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 90),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 180),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 270),
                            new TimedTransition(0, "5_1")
                            ),
                        new State("5_1",
                            new EntityExistsTransition("NM Red Dragon Minion", 999, "5_2")
                            ),
                        new State("5_2",
                            new EntitiesNotExistsTransition(999, "8", "NM Red Dragon Minion"),
                            new Shoot(20, 6, 15, 4, coolDown: 1500),
                            new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                            new State("6",
                                new Shoot(99, 4, 90, 0, 0, 0),
                                new TimedTransition(500, "7")
                                ),
                            new State("7",
                                new Shoot(99, 4, 90, 0, 0, 45),
                                new TimedTransition(500, "6")
                                )
                            ),
                        new State("8",
                            new Order(999, "NM Red Dragon Lava Trigger", "8"),
                            new TimedTransition(0, "9")
                            )
                        ),
                    new State("9",
                        new HpLessTransition(0.5, "12"),
                        new Follow(0.4, 20, 1, 6000, 6000),
                        new Shoot(20, 6, 15, 4, coolDown: 1500),
                        new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                        new Shoot(99, 6, 10, 2, 0, 0, coolDown: 2500),
                        new Shoot(99, 6, 10, 2, 0, 90, coolDown: 2500),
                        new Shoot(99, 6, 10, 2, 0, 180, coolDown: 2500),
                        new Shoot(99, 6, 10, 2, 0, 270, coolDown: 2500),
                        new Shoot(20, 3, 25, 1, coolDown: 2000),
                        new Shoot(20, 1, projectileIndex: 6, coolDown: 1000),
                        new State("9_2",
                            new Flash(0x0026FF, 0.2, 12),
                            new TimedTransition(100, "10")
                            ),
                        new State("10",
                            new Shoot(99, 4, 90, 3, 0, 0, coolDownOffset: 200),
                            new Shoot(99, 4, 90, 3, 0, 10, coolDownOffset: 400),
                            new Shoot(99, 4, 90, 3, 0, 20, coolDownOffset: 600),
                            new Shoot(99, 4, 90, 3, 0, 30, coolDownOffset: 800),
                            new Shoot(99, 4, 90, 3, 0, 40, coolDownOffset: 1000),
                            new TimedTransition(1000, "11")
                            ),
                        new State("11",
                            new Shoot(99, 4, 90, 3, 0, 40, coolDownOffset: 200),
                            new Shoot(99, 4, 90, 3, 0, 30, coolDownOffset: 400),
                            new Shoot(99, 4, 90, 3, 0, 20, coolDownOffset: 600),
                            new Shoot(99, 4, 90, 3, 0, 10, coolDownOffset: 800),
                            new Shoot(99, 4, 90, 3, 0, 0, coolDownOffset: 1000),
                            new TimedTransition(1000, "10")
                            )
                        ),
                    new State("12",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("13",
                            new ReturnToSpawn(true, 0.7),
                            new TimedTransition(4000, "14")
                            ),
                        new State("14",
                            new Order(99, "NM Red Minion Spawner", "1"),
                            new Order(99, "NM Red Fake Egg", "1"),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 0),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 90),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 180),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 270),
                            new TimedTransition(0, "15")
                            ),
                        new State("15",
                            new EntityExistsTransition("NM Red Dragon Minion", 999, "16")
                            ),
                        new State("16",
                            new EntitiesNotExistsTransition(999, "18_2", "NM Red Dragon Minion"),
                            new Shoot(20, 6, 15, 4, coolDown: 1500),
                            new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                            new State("17",
                                new Shoot(99, 4, 90, 0, 0, 0),
                                new TimedTransition(500, "18")
                                ),
                            new State("18",
                                new Shoot(99, 4, 90, 0, 0, 45),
                                new TimedTransition(500, "17")
                                ),
                            new State("18_2",
                                new Order(999, "NM Red Dragon Lava Trigger", "8"),
                                new TimedTransition(0, "19")
                                )
                            )
                        ),
                    new State("19",
                        new Follow(0.4, 20, 1, 6000, 6000),
                        new Shoot(20, 6, 15, 4, coolDown: 1500),
                        new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                        new Shoot(99, 6, 10, 2, 0, 0, coolDown: 2500),
                        new Shoot(99, 6, 10, 2, 0, 90, coolDown: 2500),
                        new Shoot(99, 6, 10, 2, 0, 180, coolDown: 2500),
                        new Shoot(99, 6, 10, 2, 0, 270, coolDown: 2500),
                        new Shoot(20, 3, 25, 1, coolDown: 2000),
                        new Shoot(20, 1, projectileIndex: 6, coolDown: 1000),
                        new State("20",
                            new Flash(0x0026FF, 0.2, 12),
                            new TimedTransition(100, "21")
                            ),
                        new State("21",
                            new Shoot(99, 4, 90, 3, 0, 0, coolDownOffset: 200),
                            new Shoot(99, 4, 90, 3, 0, 10, coolDownOffset: 400),
                            new Shoot(99, 4, 90, 3, 0, 20, coolDownOffset: 600),
                            new Shoot(99, 4, 90, 3, 0, 30, coolDownOffset: 800),
                            new Shoot(99, 4, 90, 3, 0, 40, coolDownOffset: 1000),
                            new TimedTransition(1000, "22")
                            ),
                        new State("22",
                            new Shoot(99, 4, 90, 3, 0, 40, coolDownOffset: 200),
                            new Shoot(99, 4, 90, 3, 0, 30, coolDownOffset: 400),
                            new Shoot(99, 4, 90, 3, 0, 20, coolDownOffset: 600),
                            new Shoot(99, 4, 90, 3, 0, 10, coolDownOffset: 800),
                            new Shoot(99, 4, 90, 3, 0, 0, coolDownOffset: 1000),
                            new TimedTransition(1000, "21")
                            )
                        ),
                    new State("23",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("24",
                            new ReturnToSpawn(true, 0.7),
                            new Taunt(true, "I will fight you until my last breath..."),
                            new TimedTransition(3000, "25")
                            ),
                        new State("25",
                            new Suicide()
                            )
                        )
                    )
            )
            .Init("NM Red Dragon God Hardmode",
                new State(
                    new SetAltTexture(1),
                    new StayCloseToSpawn(0.5, 24),
                    new HpLessTransition(0.05, "23"),
                    new TransformOnDeath("lod Red HM Loot Balloon"),
                    new OnDeathBehavior(new Order(99, "NM Red Dragon Spawner", "despawn")),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("1",
                            new PlayerWithinTransition(3, "2")
                            ),
                        new State("2",
                            new Flash(0xFFFFFF, 0.2, 12),
                            new TimedTransition(2500, "pre_3")
                            ),
                        new State("pre_3",
                            new Order(999, "drac wall red", "spawn"),
                            new TimedTransition(0, "3")
                            ),
                        new State("3",
                            new SetAltTexture(0),
                            new TimedTransition(1000, "4")
                            ),
                        new State("4",
                            new Order(99, "NM Red Minion Spawner", "1"),
                            new Order(99, "NM Red Fake Egg", "1"),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 0),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 90),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 180),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 270),
                            new TimedTransition(0, "5_1")
                            ),
                        new State("5_1",
                            new EntityExistsTransition("NM Red Dragon Minion", 999, "5_2")
                            ),
                        new State("5_2",
                            new EntitiesNotExistsTransition(999, "8", "NM Red Dragon Minion"),
                            new Shoot(20, 6, 15, 4, coolDown: 1500),
                            new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                            new State("6",
                                new Shoot(99, 4, 90, 0, 0, 0),
                                new TimedTransition(500, "7")
                                ),
                            new State("7",
                                new Shoot(99, 4, 90, 0, 0, 45),
                                new TimedTransition(500, "6")
                                )
                            ),
                        new State("8",
                            new Order(999, "NM Red Dragon Lava Trigger", "8"),
                            new TimedTransition(0, "9")
                            )
                        ),
                    new State("9",
                        new HpLessTransition(0.5, "12"),
                        new Follow(0.5, 20, 1, 6000, 6000),
                        new Shoot(20, 6, 15, 4, coolDown: 1500),
                        new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                        new Shoot(99, 6, 10, 2, 0, 0, coolDown: 2500),
                        new Shoot(99, 6, 10, 2, 0, 90, coolDown: 2500),
                        new Shoot(99, 6, 10, 2, 0, 180, coolDown: 2500),
                        new Shoot(99, 6, 10, 2, 0, 270, coolDown: 2500),
                        new Shoot(20, 3, 25, 1, coolDown: 2000),
                        new State("9_2",
                            new Flash(0x0026FF, 0.2, 12),
                            new TimedTransition(100, "10")
                            ),
                        new State("10",
                            new Shoot(99, 4, 90, 3, 0, 0, coolDownOffset: 200),
                            new Shoot(99, 4, 90, 3, 0, 10, coolDownOffset: 400),
                            new Shoot(99, 4, 90, 3, 0, 20, coolDownOffset: 600),
                            new Shoot(99, 4, 90, 3, 0, 30, coolDownOffset: 800),
                            new Shoot(99, 4, 90, 3, 0, 40, coolDownOffset: 1000),
                            new TimedTransition(1000, "11")
                            ),
                        new State("11",
                            new Shoot(99, 4, 90, 3, 0, 40, coolDownOffset: 200),
                            new Shoot(99, 4, 90, 3, 0, 30, coolDownOffset: 400),
                            new Shoot(99, 4, 90, 3, 0, 20, coolDownOffset: 600),
                            new Shoot(99, 4, 90, 3, 0, 10, coolDownOffset: 800),
                            new Shoot(99, 4, 90, 3, 0, 0, coolDownOffset: 1000),
                            new TimedTransition(1000, "10")
                            )
                        ),
                    new State("12",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("13",
                            new ReturnToSpawn(true, 0.7),
                            new TimedTransition(4000, "14")
                            ),
                        new State("14",
                            new Order(99, "NM Red Minion Spawner", "1"),
                            new Order(99, "NM Red Fake Egg", "1"),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 0),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 90),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 180),
                            new TossObject("NM Red Dragon Lava Bomb", 2, 270),
                            new TimedTransition(0, "15")
                            ),
                        new State("15",
                            new EntityExistsTransition("NM Red Dragon Minion", 999, "16")
                            ),
                        new State("16",
                            new EntitiesNotExistsTransition(999, "18_2", "NM Red Dragon Minion"),
                            new Shoot(20, 6, 15, 4, coolDown: 1500),
                            new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                            new State("17",
                                new Shoot(99, 4, 90, 0, 0, 0),
                                new TimedTransition(500, "18")
                                ),
                            new State("18",
                                new Shoot(99, 4, 90, 0, 0, 45),
                                new TimedTransition(500, "17")
                                ),
                            new State("18_2",
                                new Order(999, "NM Red Dragon Lava Trigger", "8"),
                                new TimedTransition(0, "19")
                                )
                            )
                        ),
                    new State("19",
                        new Follow(0.5, 20, 1, 6000, 6000),
                        new Shoot(20, 6, 15, 4, coolDown: 1500),
                        new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                        new Shoot(99, 6, 10, 2, 0, 0, coolDown: 2500),
                        new Shoot(99, 6, 10, 2, 0, 90, coolDown: 2500),
                        new Shoot(99, 6, 10, 2, 0, 180, coolDown: 2500),
                        new Shoot(99, 6, 10, 2, 0, 270, coolDown: 2500),
                        new Shoot(20, 3, 25, 1, coolDown: 2000),
                        new State("20",
                            new Flash(0x0026FF, 0.2, 12),
                            new TimedTransition(100, "21")
                            ),
                        new State("21",
                            new Shoot(99, 4, 90, 3, 0, 0, coolDownOffset: 200),
                            new Shoot(99, 4, 90, 3, 0, 10, coolDownOffset: 400),
                            new Shoot(99, 4, 90, 3, 0, 20, coolDownOffset: 600),
                            new Shoot(99, 4, 90, 3, 0, 30, coolDownOffset: 800),
                            new Shoot(99, 4, 90, 3, 0, 40, coolDownOffset: 1000),
                            new TimedTransition(1000, "22")
                            ),
                        new State("22",
                            new Shoot(99, 4, 90, 3, 0, 40, coolDownOffset: 200),
                            new Shoot(99, 4, 90, 3, 0, 30, coolDownOffset: 400),
                            new Shoot(99, 4, 90, 3, 0, 20, coolDownOffset: 600),
                            new Shoot(99, 4, 90, 3, 0, 10, coolDownOffset: 800),
                            new Shoot(99, 4, 90, 3, 0, 0, coolDownOffset: 1000),
                            new TimedTransition(1000, "21")
                            )
                        ),
                    new State("23",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("24",
                            new ReturnToSpawn(true, 0.7),
                            new Taunt(true, "I will fight you until my last breath..."),
                            new TimedTransition(3000, "25")
                            ),
                        new State("25",
                            new Suicide()
                            )
                        )
                    )
            )
        .Init("NM Red Fake Egg",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("nothin"),
                new State("1",
                    new Flash(0xFFFFFF, 0.2, 12)
                    )
                )
            )
        .Init("NM Red Minion Spawner",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("nothin"),
                new State("1",
                    new Flash(0xFFFFFF, 0.2, 12),
                    new TimedTransition(2500, "2")
                    ),
                new State("2",
                    new Spawn("NM Red Dragon Minion", 1, 0),
                    new TimedTransition(100, "nothin")
                    )
                )
            )
        .Init("NM Red Open Wall",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("nothin"),
                new State("1",
                    new ApplySetpiece("RedOpenWall")
                    )
                )
            )
        .Init("NM Red Dragon Minion",
            new State(
                new Orbit(0.3, 4, 8, null),
                new Shoot(8, 1, projectileIndex: 0, coolDown: 1500)
                )
            )
        .Init("NM Red Dragon Lava Bomb",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("1",
                    new TimedTransition(1000, "2")
                    ),
                new State("2",
                    new Order(999, "NM Red Dragon Lava Trigger", "3"),
                    new Aoe(1, false, 0, 0, false, 0xFF0000),
                    new Decay(0)
                    )
                )
            )
        .Init("NM Red Dragon Lava Trigger",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("1"),
                new State("3",
                    new ApplySetpiece("RedDragonLavaTrigger1"),
                    new TimedTransition(2000, "4")
                    ),
                new State("4",
                    new ApplySetpiece("RedDragonLavaTrigger2"),
                    new TimedTransition(2000, "5")
                    ),
                new State("5",
                    new ApplySetpiece("RedDragonLavaTrigger3"),
                    new TimedTransition(2000, "6")
                    ),
                new State("6",
                    new ApplySetpiece("RedDragonLavaTrigger4"),
                    new TimedTransition(2000, "7")
                    ),
                new State("7",
                    new ApplySetpiece("RedDragonLavaTrigger5")
                    ),
                new State("8",
                    new ApplySetpiece("RedDragonLavaTrigger6"),
                    new TimedTransition(100, "1")
                    )
                )
            )
        .Init("drac wall red",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("nothin"),
                new State("spawn",
                    new ApplySetpiece("RedCloseWall1"),
                    new TimedTransition(3000, "spawn2")
                    ),
                new State("spawn2",
                    new ApplySetpiece("RedCloseWall2"),
                    new TimedTransition(3000, "spawn3")
                    ),
                new State("spawn3",
                    new ApplySetpiece("RedCloseWall3"),
                    new TimedTransition(3000, "spawn4")
                    ),
                new State("spawn4",
                    new ApplySetpiece("RedCloseWall4"),
                    new TimedTransition(3000, "spawn5")
                    ),
                new State("spawn5",
                    new ApplySetpiece("RedCloseWall5")
                    )
                )
            )
        .Init("Iron Wall",
            new State(
                new State("2",
                    new EntityExistsTransition("lod Red Loot Balloon", 999, "3_1"),
                    new EntityExistsTransition("lod Red HM Loot Balloon", 999, "3_2")
                    ),
                new State("3_1",
                    new EntityNotExistsTransition("lod Red Loot Balloon", 999, "despawn")
                    ),
                new State("3_2",
                    new EntityNotExistsTransition("lod Red HM Loot Balloon", 999, "despawn")
                    ),
                new State("despawn",
                    new Decay(0)
                    )
                )
            )
            .Init("lod Red HM Loot Balloon",
                new State(
                    new TransformOnDeath("NM Red Dragon Dead"),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect",
                        new ThrowProjectile(0xcd5, 4, 0, 5000),
                        new ThrowProjectile(0x722, 4, 120, 5000),
                        new ThrowProjectile(0x7564, 4, 240, 5000)
                        )
                ),
                new MostDamagers(5,
                    new TierLoot(2, ItemType.Potion, 1),
                    new TierLoot(12, ItemType.Weapon, 0.05),
                    new TierLoot(11, ItemType.Weapon, 0.06),
                    new TierLoot(10, ItemType.Weapon, 0.07),
                    new TierLoot(13, ItemType.Armor, 0.05),
                    new TierLoot(12, ItemType.Armor, 0.06),
                    new TierLoot(11, ItemType.Armor, 0.07),
                    new ItemLoot("Ivory Wyvern Key", 0.01),
                    new ItemLoot("Large Red Dragon Scale Cloth", 0.1),
                    new ItemLoot("Small Red Dragon Scale Cloth", 0.1),
                    new ItemLoot("Wine Cellar Incantation", 0.01),
                    new ItemLoot("Fire Dragon Battle Armor", 0.01)
                    )
            )
            .Init("lod Red Loot Balloon",
                new State(
                    new TransformOnDeath("NM Red Dragon Dead"),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect",
                        new ThrowProjectile(0xcd5, 4, 0, 5000),
                        new ThrowProjectile(0x722, 4, 120, 5000),
                        new ThrowProjectile(0x7564, 4, 240, 5000)
                        )
                ),
                new MostDamagers(5,
                    new TierLoot(2, ItemType.Potion, 1),
                    new TierLoot(12, ItemType.Weapon, 0.03),
                    new TierLoot(11, ItemType.Weapon, 0.04),
                    new TierLoot(10, ItemType.Weapon, 0.05),
                    new TierLoot(13, ItemType.Armor, 0.03),
                    new TierLoot(12, ItemType.Armor, 0.04),
                    new TierLoot(11, ItemType.Armor, 0.05),
                    new ItemLoot("Ivory Wyvern Key", 0.008),
                    new ItemLoot("Large Red Dragon Scale Cloth", 0.08),
                    new ItemLoot("Small Red Dragon Scale Cloth", 0.08),
                    new ItemLoot("Wine Cellar Incantation", 0.008),
                    new ItemLoot("Fire Dragon Battle Armor", 0.008)
                    )
            )
        //1
            .Init("NM Red Dragon Dead",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible)
                    )
                )
            .Init("NM Green Dragon Dead",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible)
                    )
                )
            .Init("NM Blue Dragon Dead",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible)
                    )
                )
            .Init("NM Black Dragon Dead",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible)
                    )
                )
            .Init("NM Green Dragon God",
                new State(
                    new SetAltTexture(1),
                    new StayCloseToSpawn(0.5, 24),
                    new HpLessTransition(0.05, "19"),
                    new TransformOnDeath("lod Green Loot Balloon"),
                    new OnDeathBehavior(new Order(99, "NM Green Dragon Spawner", "despawn")),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("1",
                            new PlayerWithinTransition(3, "pre_2")
                            ),
                        new State("pre_2",
                            new Order(999, "drac wall green", "spawn"),
                            new TimedTransition(500, "2")
                            ),
                        new State("2",
                            new Flash(0xFFFFFF, 0.2, 12),
                            new TimedTransition(2500, "3")
                            ),
                        new State("3",
                            new SetAltTexture(0),
                            new TimedTransition(1000, "4")
                            ),
                        new State("4",
                            new TossObject("NM Green Dragon Shield", 3, 0),
                            new TossObject("NM Green Dragon Shield", 3, 45),
                            new TossObject("NM Green Dragon Shield", 3, 90),
                            new TossObject("NM Green Dragon Shield", 3, 135),
                            new TossObject("NM Green Dragon Shield", 3, 180),
                            new TossObject("NM Green Dragon Shield", 3, 225),
                            new TossObject("NM Green Dragon Shield", 3, 270),
                            new TossObject("NM Green Dragon Shield", 3, 315),
                            new TimedTransition(0, "5")
                            ),
                        new State("5",
                            new EntityExistsTransition("NM Green Dragon Shield", 999, "6")
                            ),
                        new State("6",
                            new EntitiesNotExistsTransition(999, "7", "NM Green Dragon Shield"),
                            new Shoot(99, 12, 30, 0, 0, 45, coolDown: 1500),
                            new Shoot(99, 2, 15, 6, 0, 0, coolDown: 1000),
                            new Shoot(99, 2, 15, 6, 0, 90, coolDown: 1000),
                            new Shoot(99, 2, 15, 6, 0, 180, coolDown: 1000),
                            new Shoot(99, 2, 15, 6, 0, 270, coolDown: 1000),
                            new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                            new Shoot(20, 2, 15, 4, coolDown: 1000)
                            )
                        ),
                    new State("7",
                        new HpLessTransition(0.5, "8"),
                        new Follow(0.4, 20, 1),
                        new Spawn("NM Green Dragon Minion", 5, 0),
                        new Shoot(99, 12, 30, 0, 0, 45, coolDown: 1500),
                        new Shoot(99, 2, 15, 6, 0, 0, coolDown: 1000),
                        new Shoot(99, 2, 15, 6, 0, 90, coolDown: 1000),
                        new Shoot(99, 2, 15, 6, 0, 180, coolDown: 1000),
                        new Shoot(99, 2, 15, 6, 0, 270, coolDown: 1000),
                        new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                        new Shoot(20, 2, 15, 4, coolDown: 1000)
                        ),
                    new State("8",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("9",
                            new ReturnToSpawn(true, 0.7),
                            new Flash(0xFFFFFF, 0.2, 12),
                            new TimedTransition(4000, "10")
                            ),
                        new State("10",
                            new TossObject("NM Green Dragon Shield", 3, 0),
                            new TossObject("NM Green Dragon Shield", 3, 45),
                            new TossObject("NM Green Dragon Shield", 3, 90),
                            new TossObject("NM Green Dragon Shield", 3, 135),
                            new TossObject("NM Green Dragon Shield", 3, 180),
                            new TossObject("NM Green Dragon Shield", 3, 225),
                            new TossObject("NM Green Dragon Shield", 3, 270),
                            new TossObject("NM Green Dragon Shield", 3, 315),
                            new TimedTransition(0, "11")
                            ),
                        new State("11",
                            new EntityExistsTransition("NM Green Dragon Shield", 999, "12")
                            ),
                        new State("12",
                            new EntitiesNotExistsTransition(999, "18", "NM Green Dragon Shield"),
                            new Shoot(99, 2, 15, 6, 0, 0, coolDown: 1000),
                            new Shoot(99, 2, 15, 6, 0, 90, coolDown: 1000),
                            new Shoot(99, 2, 15, 6, 0, 180, coolDown: 1000),
                            new Shoot(99, 2, 15, 6, 0, 270, coolDown: 1000),
                            new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                            new Shoot(20, 2, 15, 4, coolDown: 1000),
                            new State("13",
                                new Shoot(99, 12, 30, 0, 0, 45, coolDown: 1500),
                                new TimedTransition(4500, "14")
                                ),
                            new State("14",
                                new Shoot(99, 4, 90, 0, 0, 45, coolDownOffset: 200),
                                new Shoot(99, 4, 90, 0, 0, 52, coolDownOffset: 400),
                                new Shoot(99, 4, 90, 0, 0, 59, coolDownOffset: 600),
                                new Shoot(99, 4, 90, 0, 0, 66, coolDownOffset: 800),
                                new Shoot(99, 4, 90, 0, 0, 73, coolDownOffset: 1000),
                                new Shoot(99, 4, 90, 0, 0, 80, coolDownOffset: 1200),
                                new Shoot(99, 4, 90, 0, 0, 87, coolDownOffset: 1400),
                                new Shoot(99, 4, 90, 0, 0, 90, coolDownOffset: 1600),
                                new TimedTransition(1600, "15")
                                ),
                            new State("15",
                                new Shoot(99, 4, 90, 0, 0, 90, coolDown: 200),
                                new TimedTransition(400, "16")
                                ),
                            new State("16",
                                new Shoot(99, 4, 90, 0, 0, 90, coolDownOffset: 200),
                                new Shoot(99, 4, 90, 0, 0, 87, coolDownOffset: 400),
                                new Shoot(99, 4, 90, 0, 0, 80, coolDownOffset: 600),
                                new Shoot(99, 4, 90, 0, 0, 73, coolDownOffset: 800),
                                new Shoot(99, 4, 90, 0, 0, 66, coolDownOffset: 1000),
                                new Shoot(99, 4, 90, 0, 0, 59, coolDownOffset: 1200),
                                new Shoot(99, 4, 90, 0, 0, 52, coolDownOffset: 1400),
                                new Shoot(99, 4, 90, 0, 0, 45, coolDownOffset: 1600),
                                new TimedTransition(1600, "17")
                                ),
                            new State("17",
                                new Shoot(99, 4, 90, 0, 0, 45, coolDown: 200),
                                new TimedTransition(400, "13")
                                )
                            )
                        ),
                    new State("18",
                        new Follow(0.4, 20, 1),
                        new Spawn("NM Green Dragon Minion", 5, 0),
                        new Shoot(99, 12, 30, 0, 0, 45, coolDown: 1500),
                        new Shoot(99, 2, 15, 6, 0, 0, coolDown: 1000),
                        new Shoot(99, 2, 15, 6, 0, 90, coolDown: 1000),
                        new Shoot(99, 2, 15, 6, 0, 180, coolDown: 1000),
                        new Shoot(99, 2, 15, 6, 0, 270, coolDown: 1000),
                        new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                        new Shoot(20, 2, 15, 4, coolDown: 1000)
                        ),
                    new State("19",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("20",
                            new ReturnToSpawn(true, 0.7),
                            new Taunt(true, "Flee my servants, I can no longer protect you as you have protected me..."),
                            new TimedTransition(3000, "21")
                            ),
                        new State("21",
                            new Suicide()
                            )
                        )
                    )
            )
            .Init("NM Green Open Wall",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("nothin"),
                new State("1",
                    new ApplySetpiece("GreenOpenWall")
                    )
                )
            )
            .Init("NM Green Dragon God Hardmode",
                new State(
                    new SetAltTexture(1),
                    new StayCloseToSpawn(0.5, 24),
                    new HpLessTransition(0.05, "19"),
                    new TransformOnDeath("lod Green HM Loot Balloon"),
                    new OnDeathBehavior(new Order(99, "NM Green Dragon Spawner", "despawn")),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("1",
                            new PlayerWithinTransition(3, "pre_2")
                            ),
                        new State("pre_2",
                            new Order(999, "drac wall green", "spawn"),
                            new TimedTransition(500, "2")
                            ),
                        new State("2",
                            new Flash(0xFFFFFF, 0.2, 12),
                            new TimedTransition(2500, "3")
                            ),
                        new State("3",
                            new SetAltTexture(0),
                            new TimedTransition(1000, "4")
                            ),
                        new State("4",
                            new TossObject("NM Green Dragon Shield", 3, 0),
                            new TossObject("NM Green Dragon Shield", 3, 45),
                            new TossObject("NM Green Dragon Shield", 3, 90),
                            new TossObject("NM Green Dragon Shield", 3, 135),
                            new TossObject("NM Green Dragon Shield", 3, 180),
                            new TossObject("NM Green Dragon Shield", 3, 225),
                            new TossObject("NM Green Dragon Shield", 3, 270),
                            new TossObject("NM Green Dragon Shield", 3, 315),
                            new TimedTransition(0, "5")
                            ),
                        new State("5",
                            new EntityExistsTransition("NM Green Dragon Shield", 999, "6")
                            ),
                        new State("6",
                            new EntitiesNotExistsTransition(999, "7", "NM Green Dragon Shield"),
                            new Shoot(99, 12, 30, 0, 0, 45, coolDown: 1500),
                            new Shoot(99, 2, 15, 6, 0, 0, coolDown: 1000),
                            new Shoot(99, 2, 15, 6, 0, 90, coolDown: 1000),
                            new Shoot(99, 2, 15, 6, 0, 180, coolDown: 1000),
                            new Shoot(99, 2, 15, 6, 0, 270, coolDown: 1000),
                            new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                            new Shoot(20, 2, 15, 4, coolDown: 1000)
                            )
                        ),
                    new State("7",
                        new HpLessTransition(0.5, "8"),
                        new Follow(0.4, 20, 1),
                        new Spawn("NM Green Dragon Minion", 5, 0),
                        new Shoot(99, 12, 30, 0, 0, 45, coolDown: 1500),
                        new Shoot(99, 2, 15, 6, 0, 0, coolDown: 1000),
                        new Shoot(99, 2, 15, 6, 0, 90, coolDown: 1000),
                        new Shoot(99, 2, 15, 6, 0, 180, coolDown: 1000),
                        new Shoot(99, 2, 15, 6, 0, 270, coolDown: 1000),
                        new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                        new Shoot(20, 2, 15, 4, coolDown: 1000)
                        ),
                    new State("8",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("9",
                            new ReturnToSpawn(true, 0.7),
                            new Flash(0xFFFFFF, 0.2, 12),
                            new TimedTransition(4000, "10")
                            ),
                        new State("10",
                            new TossObject("NM Green Dragon Shield", 3, 0),
                            new TossObject("NM Green Dragon Shield", 3, 45),
                            new TossObject("NM Green Dragon Shield", 3, 90),
                            new TossObject("NM Green Dragon Shield", 3, 135),
                            new TossObject("NM Green Dragon Shield", 3, 180),
                            new TossObject("NM Green Dragon Shield", 3, 225),
                            new TossObject("NM Green Dragon Shield", 3, 270),
                            new TossObject("NM Green Dragon Shield", 3, 315),
                            new TimedTransition(0, "11")
                            ),
                        new State("11",
                            new EntityExistsTransition("NM Green Dragon Shield", 999, "12")
                            ),
                        new State("12",
                            new EntitiesNotExistsTransition(999, "18", "NM Green Dragon Shield"),
                            new Shoot(99, 2, 15, 6, 0, 0, coolDown: 1000),
                            new Shoot(99, 2, 15, 6, 0, 90, coolDown: 1000),
                            new Shoot(99, 2, 15, 6, 0, 180, coolDown: 1000),
                            new Shoot(99, 2, 15, 6, 0, 270, coolDown: 1000),
                            new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                            new Shoot(20, 2, 15, 4, coolDown: 1000),
                            new State("13",
                                new Shoot(99, 12, 30, 0, 0, 45, coolDown: 1500),
                                new TimedTransition(4500, "14")
                                ),
                            new State("14",
                                new Shoot(99, 4, 90, 0, 0, 45, coolDownOffset: 200),
                                new Shoot(99, 4, 90, 0, 0, 52, coolDownOffset: 400),
                                new Shoot(99, 4, 90, 0, 0, 59, coolDownOffset: 600),
                                new Shoot(99, 4, 90, 0, 0, 66, coolDownOffset: 800),
                                new Shoot(99, 4, 90, 0, 0, 73, coolDownOffset: 1000),
                                new Shoot(99, 4, 90, 0, 0, 80, coolDownOffset: 1200),
                                new Shoot(99, 4, 90, 0, 0, 87, coolDownOffset: 1400),
                                new Shoot(99, 4, 90, 0, 0, 90, coolDownOffset: 1600),
                                new TimedTransition(1600, "15")
                                ),
                            new State("15",
                                new Shoot(99, 4, 90, 0, 0, 90, coolDown: 200),
                                new TimedTransition(400, "16")
                                ),
                            new State("16",
                                new Shoot(99, 4, 90, 0, 0, 90, coolDownOffset: 200),
                                new Shoot(99, 4, 90, 0, 0, 87, coolDownOffset: 400),
                                new Shoot(99, 4, 90, 0, 0, 80, coolDownOffset: 600),
                                new Shoot(99, 4, 90, 0, 0, 73, coolDownOffset: 800),
                                new Shoot(99, 4, 90, 0, 0, 66, coolDownOffset: 1000),
                                new Shoot(99, 4, 90, 0, 0, 59, coolDownOffset: 1200),
                                new Shoot(99, 4, 90, 0, 0, 52, coolDownOffset: 1400),
                                new Shoot(99, 4, 90, 0, 0, 45, coolDownOffset: 1600),
                                new TimedTransition(1600, "17")
                                ),
                            new State("17",
                                new Shoot(99, 4, 90, 0, 0, 45, coolDown: 200),
                                new TimedTransition(400, "13")
                                )
                            )
                        ),
                    new State("18",
                        new Follow(0.4, 20, 1),
                        new Spawn("NM Green Dragon Minion", 5, 0),
                        new Shoot(99, 12, 30, 0, 0, 45, coolDown: 1500),
                        new Shoot(99, 2, 15, 6, 0, 0, coolDown: 1000),
                        new Shoot(99, 2, 15, 6, 0, 90, coolDown: 1000),
                        new Shoot(99, 2, 15, 6, 0, 180, coolDown: 1000),
                        new Shoot(99, 2, 15, 6, 0, 270, coolDown: 1000),
                        new Shoot(99, 10, 36, 5, 0, 10, coolDown: 2000),
                        new Shoot(20, 2, 15, 4, coolDown: 1000)
                        ),
                    new State("19",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("20",
                            new ReturnToSpawn(true, 0.7),
                            new Taunt(true, "Flee my servants, I can no longer protect you as you have protected me..."),
                            new TimedTransition(3000, "21")
                            ),
                        new State("21",
                            new Suicide()
                            )
                        )
                    )
            )
        .Init("NM Green Dragon Spawner",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("nothin"),
                new State("normal",
                    new Spawn("NM Green Dragon God", 1, 0)
                    ),
                new State("hardmode",
                    new Spawn("NM Green Dragon God Hardmode", 1, 0)
                    ),
                new State("despawn",
                    //new Decay(0)
                    new Suicide()
                    )
                )
            )
        .Init("NM Green Dragon Shield",
            new State(
                new Orbit(0.4, 3, 10, "NM Green Dragon God"),
                new Orbit(0.4, 3, 10, "NM Green Dragon God Hardmode"),
                new State("1",
                    new Shoot(20, 1, projectileIndex: 0, coolDown: 5000),
                    new TimedTransition(10000, "2")
                    ),
                new State("2",
                    new Shoot(20, 1, projectileIndex: 1, coolDown: 5000),
                    new TimedTransition(10000, "1")
                    )
                )
            )
              .Init("lod Mirror Wyvern1",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new Shoot(8.4, count: 1, projectileIndex: 0, coolDown: 1)
                    )
            )
              .Init("lod White Dragon Orb",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new Shoot(8.4, count: 6, projectileIndex: 0, coolDown: 2000),
                    new Shoot(8.4, count: 6, projectileIndex: 1, coolDown: 1671)
                    )
            )
               .Init("lod Red Soul Flame",
                new State(
                    new Shoot(8.4, count: 6, shootAngle: 22, projectileIndex: 0, fixedAngle: 90, coolDown: new Cooldown(750, 250))
                    )
            )
               .Init("lod Green Soul Flame",
                new State(
                    new Shoot(8.4, count: 6, shootAngle: 22, projectileIndex: 0, fixedAngle: 90, coolDown: new Cooldown(750, 250))
                    )
            )
                .Init("lod Blue Soul Flame",
                new State(
                    new Shoot(8.4, count: 6, shootAngle: 22, projectileIndex: 0, fixedAngle: 90, coolDown: new Cooldown(750, 250))
                    )
            )
               .Init("lod Black Soul Flame",
                new State(
                    new Shoot(8.4, count: 6, shootAngle: 22, projectileIndex: 0, fixedAngle: 90, coolDown: new Cooldown(750, 250))
                    )
            )
        .Init("NM Green Dragon Minion",
            new State(
                new Protect(0.5, "NM Green Dragon God", 10, 7),
                new Protect(0.5, "NM Green Dragon God Hardmode", 10, 7),
                new Wander(0.3),
                new Shoot(10, 1, projectileIndex: 3, coolDown: 1000),
                new State("1",
                    new EntitiesNotExistsTransition(999, "2", "NM Green Dragon God", "NM Green Dragon God Hardmode")
                    ),
                new State("2",
                    new Suicide()
                    )
                )
            )
            .Init("lod Green Loot Balloon",
                new State(
                    new TransformOnDeath("NM Green Dragon Dead"),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect",
                        new ThrowProjectile(0xcd5, 4, 0, 5000),
                        new ThrowProjectile(0x722, 4, 120, 5000),
                        new ThrowProjectile(0x7562, 4, 240, 5000)
                        )
                ),
                new MostDamagers(5,
                    new TierLoot(2, ItemType.Potion, 1),
                    new TierLoot(12, ItemType.Weapon, 0.03),
                    new TierLoot(11, ItemType.Weapon, 0.04),
                    new TierLoot(10, ItemType.Weapon, 0.05),
                    new TierLoot(13, ItemType.Armor, 0.03),
                    new TierLoot(12, ItemType.Armor, 0.04),
                    new TierLoot(11, ItemType.Armor, 0.05),
                    new ItemLoot("Ivory Wyvern Key", 0.008),
                    new ItemLoot("Large Green Dragon Scale Cloth", 0.08),
                    new ItemLoot("Small Green Dragon Scale Cloth", 0.08),
                    new ItemLoot("Wine Cellar Incantation", 0.008),
                    new ItemLoot("Leaf Dragon Hide Armor", 0.008)
                    )
            )
            .Init("lod Green HM Loot Balloon",
                new State(
                    new TransformOnDeath("NM Green Dragon Dead"),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect",
                        new ThrowProjectile(0xcd5, 4, 0, 5000),
                        new ThrowProjectile(0x722, 4, 120, 5000),
                        new ThrowProjectile(0x7562, 4, 240, 5000)
                        )
                ),
                new MostDamagers(5,
                    new TierLoot(2, ItemType.Potion, 1),
                    new TierLoot(12, ItemType.Weapon, 0.05),
                    new TierLoot(11, ItemType.Weapon, 0.06),
                    new TierLoot(10, ItemType.Weapon, 0.07),
                    new TierLoot(13, ItemType.Armor, 0.05),
                    new TierLoot(12, ItemType.Armor, 0.06),
                    new TierLoot(11, ItemType.Armor, 0.07),
                    new ItemLoot("Ivory Wyvern Key", 0.01),
                    new ItemLoot("Large Green Dragon Scale Cloth", 0.1),
                    new ItemLoot("Small Green Dragon Scale Cloth", 0.1),
                    new ItemLoot("Wine Cellar Incantation", 0.01),
                    new ItemLoot("Leaf Dragon Hide Armor", 0.01)
                    )
            )
        .Init("drac wall green",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("nothin"),
                new State("spawn",
                    new ApplySetpiece("GreenCloseWall1"),
                    new TimedTransition(3000, "spawn2")
                    ),
                new State("spawn2",
                    new ApplySetpiece("GreenCloseWall2"),
                    new TimedTransition(3000, "spawn3")
                    ),
                new State("spawn3",
                    new ApplySetpiece("GreenCloseWall3"),
                    new TimedTransition(3000, "spawn4")
                    ),
                new State("spawn4",
                    new ApplySetpiece("GreenCloseWall4"),
                    new TimedTransition(3000, "spawn5")
                    ),
                new State("spawn5",
                    new ApplySetpiece("GreenCloseWall5")
                    )
                )
            )
        .Init("drac floor green",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible)
                )
            )
        .Init("Big Trees",
            new State(
                new State("2",
                    new EntityExistsTransition("lod Green Loot Balloon", 999, "3_1"),
                    new EntityExistsTransition("lod Green HM Loot Balloon", 999, "3_2")
                    ),
                new State("3_1",
                    new EntityNotExistsTransition("lod Green Loot Balloon", 999, "despawn")
                    ),
                new State("3_2",
                    new EntityNotExistsTransition("lod Green HM Loot Balloon", 999, "despawn")
                    ),
                new State("despawn",
                    new Decay(0)
                    )
                )
            )
        .Init("Stalagmite",
            new State(
                new State("2",
                    new EntityExistsTransition("lod Black Loot Balloon", 999, "3_1"),
                    new EntityExistsTransition("lod Black HM Loot Balloon", 999, "3_2")
                    ),
                new State("3_1",
                    new EntityNotExistsTransition("lod Black Loot Balloon", 999, "despawn")
                    ),
                new State("3_2",
                    new EntityNotExistsTransition("lod Black HM Loot Balloon", 999, "despawn")
                    ),
                new State("despawn",
                    new Decay(0)
                    )
                )
            )
            .Init("NM Black Open Wall",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("nothin"),
                    new State("1",
                    new ApplySetpiece("BlackOpenWall")
                        )
                    )
                )
            .Init("drac wall black",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("nothin"),
                new State("spawn",
                    new ApplySetpiece("BlackCloseWall1"),
                    new TimedTransition(3000, "spawn2")
                    ),
                new State("spawn2",
                    new ApplySetpiece("BlackCloseWall2"),
                    new TimedTransition(3000, "spawn3")
                    ),
                new State("spawn3",
                    new ApplySetpiece("BlackCloseWall3"),
                    new TimedTransition(3000, "spawn4")
                    ),
                new State("spawn4",
                    new ApplySetpiece("BlackCloseWall4"),
                    new TimedTransition(3000, "spawn5")
                    ),
                new State("spawn5",
                    new ApplySetpiece("BlackCloseWall5")
                    )
                )
            )
            .Init("NM Black Dragon God",
                new State(
                    new SetAltTexture(1),
                    new StayCloseToSpawn(0.5, 24),
                    new HpLessTransition(0.05, "15"),
                    new TransformOnDeath("lod Black Loot Balloon"),
                    new OnDeathBehavior(new Order(99, "NM Black Dragon Spawner", "despawn")),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("1",
                            new PlayerWithinTransition(3, "pre_2")
                            ),
                        new State("pre_2",
                            new Order(999, "drac wall black", "spawn"),
                            new TimedTransition(500, "3")
                            ),
                        new State("2",
                            new Flash(0xFFFFFF, 0.2, 12),
                            new TimedTransition(2500, "3")
                            ),
                        new State("3",
                            new SetAltTexture(0),
                            new Taunt("Prepare to meet your doom. There is no mercy here."),
                            new TimedTransition(1000, "4")
                            )
                        ),
                    new State("4",
                        new Follow(0.4, 10, 3),
                        new StayCloseToSpawn(0.7, 10),
                        new Shoot(12, 5, 36, 0, coolDown: 1000),
                        new Shoot(12, 1, projectileIndex: 1, coolDown: 500),
                        new Shoot(12, 5, 36, 2, predictive: 1, coolDown: 1000),
                        new Shoot(22, 2, 45, 3, coolDown: 1000),
                        new Shoot(12, 5, 36, 5, coolDown: 1500),
                        new Shoot(999, 5, 25, 7, 0, 270, coolDown: 1000),
                        new Grenade(4, 100, 14, coolDown: 7000),
                        new Spawn("NM Black Dragon Shadow", 2, 0),
                        new Reproduce("NM Black Dragon Shadow", 99, 2, 0, 10000),
                        new State("5",
                            new NoPlayerWithinTransition(10, "6"),
                            new State("7",
                                new Shoot(999, 6, 25, 6, 0, 0),
                                new TimedTransition(1000, "8")
                                ),
                            new State("8",
                                new Shoot(999, 6, 25, 6, 0, 90),
                                new TimedTransition(1000, "9")
                                ),
                            new State("9",
                                new Shoot(999, 6, 25, 6, 0, 180),
                                new TimedTransition(1000, "10")
                                ),
                            new State("10",
                                new Shoot(999, 6, 25, 6, 0, 270),
                                new TimedTransition(1000, "7")
                                )
                            ),
                        new State("6",
                            new ReturnToSpawn(true, 0.7),
                            new PlayerWithinTransition(10, "5"),
                            new State("11",
                                new Shoot(999, 6, 25, 6, 0, 0),
                                new TimedTransition(1000, "12")
                                ),
                            new State("12",
                                new Shoot(999, 6, 25, 6, 0, 90),
                                new TimedTransition(1000, "13")
                                ),
                            new State("13",
                                new Shoot(999, 6, 25, 6, 0, 180),
                                new TimedTransition(1000, "14")
                                ),
                            new State("14",
                                new Shoot(999, 6, 25, 6, 0, 270),
                                new TimedTransition(1000, "11")
                                )
                            )
                        ),
                    new State("15",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("16",
                            new ReturnToSpawn(true, 0.7),
                            new Taunt(true, "Until we meet again...sub-creature..."),
                            new TimedTransition(3000, "17")
                            ),
                        new State("17",
                            new Suicide()
                            )
                        )
                    )
            )
            .Init("NM Black Dragon God Hardmode",
                new State(
                    new SetAltTexture(1),
                    new StayCloseToSpawn(0.5, 24),
                    new HpLessTransition(0.05, "15"),
                    new TransformOnDeath("lod Black HM Loot Balloon"),
                    new OnDeathBehavior(new Order(99, "NM Black Dragon Spawner", "despawn")),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("1",
                            new PlayerWithinTransition(3, "pre_2")
                            ),
                        new State("pre_2",
                            new Order(999, "drac wall black", "spawn"),
                            new TimedTransition(500, "3")
                            ),
                        new State("2",
                            new Flash(0xFFFFFF, 0.2, 12),
                            new TimedTransition(2500, "3")
                            ),
                        new State("3",
                            new SetAltTexture(0),
                            new Taunt("Prepare to meet your doom. There is no mercy here."),
                            new TimedTransition(1000, "4")
                            )
                        ),
                    new State("4",
                        new Follow(0.4, 10, 3),
                        new StayCloseToSpawn(0.7, 10),
                        new Shoot(12, 5, 36, 0, coolDown: 1000),
                        new Shoot(12, 1, projectileIndex: 1, coolDown: 500),
                        new Shoot(12, 5, 36, 2, predictive: 1, coolDown: 1000),
                        new Shoot(22, 2, 45, 3, coolDown: 1000),
                        new Shoot(12, 5, 36, 5, coolDown: 1500),
                        new Shoot(999, 5, 25, 7, 0, 270, coolDown: 1000),
                        new Grenade(4, 100, 14, coolDown: 7000),
                        new Spawn("NM Black Dragon Shadow", 2, 0),
                        new Reproduce("NM Black Dragon Shadow", 99, 2, 0, 10000),
                        new State("5",
                            new NoPlayerWithinTransition(10, "6"),
                            new State("7",
                                new Shoot(999, 6, 25, 6, 0, 0),
                                new TimedTransition(1000, "8")
                                ),
                            new State("8",
                                new Shoot(999, 6, 25, 6, 0, 90),
                                new TimedTransition(1000, "9")
                                ),
                            new State("9",
                                new Shoot(999, 6, 25, 6, 0, 180),
                                new TimedTransition(1000, "10")
                                ),
                            new State("10",
                                new Shoot(999, 6, 25, 6, 0, 270),
                                new TimedTransition(1000, "7")
                                )
                            ),
                        new State("6",
                            new ReturnToSpawn(true, 0.7),
                            new PlayerWithinTransition(10, "5"),
                            new State("11",
                                new Shoot(999, 6, 25, 6, 0, 0),
                                new TimedTransition(1000, "12")
                                ),
                            new State("12",
                                new Shoot(999, 6, 25, 6, 0, 90),
                                new TimedTransition(1000, "13")
                                ),
                            new State("13",
                                new Shoot(999, 6, 25, 6, 0, 180),
                                new TimedTransition(1000, "14")
                                ),
                            new State("14",
                                new Shoot(999, 6, 25, 6, 0, 270),
                                new TimedTransition(1000, "11")
                                )
                            )
                        ),
                    new State("15",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new State("16",
                            new ReturnToSpawn(true, 0.7),
                            new Taunt(true, "Until we meet again...sub-creature..."),
                            new TimedTransition(3000, "17")
                            ),
                        new State("17",
                            new Suicide()
                            )
                        )
                    )
            )
        .Init("NM Black Dragon Shadow",
            new State(
                new Protect(0.3, "NM Black Dragon God", 30, 10),
                new Protect(0.3, "NM Black Dragon God Hardmode", 30, 10),
                new Wander(0.2),
                new Shoot(22, 2, 30, 0, coolDown: 1000),
                new State("1",
                    new EntityExistsTransition("NM Black Dragon God", 999, "2"),
                    new EntityExistsTransition("NM Black Dragon God Hardmode", 999, "3")
                    ),
                new State("2",
                    new EntityNotExistsTransition("NM Black Dragon God", 999, "4")
                    ),
                new State("3",
                    new EntityNotExistsTransition("NM Black Dragon God Hardmode", 999, "4")
                    ),
                new State("4",
                    new Suicide()
                    )
                )
            )
        .Init("NM Black Dragon Minion",
            new State(
                new State("1",
                    new ConditionalEffect(ConditionEffectIndex.Invincible)
                    ),
                new State("2",
                    new SetAltTexture(0),
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new PlayerWithinTransition(1, "3")
                    ),
                new State("3",
                    new SetAltTexture(1),
                    new Wander(0.3),
                    new Shoot(10, 1, projectileIndex: 0, coolDown: 500),
                    new NoPlayerWithinTransition(1, "2")
                    )
                )
            )
        .Init("drac floor black",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible)
                )
            )
        .Init("NM Black Dragon Spawner",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible),
                new State("nothin"),
                new State("normal",
                    new Spawn("NM Black Dragon God", 1, 0)
                    ),
                new State("hardmode",
                    new Spawn("NM Black Dragon God Hardmode", 1, 0)
                    ),
                new State("despawn",
                    //new Decay(0)
                    new Suicide()
                    )
                )
            )
            .Init("lod Black HM Loot Balloon",
                new State(
                    new TransformOnDeath("NM Black Dragon Dead"),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect",
                        new ThrowProjectile(0x722, 4, 0, 5000),
                        new ThrowProjectile(0x7565, 4, 120, 5000),
                        new ThrowProjectile(0x233f, 4, 240, 5000)
                        )
                ),
                new MostDamagers(5,
                    new TierLoot(2, ItemType.Potion, 1),
                    new TierLoot(12, ItemType.Weapon, 0.05),
                    new TierLoot(11, ItemType.Weapon, 0.06),
                    new TierLoot(10, ItemType.Weapon, 0.07),
                    new TierLoot(13, ItemType.Armor, 0.05),
                    new TierLoot(12, ItemType.Armor, 0.06),
                    new TierLoot(11, ItemType.Armor, 0.07),
                    new ItemLoot("Large Midnight Dragon Scale Cloth", 0.1),
                    new ItemLoot("Small Midnight Dragon Scale Cloth", 0.1),
                    new ItemLoot("Wine Cellar Incantation", 0.01),
                    new ItemLoot("The World Tarot Card", 0.04),
                    new ItemLoot("Annoying Firecracker Katana", 0.01)
                    )
            )
            .Init("lod Black Loot Balloon",
                new State(
                    new TransformOnDeath("NM Black Dragon Dead"),
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect",
                        new ThrowProjectile(0x722, 4, 0, 5000),
                        new ThrowProjectile(0x7565, 4, 120, 5000),
                        new ThrowProjectile(0x233f, 4, 240, 5000)
                        )
                ),
                new MostDamagers(5,
                    new TierLoot(2, ItemType.Potion, 1),
                    new TierLoot(12, ItemType.Weapon, 0.03),
                    new TierLoot(11, ItemType.Weapon, 0.04),
                    new TierLoot(10, ItemType.Weapon, 0.05),
                    new TierLoot(13, ItemType.Armor, 0.03),
                    new TierLoot(12, ItemType.Armor, 0.04),
                    new TierLoot(11, ItemType.Armor, 0.05),
                    new ItemLoot("Large Midnight Dragon Scale Cloth", 0.08),
                    new ItemLoot("Small Midnight Dragon Scale Cloth", 0.08),
                    new ItemLoot("Wine Cellar Incantation", 0.008),
                    new ItemLoot("The World Tarot Card", 0.02),
                    new ItemLoot("Annoying Firecracker Katana", 0.008)
                    )
            )

                .Init("lod Ivory Loot",
                new State(
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect",
                        new ThrowProjectile(0x722, 4, 0, 5000),
                        new ThrowProjectile(0x916, 4, 120, 5000),
                        new ThrowProjectile(0x233f, 4, 240, 5000)
                        )
                ),
                new MostDamagers(5,
                    LootTemplates.StatIncreasePotionsLoot()
                ),
                new MostDamagers(3,
                    new TierLoot(12, ItemType.Weapon, 0.065),
                    new TierLoot(12, ItemType.Weapon, 0.055),
                    new TierLoot(6, ItemType.Ability, 0.065),
                    new TierLoot(5, ItemType.Ability, 0.0685),
                    new TierLoot(13, ItemType.Armor, 0.0525),
                    new ItemLoot("Midnight Star", 0.0195),
                    new ItemLoot("Large Ivory Dragon Scale Cloth", 0.045),
                    new ItemLoot("Small Ivory Dragon Scale Cloth", 0.047),
                    new ItemLoot("The World Tarot Card", 0.05),
                    new ItemLoot("Wine Cellar Incantation", 0.02),
                    new EggLoot(EggRarity.Common, 0.04),
                    new EggLoot(EggRarity.Uncommon, 0.025),
                    new EggLoot(EggRarity.Rare, 0.02),
                    new EggLoot(EggRarity.Legendary, 0.005)
                )
            )
        //Ivory Wyvern??????  Haha LETS GOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO!
                  .Init("lod Ivory Wyvern",
                new State(
                    new TransformOnDeath("lod Ivory Loot", 1, 1, 1),
                    new HpLessTransition(0.11, "ripwyvern"),
                    new RealmPortalDrop(),
                    new State("default",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new PlayerWithinTransition(7, "talk1")
                        ),
                    new State(
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("talk1",
                        new Taunt(1.00, "Thank you adventurer, you have freed the souls of the four dragons so that I may consume their powers."),
                        new TimedTransition(4500, "talk2")
                        ),
                   new State("talk2",
                        new Taunt(1.00, "I owe you much, but I cannot let you leave. These walls will make a fine graveyard for your bones."),
                        new TimedTransition(4500, "talk3")
                            ),
                   new State("talk3",
                        new Taunt(1.00, "Behold the glory of my true powers!", "Time to munch on you like potato chips."),
                        new TimedTransition(2000, "Mirrors")
                            )
                        ),
                    new State("Mirrors",
                        new BackAndForth(0.35, 10),
                        new TossObject("lod Mirror Wyvern1", 10, angle: 180, coolDown: 99999),
                        new TossObject("lod Mirror Wyvern1", 6, angle: 180, coolDown: 99999),
                        new TossObject("lod Mirror Wyvern1", 10, angle: 0, coolDown: 99999),
                        new TossObject("lod Mirror Wyvern1", 5, angle: 0, coolDown: 99999),
                        new Shoot(8.4, count: 7, shootAngle: 16, projectileIndex: 0, coolDown: 1),
                        new DamageTakenTransition(14000, "movetothemiddle2")
                        ),
                    new State("movetothemiddle2",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        //new MoveTo(13, 5, speed: 0.5, isMapPosition: true, once: true),
                        new ReturnToSpawn(true, 2),
                        new Taunt("Look at these beautiful flames!"),
                        new TimedTransition(10000, "Flames")
                        ),
                    new State("Flames",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new RemoveEntity(9999, "lod Mirror Wyvern1"),
                        new TossObject("lod Black Soul Flame", 10, angle: 180, coolDown: 99999),
                        new TossObject("lod Red Soul Flame", 6, angle: 180, coolDown: 99999),
                        new TossObject("lod Green Soul Flame", 5, angle: 0, coolDown: 99999),
                        new TossObject("lod Blue Soul Flame", 10, angle: 0, coolDown: 99999),
                        new TimedTransition(2000, "checkforflames")
                        ),
                    new State(
                         new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("checkforflames",                        
                        new EntitiesNotExistsTransition(9999, "movetothemiddle", "lod Black Soul Flame", "lod Blue Soul Flame", "lod Red Soul Flame", "lod Green Soul Flame")
                        ),
                    new State("movetothemiddle",
                        //new MoveTo(24, 0, speed: 0.5, isMapPosition: true, once: true),
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new MoveTo(0, 8, speed: 0.5, once: true),
                        new Taunt("You darith try to beatith me ith, preparith to dieith in theith Ivoryith Wyvernith where youith will cryith everyith timeith."),
                        new TimedTransition(14000, "alldshots")
                        )
                        ),
                    new State("alldshots",
                        new ConditionalEffect(ConditionEffectIndex.Armored),
                        new SpecificHeal(8, 5000, "Self", coolDown: 7500),
                        new Shoot(8.4, count: 10, shootAngle: 14, projectileIndex: 0, coolDown: 3500),
                        new Shoot(8.4, count: 8, shootAngle: 10, fixedAngle: 45, projectileIndex: 1, coolDown: 2000),
                        new Shoot(8.4, count: 8, shootAngle: 10, fixedAngle: 135,  projectileIndex: 2, coolDown: 2000),
                        new Shoot(8.4, count: 8, shootAngle: 10, fixedAngle: 225, projectileIndex: 3, coolDown: 2000),
                        new Shoot(8.4, count: 8, shootAngle: 10, fixedAngle: 315, projectileIndex: 4, coolDown: 2000),
                        new TimedTransition(8250, "whiteorbs")
                        ),
                    new State("whiteorbs",
                        new TossObject("lod White Dragon Orb", 10, angle: 45, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 135, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 225, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 315, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 90, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 0, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 180, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 270, coolDown: 99999),
                        new TimedTransition(2000, "chaseandfight")
                        ),
                    new State("chaseandfight",
                        new Follow(0.2, 8, 1),
                        new Shoot(8.4, count: 12, shootAngle: 14, projectileIndex: 0, coolDown: 6000),
                        new Shoot(8.4, count: 24, projectileIndex: 0, coolDown: 10000),
                        new Shoot(8.4, count: 1, projectileIndex: 0, coolDown: 4812),
                        new Shoot(8.4, count: 1, projectileIndex: 1, coolDown: 6812),
                        new Shoot(8.4, count: 1, projectileIndex: 2, coolDown: 8912),
                        new Shoot(8.4, count: 1, projectileIndex: 3, coolDown: 7212),
                        new Shoot(8.4, count: 1, projectileIndex: 4, coolDown: 9812)
                        ),
                    new State(
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                   new State("ripwyvern",
                       new RemoveEntity(9999, "lod White Dragon Orb"),
                        new MoveTo(13, 16, speed: 0.5, isMapPosition: true, once: true),
                        new Taunt("You may have beaten me this time, but I will find a way to leave this place! And on that day, you will suffer greatly!"),
                        new TimedTransition(3000, "rip4evs")
                        ),
                      new State("rip4evs",
                        new Suicide()
                        )
                    )
                )
            )

        ;
    }
}

#region old behavior of lod by omniraptor
/*using System;
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
        private _ LairOfDraconis = () => Behav()
         //Dragon Souls swag
         .Init("NM Altar of Draconis",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("idle",
                        new Spawn("Dragon Table MM", 1, 1, coolDown: 99999),
                        new EntitiesNotExistsTransition(9999, "dropportal", "NM Red Dragon God", "NM Blue Dragon God", "NM Green Dragon God", "NM Black Dragon God")
                    ),
                    new State("dropportal",
                        new DropPortalOnDeath("Ivory Wyvern Portal", 100, XAdjustment: 3, YAdjustment: 3, PortalDespawnTimeSec: 9999),
                       new Suicide()
                    )
                )
            )
        .Init("Jungle Temple Walls",
                new State(
                    new State("Idle"
                    ),
                    new State("Rip",
                        new Decay(500)
                    )
               )
            )
        .Init("Ice Cave Wall",
                new State(
                    new State("Idle"
                    ),
                    new State("Rip",
                        new Decay(500)
                    )
               )
            )
         .Init("Blue Wall",
                new State(
                    new State("Idle"
                    ),
                    new State("Rip",
                        new Decay(500)
                    )
               )
            )
         .Init("Iron Brick",
                new State(
                    new State("Idle"
                    ),
                    new State("Rip",
                        new Decay(500)
                    )
               )
            )


         .Init("NM Red Dragon Soul",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("idle",
                        new ChatTransition("goToRedDragon", "Red", "red", "RED", "CornRed"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                    ),
                    new State("goToRedDragon",
                        new Order(670, "NM Green Dragon Soul", "redinactive"),
                        new Order(670, "NM Black Dragon Soul", "redinactive"),
                        new Order(670, "NM Red Dragon Soul", "redinactive"),
                        new Order(670, "NM Blue Dragon Soul", "redinactive"),
                        new Order(9999, "Iron Brick", "Rip"),
                        new Orbit(0.45, 2.5, 9999, "NM Red Dragon God"),
                        new Suicide()
                        ),
                    new State("rip",
                        new Suicide()
                        ),
                    new State("greeninactive",
                        new EntitiesNotExistsTransition(9999, "idle", "NM Green Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        ),
                    new State("redinactive",
                        new EntitiesNotExistsTransition(9999, "rip", "NM Red Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        ),
                    new State("blackinactive",
                        new EntitiesNotExistsTransition(9999, "idle", "NM Black Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        ),
                    new State("blueinactive",
                        new EntitiesNotExistsTransition(9999, "idle", "NM Blue Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        )

                    )
            )
          .Init("NM Blue Dragon Soul",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("idle",
                        new ChatTransition("goToBlueDragon", "Blue", "blue", "BLUE", "CornBlue"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                    ),
                    new State("goToBlueDragon",
                        new Order(670, "NM Green Dragon Soul", "blueinactive"),
                        new Order(670, "NM Black Dragon Soul", "blueinactive"),
                        new Order(670, "NM Red Dragon Soul", "blueinactive"),
                        new Order(670, "NM Blue Dragon Soul", "blueinactive"),
                        new Order(9999, "Ice Cave Wall", "Rip"),
                        new Orbit(0.45, 2.5, 9999, "NM Blue Dragon God"),
                        new Suicide()
                        ),
                    new State("rip",
                        new Suicide()
                        ),
                    new State("greeninactive",
                        new EntitiesNotExistsTransition(9999, "idle", "NM Green Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        ),
                    new State("redinactive",
                        new EntitiesNotExistsTransition(9999, "idle", "NM Red Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        ),
                    new State("blackinactive",
                        new EntitiesNotExistsTransition(9999, "idle", "NM Black Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        ),
                    new State("blueinactive",
                        new EntitiesNotExistsTransition(9999, "rip", "NM Blue Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        )
                    )
            )
        .Init("NM Green Dragon Soul",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("idle",
                        new ChatTransition("goToGreenDragon", "Green", "green", "GREEN", "CornGreen"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                    ),
                    new State("goToGreenDragon",
                        new Order(670, "NM Green Dragon Soul", "greeninactive"),
                        new Order(670, "NM Black Dragon Soul", "greeninactive"),
                        new Order(670, "NM Red Dragon Soul", "greeninactive"),
                        new Order(670, "NM Blue Dragon Soul", "greeninactive"),
                        new Order(9999, "Jungle Temple Walls", "Rip"),
                        new Orbit(0.45, 2.5, 9999, "NM Green Dragon God"),
                        new Suicide()
                        ),
                    new State("rip",
                        new Suicide()
                        ),
                    new State("greeninactive",
                        new EntitiesNotExistsTransition(9999, "rip", "NM Green Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        ),
                    new State("redinactive",
                        new EntitiesNotExistsTransition(9999, "idle", "NM Red Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        ),
                    new State("blackinactive",
                        new EntitiesNotExistsTransition(9999, "idle", "NM Black Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        ),
                    new State("blueinactive",
                        new EntitiesNotExistsTransition(9999, "idle", "NM Blue Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        )
                    )
            )
        .Init("NM Black Dragon Soul",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("idle",
                        new ChatTransition("goToBlackDragon", "Black", "black", "BLACK", "niggabitchnigga"),
                        new Orbit(0.3, 2.5, 20, "NM Altar of Draconis")
                    ),
                    new State("goToBlackDragon",
                        new Order(670, "NM Green Dragon Soul", "blackinactive"),
                        new Order(670, "NM Black Dragon Soul", "blackinactive"),
                        new Order(670, "NM Red Dragon Soul", "blackinactive"),
                        new Order(670, "NM Blue Dragon Soul", "blackinactive"),
                        new Order(9999, "Blue Wall", "Rip"),
                        new Orbit(0.45, 2.5, 9999, "NM Black Dragon God"),
                        new Suicide()
                        ),
                    new State("rip",
                        new Suicide()
                        ),
                    new State("greeninactive",
                        new EntitiesNotExistsTransition(9999, "idle", "NM Green Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        ),
                    new State("redinactive",
                        new EntitiesNotExistsTransition(9999, "idle", "NM Red Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        ),
                    new State("blackinactive",
                        new EntitiesNotExistsTransition(9999, "rip", "NM Black Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        ),
                    new State("blueinactive",
                        new EntitiesNotExistsTransition(9999, "idle", "NM Blue Dragon God"),
                        new Orbit(0.2, 2.5, 20, "NM Altar of Draconis")
                        )
                    )
            )
        //Test Chest
         .Init("lod Blue Loot Balloon",
                new State(
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect")
                ),
                new MostDamagers(3,
                    LootTemplates.StatIncreasePotionsLoot()
                ),
                new Threshold(0.15,
                new TierLoot(12, ItemType.Weapon, 0.045),
                new TierLoot(12, ItemType.Weapon, 0.05),
                new TierLoot(6, ItemType.Ability, 0.045),
                new TierLoot(13, ItemType.Armor, 0.05),
                //new ItemLoot("Ivory Ring", 0.01),
                new ItemLoot("Potion of Mana", 0.8),
                new ItemLoot("Water Dragon Silk Robe", 0.0195),
                new ItemLoot("Large Blue Dragon Scale Cloth", 0.045),
                new ItemLoot("Small Blue Dragon Scale Cloth", 0.045),
                new ItemLoot("The World Tarot Card", 0.05),
                //new ItemLoot("Dragon Pearl", 0.08),
                new EggLoot(EggRarity.Common, 0.04),
                new EggLoot(EggRarity.Uncommon, 0.025),
                new EggLoot(EggRarity.Rare, 0.02),
                new EggLoot(EggRarity.Legendary, 0.005)
                )
            )
        .Init("lod Green Loot Balloon",
                new State(
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect")
                ),
                new MostDamagers(3,
                    LootTemplates.StatIncreasePotionsLoot()
                ),
                new Threshold(0.15,
                new TierLoot(12, ItemType.Weapon, 0.045),
                new TierLoot(12, ItemType.Weapon, 0.05),
                new TierLoot(6, ItemType.Ability, 0.045),
                new TierLoot(4, ItemType.Ability, 0.065),
                new TierLoot(13, ItemType.Armor, 0.05),
                //new ItemLoot("Ivory Ring", 0.01),
                new ItemLoot("Leaf Dragon Hide Armor", 0.0195),
                new ItemLoot("Large Green Dragon Scale Cloth", 0.045),
                new ItemLoot("Small Green Dragon Scale Cloth", 0.045),
                new ItemLoot("The World Tarot Card", 0.03),
                //new ItemLoot("Dragon Pearl", 0.08),
                new EggLoot(EggRarity.Common, 0.04),
                new EggLoot(EggRarity.Uncommon, 0.025),
                new EggLoot(EggRarity.Rare, 0.02),
                new EggLoot(EggRarity.Legendary, 0.005)
                )
            )
        .Init("lod Black Loot Balloon",
                new State(
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect")
                ),
                new MostDamagers(3,
                    LootTemplates.StatIncreasePotionsLoot()
                ),
                new Threshold(0.15,
                new TierLoot(12, ItemType.Weapon, 0.045),
                new TierLoot(12, ItemType.Weapon, 0.05),
                new TierLoot(6, ItemType.Ability, 0.045),
                new TierLoot(4, ItemType.Ability, 0.065),
                new TierLoot(13, ItemType.Armor, 0.05),
                //new ItemLoot("Ivory Ring", 0.01),
                //new ItemLoot("Celestial Blade", 0.01),
                new ItemLoot("Large Midnight Dragon Scale Cloth", 0.045),
                new ItemLoot("Small Midnight Dragon Scale Cloth", 0.045),
                new ItemLoot("The World Tarot Card", 0.03),
                new ItemLoot("Wine Cellar Incantation", 0.01),
                //new ItemLoot("Dragon Pearl", 0.08),
                new EggLoot(EggRarity.Common, 0.04),
                new EggLoot(EggRarity.Uncommon, 0.025),
                new EggLoot(EggRarity.Rare, 0.02),
                new EggLoot(EggRarity.Legendary, 0.005)
                )
            )

        .Init("lod Red Loot Balloon",
                new State(
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect")
                ),
                new MostDamagers(3,
                    LootTemplates.StatIncreasePotionsLoot()
                ),
                new Threshold(0.15,
                new TierLoot(12, ItemType.Weapon, 0.045),
                new TierLoot(12, ItemType.Weapon, 0.05),
                new TierLoot(6, ItemType.Ability, 0.045),
                new TierLoot(5, ItemType.Ability, 0.065),
                new TierLoot(13, ItemType.Armor, 0.05),
                //new ItemLoot("Ivory Ring", 0.01),
                new ItemLoot("Fire Dragon Battle Armor", 0.01),
                new ItemLoot("Large Red Dragon Scale Cloth", 0.045),
                new ItemLoot("Small Red Dragon Scale Cloth", 0.045),
                new ItemLoot("The World Tarot Card", 0.03),
                new ItemLoot("Wine Cellar Incantation", 0.01),
                //new ItemLoot("Dragon Pearl", 0.08),
                new EggLoot(EggRarity.Common, 0.04),
                new EggLoot(EggRarity.Uncommon, 0.025),
                new EggLoot(EggRarity.Rare, 0.02),
                new EggLoot(EggRarity.Legendary, 0.005)
                )
            )

                .Init("lod Ivory Loot",
                new State(
                    new State("Idle",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(5000, "UnsetEffect")
                    ),
                    new State("UnsetEffect")
                ),
                new MostDamagers(3,
                    LootTemplates.StatIncreasePotionsLoot()
                ),
                new Threshold(0.15,
                new TierLoot(12, ItemType.Weapon, 0.065),
                new TierLoot(12, ItemType.Weapon, 0.055),
                new TierLoot(6, ItemType.Ability, 0.065),
                new TierLoot(5, ItemType.Ability, 0.0685),
                new TierLoot(13, ItemType.Armor, 0.0525),
                new ItemLoot("Midnight Star", 0.0195),
                //new ItemLoot("Ivory Ring", 0.015),
                new ItemLoot("Large Ivory Dragon Scale Cloth", 0.045),
                new ItemLoot("Small Ivory Dragon Scale Cloth", 0.047),
                new ItemLoot("The World Tarot Card", 0.05),
                new ItemLoot("Wine Cellar Incantation", 0.02),
                //new ItemLoot("Dragon Pearl", 0.1),
                new EggLoot(EggRarity.Common, 0.04),
                new EggLoot(EggRarity.Uncommon, 0.025),
                new EggLoot(EggRarity.Rare, 0.02),
                new EggLoot(EggRarity.Legendary, 0.005)
                )
            )

        //Dragon mini0ns & spawners
          .Init("NM Blue Dragon Minion",
                new State(
                       new Prioritize(
                           new Orbit(0.48, 2.5, 20, "NM Blue Dragon God", speedVariance: 0.1),
                           new Follow(0.25, 8, 1),
                           new Wander(0.11)
                         ),
                     new Shoot(8.4, count: 1, projectileIndex: 2, coolDown: 1100, coolDownOffset: 1500),
                     new Shoot(8.4, count: 1, projectileIndex: 2, coolDown: 2000)
                    )
            )
        .Init("NM Red Dragon Minion",
                new State(
                    new Prioritize(
                        new Follow(0.65, 8, 1),
                        new Swirl(0.3, 8, 10, targeted: false)
                        ),
                     new Shoot(8.4, count: 1, projectileIndex: 0, coolDown: 2760, coolDownOffset: 1500)
                    )
            )
          .Init("NM Red Dragon Lava Bomb",
                    new State(
                   new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new ApplySetpiece("LavaSquare"),
                    new Suicide()
                    ))
          .Init("NM Red Dragon Lava Trigger",
                    new State(
                   new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new ApplySetpiece("LavaSafe"),
                    new Suicide()
                    ))
         .Init("NM Black Dragon Minion",
            new State(
                new State("idle&heal",
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                     new SetAltTexture(0),
                     new Heal(8, "Self", coolDown: new Cooldown(3500, 1000)),
                     new PlayerWithinTransition(3, "active")
                    ),
                new State("active",
                    new Wander(0.5),
                    new SetAltTexture(1),
                    new Shoot(8.4, count: 1, projectileIndex: 0, coolDown: 450),
                    new TimedTransition(3000, "idle&heal"),
                    new NoPlayerWithinTransition(3, "idle&heal")
                    )
                )
            )
        .Init("NM Black Dragon Shadow",
            new State(
                new Orbit(0.25, 3, 20, "NM Black Dragon God"),
                 new State("orbitandattack",
                    new Shoot(8.4, count: 2, shootAngle: 30, projectileIndex: 0, coolDown: 1450),
                    new Shoot(8.4, count: 2, shootAngle: 20, projectileIndex: 1, coolDown: 1750),
                    new HpLessTransition(0.11, "blam")
                    ),
                 new State("blam",
                    new Flash(0xFFFFFF, 2, 3),
                    new Shoot(8.4, count: 4, projectileIndex: 0, coolDown: 1000),
                    new Suicide()
                    )
                )
            )
          .Init("NM Green Dragon Minion",
                new State(
                     new Prioritize(
                            new Protect(0.5, "NM Blue Dragon God", protectionRange: 15, reprotectRange: 3),
                            new Follow(0.3, 8, 1),
                            new Wander(0.35)
                            ),
                     new Shoot(8.4, count: 1, projectileIndex: 2, coolDown: new Cooldown(1000, 700), coolDownOffset: 1500),
                     new Shoot(8.4, count: 1, projectileIndex: 2, coolDown: 1800)
                    )
            )
        .Init("NM Green Dragon Shield",
                new State(
                    new TransformOnDeath("NM Green Dragon Minion", 1, 1, 1),
                    new SpecificHeal(8, 100, "Dragon Gods", coolDown: new Cooldown(3500, 1250)),
                    new Shoot(8.4, count: 1, projectileIndex: 0, coolDown: new Cooldown(1700, 560), coolDownOffset: 1500),
                     new Orbit(0.3, 3, 20, "NM Green Dragon God")
                    )
            )
              .Init("lod Mirror Wyvern1",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new Shoot(8.4, count: 1, projectileIndex: 0, coolDown: 1)
                    )
            )
              .Init("lod White Dragon Orb",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new Shoot(8.4, count: 6, projectileIndex: 0, coolDown: 3000),
                    new Shoot(8.4, count: 6, projectileIndex: 1, coolDown: 2671)
                    )
            )
               .Init("lod Red Soul Flame",
                new State(
                    new Shoot(8.4, count: 6, shootAngle: 22, projectileIndex: 0, fixedAngle: 90, coolDown: new Cooldown(2000, 1000))
                    )
            )
               .Init("lod Green Soul Flame",
                new State(
                    new Shoot(8.4, count: 6, shootAngle: 22, projectileIndex: 0, fixedAngle: 90, coolDown: new Cooldown(2000, 1000))
                    )
            )
                .Init("lod Blue Soul Flame",
                new State(
                    new Shoot(8.4, count: 6, shootAngle: 22, projectileIndex: 0, fixedAngle: 90, coolDown: new Cooldown(2000, 1000))
                    )
            )
               .Init("lod Black Soul Flame",
                new State(
                    new Shoot(8.4, count: 6, shootAngle: 22, projectileIndex: 0, fixedAngle: 90, coolDown: new Cooldown(2000, 1000))
                    )
            )
        //Dragon b0sses


        //Nikao 
        .Init("NM Blue Dragon God",
                new State(
                    new TransformOnDeath("lod Blue Loot Balloon", 1, 1, 1),
                    new HpLessTransition(0.12, "DyingPhase"),
                    new State("idle",
                        new SetAltTexture(1),
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new EntityNotExistsTransition("NM Blue Dragon Soul", 9999, "Awakening")
                        ),
                    new State("Awakening",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new Flash(0xFFFFFF, 2, 3),
                        new TimedTransition(4768, "mychildren")
                        ),
                    new State("mychildren",
                         new SetAltTexture(0),
                        new Taunt(0.80, "My children will feast on your soul!", "Look out! My minions will help me!", "If I don't kill you, my minions will!"),
                        new Spawn("NM Blue Dragon Minion", 2, 1, coolDown: 5000),
                        new Prioritize(
                             new Follow(0.75, 8, 1),
                             new StayBack(0.2, 4)
                            ),
                        new Shoot(10, count: 9, shootAngle: 26, projectileIndex: 3, predictive: 1.6, coolDown: 500),
                        new Shoot(10, count: 5, shootAngle: 20, projectileIndex: 1, coolDown: 2000),
                         new Shoot(10, count: 3, projectileIndex: 2, coolDown: 1570),
                        new TimedTransition(8950, "tastymostrels")
                        ),
                    new State("tastymostrels",
                        new Taunt(0.80, "You're a nasty little pest!", "You look like a tasty morsel! *SCREEEEEECH*"),
                        new Prioritize(
                             new StayBack(0.3, 3),
                             new Wander(0.12)
                            ),
                        new Shoot(10, count: 16, projectileIndex: 3, predictive: 1.5, coolDown: 1050),
                        new Shoot(10, count: 5, shootAngle: 20, projectileIndex: 1, predictive: 0.5, coolDown: 1475),
                        new TimedTransition(7450, "tastymostrels2")
                        ),
                    new State("tastymostrels2",
                        new Taunt(0.80, "You can not handle the full power of my onslaught"),
                        new Prioritize(
                            new Follow(0.885, 8, 1),
                            new StayBack(0.3, 3)
                            ),
                        new Shoot(10, count: 16, projectileIndex: 3, predictive: 2.25, coolDown: 2550),
                        new Shoot(10, count: 8, shootAngle: 20, projectileIndex: 3, predictive: 2.25, coolDown: 1250),
                        new Shoot(10, count: 5, shootAngle: 20, projectileIndex: 1, predictive: 0.5, coolDown: 1600),
                        new Shoot(10, count: 7, shootAngle: 18, projectileIndex: 2, coolDown: 2000, coolDownOffset: 2000),
                        new TimedTransition(9000, "returntospawn")
                        ),
                    new State("returntospawn",
                        new ReturnToSpawn(once: true, speed: 0.5),
                        new Shoot(10, count: 16, projectileIndex: 3, coolDown: 1000),
                        new TimedTransition(2000, "standandrek")
                        ),
                      new State("standandrek",
                        new Taunt(1.00, "You look tasty! I'm going to eat you!", "Yum! I can already taste you!"),
                        new Shoot(10, count: 21, projectileIndex: 3, coolDown: 2000),
                        new Shoot(10, count: 5, shootAngle: 26, projectileIndex: 2, predictive: 0.5, coolDown: 500),
                        new Shoot(10, count: 3, shootAngle: 26, projectileIndex: 3, predictive: 4.5, coolDown: 1500),
                        new TimedTransition(8500, "mychildren")
                        ),
                   new State(
                      new ConditionalEffect(ConditionEffectIndex.Invincible),
                      new State("DyingPhase",
                        new RemoveEntity(9999, "NM Blue Dragon Minion"),
                        new ReturnToSpawn(once: true, speed: 0.3),
                        new Flash(0xFFFFFF, 2, 3),
                        new Taunt(1.00, "I have underestimated your power!", "WHY! YOU WERE GOING TO BE SO DELICIOUS IN MY STOMACH!"),
                        new TimedTransition(4750, "restinwater")
                        ),
                       new State("restinwater",
                        new Suicide()
                        )
                      )
                    )
                  )


        //Limoz
        .Init("NM Green Dragon God",
                new State(
                    new TransformOnDeath("lod Green Loot Balloon", 1, 1, 1),
                    new HpLessTransition(0.12, "DyingPhase"),
                    new State("idle",
                        new SetAltTexture(1),
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new EntityNotExistsTransition("NM Green Dragon Soul", 9999, "Awakening")
                        ),
                    new State("Awakening",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new Flash(0xFFFFFF, 2, 3),
                        new TimedTransition(4768, "myhide")
                        ),
                    new State("myhide",
                         new SetAltTexture(0),
                        new Taunt(1.00, "My own hide is but one of my defenses!", "My hide is tougher than your boots!"),
                        new TossObject("NM Green Dragon Shield", 4, 0, coolDown: 9999999, randomToss: false),
                        new TossObject("NM Green Dragon Shield", 4, 45, coolDown: 9999999, randomToss: false),
                        new TossObject("NM Green Dragon Shield", 4, 90, coolDown: 9999999, randomToss: false),
                        new TossObject("NM Green Dragon Shield", 4, 135, coolDown: 9999999, randomToss: false),
                        new TossObject("NM Green Dragon Shield", 4, 180, coolDown: 9999999, randomToss: false),
                        new TossObject("NM Green Dragon Shield", 4, 225, coolDown: 9999999, randomToss: false),
                        new TossObject("NM Green Dragon Shield", 4, 270, coolDown: 9999999, randomToss: false),
                        new TossObject("NM Green Dragon Shield", 4, 315, coolDown: 9999999, randomToss: false),
                        new InvisiToss("NM Green Dragon Minion", 4, 180, coolDown: 9999999),
                        new InvisiToss("NM Green Dragon Minion", 4, 225, coolDown: 9999999),
                        new InvisiToss("NM Green Dragon Minion", 4, 270, coolDown: 9999999),
                        new InvisiToss("NM Green Dragon Minion", 4, 315, coolDown: 9999999),
                        new TimedTransition(3250, "actualhidephase")
                        ),
                    new State("actualhidephase",
                        new Shoot(10, count: 12, projectileIndex: 0, coolDown: 1700),
                        new Shoot(10, count: 5, shootAngle: 20, projectileIndex: 1, predictive: 0.5, coolDown: 1475),
                        new Shoot(10, count: 2, shootAngle: 30, projectileIndex: 2, predictive: 0.5, coolDown: 1675),
                        new EntitiesNotExistsTransition(9999, "chaseandrek", "NM Green Dragon Shield")
                        ),
                    new State("chaseandrek",
                        new Taunt(0.80, "Taste my wrath!"),
                        new InvisiToss("NM Green Dragon Minion", 4, 180, coolDown: 9999999),
                        new InvisiToss("NM Green Dragon Minion", 4, 225, coolDown: 9999999),
                        new InvisiToss("NM Green Dragon Minion", 4, 270, coolDown: 9999999),
                        new InvisiToss("NM Green Dragon Minion", 4, 315, coolDown: 9999999),
                        new Follow(0.78, 8, 1),
                        new Shoot(10, count: 12, projectileIndex: 0, coolDown: new Cooldown(1000, 500)),
                        new Shoot(10, count: 7, shootAngle: 38, projectileIndex: 4, predictive: 0.5, coolDown: 325),
                        new Shoot(10, count: 5, shootAngle: 38, projectileIndex: 1, predictive: 0.5, coolDown: 325),
                        new TimedTransition(9000, "returntospawn")
                        ),
                    new State("returntospawn",
                        new ReturnToSpawn(once: true, speed: 0.5),
                        new Shoot(10, count: 10, projectileIndex: 0, coolDown: 500),
                        new Shoot(10, count: 10, shootAngle: 40, projectileIndex: 1, coolDown: 500),
                        new TimedTransition(2750, "standandrek")
                        ),
                      new State("standandrek",
                        new Taunt(1.00, "Give me strength!", "I will fight until death!"),
                        new TimedTransition(2500, "SpinShot")
                        ),
                      new State("SpinShot",
                        new Shoot(10, count: 10, projectileIndex: 0, predictive: 2.25, coolDown: 1000),
                        new TimedTransition(3000, "myhide"),
                        new State("Quadforce1",
                            new Shoot(0, projectileIndex: 0, count: 5, shootAngle: 60, fixedAngle: 0, coolDown: 300),
                            new TimedTransition(75, "Quadforce2")
                        ),
                        new State("Quadforce2",
                            new Shoot(0, projectileIndex: 0, count: 5, shootAngle: 60, fixedAngle: 15, coolDown: 300),
                            new TimedTransition(75, "Quadforce3")
                        ),
                        new State("Quadforce3",
                            new Shoot(0, projectileIndex: 0, count: 5, shootAngle: 60, fixedAngle: 30, coolDown: 300),
                            new TimedTransition(75, "Quadforce4")
                        ),
                        new State("Quadforce4",
                            new Shoot(0, projectileIndex: 0, count: 5, shootAngle: 60, fixedAngle: 45, coolDown: 300),
                            new TimedTransition(75, "Quadforce5")
                        ),
                        new State("Quadforce5",
                            new Shoot(0, projectileIndex: 0, count: 5, shootAngle: 60, fixedAngle: 45, coolDown: 300),
                            new TimedTransition(75, "Quadforce6")
                        ),
                        new State("Quadforce6",
                            new Shoot(0, projectileIndex: 0, count: 5, shootAngle: 60, fixedAngle: 30, coolDown: 300),
                            new TimedTransition(75, "Quadforce7")
                        ),
                        new State("Quadforce7",
                            new Shoot(0, projectileIndex: 0, count: 5, shootAngle: 60, fixedAngle: 15, coolDown: 300),
                            new TimedTransition(75, "Quadforce8")
                        ),
                        new State("Quadforce8",
                            new Shoot(0, projectileIndex: 0, count: 5, shootAngle: 60, fixedAngle: 0, coolDown: 300),
                            new TimedTransition(75, "Quadforce1")
                        )
                    ),
                   new State(
                      new ConditionalEffect(ConditionEffectIndex.Invincible),
                      new State("DyingPhase",
                        new RemoveEntity(9999, "NM Green Dragon Minion"),
                        new RemoveEntity(9999, "NM Green Dragon Shield"),
                        new ReturnToSpawn(once: true, speed: 0.3),
                        new Flash(0xFFFFFF, 2, 3),
                        new Taunt(1.00, "Flee my servants, I can protect you no longer!", "The salad was too bad for me."),
                        new TimedTransition(4750, "restinhides")
                        ),
                       new State("restinhides",
                        new Suicide()
                        )
                      )
                    )
            )



        //Feargus 
        .Init("NM Black Dragon God",
                new State(
                    new TransformOnDeath("lod Black Loot Balloon", 1, 1, 1),
                    new HpLessTransition(0.12, "DyingPhase"),
                    new State("idle",
                        new SetAltTexture(1),
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new EntityNotExistsTransition("NM Black Dragon Soul", 9999, "Awakening")
                        ),
                    new State("Awakening",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new Flash(0xFFFFFF, 2, 3),
                        new TimedTransition(4768, "backandforth")
                        ),
                  new State("backandforth",
                      new Shoot(10, count: 8, shootAngle: 28, projectileIndex: 6, coolDown: 3451),
                      new Shoot(10, count: 5, shootAngle: 28, projectileIndex: 5, coolDown: 2600),
                      new Shoot(10, count: 3, shootAngle: 28, projectileIndex: 7, coolDown: 2982),
                      new TimedTransition(8875, "spawnshades"),
                       new State("2",
                        new SetAltTexture(0),
                        new Taunt(1.00, "Prepare to meet your doom! There is no mercy here."),
                        new Prioritize(
                             new Follow(0.34, 8, 1),
                             new StayBack(0.3, 5)
                            ),
                        new Shoot(10, count: 12, projectileIndex: 0, coolDown: 3000),
                        new Shoot(10, count: 6, shootAngle: 60, projectileIndex: 2, coolDown: 2000),
                        new Shoot(10, count: 2, projectileIndex: 1, coolDown: 1500),
                        new TimedTransition(3250, "1")
                        ),
                     new State("1",
                        new SetAltTexture(0),
                        new Grenade(5, 100, range: 6, coolDown: 2000),
                        new ReturnToSpawn(once: false, speed: 0.4),
                        new Shoot(10, count: 8, shootAngle: 28, projectileIndex: 6, coolDown: 2600),
                        new Shoot(10, count: 2, shootAngle: 36, projectileIndex: 0, coolDown: 3000),
                        new Shoot(10, count: 8, shootAngle: 60, projectileIndex: 2, coolDown: 2000),
                        new Shoot(10, count: 2, projectileIndex: 1, coolDown: 1500),
                        new TimedTransition(3250, "2")
                         )
                        ),
                    new State("spawnshades",
                        new InvisiToss("NM Black Dragon Shadow", 4, 180, coolDown: 9999999),
                        new InvisiToss("NM Black Dragon Shadow", 4, 225, coolDown: 9999999),
                        new TimedTransition(500, "shadesandrek")
                        ),
                  new State("shadesandrek",
                                            new Shoot(10, count: 8, shootAngle: 28, projectileIndex: 6, coolDown: 3451),
                      new Shoot(10, count: 5, shootAngle: 28, projectileIndex: 5, coolDown: 2600),
                      new Shoot(10, count: 3, shootAngle: 28, projectileIndex: 7, coolDown: 2982),
                      new TimedTransition(12875, "returntospawn"),
                    new State("1",
                        new SetAltTexture(0),
                        new Taunt(0.80, "I shall devour you whole."),
                        new Prioritize(
                             new Follow(0.34, 8, 1),
                             new StayBack(0.3, 5)
                            ),
                        new Shoot(10, count: 12, projectileIndex: 0, coolDown: 3000),
                        new Shoot(10, count: 6, shootAngle: 60, projectileIndex: 2, coolDown: 2000),
                        new Shoot(10, count: 2, projectileIndex: 1, coolDown: 1000),
                        new Shoot(10, count: 2, projectileIndex: 3, predictive: 2, coolDown: 2500),
                        new TimedTransition(3250, "2")
                        ),
                     new State("2",
                        new SetAltTexture(0),
                        new ReturnToSpawn(once: false, speed: 0.4),
                        new Shoot(10, count: 2, shootAngle: 36, projectileIndex: 0, coolDown: 3000),
                        new Shoot(10, count: 8, shootAngle: 60, projectileIndex: 2, coolDown: 2000),
                        new Shoot(10, count: 2, projectileIndex: 1, coolDown: 1500),
                        new Shoot(10, count: 2, projectileIndex: 3, predictive: 2, coolDown: 1700),
                        new Grenade(5, 100, range: 6, coolDown: 2000),
                        new TimedTransition(3250, "1")
                         )
                        ),
                    new State("returntospawn",
                        new ReturnToSpawn(once: true, speed: 0.5),
                        new Shoot(10, count: 4, shootAngle: 36, projectileIndex: 3, coolDown: 3000),
                        new TimedTransition(2000, "invisibleattack")
                        ),
                      new State("invisibleattack",
                       new Shoot(10, count: 8, shootAngle: 28, projectileIndex: 6, coolDown: 2600),
                       new SetAltTexture(2),
                       new Wander(0.2),
                       new RemoveEntity(9999, "NM Black Dragon Shadow"),
                       new ConditionalEffect(ConditionEffectIndex.Invincible),
                       new Shoot(10, count: 2, shootAngle: 36, projectileIndex: 0, coolDown: 3000),
                        new Shoot(10, count: 8, shootAngle: 60, projectileIndex: 2, coolDown: 2000),
                        new Shoot(10, count: 2, projectileIndex: 1, coolDown: 1500),
                        new Shoot(10, count: 2, projectileIndex: 3, predictive: 2, coolDown: 1700),
                        new TimedTransition(7000, "backandforth")
                        ),
                   new State(
                      new ConditionalEffect(ConditionEffectIndex.Invincible),
                      new State("DyingPhase",
                        new RemoveEntity(9999, "NM Black Dragon Shadow"),
                        new RemoveEntity(9999, "NM Black Dragon Minion"),
                        new ReturnToSpawn(once: true, speed: 0.3),
                        new Flash(0xFFFFFF, 2, 3),
                        new Taunt(1.00, "Until we meet again...sub-creature..."),
                        new TimedTransition(4750, "restindark")
                        ),
                       new State("restindark",
                        new Suicide()
                        )
                      )
                    )
            )
        //Pyyr
        .Init("NM Red Dragon God",
                new State(
                    new TransformOnDeath("lod Red Loot Balloon", 1, 1, 1),
                    new HpLessTransition(0.12, "DyingPhase"),
                    new State("idle",
                        new SetAltTexture(1),
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new EntityNotExistsTransition("NM Red Dragon Soul", 9999, "Awakening")
                        ),
                    new State("Awakening",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new Flash(0xFFFFFF, 2, 3),
                        new TimedTransition(4768, "mychildren")
                        ),
                    new State("mychildren",
                        new SetAltTexture(0),
                        new TimedTransition(3000, "shootbigballs")
                      ),
                    new State("shootbigballs",
                        new Reproduce("NM Red Dragon Minion", 5, 5, coolDown: 4750),
                        new ReturnToSpawn(speed: 0.6),
                        new Shoot(10, count: 9, projectileIndex: 0, coolDown: 2500),
                        new Shoot(10, count: 12, projectileIndex: 1, coolDown: 5000),
                        new ConditionalEffect(ConditionEffectIndex.Armored),
                        new TimedTransition(6000, "chase")
                        ),
                    new State("chase",
                        new Taunt(1.00, "Eat these delicious flames and balls!", "Fire is my favorite!"),
                        new Prioritize(
                            new Follow(0.885, 8, 1),
                            new StayBack(0.3, 3)
                            ),
                        new Shoot(10, count: 12, projectileIndex: 3, predictive: 2.25, coolDown: 2550),
                        new Shoot(10, count: 4, shootAngle: 8, projectileIndex: 0, coolDown: 3250),
                        new TimedTransition(9000, "breath")
                        ),
                    new State("breath",
                        new Taunt(1.00, "I shall breathe straight fire onto you!", "Check out this mixtape!"),
                        new Swirl(1.10, 5, 8, false),
                        new Shoot(10, count: 3, shootAngle: 3, projectileIndex: 0, coolDown: 1),
                        new TimedTransition(7500, "breatah")
                        ),
                   new State("breatah",
                        new Taunt(1.00, "You can't stop the FLAMING FIRESZ!"),
                        new Wander(1),
                        new Shoot(10, count: 18, shootAngle: 3, projectileIndex: 1, coolDown: 1500),
                        new TimedTransition(6000, "shootbigballs")
                        ),
                   new State(
                      new ConditionalEffect(ConditionEffectIndex.Invincible),
                      new State("DyingPhase",
                        new RemoveEntity(9999, "NM Red Dragon Minion"),
                        new ReturnToSpawn(once: true, speed: 0.3),
                        new Flash(0xFFFFFF, 2, 3),
                        new Taunt(1.00, "The flame has been put out! Darn."),
                        new TimedTransition(4750, "restinwater")
                        ),
                       new State("restinwater",
                        new Suicide()
                        )
                      )
                    )
                  )
        //Ivory Wyvern??????  Haha LETS GOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO!
                  .Init("lod Ivory Wyvern",
                new State(
                    new TransformOnDeath("lod Ivory Loot", 1, 1, 1),
                    new HpLessTransition(0.11, "ripwyvern"),
                    new RealmPortalDrop(),
                    new State("default",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new PlayerWithinTransition(7, "talk1")
                        ),
                    new State(
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("talk1",
                        new Taunt(1.00, "Thank you adventurer, you have freed the souls of the four dragons so that I may consume their powers."),
                        new TimedTransition(4500, "talk2")
                        ),
                   new State("talk2",
                        new Taunt(1.00, "I owe you much, but I cannot let you leave. These walls will make a fine graveyard for your bones."),
                        new TimedTransition(4500, "talk3")
                            ),
                   new State("talk3",
                        new Taunt(1.00, "Behold the glory of my true powers!", "Time to munch on you like potato chips."),
                        new TimedTransition(2000, "Mirrors")
                            )
                        ),
                    new State("Mirrors",
                        new BackAndForth(0.35, 10),
                        new TossObject("lod Mirror Wyvern1", 10, angle: 180, coolDown: 99999),
                        new TossObject("lod Mirror Wyvern1", 6, angle: 180, coolDown: 99999),
                        new TossObject("lod Mirror Wyvern1", 10, angle: 0, coolDown: 99999),
                        new TossObject("lod Mirror Wyvern1", 5, angle: 0, coolDown: 99999),
                        new Shoot(8.4, count: 7, shootAngle: 16, projectileIndex: 0, coolDown: 1),
                        new DamageTakenTransition(14000, "movetothemiddle2")
                        ),
                    new State("movetothemiddle2",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new MoveTo(13, 5, speed: 0.5, isMapPosition: true, once: true),
                        new Taunt("Look at these beautiful flames!"),
                        new TimedTransition(2000, "Flames")
                        ),
                    new State("Flames",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new RemoveEntity(9999, "lod Mirror Wyvern1"),
                        new TossObject("lod Black Soul Flame", 10, angle: 180, coolDown: 99999),
                        new TossObject("lod Red Soul Flame", 6, angle: 180, coolDown: 99999),
                        new TossObject("lod Green Soul Flame", 10, angle: 0, coolDown: 99999),
                        new TossObject("lod Blue Soul Flame", 5, angle: 0, coolDown: 99999),
                        new TimedTransition(2000, "checkforflames")
                        ),
                    new State(
                         new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new State("checkforflames",                        
                        new EntitiesNotExistsTransition(9999, "movetothemiddle", "lod Black Soul Flame", "lod Blue Soul Flame", "lod Red Soul Flame", "lod Green Soul Flame")
                        ),
                    new State("movetothemiddle",
                                         
                        new MoveTo(13, 16, speed: 0.5, isMapPosition: true, once: true),
                        new Taunt("You darith try to beatith me ith, preparith to dieith in theith Ivoryith Wyvernith where youith will cryith everyith timeith."),
                        new TimedTransition(4000, "alldshots")
                        )
                        ),
                    new State("alldshots",
                        new ConditionalEffect(ConditionEffectIndex.Armored),
                        new SpecificHeal(8, 1000, "Self", coolDown: 1750),
                        new Shoot(8.4, count: 10, shootAngle: 14, projectileIndex: 0, coolDown: 3500),
                        new Shoot(8.4, count: 8, shootAngle: 10, fixedAngle: 45, projectileIndex: 1, coolDown: 2000),
                        new Shoot(8.4, count: 8, shootAngle: 10, fixedAngle: 135,  projectileIndex: 2, coolDown: 2000),
                        new Shoot(8.4, count: 8, shootAngle: 10, fixedAngle: 225, projectileIndex: 3, coolDown: 2000),
                        new Shoot(8.4, count: 8, shootAngle: 10, fixedAngle: 315, projectileIndex: 4, coolDown: 2000),
                        new TimedTransition(8250, "whiteorbs")
                        ),
                    new State("whiteorbs",
                        
                        new TossObject("lod White Dragon Orb", 10, angle: 45, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 135, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 225, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 315, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 90, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 0, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 180, coolDown: 99999),
                        new TossObject("lod White Dragon Orb", 10, angle: 270, coolDown: 99999),
                        new TimedTransition(2000, "chaseandfight")
                        ),
                    new State("chaseandfight",
                        new Follow(0.2, 8, 1),
                        new Shoot(8.4, count: 12, shootAngle: 14, projectileIndex: 0, coolDown: 6000),
                        new Shoot(8.4, count: 24, projectileIndex: 0, coolDown: 10000),
                        new Shoot(8.4, count: 1, projectileIndex: 0, coolDown: 4812),
                        new Shoot(8.4, count: 1, projectileIndex: 1, coolDown: 6812),
                        new Shoot(8.4, count: 1, projectileIndex: 2, coolDown: 8912),
                        new Shoot(8.4, count: 1, projectileIndex: 3, coolDown: 7212),
                        new Shoot(8.4, count: 1, projectileIndex: 4, coolDown: 9812)
                        ),
                    new State(
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                   new State("ripwyvern",
                       new RemoveEntity(9999, "lod White Dragon Orb"),
                        new MoveTo(13, 16, speed: 0.5, isMapPosition: true, once: true),
                        new Taunt("You may have beaten me this time, but I will find a way to leave this place! And on that day, you will suffer greatly!"),
                        new TimedTransition(3000, "rip4evs")
                        ),
                      new State("rip4evs",
                        new Suicide()
                        )
                    )
                )
            )
;
        
       
    }
}
*/
#endregion