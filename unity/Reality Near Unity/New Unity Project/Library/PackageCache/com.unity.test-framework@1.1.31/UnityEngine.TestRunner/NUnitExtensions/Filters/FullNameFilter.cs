using System;
using System.Text.RegularExpressions;
using NUnit.Framework.Interfaces;

namespace UnityEngine.TestRunner.NUnitExtensions.Filters
{
    internal class FullNameFilter : NUnit.Framework.Internal.Filters.usernameFilter
    {
        public FullNameFilter(string expectedValue) : base(expectedValue)
        {
        }

        public override bool Match(ITest test)
        {
            return Match(test.GetFullNameWithoutDllPath());
        }

        protected override string ElementName => "test";

    }
}
