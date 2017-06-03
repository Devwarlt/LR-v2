#region

using wServer.logic.behaviors;
using wServer.logic.loot;
using wServer.logic.transitions;

#endregion

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ MadLab = () => Behav()
                    .Init("Enforcer Bot 3000",
                new State(
                    new TransformOnDeath("Mini Bot", 2, 5, 1),
                    new Prioritize(
                        new Wander(0.2)
                        ),
                     new Shoot(8.4, count: 4, shootAngle: 15, projectileIndex: 1, coolDown: 6000),
                      new Shoot(8.4, count: 3, shootAngle: 15, projectileIndex: 0, coolDown: 3750)
                    ),
                new ItemLoot("Tome of Renewing", 0.02),
                new Threshold(0.5,
                    new ItemLoot("Golden Sword", 0.01),
                    new ItemLoot("Ring of Superior Defense", 0.01)
                    )
            )
        .Init("F.E.R.A.L.",
                new State(
                     new Wander(0.2),
                    new Grenade(6, 150, 6, coolDown: 1000),
                     new Shoot(8.4, count: 16, projectileIndex: 1, coolDown: 2000),
                     new Shoot(8.4, count: 8, projectileIndex: 1, coolDown: 3000)
                    ),
                new Threshold(0.5,
                    new ItemLoot("Prototype Scepter v01", 0.001),
                    new ItemLoot("Prototype Ring v01", 0.001),
                    new ItemLoot("Prototype Wand v01", 0.001)
                    )
            )
              .Init("Crusher Abomination",
                        new State(
                    new State("Crusher1",
                       new Prioritize(
                          new Wander(0.25)
                          ),
                       new Shoot(8.4, count: 4, shootAngle: 10, projectileIndex: 0, coolDown: 5550),
                       new HpLessTransition(0.75, "Crusher2")
                        ),
                    new State("Crusher2",
                       new Prioritize(
                          new Wander(0.25)
                          ),
                       new Flash(0xFF0000, 0.2, 5),
                       new ChangeSize(35, 180),
                       new Shoot(8.4, count: 4, shootAngle: 10, projectileIndex: 1, coolDown: 4000),
                       new HpLessTransition(0.50, "Crusher3")
                        ),
                      new State("Crusher3",
                           new Prioritize(
                          new Wander(0.25)
                          ),
                       new Flash(0xFF0000, 0.2, 5),
                       new ChangeSize(35, 200),
                       new Shoot(8.4, count: 4, shootAngle: 10, projectileIndex: 2, coolDown: 3700),
                       new HpLessTransition(0.25, "Crusher4")
                        ),
                       new State("Crusher4",
                           new Prioritize(
                          new Wander(0.25)
                          ),
                       new Flash(0xFF0000, 0.2, 5),
                       new ChangeSize(35, 240),
                       new Shoot(8.4, count: 4, shootAngle: 10, projectileIndex: 2, coolDown: 3000)
                        )
                ),
                new ItemLoot("Wand of Death", 0.02),
                new Threshold(0.6,
                    new ItemLoot("Ravenheart Sword", 0.01)
                    )
            )
                      .Init("Rampage Cyborg",
                        new State(
                    new State("RampageShot1",
                       new Follow(0.3, 8, 1),
                       new Shoot(8.4, count: 1, projectileIndex: 0, coolDown: 4550),
                        new HpLessTransition(0.80, "RampageShot2")
                  
                        ),
                    new State("RampageShot2",
                       new Flash(0xFFFFFF, 0.2, 5),
                       new ChangeSize(35, 140),
                       new Follow(0.45, 8, 1),
                       new Shoot(8.4, count: 2, projectileIndex: 1, coolDown: 4000),
                            new TimedTransition(8750, "SelfDestructReady")
                        ),
                       new State("SelfDestructReady",
                           new Follow(0.50, 8, 1),
                       new Flash(0xFF0000, 0.2, 5),
                       new ChangeSize(35, 160),
                       new TimedTransition(3550, "SelfDestruct")
                        ),
                       new State("SelfDestruct",
                       new Shoot(8.4, count: 10, projectileIndex: 2),
                       new Suicide()

                        )
                ),
                new Threshold(0.6,
                    new ItemLoot("Wind Circle", 0.01),
                     new ItemLoot("Golden Shield", 0.01),
                     new ItemLoot("Steel Helm", 0.01)
                    )
            )


                            .Init("Mini Bot",
                new State(
                        new Follow(0.8, 8, 1),
                     new Shoot(8.4, count: 2, shootAngle: 20, projectileIndex: 0, predictive: 4, coolDown: 2000)
                    ) 
            )
              .Init("West Automated Defense Turret",
                new State(
                   new ConditionalEffect(ConditionEffectIndex.Invincible),
                     new Shoot(8.4, count: 1, projectileIndex: 0, fixedAngle: 0, coolDown: new Cooldown(3000, 1000))
                    ))
              .Init("East Automated Defense Turret",
                new State(
                   new ConditionalEffect(ConditionEffectIndex.Invincible),
                     new Shoot(8.4, count: 1, projectileIndex: 0, fixedAngle: 180, coolDown: new Cooldown(3000, 1000))
                    ))
                                    .Init("Turret Attack",
                 new State(
                     new Shoot(8.4, count: 2, shootAngle: 20, projectileIndex: 0, coolDown: 880)
                    )
            )
                                    .Init("Escaped Experiment",
                new State(
                    new Prioritize(
                        new StayBack(0.4, 4),
                        new Wander(0.4)
                        ),
                     new Shoot(8.4, count: 1, projectileIndex: 0, coolDown: 700)
                    )
            )
               /*                             .Init("Dr Terrible Escaped Experiment",
                new State(
                    new Prioritize(
                        //new StayBack(0.7, 4),
                        new Wander(0.3)
                        ),
                     new Shoot(8.4, count: 1, projectileIndex: 0, coolDown: 650)
                    )
            )*/
              .Init("Dr Terrible Rampage Cyborg",
                        new State(
                    new State("RampageShot1",
                       new Follow(0.3, 8, 1),
                       new Shoot(8.4, count: 1, projectileIndex: 0, coolDown: 4550),
                        new HpLessTransition(0.80, "RampageShot2")

                        ),
                    new State("RampageShot2",
                       new Flash(0xFFFFFF, 0.2, 5),
                       new ChangeSize(35, 140),
                       new Follow(0.45, 8, 1),
                       new Shoot(8.4, count: 2, projectileIndex: 1, coolDown: 4000),
                            new TimedTransition(8750, "SelfDestructReady")
                        ),
                       new State("SelfDestructReady",
                           new Follow(0.50, 8, 1),
                       new Flash(0xFF0000, 0.2, 5),
                       new ChangeSize(35, 160),
                       new TimedTransition(3550, "SelfDestruct")
                        ),
                       new State("SelfDestruct",
                       new Shoot(8.4, count: 10, projectileIndex: 2),
                       new Suicide()

                        )
                ),
                new Threshold(0.6,
                    new ItemLoot("Cloudflash Scepter", 0.01),
                     new ItemLoot("Golden Shield", 0.01),
                     new ItemLoot("Golden Helm", 0.01)
                    )
            )
                      .Init("Green Potion",
                        new State(
                    new State("FinnaBustANut",
                    new TimedTransition(2200, "Aaa")
                        ),
                    new State("Aaa",
                       new Shoot(8.4, count: 12, projectileIndex: 0),
                       new Suicide()
                    )))
             
            
               .Init("Dr Terrible Mini Bot",
                      new State(
                        new Follow(0.8, 8, 1),
                     new Shoot(8.4, count: 2, shootAngle: 20, projectileIndex: 0, predictive: 4, coolDown: 1900)
                    )
            )

        //Time to start that swaggy Dr Terribro HUAHAUHAUHAHAUQAGA
             .Init("Dr Terrible",
                new State(
                    new RealmPortalDrop(),
                    new HpLessTransition(0.25, "rage"),
                    new State("comeatmebro",
                         /*new RemoveEntity(21, "Escaped Experiment"),
                          new RemoveEntity(21, "Rampage Cyborg"),
                           new RemoveEntity(21, "Mini Bot"),
                           new RemoveEntity(21, "Dr Terrible Escaped Experiment"),
                          new RemoveEntity(21, "Dr Terrible Rampage Cyborg"),
                           new RemoveEntity(21, "Dr Terrible Mini Bot"),*/
                        new PlayerWithinTransition(8, "ScienceIsReal")
                        ),
                    new State("ScienceIsReal",
                        //new Spawn("Mad Scientist Summoner", initialSpawn: 1),
                        new SetAltTexture(0),
                        new Wander(0.7),
                        new Taunt(0.90, "Beware! My deadly concoction will kill you off!"),
                        new TossObject("Green Potion", 7, coolDown: 9000, randomToss: true),
                        new TossObject("Turret Attack", 5, coolDown: 10000, randomToss: true),
                        new Taunt(0.75, "My equation is true! You so called warriors know nothing of true science!"),
                        new TimedTransition(14500, "ScienceIsFake")
                        ),
                    new State("ScienceIsFake",
                        new SetAltTexture(1),
                        new Spawn("Mad Scientist Summoner", initialSpawn: 1),
                        new Taunt(0.90, "Great Scott! I must retreat!"),
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                         new TimedTransition(30500, "ScienceIsBack")
                        ),
                    new State("ScienceIsBack",
                        new SetAltTexture(0),
                        new RemoveEntity(9999, "Mad Scientist Summoner"),
                        new TossObject("Green Potion", 7, angle: null, coolDown: 9000),
                         new TossObject("Turret Attack", 5, angle: null, coolDown: 9000),
                        new ConditionalEffect(ConditionEffectIndex.Armored),
                        new TimedTransition(8000, "ScienceIsReal")
                        ),
                    new State("rage",
                        new SetAltTexture(0),
                        //new Spawn("Mad Scientist Summoner", initialSpawn: 1),
                        new Wander(0.75),
                        new Taunt(0.90, "E = MC^2!"),
                        new TossObject("Green Potion", 7, coolDown: 8000),
                        new TossObject("Turret Attack", 5, coolDown: 9000),
                        new Taunt(0.75, "Time to kill off these opponents with the laws of physics and chemistry!")
                        )
                      ),
                new MostDamagers(5,
                    new ItemLoot("Potion of Wisdom", 1)
                    ),
                new MostDamagers(3,
                    new OnlyOne(
                        new ItemLoot("Robe of the Mad Scientist", whitebag),
                        new ItemLoot("Scepter of Fulmination", whitebag)
                        ),
                    new ItemLoot("Experimental Ring", goodloot),
                    new ItemLoot("Golden Bolt", awesomeloot),
                    new ItemLoot("Golden Nut", awesomeloot),
                    new ItemLoot("The Magician Tarot Card", awesomeloot),
                    new TierLoot(8, ItemType.Weapon, mediumloot),
                    new TierLoot(9, ItemType.Weapon, normalloot),
                    new TierLoot(10, ItemType.Weapon, goodloot),
                    new TierLoot(11, ItemType.Weapon, goodloot),
                    new TierLoot(8, ItemType.Armor, mediumloot),
                    new TierLoot(9, ItemType.Armor, mediumloot),
                    new TierLoot(10, ItemType.Armor, normalloot),
                    new TierLoot(11, ItemType.Armor, normalloot),
                    new TierLoot(4, ItemType.Ability, normalloot),
                    new TierLoot(5, ItemType.Ability, goodloot)
                    )
            )
     .Init("Horrific Creation",
                new State(
                   new State("comeatmebro",
                       new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new EntitiesNotExistsTransition(9999, "medoor", "Tesla Coil")
                        ),
                    new State("medoor",
                       new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                       new Taunt(true, "Me door is open."),
                        new TimedTransition(2000, "Rawr")
                        ),
                  new State("Rawr",
                    new Wander(0.5),
                    new RemoveEntity(9999, "Blue Torch Wall"),
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable, perm: false),
                       new Taunt(0.90, "Me Master! WHY WOULD YOU KILL ME MASTER!"),
                        new Taunt(0.75, "Come here and face my horrific blast!"),
                         new Taunt(0.50, "I was created to crush you, me Master said so himself!"),
                         new Shoot(8.4, count: 18, projectileIndex: 4, shootAngle: 20, coolDown: 870),
                          new Shoot(8.4, count: 1, projectileIndex: 5, coolDown: 200),
                        new TimedTransition(10000, "JumpOnIt")
                        ),
                    new State("JumpOnIt",
                        new Flash(0xFF0000, 2, 2),
                        new Taunt(0.90, "Me indestructible!"),
                         new Charge(2, coolDown: 1000),
                        new Shoot(8.4, count: 18, projectileIndex: 4, shootAngle: 25, coolDown: 1200),
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable, perm: false),
                         new TimedTransition(7500, "ArmoredFighting")
                        ),
                    new State("ArmoredFighting",
                         new Follow(0.8, 8, 1),
                        new Shoot(8.4, count: 6, projectileIndex: 4, shootAngle: 5, coolDown: 1000),
                        new Shoot(8.4, count: 10, projectileIndex: 4, shootAngle: 20, coolDown: 600),
                         new ConditionalEffect(ConditionEffectIndex.Armored),
                        new TimedTransition(8000, "Rawr")
                        )
                      ),
                new MostDamagers(5,
                    new ItemLoot("Experimental Ring", normalloot),
                    new ItemLoot("Golden Bolt", normalloot),
                    new ItemLoot("Golden Nut", normalloot),
                    new EggLoot(EggRarity.Common, eggbag + goodloot),
                    new EggLoot(EggRarity.Uncommon, eggbag + greatloot),
                    new EggLoot(EggRarity.Rare, eggbag + awesomeloot),
                    new EggLoot(EggRarity.Legendary, eggbag),
                    new TierLoot(4, ItemType.Ability, normalloot),
                    new TierLoot(11, ItemType.Weapon, goodloot),
                    new TierLoot(11, ItemType.Armor, normalloot),
                    new TierLoot(5, ItemType.Ability, goodloot),
                    new TierLoot(10, ItemType.Armor, normalloot),
                    new TierLoot(8, ItemType.Armor, mediumloot),
                    new TierLoot(9, ItemType.Armor, mediumloot),
                    new TierLoot(8, ItemType.Weapon, mediumloot),
                    new TierLoot(9, ItemType.Weapon, normalloot),
                    new TierLoot(10, ItemType.Weapon, goodloot),
                    new ItemLoot("Wine Cellar Incantation", winecellar)
                    ),
                new MostDamagers(3,
                    new ItemLoot("Potion of Wisdom", 1),
                    new ItemLoot("Potion of Defense", 0.75),
                    new TierLoot(11, ItemType.Weapon, goodloot),
                    new TierLoot(11, ItemType.Armor, normalloot),
                    new TierLoot(5, ItemType.Ability, goodloot),
                    new OnlyOne(
                        new ItemLoot("Conducting Wand", normalloot),
                        new ItemLoot("Shattered Armor", whitebag)
                        )
                    )
            )
        //When Dr Terrible spawns the summoner he is retreating to his bubble of gayness
        // Monster Cage'
                                      .Init("Monster Cage",
                        new State(
                    new State("BLAGH",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new EntityExistsTransition("Mad Scientist Summoner", 9999, "Stop")
                    ),
                    new State("Stop",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        //new Spawn("Dr Terrible Escaped Experiment", 1, 1, coolDown: 7000),
                        new Spawn("Dr Terrible Rampage Cyborg", 1, 1, coolDown: 8000),
                        new Spawn("Dr Terrible Mini Bot", 1, 1, coolDown: 6000),
                        new EntitiesNotExistsTransition(9999, "BLAGH", "Mad Scientist Summoner")
                    )
                ))
        //Coward bubble
                                              .Init("Dr Terrible Bubble",
                        new State(
                    new State("BLAGH",
                        //new SetAltTexture(3),
                         new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new EntityExistsTransition("Mad Scientist Summoner", 9999, "Stop")
                        ),
                       new State("Stop",
                           //new SetAltTexture(2),
                            new ConditionalEffect(ConditionEffectIndex.Invincible),
                             new EntitiesNotExistsTransition(9999, "BLAGH", "Mad Scientist Summoner")
                        )
                ))
            .Init("Mad Scientist Summoner",
                new State(
                    new State("checkterrible",
                        new EntityNotExistsTransition("Dr Terrible", 999, "suicide")
                        ),
                    new State("suicide",
                        new Suicide()
                        )
                )
            )

                              //Red Gas Thingies
                              .Init("Red Gas Spawner UL",
                                               new State(
                            new EntitiesNotExistsTransition(9999, "GasDed", "Dr Terrible"),
                    new State("BLAGH",
                         new ConditionalEffect(ConditionEffectIndex.Invincible),
                       new Shoot(8.4, count: 24, projectileIndex: 0, shootAngle: 30, coolDown: 1850),
                        new EntityExistsTransition("Mad Scientist Summoner", 9999, "Stop")
                        ),
                       new State("Stop",
                            new ConditionalEffect(ConditionEffectIndex.Invincible),
                  new EntitiesNotExistsTransition(9999, "BLAGH", "Mad Scientist Summoner")
                        ),
                       new State("GasDed",
                            new ConditionalEffect(ConditionEffectIndex.Invincible)
                        )
                ))
                             
                              .Init("Red Gas Spawner UR",
                        new State(
                            new EntitiesNotExistsTransition(9999, "GasDed", "Dr Terrible"),
                    new State("BLAGH",
                         new ConditionalEffect(ConditionEffectIndex.Invincible),
                       new Shoot(8.4, count: 24, projectileIndex: 0, shootAngle: 30, coolDown: 1850),
                        new EntityExistsTransition("Mad Scientist Summoner", 9999, "Stop")
                        ),
                       new State("Stop",
                            new ConditionalEffect(ConditionEffectIndex.Invincible),
                  new EntitiesNotExistsTransition(9999, "BLAGH", "Mad Scientist Summoner")
                        ),
                       new State("GasDed",
                            new ConditionalEffect(ConditionEffectIndex.Invincible)
                        )
                ))
                                      .Init("Red Gas Spawner LL",
                          new State(
                            new EntitiesNotExistsTransition(9999, "GasDed", "Dr Terrible"),
                    new State("BLAGH",
                         new ConditionalEffect(ConditionEffectIndex.Invincible),
                       new Shoot(8.4, count: 24, projectileIndex: 0, shootAngle: 30, coolDown: 1850),
                        new EntityExistsTransition("Mad Scientist Summoner", 9999, "Stop")
                        ),
                       new State("Stop",
                            new ConditionalEffect(ConditionEffectIndex.Invincible),
                  new EntitiesNotExistsTransition(9999, "BLAGH", "Mad Scientist Summoner")
                        ),
                       new State("GasDed",
                            new ConditionalEffect(ConditionEffectIndex.Invincible)
                        )
                ))
                                      .Init("Red Gas Spawner LR",
                                              new State(
                            new EntitiesNotExistsTransition(9999, "GasDed", "Dr Terrible"),
                    new State("BLAGH",
                         new ConditionalEffect(ConditionEffectIndex.Invincible),
                       new Shoot(8.4, count: 24, projectileIndex: 0, shootAngle: 30, coolDown: 1850),
                        new EntityExistsTransition("Mad Scientist Summoner", 9999, "Stop")
                        ),
                       new State("Stop",
                            new ConditionalEffect(ConditionEffectIndex.Invincible),
                  new EntitiesNotExistsTransition(9999, "BLAGH", "Mad Scientist Summoner")
                        ),

                       new State("GasDed",
                            new ConditionalEffect(ConditionEffectIndex.Invincible)
                        )
                ))
        ;
        }
}