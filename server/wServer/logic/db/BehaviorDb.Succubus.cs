using wServer.logic.behaviors;
using wServer.logic.transitions;
using wServer.logic.loot;

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ Succubus = () => Behav()
            .Init("Maurth the Succubus Queen",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.StasisImmune),
                    new DropPortalOnDeath("The Shatters", percent: 50, dropDelaySec: 2, XAdjustment: 0, YAdjustment: 2, PortalDespawnTimeSec: 70),
                    new State("default",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new PlayerWithinTransition(8, "taunt1")
                        ),
                    new State("taunt1",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new Taunt("You think you are going to survive? I do not think this is true."),
                        new TimedTransition(5000, "taunt2")
                        ),
                    new State("taunt2",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new Taunt("I will show you my power."),
                        new TimedTransition(5000, "taunt3")
                        ),
                    new State("taunt3",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new Flash(0xFFFFFF, 2, 2),
                        new Taunt("Haha, so what will it be? Freeze or Burn to death?"),
                        new TimedTransition(5000, "CircleShot")
                        ),
                    new State("tauntcool",
                        new ConditionalEffect(ConditionEffectIndex.Invincible),
                        new Flash(0xFFFFFF, 2, 2),
                        new Taunt("Better watch out!", "Let Oryx live forever!", "Your souls will freeze then burn!"),
                        new TimedTransition(3000, "CircleShot")
                        ),
                    new State("CircleShot",
                       new Prioritize(
                            new StayCloseToSpawn(0.6, 5),
                            new Wander(0.2)
                            ),
                        new ConditionalEffect(ConditionEffectIndex.Armored),
                        new Shoot(10, count: 10, projectileIndex: 5, coolDown: 500),
                        new Shoot(10, count: 3, shootAngle: 16, projectileIndex: 4, coolDown: 2000, coolDownOffset: 200),
                        new Shoot(10, count: 4, shootAngle: 16, projectileIndex: 4, coolDown: 2000, coolDownOffset: 500),
                        new Shoot(10, count: 5, shootAngle: 16, projectileIndex: 4, coolDown: 2000, coolDownOffset: 900),
                        new Shoot(10, count: 6, shootAngle: 16, projectileIndex: 4, coolDown: 2000, coolDownOffset: 1300),
                        new Shoot(10, count: 7, shootAngle: 16, projectileIndex: 4, coolDown: 2000, coolDownOffset: 1700),
                        new TimedTransition(9000, "LinePhase")
                        ),
                    new State("LinePhase",
                        new Prioritize(
                            new Follow(0.4, 8, 1),
                            new StayCloseToSpawn(0.4, 6)
                            ),
                        new Taunt("Fire and Ice, neither is nice!"),
                        new Shoot(10, count: 1, projectileIndex: 0, coolDown: 5),
                        new Shoot(10, count: 1, projectileIndex: 0, coolDown: 5, coolDownOffset: 10),
                        new Shoot(10, count: 1, projectileIndex: 1, coolDown: 5),
                        new Shoot(10, count: 1, projectileIndex: 1, coolDown: 5, coolDownOffset: 10),
                        new TimedTransition(8000, "ViciousPhase")
                    ),
                   new State("ViciousPhase",
                        new Prioritize(
                            new StayCloseToSpawn(0.4, 4),
                            new Wander(0.2)
                            ),
                        new Taunt("I don't think you'll enjoy this!", "You will be destroyed!"),
                        new Shoot(10, count: 7, projectileIndex: 2, coolDown: 1500),
                        new Grenade(3, 360, 6, coolDown: 3500),
                        new TimedTransition(7000, "ShotgunPhase")
                       ),
                   new State("ShotgunPhase",
                        new Prioritize(
                            new StayCloseToSpawn(1, 5),
                            new Wander(0.2)
                            ),
                        new ConditionalEffect(ConditionEffectIndex.ParalyzeImmune),
                        new ConditionalEffect(ConditionEffectIndex.StunImmune),
                        new Shoot(10, count: 12, shootAngle: 18, projectileIndex: 3, coolDown: 2750),
                        new Shoot(10, count: 6, shootAngle: 20, predictive: 3, projectileIndex: 4, coolDown: 1500),
                        new Shoot(10, count: 6, shootAngle: 20, predictive: 3, projectileIndex: 5, coolDown: 1500),
                        new TimedTransition(7000, "tauntcool")
                       )
                    ),
                new MostDamagers(15,
                    new ItemLoot("Potion of Vitality", 1)
                ),
                new MostDamagers(10,
                    new ItemLoot("Potion of Speed", 1),
                    new OnlyOne(
                        new ItemLoot("Staff of the Succubus", awesomeloot),
                        new ItemLoot("Skull of the Succubus", awesomeloot),
                        new ItemLoot("Robe of the Succubus", awesomeloot),
                        new ItemLoot("Ring of the Succubus", awesomeloot),
                        new ItemLoot("Warden Two-handed Sword", whitebag)
                        ),
                    new TierLoot(10, ItemType.Weapon, goodloot),
                    new TierLoot(4, ItemType.Ability, normalloot),
                    new TierLoot(10, ItemType.Armor, 0.1),
                    new TierLoot(3, ItemType.Ring, mediumloot),
                    new TierLoot(11, ItemType.Armor, normalloot),
                    new TierLoot(11, ItemType.Weapon, goodloot)
                )
            );
            
    }
}