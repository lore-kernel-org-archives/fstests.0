Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:8494 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932103AbbHDHAr (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 4 Aug 2015 03:00:47 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1ZMWD9-0002wa-Oa
	for fstests@vger.kernel.org; Tue, 04 Aug 2015 17:00:31 +1000
Date: Tue, 4 Aug 2015 17:00:31 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 8c3016b
Message-ID: <20150804070031.GY3902@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated.

It's been a little while since I've updated the tree, so this is a
fairly large update. I'd like to pass a big thanks to Eryu for
reviewing as many patches as he does - he reviewed more commits
than he authored, and he was the equal highest author.

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

-Dave.

The new head of the master branch is commit:

8c3016b xfstests: fix build errors and warnings

New Commits:

Ari Sundholm (1):
      [d484690] awk invocation cleanup for busybox support.

Brian Foster (3):
      [46e088e] xfs: test inode allocation with fragmented free space
      [67f0524] generic: xattr enospc cleanup test
      [f56f5bd] xfs: test log recovery checksum with different log buf sizes

Dave Chinner (2):
      [dce54db] xfs: test extent size hint size overflows
      [8c3016b] xfstests: fix build errors and warnings

Dongsheng Yang (2):
      [4273348] btrfs/022: add a quota rescan -w to wait rescan finished.
      [6834333] generic/038: mount scratch before checking it

Eric Sandeen (1):
      [a092363] PATCH 3/3 V6] xfs: test changing UUID on V5 superblock

Eryu Guan (9):
      [00c81b7] generic/081: wait for lv to be settled before creating fs o=
n it
      [45e4e5b] xfs: test rw remount on norecovery ro mount
      [7a2354e] common: move _check_dmesg to common/rc
      [677f277] common: add filter to _check_dmesg
      [fe272bc] generic: concurrent IO test with mixed IO types
      [6733157] fstests: remove $seqres.full before tests run
      [9f7d2a5] ext4: test migration to non-extent based file format
      [5a18f83] xfs/078: omit -m crc=3D0 mkfs option if mkfs.xfs has no met=
a support
      [5da2519] common: fix _count_extents and _count_holes

Filipe Manana (9):
      [3cc9364] generic: test for fsync after adding hard link to a file
      [4712000] shared: test for fsync after adding xattrs to a file
      [43b3882] generic: test for truncating a file into the middle of a ho=
le
      [9dcfb88] generic: test for fsync after file truncations
      [7f76160] btrfs: test to exercise shared extent reference accounting
      [a022d31] btrfs: regression test for the clone ioctl
      [5b415d2] generic: test for fsync after adding hard links
      [3d0e773] generic: file fsync after unlink and inode eviction
      [45eca98] btrfs: test for incremental send after file extent cloning

George Wang (1):
      [8387546] xfs/015: keep create_file running until growfs finished

Jan Tulak (2):
      [6108261] check: Allow partial test names
      [7fd3085] check: add a flag for direct printing of test output

Josef Bacik (2):
      [0372c9f] fiemap-tester: convert to use O_DIRECT
      [996d967] generic: add fiemap test that does prealloc

Kamalesh Babulal (1):
      [9571c79] check: Fix a typo

Lukas Czerner (1):
      [6b992d5] generic: test zero range crossing isize within single block

Omar Sandoval (2):
      [0e2a022] btrfs: test premature submount unmounting when deleting def=
ault subvolume
      [e1aaded] btrfs/011: test replace on RAID 5/6 now that it's supported

Theodore Ts'o (4):
      [cf67ba1] fsstress: add the [-l loops] option
      [ad75f28] fsstress: add the -c option
      [9cd152c] lstat64:: use Posix st_mode defines
      [dca33a6] locktest: remove manual declaration of errno

Wang Sheng-Hui (1):
      [ea9e6f5] generic/288: correct the testcase description

Wang Yanfeng (1):
      [b9982f9] generic: busy loop of dd and rm test

Zhao Lei (1):
      [4380e4d] check: Make -g and -x option meet description in manual


Code Diffstat:

 check                                          |   81 +-
 common/config                                  |   19 +
 common/filter                                  |    4 +-
 common/punch                                   |    4 +-
 common/rc                                      |   94 +-
 dmapi/src/common/cmd/write_invis.c             |    1 +
 dmapi/src/common/lib/util.c                    |    1 +
 dmapi/src/suite1/cmd/get_dirattrs.c            |    1 +
 dmapi/src/suite1/cmd/probe_punch_xfsctl_hole.c |    3 +
 dmapi/src/suite2/src/test_dmattr.c             |    1 +
 ltp/doio.c                                     |    1 +
 ltp/fsstress.c                                 |   27 +-
 src/bulkstat_unlink_test.c                     |    2 +
 src/bulkstat_unlink_test_modified.c            |    2 +
 src/fiemap-tester.c                            |    5 +-
 src/iopat.c                                    |    3 +
 src/locktest.c                                 |    1 -
 src/lstat64.c                                  |   18 +-
 src/trunc.c                                    |   12 +-
 src/unwritten_sync.c                           |    2 +
 src/xfsctl.c                                   |    5 +
 tests/btrfs/011                                |    4 +-
 tests/btrfs/022                                |    1 +
 tests/btrfs/089                                |   79 +
 tests/btrfs/089.out                            |    2 +
 tests/btrfs/095                                |  154 ++
 tests/btrfs/095.out                            |    9 +
 tests/btrfs/096                                |   80 +
 tests/btrfs/096.out                            |   12 +
 tests/btrfs/097                                |  113 ++
 tests/btrfs/097.out                            |    7 +
 tests/btrfs/group                              |    4 +
 tests/ext4/005                                 |   83 +
 tests/ext4/271                                 |    1 +
 tests/ext4/group                               |    1 +
 tests/generic/019                              |    1 +
 tests/generic/038                              |    2 +-
 tests/generic/081                              |    2 +
 tests/generic/090                              |  108 ++
 tests/generic/090.out                          |   17 +
 tests/generic/094                              |   71 +
 tests/generic/094.out                          |    3 +
 tests/generic/095                              |  141 ++
 tests/generic/095.out                          |    2 +
 tests/generic/096                              |   64 +
 tests/generic/096.out                          |    2 +
 tests/generic/098                              |   91 ++
 tests/generic/098.out                          |   11 +
 tests/generic/101                              |  117 ++
 tests/generic/101.out                          |   19 +
 tests/generic/102                              |   65 +
 tests/generic/102.out                          |   21 +
 tests/generic/103                              |   92 ++
 tests/generic/103.out                          |    2 +
 tests/generic/104                              |   99 ++
 tests/generic/104.out                          |    3 +
 tests/generic/106                              |   97 ++
 tests/generic/106.out                          |    3 +
 tests/generic/269                              |    1 +
 tests/generic/270                              |    1 +
 tests/generic/273                              |    2 +-
 tests/generic/288                              |    2 +-
 tests/generic/group                            |   10 +
 tests/shared/002                               |  121 ++
 tests/shared/002.out                           | 2014 ++++++++++++++++++++=
