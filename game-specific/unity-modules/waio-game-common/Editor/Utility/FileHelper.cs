namespace JoyBrick.WAIO.Game.Common.EditorPart.Utility
{
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;

    public static partial class FileHelper
    {
        public static void CreateDirectoryIfNotExisted(string directoryPath)
        {
            var existed = Directory.Exists(directoryPath);
            if (!existed)
            {
                Directory.CreateDirectory(directoryPath);
            }
        }
    }
}
