Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:56592 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750747AbcILXvC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Sep 2016 19:51:02 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1bjb06-0002YM-J5
        for fstests@vger.kernel.org; Tue, 13 Sep 2016 09:50:58 +1000
Date: Tue, 13 Sep 2016 09:50:58 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 06d4001
Message-ID: <20160912235058.GE30497@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Eryu has put together quite a large update,
and there are a couple of new tests that might cause failures on XFS
as the fixes aren't upstream yet. Overall there are lots of XFS test
changes, some overlay and generic test changes and a couple of ext4
test fixes make up the update. Thanks to everyone who has submitted
new tests, and even more thanks to everyone who has reviewed them!

-Dave.

The new head of the master branch is commit:

06d4001 xfs: test getbmapx shared extent reporting

New Commits:

Artem Savkov (1):
      [0dea6dc] generic: listxattr syscall with different buffer sizes

Darrick J. Wong (10):
      [5ca088b] tests/xfs: don't run tests if cowextsize isn't present
      [5bcb0b7] xfs/122: decrease the log update done item sizes
      [acede20] xfs/130,235: deal with an unreplayable dirty log
      [297985b] generic/159, 160: deal with EACCES -> EPERM transition
      [a381fcb] xfs/122: test btree header block sizes
      [bb5bd55] xfs: test swapext with reflink
      [5324dcb] xfs/122: track xfs_scrub_metadata
      [2db29c7] xfs/122: check the ag reservation counter ioctl
      [c49136e] xfs: test getfsmap ioctl
      [06d4001] xfs: test getbmapx shared extent reporting

Eric Sandeen (1):
      [2c40339] README: fix up dependency lists

Eryu Guan (4):
      [3e3b49c] common/rc: introduce _overlay_mount_dirs helper
      [628d9db] overlay: copy-up lowerdir which has opaque xattr set
      [14a7fdf] xfs/279: filter scsi debug device correctly
      [0cc2716] generic: simple permission check on hard links

Qu Wenruo (1):
      [d67700c] common/rc: Enhance _exclude_scratch_mount_option to handle =
multiple options

Wang Xiaoguang (1):
      [a54bed2] generic/172: raise fs size

Xiao Yang (1):
      [115563d] ext4/021: use $XFS_IO_PROG instead of xfs_io

Zorro Lang (2):
      [643d623] generic/095: add xfs_file_aio_read into warning whitelist
      [1083413] xfs: rw remount with unknown ro-compat features


Code Diffstat:

 .gitignore            |   1 +
 README                |  17 +++++----
 common/rc             |  48 ++++++++++++++++++-----
 src/Makefile          |   2 +-
 src/listxattr.c       |  73 +++++++++++++++++++++++++++++++++++
 tests/ext4/021        |   2 +-
 tests/ext4/271        |   6 +--
 tests/generic/095     |   4 +-
 tests/generic/159     |   7 +++-
 tests/generic/160     |   7 +++-
 tests/generic/172     |  20 ++++------
 tests/generic/377     |  87 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/377.out |  11 ++++++
 tests/generic/378     |  73 +++++++++++++++++++++++++++++++++++
 tests/generic/378.out |   3 ++
 tests/generic/group   |   2 +
 tests/overlay/005     |   5 +--
 tests/overlay/010     |   5 +--
 tests/overlay/014     |  94 +++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/014.out |   3 ++
 tests/overlay/group   |   1 +
 tests/xfs/122.out     |  10 +++--
 tests/xfs/130         |   3 +-
 tests/xfs/134         |   3 +-
 tests/xfs/215         |   1 +
 tests/xfs/218         |   1 +
 tests/xfs/219         |   1 +
 tests/xfs/221         |   1 +
 tests/xfs/223         |   1 +
 tests/xfs/224         |   1 +
 tests/xfs/225         |   1 +
 tests/xfs/226         |   1 +
 tests/xfs/228         |   1 +
 tests/xfs/230         |   1 +
 tests/xfs/231         |   1 +
 tests/xfs/232         |   1 +
 tests/xfs/235         |   3 +-
 tests/xfs/243         |   1 +
 tests/xfs/248         |   1 +
 tests/xfs/249         |   1 +
 tests/xfs/251         |   1 +
 tests/xfs/254         |   1 +
 tests/xfs/255         |   1 +
 tests/xfs/256         |   1 +
 tests/xfs/257         |   1 +
 tests/xfs/258         |   1 +
 tests/xfs/270         |  93 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/270.out     |   5 +++
 tests/xfs/271         |  82 ++++++++++++++++++++++++++++++++++++++++
 tests/xfs/271.out     |  13 +++++++
 tests/xfs/272         |  84 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/272.out     |   6 +++
 tests/xfs/273         |  65 ++++++++++++++++++++++++++++++++
 tests/xfs/273.out     |   3 ++
 tests/xfs/274         |  95 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/274.out     |   7 ++++
 tests/xfs/275         |  68 +++++++++++++++++++++++++++++++++
 tests/xfs/275.out     |   4 ++
 tests/xfs/276         |  85 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/276.out     |   6 +++
 tests/xfs/277         |  68 +++++++++++++++++++++++++++++++++
 tests/xfs/277.out     |   4 ++
 tests/xfs/279         |   2 +-
 tests/xfs/280         |  93 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/280.out     |  17 +++++++++
 tests/xfs/315         |   1 +
 tests/xfs/326         |   1 +
 tests/xfs/328         | 109 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
 tests/xfs/328.out     |   6 +++
 tests/xfs/329         |  97 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/329.out     |  10 +++++
 tests/xfs/330         | 102 ++++++++++++++++++++++++++++++++++++++++++++++=
