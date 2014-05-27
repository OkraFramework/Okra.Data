using System;
using Windows.ApplicationModel.Resources;

namespace Okra.Data.Helpers
{
    internal static class ResourceHelper
    {
        // *** Constants ***

        private const string RESOURCEMAP_ERROR = "Okra.Data/Errors";
        private const string RESOURCE_NOT_FOUND_ERROR = "Exception_ArgumentException_ResourceStringNotFound";

        // *** Static Fields ***

        private static ResourceLoader errorResourceLoader;

        // *** Methods ***

        public static string GetErrorResource(string resourceName)
        {
            if (errorResourceLoader == null)
                errorResourceLoader = ResourceLoader.GetForViewIndependentUse(RESOURCEMAP_ERROR);

            string errorResource = errorResourceLoader.GetString(resourceName);

            if (string.IsNullOrEmpty(errorResource) && resourceName != RESOURCE_NOT_FOUND_ERROR)
                throw new ArgumentException(GetErrorResource(RESOURCE_NOT_FOUND_ERROR));

            return errorResource;
        }
    }
}
