# Old Example
This example assumed that progressive development would be actively made to the main branch (trunk) and that the Dyalog build process would have versions frozen in place by picking up specific releases.

RP: I still think this is a good idea if the Tools Versions system can neatly provide the correct commit to branch from. However, if MK's proposal is just as easy then that is fine.  
Compatibility vs. Inclusion in the build process  
Critical fixes vs. new feature development  

Apparently Tools team envisions this scenario:  
New Dyalog version (18.1) is just released. Shortly after there is a period of bug reports of generally critical bugs which we decide to fix, and we want those fixes included in both 18.1 and 19.0.

The "let's have those fixes in the trunk" - but we don't want to manually update anything. I think it is safer if the "build system" (Tools Versions tool) has to be manually updated. It is possible that during the period after a new release, we have that /toolname/181 and /toolname/190 both always take the latest release? These new releases during the period of rapid bug fixes immediately following a Dyalog release would include several well-tested fixes each, rather than a release per bug fix?

Currently - The SVN extern points to a single place, and always gets the latest thing. However, the latest thing currently does not tell you what version it is, so the version number from 3 commits ago looks the same as the one from today. We want to continue to get the latest thing but also sometimes not but not have to do much work to achieve that?

## Set up automated draft releases
Using GitHub actions, create an action "draft-release.yml"
```YAML
name: "Draft Release"

on:
  push:
    branches:
      - "master"
  workflow_dispatch:   # allows triggering from GitHub interface

jobs:
# Generate patch version number
  draft_release:
    runs-on: ubuntu-latest
    steps:
      - name: Triggered by which branch
        run: echo "$GITHUB_REF"
      - name: Checkout code
        uses: actions/checkout@v2      
      - name: Read major.minor
        id: majmin
        run: |
          VER=$( cat MyTool.apln | grep "∆VERSION_STRING∆ ← '[0-9]\+.[0-9]\+..*-\?0'" | cut -c 33- | sed "s/..$//" )
          echo ${VER}
          echo "::set-output name=version::${VER}"
# Create or update Draft release
      - name: Build and test
        run: |
          echo "done!"
      - name: Insert patch number
      # Replaces e.g. ∆VERSION_STRING∆ ← 0.3.0       with   ∆VERSION_STRING∆ ← 0.3.[nruns]-[git-hash]
      #            or ∆VERSION_STRING∆ ← 0.3.dev-0   with   ∆VERSION_STRING∆ ← 0.3.dev-[nruns]-[git-hash]
        run: |
          sed -i "/∆VERSION_STRING∆ ← '[0-9]\+.[0-9]\+..*-\?0'/s/0'/${{ github.run_number }}-${{ github.sha }}'/" MyTool.apln 
          cat MyTool.dyalog
      - name: Draft release
        uses: "marvinpinto/action-automatic-releases@latest"        
        with:
         # ver: ${{ cat 'version.txt' }}
          repo_token: "${{ secrets.GITHUB_TOKEN }}"
          automatic_release_tag: "${{ steps.majmin.outputs.version }}.${{ github.run_number }}-${{ github.sha }}"
          prerelease: false
          draft: true
          title: "v${{ steps.majmin.outputs.version }}.${{ github.run_number }}"
          files: |
            MyTool.apln

```

In the real system, this should delete the previous unpublished draft release. With the above action, draft releases must be manually removed. Furthermore, an organisation's repository should be developed using forks and pull requests, but here commits are made directly to the main repository.

In this system, supported Dyalog versions are manually input in release notes upon publication of releases. In the real system, this part may be automated.

## Initial commits (v0.0)
Compatible with Dyalog v17.0 to latest  
Dyalog v17.0 was released including this (patch) version of the tool.

1. Create README.md
1. Create MyTool.apln with embedded version function (0th feature)
1. Document MyTool v0.0
1. Commit to main branch

        git add .  
        git commit -m "Version function"  
        git push

1. Publish latest docs  

        mike deploy --push --update-aliases 0.0 latest

1. Publish release

    First line of notes:  
    `Compatible with Dyalog versions: 17.0 - `

## Set up GitHub Pages
On the GitHub website, go to the repository settings (e.g. `https://github.com/rikedyp/MyTool/settings`) and enable GitHub pages using the `gh-pages` branch.

## Add a feature (v0.1)
Compatible with Dyalog v17.0 to latest.  

1. Add F1 to MyTool.apln
1. Document F1
1. Create "Old Versions" page in docs
1. Stash old versions change only
1. Commit changes 1 and 2 to main branch
1. Apply old versions stash to main branch
1. Commit old versions change to main branch
1. Check out commit with tag of previous minor release
1. Apply old versions stash
1. Publish old docs version

        mike deploy --push 0.0

1. Publish new latest docs version

        mike deploy --push --update-aliases 0.1 latest

## Fix a bug
Dyalog v17.1 was released including this (patch) version of the tool.  

1. Add comment ("bug fix") to MyTool.apln
1. Commit to main branch
1. Publish release

    First line of notes:  
    `Compatible with Dyalog versions: 17.1 - `

## Add a feature (v0.2)
Compatible with Dyalog v18.0 to latest  
Dyalog v18.0 was released with this (patch) version of the tool.

1. Add F2 to MyTool.apln
1. Document F2
1. Commit to main branch
1. Publish new docs version
1. Update "old versions" page of previous docs version (see [Add a feature (v0.1)](#add-a-feature-v01))

## Fix 2 bugs
Corporate customers do not want to risk applying these fixes to tool version v0.1 and v0.2 for Dyalog versions 17 and 18 respectively.

1. Add comment ("bug fix 2") to MyTool.apln
1. Commit to main branch
1. Add comment ("bug fix 3") to MyTool.apln
1. Commit to main branch
1. Publish release

## Add a feature (v0.3)
Compatible with Dyalog v18.0 to latest

1. Add F2 to MyTool.apln
1. Document F2
1. Commit to main branch
1. Publish new docs version
1. Update "old versions" page of previous docs version (see [Add a feature (v0.1)](#add-a-feature-v01))

## Make change to v0.1 docs
1. Checkout commit of 0.1 release
1. Make change to doc
1. Publish old docs version
1. Copy docs folder somewhere on your file system
1. Checkout head
1. Copy locally stored, modified old docs folder to docs/0.1
1. Modify mkdocs.yml to exclude docs/0.1
1. Commit to main branch and push

## Fix CRITICAL bug
This bug has been deemed severe enough to warrant cherry-picked backporting to old versions of the tool which are compatible with supported versions of Dyalog

The fix will be backported to tools included in builds of v17.0, v17.1 and v18.0. New branches 0.1.171-0 and 0.2.180-0 will be created.

1. Fix bug in head
1. Commit to main branch
1. Determine commits corresponding to old releases of tool (using [the tools versions tool](Meta/ToolVersions.md), which follows the procedure outlined in [The Document]()) which need the patch applied and for each commit:
	1. Branch the commit, giving it the appropriate name
	1. Cherry pick the fix
	1. Push the new branch to GitHub

