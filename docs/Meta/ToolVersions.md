# The Tool Versions Tool
A web API is proposed to facilitate:

- including a GitHub-hosted tool in Dyalog installations.
- being able to reproduce a particular build of Dyalog from the past.
- find the latest "stable" (support) version of a tool, that may contain critical bug fixes, which is compatible with an old version of Dyalog
- find the latest version of a tool which is compatible with any particular version of Dyalog

It would allow URL queries to obtain releases, for example:

- `https://toolversions.dyalog.com/toolname/180` to obtain the latest release of `toolname` compatible with Dyalog v18.0.  
- `https://toolversions.dyalog.com/toolname/180?date=2021-01-13` to obtain the release of `toolname` which was included with the Dyalog build on the 13<sup>th</sup> January 2021.

It would also provide a GUI at `https://toolversions.dyalog.com` to allow users to find that information.

## What Dyalog versions are compatible with this version of MyTool?
The tool version information (usually a niladic function called `Version`) should return the string `VERSION_STRING`, but also include within it the string `APL_VERSION_RANGE`. The scheme for determining `APL_VERSION_RANGE` is given in the table below:

|Number format|Compatibility|Example|
|---|---|---|
|A single Dyalog version number | This tool version is compatible with that Dyalog version only | `APL_VERSION_RANGE ← '17.0'`
|A single Dyalog version number followed by a dash `⎕UCS 45` | This tool version is compatible with that Dyalog version or higher | `APL_VERSION_RANGE ← '17.1-'`
|Two Dyalog version numbers separated by a dash `⎕UCS 45` | This tool version is compatible with all Dyalog versions from the lowest to the highest specified inclusive | `APL_VERSION_RANGE ← '17.1-19.0'`
|Two or more Dyalog version numbers separated by commas `⎕UCS 44` | This tool version is compatible with the specified Dyalog versions only | `APL_VERSION_RANGE ← '16.0,17.1'`

## What version of MyTool is included with this build of Dyalog?

## Do I have a trunk or a support version?
Trunk versions may have minor bug fixes and new features. Support versions have only cherry-picked fixes with thorough testing to better ensure stability.

- A trunk release has a 2-part patch number

    e.g. `3.2.15-fghij`

- A support release has a 3-part patch number, including the latest Dyalog version which includes this release

    e.g. `3.2.170-2-3fjk`  
    This release would come from a branch called `3.2.170` where the major.minor version number found in the source is `3.2.170-0`.
