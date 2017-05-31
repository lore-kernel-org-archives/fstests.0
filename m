Received: from mail-pf0-f169.google.com ([209.85.192.169]:34692 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdEaWjw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 31 May 2017 18:39:52 -0400
Received: by mail-pf0-f169.google.com with SMTP id 9so19596216pfj.1
        for <fstests@vger.kernel.org>; Wed, 31 May 2017 15:39:51 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 0/6] xfstests: remove most IRIX-specific code
Date: Wed, 31 May 2017 15:36:49 -0700
Message-Id: <20170531223655.130613-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

For some time xfstests has de facto not supported IRIX anymore.  The
final release of IRIX was over 10 years ago and it seems no one has
been running the latest xfstests releases on any IRIX system, as at
the very least xfstests now assumes the existence of some util-linux
binaries.  There are probably other examples of this bitrot too.

Therefore, this patchset simplifies things removing IRIX support from
the xfstests tests, build system, and documentation.

It focuses on making larger, more obvious cleanups.  Of course,
there's more to do if people want to spend more time going through
some of the more intricate details, especially XFS-specific details.
But this should be a good start.

Eric Biggers (6):
  README: remove IRIX-specific documentation
  tests: remove IRIX-specific tests
  tests: remove IRIX support from tests also supported on Linux
  tests: clean up per-OS output files
  common: remove IRIX-specific code
  build: remove IRIX-specific build logic

 .gitignore                                   |   14 -
 README                                       |   51 +-
 common/attr                                  |    6 +-
 common/config                                |   12 -
 common/dump                                  |   39 +-
 common/filestreams                           |   43 +-
 common/log                                   |    1 -
 common/rc                                    |   23 +-
 configure.ac                                 |   59 +-
 include/builddefs.in                         |    3 -
 lib/str_to_bytes.c                           |    2 +-
 ltp/Makefile                                 |    4 -
 ltp/rwtest.sh                                |    1 -
 m4/package_globals.m4                        |    2 +-
 m4/package_libcdev.m4                        |    2 +-
 m4/package_utilies.m4                        |   14 +-
 m4/package_xfslibs.m4                        |   13 -
 make_irix                                    |  114 -
 src/Makefile                                 |    4 -
 src/fill2fs                                  |    3 +-
 tests/generic/001                            |    2 +-
 tests/generic/002                            |    2 +-
 tests/generic/005                            |    9 +-
 tests/generic/006                            |    2 +-
 tests/generic/007                            |    2 +-
 tests/generic/010                            |    2 +-
 tests/generic/011                            |    2 +-
 tests/generic/013                            |    8 +-
 tests/generic/014                            |    2 +-
 tests/generic/015                            |    2 +-
 tests/generic/029                            |    2 +-
 tests/generic/030                            |    2 +-
 tests/generic/031                            |    2 +-
 tests/generic/043                            |    2 +-
 tests/generic/044                            |    2 +-
 tests/generic/045                            |    2 +-
 tests/generic/046                            |    2 +-
 tests/generic/047                            |    2 +-
 tests/generic/048                            |    2 +-
 tests/generic/049                            |    2 +-
 tests/generic/052                            |    2 +-
 tests/generic/054                            |    2 +-
 tests/generic/055                            |    2 +-
 tests/generic/068                            |    2 +-
 tests/generic/069                            |    2 +-
 tests/generic/070                            |    2 +-
 tests/generic/074                            |   37 +-
 tests/generic/075                            |    2 +-
 tests/generic/076                            |    2 +-
 tests/generic/080                            |    2 +-
 tests/generic/083                            |    2 +-
 tests/generic/086                            |    2 +-
 tests/generic/088                            |    5 +-
 tests/generic/088.cfg                        |    2 -
 tests/generic/{088.out.linux => 088.out}     |    0
 tests/generic/088.out.irix                   |    9 -
 tests/generic/093                            |  158 -
 tests/generic/093.out                        |  Bin 917 -> 0 bytes
 tests/generic/096                            |    2 +-
 tests/generic/097                            |  250 --
 tests/generic/097.out.udf                    |  132 -
 tests/generic/097.out.xfs                    |  132 -
 tests/generic/099                            |  331 --
 tests/generic/099.out                        |  215 -
 tests/generic/100                            |    2 +-
 tests/generic/105                            |   11 +-
 tests/generic/117                            |    2 +-
 tests/generic/120                            |    2 +-
 tests/generic/123                            |    2 +-
 tests/generic/130                            |    2 +-
 tests/generic/132                            |    2 +-
 tests/generic/133                            |    2 +-
 tests/generic/135                            |    2 +-
 tests/generic/184                            |    2 +-
 tests/generic/219                            |    2 +-
 tests/generic/226                            |    2 +-
 tests/generic/230                            |    2 +-
 tests/generic/234                            |    2 +-
 tests/generic/235                            |    2 +-
 tests/generic/273                            |    2 +-
 tests/generic/274                            |    2 +-
 tests/generic/275                            |    2 +-
 tests/generic/309                            |    2 +-
 tests/generic/313                            |    2 +-
 tests/generic/320                            |    2 +-
 tests/generic/378                            |    2 +-
 tests/generic/379                            |    2 +-
 tests/generic/380                            |    2 +-
 tests/generic/384                            |    8 +-
 tests/generic/403                            |    2 +-
 tests/generic/416                            |    2 +-
 tests/generic/424                            |    2 +-
 tests/generic/group                          |    3 -
 tests/udf/098                                |  274 --
 tests/udf/098.out                            | 1594 --------
 tests/udf/101                                |   62 -
 tests/udf/101.out                            |   19 -
 tests/udf/102                                |    2 +-
 tests/udf/group                              |    2 -
 tests/xfs/003                                |   12 +-
 tests/xfs/004                                |    6 +-
 tests/xfs/007                                |    2 +-
 tests/xfs/008                                |    2 +-
 tests/xfs/009                                |    2 +-
 tests/xfs/012                                |    2 +-
 tests/xfs/018                                |   11 +-
 tests/xfs/018.cfg                            |    2 -
 tests/xfs/{018.op.linux => 018.op}           |    0
 tests/xfs/018.op.irix                        | 5628 --------------------------
 tests/xfs/019                                |    2 +-
 tests/xfs/022                                |    8 +-
 tests/xfs/022.cfg                            |    2 -
 tests/xfs/{022.out.linux => 022.out}         |    0
 tests/xfs/022.out.irix                       |   55 -
 tests/xfs/023                                |    5 +-
 tests/xfs/023.cfg                            |    2 -
 tests/xfs/{023.out.linux => 023.out}         |    0
 tests/xfs/023.out.irix                       |   89 -
 tests/xfs/026                                |    2 +-
 tests/xfs/027                                |    2 +-
 tests/xfs/028                                |    2 +-
 tests/xfs/030                                |    5 +-
 tests/xfs/030.cfg                            |    2 -
 tests/xfs/{030.out.linux => 030.out}         |    0
 tests/xfs/030.out.irix                       |  288 --
 tests/xfs/031                                |    5 +-
 tests/xfs/031.cfg                            |    2 -
 tests/xfs/{031.out.linux => 031.out}         |    0
 tests/xfs/031.out.irix                       |  123 -
 tests/xfs/032                                |    2 +-
 tests/xfs/033                                |    6 +-
 tests/xfs/033.cfg                            |    4 +-
 tests/xfs/{033.out.crc.linux => 033.out.crc} |    0
 tests/xfs/{033.out.linux => 033.out.default} |    0
 tests/xfs/033.out.irix                       |  217 -
 tests/xfs/035                                |    5 +-
 tests/xfs/035.cfg                            |    2 -
 tests/xfs/{035.out.linux => 035.out}         |    0
 tests/xfs/035.out.irix                       |   94 -
 tests/xfs/036                                |    5 +-
 tests/xfs/036.cfg                            |    2 -
 tests/xfs/{036.out.linux => 036.out}         |    0
 tests/xfs/036.out.irix                       |   86 -
 tests/xfs/039                                |    5 +-
 tests/xfs/039.cfg                            |    2 -
 tests/xfs/{039.out.linux => 039.out}         |    0
 tests/xfs/039.out.irix                       |   89 -
 tests/xfs/041                                |    2 +-
 tests/xfs/042                                |    2 +-
 tests/xfs/043                                |    5 +-
 tests/xfs/043.cfg                            |    2 -
 tests/xfs/{043.out.linux => 043.out}         |    0
 tests/xfs/043.out.irix                       |  104 -
 tests/xfs/046                                |    2 +-
 tests/xfs/047                                |    2 +-
 tests/xfs/048                                |    2 +-
 tests/xfs/050                                |   16 +-
 tests/xfs/052                                |    2 +-
 tests/xfs/053                                |    2 +-
 tests/xfs/055                                |    5 +-
 tests/xfs/{055.out.linux => 055.out}         |    0
 tests/xfs/055.out.irix                       |   89 -
 tests/xfs/056                                |    2 +-
 tests/xfs/057                                |   47 -
 tests/xfs/057.out                            |   34 -
 tests/xfs/058                                |   46 -
 tests/xfs/058.out                            |  243 --
 tests/xfs/061                                |    2 +-
 tests/xfs/064                                |    2 +-
 tests/xfs/065                                |    2 +-
 tests/xfs/066                                |    2 +-
 tests/xfs/071                                |    2 +-
 tests/xfs/072                                |    2 +-
 tests/xfs/080                                |    6 -
 tests/xfs/081                                |   10 +-
 tests/xfs/082                                |   11 +-
 tests/xfs/082.cfg                            |    2 -
 tests/xfs/{082.op.linux => 082.op}           |    0
 tests/xfs/082.op.irix                        | 5628 --------------------------
 tests/xfs/084                                |   10 +-
 tests/xfs/092                                |    2 +-
 tests/xfs/094                                |    2 +-
 tests/xfs/095                                |   69 -
 tests/xfs/095.out                            |    6 -
 tests/xfs/096                                |    2 +-
 tests/xfs/103                                |    2 +-
 tests/xfs/107                                |    2 +-
 tests/xfs/108                                |    2 +-
 tests/xfs/114                                |  340 --
 tests/xfs/114.out                            |  365 --
 tests/xfs/115                                |  257 --
 tests/xfs/115.out                            |  118 -
 tests/xfs/116                                |    2 +-
 tests/xfs/118                                |    2 +-
 tests/xfs/119                                |    2 +-
 tests/xfs/121                                |    2 +-
 tests/xfs/136                                |    2 +-
 tests/xfs/142                                |    2 +-
 tests/xfs/143                                |    2 +-
 tests/xfs/144                                |    2 +-
 tests/xfs/145                                |    2 +-
 tests/xfs/146                                |    5 +-
 tests/xfs/146.cfg                            |    2 -
 tests/xfs/{146.out.linux => 146.out}         |    0
 tests/xfs/146.out.irix                       |  324 --
 tests/xfs/147                                |    2 +-
 tests/xfs/148                                |    2 +-
 tests/xfs/149                                |    2 +-
 tests/xfs/150                                |    2 +-
 tests/xfs/151                                |    2 +-
 tests/xfs/152                                |    2 +-
 tests/xfs/153                                |    2 +-
 tests/xfs/154                                |    2 +-
 tests/xfs/155                                |    2 +-
 tests/xfs/156                                |    2 +-
 tests/xfs/157                                |    2 +-
 tests/xfs/158                                |    2 +-
 tests/xfs/159                                |    2 +-
 tests/xfs/160                                |    2 +-
 tests/xfs/161                                |    2 +-
 tests/xfs/162                                |    2 +-
 tests/xfs/163                                |    2 +-
 tests/xfs/164                                |    2 +-
 tests/xfs/165                                |    2 +-
 tests/xfs/170                                |    2 +-
 tests/xfs/172                                |    2 +-
 tests/xfs/173                                |    2 +-
 tests/xfs/174                                |    2 +-
 tests/xfs/181                                |    2 +-
 tests/xfs/185                                |    2 +-
 tests/xfs/188                                |    2 +-
 tests/xfs/194                                |    2 +-
 tests/xfs/206                                |    2 +-
 tests/xfs/291                                |    2 +-
 tests/xfs/292                                |    2 +-
 tests/xfs/293                                |    2 +-
 tests/xfs/295                                |    2 +-
 tests/xfs/297                                |    2 +-
 tests/xfs/303                                |    2 +-
 tests/xfs/group                              |    5 -
 240 files changed, 245 insertions(+), 18195 deletions(-)
 delete mode 100755 make_irix
 delete mode 100644 tests/generic/088.cfg
 rename tests/generic/{088.out.linux => 088.out} (100%)
 delete mode 100644 tests/generic/088.out.irix
 delete mode 100755 tests/generic/093
 delete mode 100644 tests/generic/093.out
 delete mode 100755 tests/generic/097
 delete mode 100644 tests/generic/097.out.udf
 delete mode 100644 tests/generic/097.out.xfs
 delete mode 100755 tests/generic/099
 delete mode 100644 tests/generic/099.out
 delete mode 100755 tests/udf/098
 delete mode 100644 tests/udf/098.out
 delete mode 100755 tests/udf/101
 delete mode 100644 tests/udf/101.out
 delete mode 100644 tests/xfs/018.cfg
 rename tests/xfs/{018.op.linux => 018.op} (100%)
 delete mode 100644 tests/xfs/018.op.irix
 delete mode 100644 tests/xfs/022.cfg
 rename tests/xfs/{022.out.linux => 022.out} (100%)
 delete mode 100644 tests/xfs/022.out.irix
 delete mode 100644 tests/xfs/023.cfg
 rename tests/xfs/{023.out.linux => 023.out} (100%)
 delete mode 100644 tests/xfs/023.out.irix
 delete mode 100644 tests/xfs/030.cfg
 rename tests/xfs/{030.out.linux => 030.out} (100%)
 delete mode 100644 tests/xfs/030.out.irix
 delete mode 100644 tests/xfs/031.cfg
 rename tests/xfs/{031.out.linux => 031.out} (100%)
 delete mode 100644 tests/xfs/031.out.irix
 rename tests/xfs/{033.out.crc.linux => 033.out.crc} (100%)
 rename tests/xfs/{033.out.linux => 033.out.default} (100%)
 delete mode 100644 tests/xfs/033.out.irix
 delete mode 100644 tests/xfs/035.cfg
 rename tests/xfs/{035.out.linux => 035.out} (100%)
 delete mode 100644 tests/xfs/035.out.irix
 delete mode 100644 tests/xfs/036.cfg
 rename tests/xfs/{036.out.linux => 036.out} (100%)
 delete mode 100644 tests/xfs/036.out.irix
 delete mode 100644 tests/xfs/039.cfg
 rename tests/xfs/{039.out.linux => 039.out} (100%)
 delete mode 100644 tests/xfs/039.out.irix
 delete mode 100644 tests/xfs/043.cfg
 rename tests/xfs/{043.out.linux => 043.out} (100%)
 delete mode 100644 tests/xfs/043.out.irix
 rename tests/xfs/{055.out.linux => 055.out} (100%)
 delete mode 100644 tests/xfs/055.out.irix
 delete mode 100755 tests/xfs/057
 delete mode 100644 tests/xfs/057.out
 delete mode 100755 tests/xfs/058
 delete mode 100644 tests/xfs/058.out
 delete mode 100644 tests/xfs/082.cfg
 rename tests/xfs/{082.op.linux => 082.op} (100%)
 delete mode 100644 tests/xfs/082.op.irix
 delete mode 100755 tests/xfs/095
 delete mode 100644 tests/xfs/095.out
 delete mode 100755 tests/xfs/114
 delete mode 100644 tests/xfs/114.out
 delete mode 100755 tests/xfs/115
 delete mode 100644 tests/xfs/115.out
 delete mode 100644 tests/xfs/146.cfg
 rename tests/xfs/{146.out.linux => 146.out} (100%)
 delete mode 100644 tests/xfs/146.out.irix

-- 
2.13.0.506.g27d5fe0cd-goog