+++
 tests/xfs/330.out     |  12 ++++++
 tests/xfs/group       |  12 ++++++
 74 files changed, 1607 insertions(+), 54 deletions(-)
 create mode 100644 src/listxattr.c
 create mode 100755 tests/generic/377
 create mode 100644 tests/generic/377.out
 create mode 100755 tests/generic/378
 create mode 100644 tests/generic/378.out
 create mode 100755 tests/overlay/014
 create mode 100644 tests/overlay/014.out
 create mode 100755 tests/xfs/270
 create mode 100644 tests/xfs/270.out
 create mode 100755 tests/xfs/271
 create mode 100644 tests/xfs/271.out
 create mode 100755 tests/xfs/272
 create mode 100644 tests/xfs/272.out
 create mode 100755 tests/xfs/273
 create mode 100644 tests/xfs/273.out
 create mode 100755 tests/xfs/274
 create mode 100644 tests/xfs/274.out
 create mode 100755 tests/xfs/275
 create mode 100644 tests/xfs/275.out
 create mode 100755 tests/xfs/276
 create mode 100644 tests/xfs/276.out
 create mode 100755 tests/xfs/277
 create mode 100644 tests/xfs/277.out
 create mode 100755 tests/xfs/280
 create mode 100644 tests/xfs/280.out
 create mode 100755 tests/xfs/328
 create mode 100644 tests/xfs/328.out
 create mode 100755 tests/xfs/329
 create mode 100644 tests/xfs/329.out
 create mode 100755 tests/xfs/330
 create mode 100644 tests/xfs/330.out
--=20
Dave Chinner
david@fromorbit.com

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX1z9iAAoJEK3oKUf0dfod32cQAJpRxlBcs5LKltBtV//WqWbE
8E2JDhi9zbHiMaw9gjJABI9U1VAE+HhRLmHJOiKI9W/qFicgA7e7QnN4vPvRgm54
7UhlU8o5lmFm11OI2Txga3e/ygiImTorytlpTnmViCx7wqz5ek7lcEffMK5hYlNw
ODVenkZmFsnhsFenBYMuhHgKSFAI2U+iyYsYaNu8kWE/a+XBO/hHCUm2pJvtZMiS
EeX7Yya+2UA5kVHJ12iHkXnp32H7MkT4HyihisyMz1HWo42i34oYwWa+/c+G2/5s
J4JcU4ha7hXXxzMxhTkjatj4nL7LHH57YRKwurz9iTPBmBRthpmfhjYpVwYm5EvK
l4mnX0vRN15mZcgOIOoS5LT38ZbZCkXa6VKrAoONXqbwnZt8wshNPsjqH1OFQYzB
9DiIgJemW+C2KX2EjRuI2SUWWtHPADw1q1/ltv4Qe0BG3Emla5pbjZA7wCrc6hLC
mqo+zso0/+7j9k/ny2XbccOZ5vpIaAbPYdBqqKicbFA9oySDLn4fzSf3R5j+fs/O
uF3AQcBmGIi5E4iMW1zYFLIGJicXODSsBu8Q3aAV3mYGeC/XJB2YZ9MVEJTTvhMy
xs/yWKnGSM6YTxsuRjqeG+cpRGFjXbKgRmRK/kZm+ysvcLWrhCUabsIekksP9BGW
Z0GLIuA/jXHhWyyP2yf8
=aZMY
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
