#region

using System;
using wServer.networking.svrPackets;
using wServer.realm;
using wServer.realm.entities;

#endregion

namespace wServer.logic.behaviors
{
	public class ThrowProjectile : Behavior
	{
		protected readonly uint projectileId;
		protected readonly bool randomToss;
		protected readonly double range;
		protected double? angle;
		protected Cooldown coolDown;
		protected readonly int coolDownOffset;

		public ThrowProjectile(uint projectileId, double range = 5, double? angle = null,
			Cooldown coolDown = new Cooldown(), int coolDownOffset = 0, bool randomToss = false)
		{
			this.projectileId = projectileId;
			this.range = range;
			this.angle = angle * Math.PI / 180;
			this.coolDown = coolDown.Normalize();
			this.coolDownOffset = coolDownOffset;
			this.randomToss = randomToss;
		}

		protected override void OnStateEntry(Entity host, RealmTime time, ref object state)
		{
			state = coolDownOffset;
		}

		protected override void TickCore(Entity host, RealmTime time, ref object state)
		{
			int cool = (int)state;

			if (cool <= 0)
			{
				if (host.HasConditionEffect(ConditionEffectIndex.Stunned)) return;
				double? tossAngle = randomToss ? Random.Next(0, 360) * Math.PI / 180 : angle;
				Entity en = null;
				if (tossAngle == null)
					en = host.GetNearestEntity(range, null);
				if (tossAngle == null && en == null) return;

				Position target = tossAngle == null ?
				new Position
				{
					X = en.X,
					Y = en.Y
				} :
				new Position
				{
					X = host.X + (float)(range * Math.Cos(tossAngle.Value)),
					Y = host.Y + (float)(range * Math.Sin(tossAngle.Value)),
				};
				host.Owner.BroadcastPacket(new ShowEffectPacket
				{
					EffectType = EffectType.ThrowProjectile,
					Color = new ARGB(projectileId),
					PosA = target,
					PosB = new Position{ X = host.X, Y = host.Y } //host pos.
					}, null);
				cool = coolDown.Next(Random);
			}
			else
				cool -= time.thisTickCounts;

			state = cool;
		}
	}
}