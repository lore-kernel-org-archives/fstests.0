Received: from mail-pg0-f65.google.com ([74.125.83.65]:35443 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdG3Jds (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Jul 2017 05:33:48 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so27724086pgc.2
        for <fstests@vger.kernel.org>; Sun, 30 Jul 2017 02:33:48 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id t70sm48534330pfk.111.2017.07.30.02.33.45
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jul 2017 02:33:46 -0700 (PDT)
Message-ID: <597da7fa.c999620a.e7c2a.8fe4@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 30 Jul 2017 17:33:39 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 14d318429ebb
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ESzoNa98vRCI"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--ESzoNa98vRCI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a fairly large update, mainly due to the
removal of IRIX support from Eric Biggers (many many thanks to Eric!).  Though
there're, as Eric mentioned in his cover letter email, still some remaining
pieces to be removed, like the check for $HOSTOS and even killing _supported_os
completely, this update removed most of the IRIX support, including
IRIX-specific tests, build system and documentation.

Other notable changes are, Zorro Lang added new pread/pwrite and aio operations
to fsstress; Ernesto added reiserfs support to _scratch_mkfs_sized. There're
also new tests for new ext4 ea_inode feature and for xfs_db.

Thanks again to those who have contributed to this update!

New failures I've noticed in this update:
- generic/099 fails on NFSv3 and CIFSv1.0, which was previously an
  IRIX-specific acl test, and has been made generic in this update
  (renamed from shared/051)

Thanks,
Eryu

The new head of the master branch is commit:

14d318429ebb generic/446: make sure all background processes are dead before umount

New commits:

Bill O'Donnell (1):
      [6a6e65aa5093] xfs: test xfs_db to ensure type size taken into account with new type

Eric Biggers (15):
      [f5413189dbd5] tests: port generic/093 to Linux
      [74d977646c74] tests: port generic/097 to Linux
      [3c64e7819ae5] tests: port xfs/095 to Linux
      [004e03ed15b0] tests: remove udf/098
      [27518372dc03] tests: remove udf/101
      [1ce90e01a794] tests: remove xfs/114 and xfs/115
      [5cb1f2b05520] tests: remove xfs/057 and xfs/058
      [5b55643c4509] tests: remove generic/099
      [46a6604d39ed] tests: make shared/051 a generic test
      [0e3b0ab584b2] README: remove IRIX-specific documentation
      [2983eebf075f] tests: remove IRIX support from tests also supported on Linux
      [48a473b5da50] tests: clean up per-OS output files
      [4556c97ebf90] common: remove IRIX-specific code
      [fb05a918085e] build: remove IRIX-specific build logic
      [fec7352230c2] include: remove some unused headers

Ernesto A. Fernández (1):
      [8489391928fd] common/rc: support reiserfs in _scratch_mkfs_sized

Eryu Guan (1):
      [14d318429ebb] generic/446: make sure all background processes are dead before umount

Tahsin Erdogan (1):
      [606c652eee97] ext4: add a test for ea_inode feature

Xiao Yang (1):
      [22b17d9e4f65] common/rc: factor out _ext4_disable_extent_zeroout() helper

Zorro Lang (3):
      [80499d8f5f25] fsstress: new writev and readv operations test
      [3fcc2c75bf13] fsstress: add AIO read/write and fsync test
      [d613bee20375] xfs/068: update golden output due to new operations in fsstress


Code Diffstat:

 .gitignore                                   |   14 -
 README                                       |   51 +-
 common/attr                                  |   12 -
 common/config                                |   12 -
 common/dump                                  |   19 +-
 common/filestreams                           |   43 +-
 common/log                                   |    1 -
 common/rc                                    |   57 +-
 configure.ac                                 |   59 +-
 include/builddefs.in                         |    3 -
 include/test.h                               |  192 -
 include/usctest.h                            |  303 --
 lib/str_to_bytes.c                           |    2 +-
 ltp/Makefile                                 |    4 -
 ltp/fsstress.c                               |  377 ++
 ltp/rwtest.sh                                |    1 -
 m4/package_globals.m4                        |    2 +-
 m4/package_libcdev.m4                        |    2 +-
 m4/package_utilies.m4                        |   14 +-
 m4/package_xfslibs.m4                        |   13 -
 make_irix                                    |  114 -
 src/Makefile                                 |    4 -
 src/acl_get.c                                |  148 -
 src/acl_test.c                               |  264 --
 src/fill2fs                                  |    5 +-
 src/writemod.c                               |    4 +-
 tests/ext4/026                               |  137 +
 tests/ext4/026.out                           |   29 +
 tests/ext4/group                             |    1 +
 tests/generic/001                            |    2 +-
 tests/generic/002                            |    2 +-
 tests/generic/005                            |    9 +-
 tests/generic/006                            |    2 +-
 tests/generic/007                            |    2 +-
 tests/generic/009                            |    3 +-
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
 tests/generic/093                            |  114 +-
 tests/generic/093.out                        |  Bin 917 -> 372 bytes
 tests/generic/096                            |    2 +-
 tests/generic/097                            |  253 +-
 tests/generic/097.out                        |  177 +
 tests/generic/097.out.udf                    |  132 -
 tests/generic/097.out.xfs                    |  132 -
 tests/generic/099                            |  136 +-
 tests/generic/099.out                        |  235 +-
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
 tests/generic/285                            |    6 -
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
 tests/generic/436                            |    6 -
 tests/generic/445                            |    6 -
 tests/generic/446                            |    6 +-
 tests/generic/448                            |    6 -
 tests/generic/group                          |    6 +-
 tests/shared/051                             |  321 --
 tests/shared/051.out                         |  220 -
 tests/shared/group                           |    1 -
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
 tests/xfs/068.out                            |    2 +-
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
 tests/xfs/095                                |   11 +-
 tests/xfs/095.out                            |    3 +-
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
 tests/xfs/424                                |  109 +
 tests/xfs/424.out                            |    2 +
 tests/xfs/group                              |    5 +-
 262 files changed, 1435 insertions(+), 19073 deletions(-)
--
Eryu Guan
eguan@redhat.com

--ESzoNa98vRCI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZfaa5AAoJECZSqilcj+djB+EQAMY+mnNBRs62VKwvCZq/KDzz
YuFi2uT/5omRGBl2aDm1NaEl8AAILnASxyawvijDBm64uYPx+baUKpWZBBggLQQ6
IrWyKDoNitlpbe0ke/4gj6wOk48ChW4zlMXQZ0DUIHgYgiVLWYLYnij9SndqZpLG
zciCfvrTWXYRcaWvDG2vIuh5mLR3C67VpGZaNDhDnpM5uGWzlpU1jnFwi5+sNqQt
Nm7IOYsA+KFYTcgKsZF0sVKltrZ45ep5hApQn2iOk5oiQlg5km7UNTpZ3E7XDNMC
e5yJT3wH0Ear/TJNGjDSmbMiOZootGYYyKbs+7lQztUIb1vSe+vyi5a7YEoTQT0d
2PqO6aPaXCKG9DvPTtTEJj5Q/CbVmnHHHzn+ClWQIOrxa6xkqv0pKN1IdyWT7iCb
GdcSNlv7Au6wB3OYiyLz6aSVTq+DcGaRKeuug0NppWVXWV0fVxb53IHI1Dd3fUcs
rz2upKm/c4o29fYw41yvCNLpRNhmMGGqFnQF8QrM4XcBlg9zaG4nA6KR6k/TFQt6
fy1WxjGOKS1SDDgoNs4/ok42z4Jz5eUxjRhIFVoSeJZ9GKEJ0n5w8ZUvvFyVbjtY
KRXyFSvm9XZg2NiQdFcb4uWJ1+d/lyLCLjrmCUIiLiBAtxaNeamSdoEpzbfaLOCV
8kbf+dQ2T0DtHj3kLJsA
=xFQO
-----END PGP SIGNATURE-----

--ESzoNa98vRCI--
