using wServer.logic.behaviors;
using wServer.logic.transitions;
using wServer.logic.loot;
using wServer.realm;

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ Shaitans = () => Behav()
        
        /*.Init("InnerSanctum Task Master",
                        new State(
                    new State("Spook",
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new EntitiesNotExistsTransition(9999, "Commence", "Big Yeti", "Snow Bat Mama")
                        ),
                    new State("Commence",
                       new DropPortalOnDeath("Inner Sanctum Portal", 100, PortalDespawnTimeSec: 99999),
                       new Taunt(true, "Innocent souls. So delicious. You have sated me. Now come, I shall give you your reward."),
                       new Suicide()
                    )))*/
                    
        .Init("md1 Right Smashing Hand",
            new State(
                new State("searching",
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new ConditionalEffect(ConditionEffectIndex.StunImmune),
                    new ConditionalEffect(ConditionEffectIndex.ParalyzeImmune),
                    new ConditionalEffect(ConditionEffectIndex.DazedImmune),
                    new ConditionalEffect(ConditionEffectIndex.SlowedImmune),
                    new ConditionalEffect(ConditionEffectIndex.StasisImmune),
                    //new StayAbove(0.2, 50),
                    new Prioritize(
                        new Charge(3),
                        new Wander(0.4)
                        ),
                    //new Reproduce(densityMax: 5, densityRadius: 10),
                    new PlayerWithinTransition(8, "creeping")
                    ),
                new State("creeping",
                    new Shoot(0, 10, 36, fixedAngle: 0),
                    new Decay(0)
                    )
                )
            )

        .Init("md1 Left Smashing Hand",
            new State(
                new State("searching",
                    new ConditionalEffect(ConditionEffectIndex.Invincible),
                    new ConditionalEffect(ConditionEffectIndex.StunImmune),
                    new ConditionalEffect(ConditionEffectIndex.ParalyzeImmune),
                    new ConditionalEffect(ConditionEffectIndex.DazedImmune),
                    new ConditionalEffect(ConditionEffectIndex.SlowedImmune),
                    new ConditionalEffect(ConditionEffectIndex.StasisImmune),
                    //new StayAbove(0.2, 50),
                    new Prioritize(
                        new Charge(3),
                        new Wander(0.4)
                        ),
                    //new Reproduce(densityMax: 5, densityRadius: 10),
                    new PlayerWithinTransition(8, "creeping")
                    ),
                new State("creeping",
                    new Shoot(0, 10, 36, fixedAngle: 0),
                    new Decay(0)
                    )
                )
            )

        .Init("md1 Head of Shaitan",
            new State(
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new State("default",
                         new ChangeSize(5, 250),
                         new TimedTransition(9000, "grow")
                        ),
                    new State("grow",
                        new TossObject("md1 Right Hand of Shaitan", range: 5, angle: 180),
                        new TossObject("md1 Left Hand of Shaitan", range: 5, angle: 0),
                         new TimedTransition(1000, "waitasec")
                        ),
                    new State("waitasec",
                         new TimedTransition(5000, "waiting")
                        ),
                    new State("waiting",
                        new EntityNotExistsTransition2(target: "md1 Right Hand of Shaitan", target2: "md1 Left Hand of Shaitan", dist: 100, targetState: "shaitanawake")
                        )
                  ),
                new State("shaitanawake",
                    new Wander(0.1),
                    new Charge(3, 10, coolDown: 15000),
                    new Follow(speed: 0.5, range: 2, coolDown: 3000),
                    new ReturnToSpawn(false, 0.51),
                    new HpLessTransition(.35, "shaitanrage"),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 0, coolDown: 1000),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 45, coolDown: 1000),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 90, coolDown: 1000),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 135, coolDown: 1000),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 180, coolDown: 1000),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 225, coolDown: 1000),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 270, coolDown: 1000),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 315, coolDown: 1000),
                    new Shoot(radius: 5, count: 1, projectileIndex: 1, fixedAngle: 0, coolDown: 600),
                    new Shoot(radius: 5, count: 1, projectileIndex: 1, fixedAngle: 60, coolDown: 600),
                    new Shoot(radius: 5, count: 1, projectileIndex: 1, fixedAngle: 120, coolDown: 600),
                    new Shoot(radius: 5, count: 1, projectileIndex: 1, fixedAngle: 180, coolDown: 600),
                    new Shoot(radius: 5, count: 1, projectileIndex: 1, fixedAngle: 240, coolDown: 600),
                    new Shoot(radius: 5, count: 1, projectileIndex: 1, fixedAngle: 300, coolDown: 600)
                ),
                new State("shaitanrage",
                    new Wander(0.2),
                    new Charge(3, 10, coolDown: 5000),
                    new ReturnToSpawn(false, 1),
                    new Follow(speed: 1.0, range: 1, coolDown: 1500),
                    new TossObject("md1 Right Smashing Hand", range: 5, angle: 180, coolDown: 6000),
                    new TossObject("md1 Left Smashing Hand", range: 5, angle: 0, coolDown: 6000),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 0, coolDown: 400),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 45, coolDown: 400),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 90, coolDown: 400),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 135, coolDown: 400),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 180, coolDown: 400),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 225, coolDown: 400),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 270, coolDown: 400),
                    new Shoot(radius: 12, count: 1, projectileIndex: 0, fixedAngle: 315, coolDown: 400),
                    new Shoot(radius: 5, count: 1, projectileIndex: 1, fixedAngle: 0, coolDown: 200),
                    new Shoot(radius: 5, count: 1, projectileIndex: 1, fixedAngle: 60, coolDown: 200),
                    new Shoot(radius: 5, count: 1, projectileIndex: 1, fixedAngle: 120, coolDown: 200),
                    new Shoot(radius: 5, count: 1, projectileIndex: 1, fixedAngle: 180, coolDown: 200),
                    new Shoot(radius: 5, count: 1, projectileIndex: 1, fixedAngle: 240, coolDown: 200),
                    new Shoot(radius: 5, count: 1, projectileIndex: 1, fixedAngle: 300, coolDown: 200)
                )
            ),
            new MostDamagers(5,
                new ItemLoot("Potion of Defense", 1),
                new ItemLoot("Small Heavy Chainmail Cloth", 0.11),
                new ItemLoot("Large Heavy Chainmail Cloth", 0.07),
                new ItemLoot("Potion of Attack", 1),
                new ItemLoot("Tincture of Dexterity", poorloot),
                new ItemLoot("Effusion of Defense", goodloot)
                ),
            new MostDamagers(3,
                new OnlyOne(
                    new ItemLoot("Skull of Endless Torment", whitebag*10),
                    new ItemLoot("Royal Battleshield", whitebag)
                    ),
                new ItemLoot("The Chariot Tarot Card", awesomeloot),
                new TierLoot(8, ItemType.Weapon, mediumloot),
                new TierLoot(9, ItemType.Weapon, normalloot),
                new TierLoot(10, ItemType.Weapon, goodloot),
                new TierLoot(11, ItemType.Weapon, goodloot),
                new TierLoot(8, ItemType.Armor, mediumloot),
                new TierLoot(9, ItemType.Armor, mediumloot),
                new TierLoot(10, ItemType.Armor, normalloot),
                new TierLoot(11, ItemType.Armor, normalloot),
                new TierLoot(12, ItemType.Armor, goodloot),
                new TierLoot(4, ItemType.Ability, normalloot),
                new TierLoot(5, ItemType.Ring, goodloot)
                )
            /*new Threshold(0.1,
                    new ItemLoot("Super Mad God Ambrosia", 0.3),
                //new ItemLoot("Eon", 0.05),
                //new ItemLoot("Potion of Divine Supplies", 0.025),
                new TierLoot(9, ItemType.Weapon, 0.175),
                new TierLoot(10, ItemType.Weapon, 0.125),
                new TierLoot(11, ItemType.Weapon, 0.05),
                new TierLoot(12, ItemType.Weapon, 0.01),
                new TierLoot(9, ItemType.Armor, 0.175),
                new TierLoot(10, ItemType.Armor, 0.15),
                new TierLoot(11, ItemType.Armor, 0.1),
                new TierLoot(12, ItemType.Armor, 0.01),
                new TierLoot(13, ItemType.Armor, 0.001),
                //new TierLoot(14, ItemType.Armor, 0.0001),
                new TierLoot(4, ItemType.Ability, 0.25),
                new TierLoot(5, ItemType.Ability, 0.15),
                new TierLoot(6, ItemType.Ability, 0.1),
                new TierLoot(5, ItemType.Ring, 0.25),
                //new TierLoot(8, ItemType.Ring, 0.0005),
                //new TierLoot(9, ItemType.Ring, 0.0001),
                //new TierLoot(7, ItemType.Ring, 0.025),
                new TierLoot(6, ItemType.Ring, 0.1),
                new Threshold(0.64,
                    //Dark Knight Set
                    new ItemLoot("Broadsword of Bloodshed", 0.3),
                    new ItemLoot("Evil Shield of the Dark Knight", 0.3),
                    new ItemLoot("Chestguard of the Underworld", 0.3),
                    new ItemLoot("Amulet of the Dark Knight", 0.3),
                    //Woodland Sorcerer Set
                    new ItemLoot("Sprig of the Copse", 0.3),
                    new ItemLoot("Caduceus of Nature", 0.3),
                    new ItemLoot("Shroud of Sagebrush", 0.3),
                    new ItemLoot("Trinket of the Groves", 0.3),
                    //Ancient Colossus Set
                    new ItemLoot("Titanic Sword", 0.3),
                    new ItemLoot("Helm of the Titans", 0.3),
                    new ItemLoot("Armor of the Giants", 0.3),
                    new ItemLoot("Amulet of the Immortals", 0.3),
                    //The Spider Queen Set
                    new ItemLoot("Bow of the Spider Silk", 0.3),
                    new ItemLoot("Spider Web Trap", 0.3),
                    new ItemLoot("Nidus Armor", 0.3),
                    new ItemLoot("Spiders Fang", 0.3)
                    )
                )*/
         )

        .Init("md1 Right Hand of Shaitan",
            new State(
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new State("default",
                         new ChangeSize(5, 200),
                         new TimedTransition(5000, "growright")
                        ),
                    new State("growright",
                         new TimedTransition(5000, "rightfrase1")
                        ),
                    new State("rightfrase1",
                         new SetAltTexture(1),
                         new SetAltTexture(2),
                         new Taunt("What hath the keepers brought Shaitan?"),
                         new TimedTransition(9000, "rightattack1")
                        )
                 ),
                new State("rightattack1",
                    new SetAltTexture(0),
                    new ReturnToSpawn(false, 0.51),
                    //size, count, projectileid,???, angle
                    new Wander(0.1),
                    new Follow(speed: 1.5, range: 3, coolDown: 3000),
                    new HpLessTransition(.5, "rightattack2"),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 0, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 45, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 90, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 135, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 180, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 225, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 270, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 315, coolDown: 500),
                    new Shoot(radius: 4, count: 1, projectileIndex: 2, fixedAngle: 0, coolDown: 250),
                    new Shoot(radius: 4, count: 1, projectileIndex: 2, fixedAngle: 60, coolDown: 250),
                    new Shoot(radius: 4, count: 1, projectileIndex: 2, fixedAngle: 120, coolDown: 250),
                    new Shoot(radius: 4, count: 1, projectileIndex: 2, fixedAngle: 180, coolDown: 250),
                    new Shoot(radius: 4, count: 1, projectileIndex: 2, fixedAngle: 240, coolDown: 250),
                    new Shoot(radius: 4, count: 1, projectileIndex: 2, fixedAngle: 300, coolDown: 250),
                    new Shoot(radius: 10, count: 1, angleOffset: 0 / 1, projectileIndex: 1, coolDown: 750)
                ),
                new State("rightattack2",
                    new ReturnToSpawn(false, 0.51),
                    //size, count, projectileid,???, angle
                    new Wander(0.2),
                    new Follow(speed: 1.5, range: 3, coolDown: 1500),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 0, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 45, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 90, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 135, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 180, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 225, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 270, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 315, coolDown: 250),
                    new Shoot(radius: 8, count: 1, projectileIndex: 2, fixedAngle: 0, coolDown: 125),
                    new Shoot(radius: 8, count: 1, projectileIndex: 2, fixedAngle: 60, coolDown: 125),
                    new Shoot(radius: 8, count: 1, projectileIndex: 2, fixedAngle: 120, coolDown: 125),
                    new Shoot(radius: 8, count: 1, projectileIndex: 2, fixedAngle: 180, coolDown: 125),
                    new Shoot(radius: 8, count: 1, projectileIndex: 2, fixedAngle: 240, coolDown: 125),
                    new Shoot(radius: 8, count: 1, projectileIndex: 2, fixedAngle: 300, coolDown: 125),
                    new Shoot(radius: 15, count: 1, angleOffset: 0 / 1, projectileIndex: 1, coolDown: 375)
                )
            )
        )

        .Init("md1 Left Hand of Shaitan",
            new State(
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new State("default",
                         new ChangeSize(5, 200),
                         new TimedTransition(12000, "growleft")
                        ),
                    new State("growleft",
                         new TimedTransition(12000, "leftfrase1")
                        ),
                    new State("leftfrase1",
                         new SetAltTexture(1),
                         new SetAltTexture(2),
                         new Taunt("What hath the keepers brought Shaitan?"),
                         new TimedTransition(2000, "leftattack1")
                        )
                 ),
                new State("leftattack1",
                    new SetAltTexture(0),
                    new ReturnToSpawn(false, 0.51),
                    //size, count, projectileid,???, angle
                    new HpLessTransition(.5, "leftattack2"),
                    new Wander(0.1),
                    new Follow(speed: 1.5, range: 3, coolDown: 3000),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 0, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 45, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 90, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 135, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 180, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 225, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 270, coolDown: 500),
                    new Shoot(radius: 15, count: 1, projectileIndex: 0, fixedAngle: 315, coolDown: 500),
                    new Shoot(radius: 4, count: 1, projectileIndex: 2, fixedAngle: 0, coolDown: 250),
                    new Shoot(radius: 4, count: 1, projectileIndex: 2, fixedAngle: 60, coolDown: 250),
                    new Shoot(radius: 4, count: 1, projectileIndex: 2, fixedAngle: 120, coolDown: 250),
                    new Shoot(radius: 4, count: 1, projectileIndex: 2, fixedAngle: 180, coolDown: 250),
                    new Shoot(radius: 4, count: 1, projectileIndex: 2, fixedAngle: 240, coolDown: 250),
                    new Shoot(radius: 4, count: 1, projectileIndex: 2, fixedAngle: 300, coolDown: 250),
                    new Shoot(radius: 10, count: 1, angleOffset: 0 / 1, projectileIndex: 1, coolDown: 750)
                ),
                new State("leftattack2",
                    //size, count, projectileid,???, angle
                    new Wander(0.2),
                    new ReturnToSpawn(false, 0.51),
                    new Follow(speed: 1.5, range: 3, coolDown: 1500),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 0, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 45, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 90, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 135, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 180, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 225, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 270, coolDown: 250),
                    new Shoot(radius: 25, count: 1, projectileIndex: 0, fixedAngle: 315, coolDown: 250),
                    new Shoot(radius: 8, count: 1, projectileIndex: 2, fixedAngle: 0, coolDown: 125),
                    new Shoot(radius: 8, count: 1, projectileIndex: 2, fixedAngle: 60, coolDown: 125),
                    new Shoot(radius: 8, count: 1, projectileIndex: 2, fixedAngle: 120, coolDown: 125),
                    new Shoot(radius: 8, count: 1, projectileIndex: 2, fixedAngle: 180, coolDown: 125),
                    new Shoot(radius: 8, count: 1, projectileIndex: 2, fixedAngle: 240, coolDown: 125),
                    new Shoot(radius: 8, count: 1, projectileIndex: 2, fixedAngle: 300, coolDown: 125),
                    new Shoot(radius: 15, count: 1, angleOffset: 0 / 1, projectileIndex: 1, coolDown: 375)
                )
            )
        )

        ;
    }
}