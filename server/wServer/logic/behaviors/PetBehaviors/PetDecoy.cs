using System;
using System.Linq;
using wServer.networking.svrPackets;
using wServer.realm;
using wServer.realm.entities;
using wServer.realm.entities.player;

namespace wServer.logic.behaviors.PetBehaviors
{
    internal class PetDecoy : Behavior
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
                
                PetLevel level = null;
                /*if (host is Pet)
                {
                    Pet p = host as Pet;
                    level = p.GetPetLevelFromAbility(Ability.Decoy, true);
                }
                else return;*/

                if (level == null) return;

                double dist = getDist(host as Pet, level);

                Enemy[] targets = host.GetNearestEntities(dist).OfType<Enemy>().ToArray();
                
                Player player = host.GetEntity((host as Pet).PlayerOwner.Id) as Player;

                Decoy decoy = new Decoy(host.Manager, player, 2000, tps: player.StatsManager.GetSpeed());

                foreach (Enemy e in targets)
                {
                    if (e.HasConditionEffect(ConditionEffectIndex.Invulnerable) || e.HasConditionEffect(ConditionEffectIndex.Invincible) || e.HasConditionEffect(ConditionEffectIndex.Stasis)) continue;
                    if (Random.Next(0, 110) > level.Level) break;

                    if (e.ObjectDesc == null | !e.ObjectDesc.Enemy) continue;

                    if (e.HasConditionEffect(ConditionEffectIndex.Invincible)) continue;

                    /*decoy.Move(host.X, host.Y);

                    host.Owner.Timers.Add(new WorldTimer((5000 - level.Level*10), (w, t) =>
                       host.Owner.EnterWorld(decoy)
                    ));*/
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