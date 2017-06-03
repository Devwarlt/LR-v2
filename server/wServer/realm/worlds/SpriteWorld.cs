using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace wServer.realm.worlds
{
    public class SpriteWorld : World
    {
        public SpriteWorld()
        {
            Name = "Sprite World";
            ClientWorldName = "Sprite World";
            Background = 0;
            Difficulty = 2;
            AllowTeleport = true;
            SetMusic("spriteworld");
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.spriteworld.wmap", MapType.Wmap);
        }
    }
}
