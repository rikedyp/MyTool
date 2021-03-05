# Tool versions format

## What Dyalog versions are compatible with this version of this tool?
The tool version information (usually a niladic function called `Version`) should return the string `VERSION_STRING`, but also include within it the string `APL_VERSION_RANGE`. The scheme for determining `APL_VERSION_RANGE` is given in the table below:

|Number format|Compatibility|Example|
|---|---|---|
|A single Dyalog version number | This tool version is compatible with that Dyalog version only | `APL_VERSION_RANGE ← '17.0'`
|A single Dyalog version number followed by a dash `⎕UCS 45` | This tool version is compatible with that Dyalog version or higher | `APL_VERSION_RANGE ← '17.1-'`
|Two Dyalog version numbers separated by a dash `⎕UCS 45` | This tool version is compatible with all Dyalog versions from the lowest to the highest specified inclusive | `APL_VERSION_RANGE ← '17.1-19.0'`
|Two or more Dyalog version numbers separated by commas `⎕UCS 44` | This tool version is compatible with the specified Dyalog versions only | `APL_VERSION_RANGE ← '16.0,17.1'`

## What version of this tool is included with this build of Dyalog?
1. If there is a support branch for the release being built:

    Use the latest draft release for this branch

1. Else if there is a support branch with a higher version number:
	- If the latest draft release for this branch is compatible with the Dyalog version being built:

        Use the latest draft release for this branch

	- Otherwise:

        Report error: attempt to include incompatible support release of tool  
        Build FAIL

1. Otherwise:
	- If the latest public release is compatible with the Dyalog version being built:

        Use the latest public release

	- Otherwise:

        Report error: attempt to include incompatible tool  
        Build FAIL


## Do I have a trunk or a support version?
Trunk versions may have minor bug fixes and new features. Support versions have only cherry-picked fixes to better ensure stability.

- A trunk release has a 2-part patch number.

    e.g. `3.2.15-fghij`

- A support release has a 3-part patch number, including the latest Dyalog version which includes this release or some other indication of an abnormal build target.

    e.g. `3.2.170-2-3fjk`  
    This release would come from a branch called `3.2.170` where the major.minor version number found in the source is `3.2.170-0`.
