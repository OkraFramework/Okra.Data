using Windows.ApplicationModel.Resources;

namespace Okra.Data.Helpers
{
    internal static class ResourceHelper
    {
        // *** Constants ***

        private const string RESOURCEMAP_ERROR = "Okra.Data/Errors";

        // *** Static Fields ***

        private static ResourceLoader errorResourceLoader;

        // *** Methods ***

        public static string GetErrorResource(string resourceName)
        {
            if (errorResourceLoader == null)
                errorResourceLoader = ResourceLoader.GetForViewIndependentUse(RESOURCEMAP_ERROR);

            string s = errorResourceLoader.GetString(resourceName);
            if (string.IsNullOrEmpty(s))
                throw new System.Exception(resourceName);

            return errorResourceLoader.GetString(resourceName);
        }
    }
}
