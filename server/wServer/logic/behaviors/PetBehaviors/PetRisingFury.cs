using System;
using System.Linq;
using wServer.networking.svrPackets;
using wServer.realm;
using wServer.realm.entities;

namespace wServer.logic.behaviors.PetBehaviors
{
    internal class PetRisingFury : Behavior
    {
        //State storage: cooldown

        protected override void OnStateEntry(Entity host, RealmTime time, ref object state)
        {
            state = 0;
        }

        protected override void TickCore(Entity host, RealmTime time, ref object state)
        {
            if (state == null) return;
            int cool = (int) state;

            if (cool <= 0)
            {
                float flashPeriod = 0.5f;
                int flashRepeats = 10;
                int cooldown = 0;
                
                PetLevel level = null;
                if (host is Pet)
                {
                    Pet p = host as Pet;
                    level = p.GetPetLevelFromAbility(Ability.RisingFury, true);
                }
                else return;

                if (level == null) return;

                double dist = getDist(host as Pet, level);

                Enemy[] targets = host.GetNearestEntities(dist).OfType<Enemy>().ToArray();

                foreach (Enemy e in targets)
                {
                    if (e.HasConditionEffect(ConditionEffectIndex.Invulnerable) || e.HasConditionEffect(ConditionEffectIndex.Invincible) || e.HasConditionEffect(ConditionEffectIndex.Stasis)) continue;
                    if (Random.Next(0, 110) > level.Level) break;

                    if (e.ObjectDesc == null | !e.ObjectDesc.Enemy) continue;

                    if (e.HasConditionEffect(ConditionEffectIndex.Invincible)) continue;

                    e.ApplyConditionEffect(new ConditionEffect
                    {
                        DurationMS = level.Level * 80,
                        Effect = ConditionEffectIndex.Slowed
                    });

                    e.Owner.BroadcastPacket(new ShowEffectPacket
                    {
                        EffectType = EffectType.Potion,
                        Color = new ARGB(0x00FFA500),
                        PosA = new Position { X = level.Level * 80},
                        TargetId = e.Id
                    }, null);
                    
                    while(cooldown <= 5000)
                    {
                        host.Owner.BroadcastPacket(new ShowEffectPacket
                        {
                            EffectType = EffectType.Flashing,
                            PosA = new Position {X = flashPeriod, Y = flashRepeats},
                            TargetId = host.Owner.Id,
                            Color = new ARGB(0x001E90FF)
                        }, null);
                        cooldown += time.thisTickTimes;
                    }

                    /*host.Owner.Timers.Add(new WorldTimer(500, (w, t) =>
                        host.Owner.BroadcastPacket(new ShowEffectPacket
                        {
                            EffectType = EffectType.Flashing,
                            Color = new ARGB(0x001E90FF),
                            PosA = new Position { X = host.X, Y = host.Y },
                            TargetId = host.Id
                        }, null)
                    ));*/

                    /*host.Owner.Timers.Add(new WorldTimer(250, (w, t) =>
                    {
                        host.Owner.BroadcastPacket(new ShowEffectPacket
                        {
                            EffectType = EffectType.Flashing,
                            Color = new ARGB(0x001E90FF),
                            PosA = new Position { X = host.X, Y = host.Y },
                            TargetId = host.Id
                        }, null);
                        (host as Entity).UpdateCount++;
                    }));*/
                    /*host.Owner.BroadcastPacket(new ShowEffectPacket
                    {
                        PosA = new Position { X = host.X, Y = host.Y },
                        EffectType = EffectType.Flashing,
                        TargetId = host.Id,
                    }, null);*/

                    /*e.Damage(null, time, level.Level, true, new ConditionEffect
                    {
                        DurationMS = level.Level * 40,
                        Effect = ConditionEffectIndex.Paralyzed
                    });*/
                }

                cool = getCooldown(host as Pet, level) / host.Manager.TPS;
            }
            else
                cool -= time.thisTickTimes;

            state = cool;
        }

        private int getCooldown(Pet host, PetLevel type)
        {
            if (type.Level <= 30)
            {
                double cool = 2500;
                for (int i = 0; i < type.Level; i++)
                    cool -= 16.6666666666666;
                return (int)cool;
            }
            else if (type.Level > 89)
            {
                double cool = 500;
                for (int i = 0; i < type.Level - 90; i++)
                    cool -= 40;
                return (int)cool;
            }
            else
            {
                double cool = 2000;
                for (int i = 0; i < type.Level - 30; i++)
                    cool -= 25;
                return (int)cool;
            }
        }

        private double getDist(Pet host, PetLevel type)
        {
            return 2;
        }
    }
}