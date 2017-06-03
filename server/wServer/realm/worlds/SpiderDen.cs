using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace wServer.realm.worlds
{
    public class SpiderDen : World
    {
        public SpiderDen()
        {
            Name = "Spider Den";
            ClientWorldName = "Spider Den";
            Background = 0;
            Dungeon = true;
            Difficulty = 2;
            AllowTeleport = true;
            SetMusic("spiderden");
        }

        public override bool NeedsPortalKey => true;

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.spiderden.wmap", MapType.Wmap);
        }
    }
}