++++
 tests/shared/272                               |    1 +
 tests/shared/group                             |    1 +
 tests/xfs/015                                  |   16 +-
 tests/xfs/074                                  |   93 ++
 tests/xfs/074.out                              |    2 +
 tests/xfs/075                                  |   61 +
 tests/xfs/075.out                              |    2 +
 tests/xfs/076                                  |  130 ++
 tests/xfs/076.out                              |    2 +
 tests/xfs/077                                  |  143 ++
 tests/xfs/077.out                              |   21 +
 tests/xfs/078                                  |    6 +-
 tests/xfs/079                                  |   88 ++
 tests/xfs/079.out                              |    2 +
 tests/xfs/group                                |    5 +
 80 files changed, 4511 insertions(+), 83 deletions(-)
 create mode 100755 tests/btrfs/089
 create mode 100644 tests/btrfs/089.out
 create mode 100755 tests/btrfs/095
 create mode 100644 tests/btrfs/095.out
 create mode 100755 tests/btrfs/096
 create mode 100644 tests/btrfs/096.out
 create mode 100755 tests/btrfs/097
 create mode 100644 tests/btrfs/097.out
 create mode 100755 tests/ext4/005
 create mode 100755 tests/generic/090
 create mode 100644 tests/generic/090.out
 create mode 100644 tests/generic/094
 create mode 100644 tests/generic/094.out
 create mode 100755 tests/generic/095
 create mode 100644 tests/generic/095.out
 create mode 100755 tests/generic/096
 create mode 100644 tests/generic/096.out
 create mode 100755 tests/generic/098
 create mode 100644 tests/generic/098.out
 create mode 100755 tests/generic/101
 create mode 100644 tests/generic/101.out
 create mode 100755 tests/generic/102
 create mode 100644 tests/generic/102.out
 create mode 100644 tests/generic/103
 create mode 100644 tests/generic/103.out
 create mode 100755 tests/generic/104
 create mode 100644 tests/generic/104.out
 create mode 100755 tests/generic/106
 create mode 100644 tests/generic/106.out
 create mode 100755 tests/shared/002
 create mode 100644 tests/shared/002.out
 create mode 100755 tests/xfs/074
 create mode 100644 tests/xfs/074.out
 create mode 100755 tests/xfs/075
 create mode 100644 tests/xfs/075.out
 create mode 100755 tests/xfs/076
 create mode 100644 tests/xfs/076.out
 create mode 100755 tests/xfs/077
 create mode 100644 tests/xfs/077.out
 create mode 100755 tests/xfs/079
 create mode 100644 tests/xfs/079.out
--=20
Dave Chinner
david@fromorbit.com

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVwGMPAAoJEK3oKUf0dfodUtcQAMyCEoq+Eq03toSTNUjbkCPd
CMATe+mJurw4anjdnD7JN2BazSU378XIsWQ0ynEcriUbwy2aDZ9j0cx3sFyC737E
QntvwoMT5trgg9jtT68doAS201ncsFhslrqmX5T3zY0Ji+EwOwpwx6pSEEunfPSc
zS36ru/lfZDteGbfLDw0ArfYWJTYR5gSlJvzDVue1ecQskHxce/uuoNkjh1x+vHn
Kks/lbXNuaD0xx6QgddqzKs5X0gqS7c/gJfLbpZEjZZUOuuTgHRnw2fxmR3o8PED
Sx18AYVXeUiNoM90thCB9iec7ztxC8KmG98r0DJ8KUw/H7jmfDh6xA6M/Nlzx5Jw
/Zz1pIrpTw4iHbHLJS8A/f0kdyeb8qyCOAeZ/iWQvVHEr25+IlUwph2ZBNQukxv2
v7BtJI6D2WGpLrpu8DPqOO8Ez6DnUHbRZSxhFUnsOCNyOuULQWeDHpbrwmbafad9
oIClMWTMuN1V+P5RnhbeVFy2DqFgWgm/iQRenh3ikG6Hsg0ohdO+way51DQZ+xCW
XzIxgQjcrnvBCZvayqhB3zLUVwLCUTWN+TqiV7vwO80QLws76sVhGL505cy/QF/I
RLb6AXCV0bFq/C0tjJORFP5kqHIgHPYAKD8fOHrgfxiAG3+tqYMB4Mfzf4tUx4oi
ykUxRTZTQKII5j36/hIp
=+lnf
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
