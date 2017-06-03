using System;
using System.Linq;
using wServer.networking.svrPackets;
using wServer.realm;
using wServer.realm.entities;

namespace wServer.logic.behaviors.PetBehaviors
{
    internal class PetSavage : Behavior
    {
        //State storage: cooldown

       /* public void Blinking(Entity host)
        {
            int time;
            int repeat = 90000001;
            Pet p = host as Pet;

            for(time = 0; time <= 15; time++)
            {
                /*host.Owner.Aoe(
                        //new Flash(0x00BFFF, 0.25, repeat)
                    );*/
           // }
            /*host.Owner.BroadcastPacket(new ShowEffectPacket
                    {
                        EffectType = EffectType.Flashing,
                        PosA = new Position { X = host.X, Y = host.Y },
                        Color = new ARGB(0x00BFFF),
                        TargetId = host.Id,
                    }, null);*/
                    /*


                    //new Flash(0x00BFFF, 0.5, 90000001)
        }*/

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
                
                PetLevel level = null;
                if (host is Pet)
                {
                    Pet p = host as Pet;
                    level = p.GetPetLevelFromAbility(Ability.Savage, true);
                    /*host.Owner.BroadcastPacket(new ShowEffectPacket
                    {
                        EffectType = EffectType.Flashing,
                        PosA = new Position { X = host.X, Y = host.Y },
                        Color = new ARGB(0x00BFFF),
                        TargetId = host.Id,
                    }, null);*/
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
                        DurationMS = level.Level * 25,
                        Effect = ConditionEffectIndex.Curse
                    });
                    
                    host.Owner.BroadcastPacket(new ShowEffectPacket
                    {
                        EffectType = EffectType.Lightning,
                        TargetId = e.Id,
                        PosA = new Position
                        {
                            X = host.X,
                            Y = host.Y
                        },
                        PosB = new Position
                        {
                            X = e.X,
                            Y = e.Y
                        },
                        Color = new ARGB(0x00FFFFF0)
                    }, null);

                    /*host.Owner.Timers.Add(new WorldTimer(1000, (w, t) =>
                        host.Owner.BroadcastPacket(new ShowEffectPacket
                        {
                            EffectType = EffectType.SavageEffect,
                            PosA = new Position { X = host.X, Y = host.Y },
                            TargetId = host.Id
                        }, null)
                    ));*/

                    /*e.Owner.BroadcastPacket(new ShowEffectPacket
                    {
                        EffectType = EffectType.Flashing,
                        PosA = new Position { X = host.X, Y = host.Y },
                        Color = new ARGB(0x00BFFF),
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