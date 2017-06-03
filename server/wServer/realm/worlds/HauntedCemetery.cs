using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace wServer.realm.worlds
{
    public class HauntedCemetery : World
    {
        public HauntedCemetery()
        {
            Name = "Haunted Cemetery";
            ClientWorldName = "Haunted Cemetery";
            Background = 0;
            Difficulty = 2;
            AllowTeleport = true;
            SetMusic("hauntedcemetery");
        }
        public override bool NeedsPortalKey => true;

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.1HauntedCemetery.jm", MapType.Json);
        }
    }
}
