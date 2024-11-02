![License](https://img.shields.io/github/license/tsunamods-codes/Junction-VIII-Catalogs) ![Overall Downloads](https://img.shields.io/github/downloads/tsunamods-codes/Junction-VIII-Catalogs/total?label=Overall%20Downloads) ![GitHub Actions Workflow Status](https://github.com/tsunamods-codes/Junction-VIII-Catalogs/actions/workflows/release.yml/badge.svg?branch=master)

# Junction-VIII-Catalogs

Catalogs for Junction-VIII - Maintained by the Tsunamods community

## How to submit your mod

1. Fork this project
2. Create a new directory for you mod inside the mods folder.
3. Create your entry for the catalog (see template below)
4. Commit your work into your fork. (push if using a local system)
5. Create a pull request from your fork to this Repository
6. Automated system will report if there are any errors you need to fix.
7. Wait for a manager to provide feedback on your Pull Request.

## `mod.xml` Template

```xml
<?xml version="1.0"?>
<Mod>
    <ID></ID>
    <Name></Name>
    <Author></Author>
    <Category></Category>
    <Description></Description>
    <LatestVersion>
      <Link></Link>
      <Version></Version>
      <ReleaseDate></ReleaseDate>
      <CompatibleGameVersions></CompatibleGameVersions>
      <PreviewImage></PreviewImage>
      <ReleaseNotes>
      </ReleaseNotes>
      <DownloadSize></DownloadSize>
    </LatestVersion>
    <Link></Link>
    <DonationLink></DonationLink>
    <Tags>
      <string></string>
    </Tags>
  </Mod>
```

You may also have a look at [any of the mods](mods) already present in this repository to have a look at the structure.
