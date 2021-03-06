﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace wServer.realm.worlds
{
    public class PuppetMastersTheatre : World
    {
        public PuppetMastersTheatre()
        {
            Name = "Puppet Master's Theatre";
            ClientWorldName = "Puppet Master's Theatre";
            Background = 0;
            Difficulty = 4;
            Dungeon = true;
            AllowTeleport = true;
            SetMusic("puppet");
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.puppet.jm", MapType.Json);
        }
    }
}
