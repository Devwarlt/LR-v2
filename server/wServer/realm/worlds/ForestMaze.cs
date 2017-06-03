using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace wServer.realm.worlds
{
    public class ForestMaze : World
    {
        public ForestMaze()
        {
            Name = "Forest Maze";
            ClientWorldName = "Forest Maze";
            Background = 0;
            Dungeon = true;
            Difficulty = 1;
            AllowTeleport = true;
            SetMusic("forestmaze");
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.forestmaze.wmap", MapType.Wmap);
        }
    }
}
