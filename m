Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:15842 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751234AbcCWGnM (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 23 Mar 2016 02:43:12 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1aicVX-0005sJ-Bi
	for fstests@vger.kernel.org; Wed, 23 Mar 2016 17:43:07 +1100
Date: Wed, 23 Mar 2016 17:43:07 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to b90938e
Message-ID: <20160323064307.GC11812@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated.

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

b90938e overlay/001: change supported fs from generic to overlay

New Commits:

Andreas Gruenbacher (2):
      [8bad7c4] Rename output file templates to match TEST.out*
      [2c1896a] xfs/191: Remove obsolete nfs4acl tests

Chandan Rajendra (1):
      [1ffa403] btrfs: 'subvolume stress' tasks need to exit gracefully

Christoph Hellwig (1):
      [a78397f] xfs/209: filter scratch dir properly

Darrick J. Wong (11):
      [5d56a95] xfs/207: fix golden output to match FS_IOC_FSSETXATTR hoist
      [64f56fd] xfs: test copy-on-write leftover recovery
      [3907442] reflink: fix fragmentation tests to work on >4k block size =
filesystems
      [218880c] xfs/23[3-6]: don't source common/xfs, it doesn't exist
      [13717ff] xfs/206: fix output when mkfs knows about reflink
      [31f4856] xfs/030: fix output on newer filesystems
      [16625d3] xfs/073: fix output
      [e1644f5] xfs/122: define _GNU_SOURCE when compiling test program
      [00cbdca] xfs/122: support rmapxbt
      [6243fb4] xfs: test per-ag allocation accounting during truncate-caus=
ed refcountbt expansion
      [f1c3fee] xfs: remove NOCOW_FL testing from test

David Sterba (2):
      [232593d] filter.btrfs: new filter for property messages
      [2dd2cea] btrfs/048: user filter for property error messages

Eryu Guan (5):
      [2451c33] common: filter more messages from _scratch_mkfs_ext4
      [ca06825] xfs/137: require scratch to be CRC enabled XFS
      [d00a869] generic: test I/O on dm error device
      [848f580] fstests: make xfs/006 generic
      [5af5146] xfs/073: avoid finobt warning from mkfs

Filipe Manana (4):
      [3a92426] btrfs/118: remove call to _need_to_be_root
      [32253c7] overlayfs: test fsync on merged directory
      [2c1973c] check: catch general protection fault traces in _check_dmesg
      [b90938e] overlay/001: change supported fs from generic to overlay

Ross Zwisler (1):
      [1637c06] ext4: defrag not supported with DAX

Wang Xiaoguang (1):
      [26ae452] btrfs/059: add a filter for btrfs compression property


Code Diffstat:

 .gitignore                                   |  19 ++
 common/defrag                                |   9 +-
 common/filter.btrfs                          |  16 ++
 common/rc                                    |  10 +-
 nfs4acl/Makefile                             |  29 ---
 nfs4acl/apply-mask.test                      | 143 -------------
 nfs4acl/basic.test                           |  70 -------
 nfs4acl/chmod.test                           |  31 ---
 nfs4acl/chown.test                           |  63 ------
 nfs4acl/computed-mode.test                   |  62 ------
 nfs4acl/create.test                          |  35 ----
 nfs4acl/ctime.test                           |  36 ----
 nfs4acl/delete.test                          |  77 -------
 nfs4acl/run                                  | 298 -----------------------=
---
 nfs4acl/unrepresentable.test                 |  20 --
 nfs4acl/write-vs-append.test                 |  46 ----
 tests/btrfs/048                              |   4 +-
 tests/btrfs/059                              |  16 +-
 tests/btrfs/059.out                          |   6 +-
 tests/btrfs/060                              |   8 +-
 tests/btrfs/065                              |   8 +-
 tests/btrfs/066                              |   8 +-
 tests/btrfs/067                              |   8 +-
 tests/btrfs/068                              |   8 +-
 tests/btrfs/118                              |   1 -
 tests/generic/338                            |  80 +++++++
 tests/generic/338.out                        |   2 +
 tests/{xfs/006 =3D> generic/339}               |  32 +--
 tests/generic/339.out                        |   2 +
 tests/generic/group                          |   2 +
 tests/overlay/001                            |   2 +-
 tests/{xfs/191 =3D> overlay/002}               |  67 +++---
 tests/overlay/002.out                        |   3 +
 tests/overlay/group                          |   1 +
 tests/xfs/006.out                            |  28 ---
 tests/xfs/030                                |   5 +-
 tests/xfs/030.out.linux                      |   2 +
 tests/xfs/073                                |   2 +-
 tests/xfs/073.out                            |   6 -
 tests/xfs/096                                |   4 +-
 tests/xfs/{096.external =3D> 096.out.external} |   0
 tests/xfs/{096.internal =3D> 096.out.internal} |   0
 tests/xfs/122                                |   1 +
 tests/xfs/122.out                            |   3 +-
 tests/xfs/127                                |   2 +-
 tests/xfs/132                                |   5 -
 tests/xfs/132.out                            |  20 --
 tests/xfs/137                                |   2 +-
 tests/xfs/191.out                            | 324 -----------------------=
------
 tests/xfs/206                                |   1 +
 tests/xfs/206.out                            |   2 +
 tests/xfs/207.out                            |   6 +-
 tests/xfs/209                                |   2 +-
 tests/xfs/209.out                            |  16 +-
 tests/xfs/215                                |   2 +-
 tests/xfs/218                                |   2 +-
 tests/xfs/219                                |   2 +-
 tests/xfs/221                                |   2 +-
 tests/xfs/223                                |   2 +-
 tests/xfs/224                                |   2 +-
 tests/xfs/225                                |   2 +-
 tests/xfs/226                                |   2 +-
 tests/xfs/228                                |   2 +-
 tests/xfs/230                                |   2 +-
 tests/xfs/231                                |   2 +-
 tests/xfs/232                                |   2 +-
 tests/xfs/233                                |   1 -
 tests/xfs/234                                |   1 -
 tests/xfs/235                                |   1 -
 tests/xfs/236                                |   1 -
 tests/xfs/263                                | 179 ++++++++++++++++
 tests/xfs/263.out                            |  13 ++
 tests/xfs/264                                | 180 ++++++++++++++++
 tests/xfs/264.out                            |  13 ++
 tests/xfs/265                                |  95 +++++++++
 tests/xfs/265.out                            |  10 +
 tests/xfs/group                              |   5 +-
 77 files changed, 773 insertions(+), 1403 deletions(-)
 delete mode 100644 nfs4acl/Makefile
 delete mode 100644 nfs4acl/apply-mask.test
 delete mode 100644 nfs4acl/basic.test
 delete mode 100644 nfs4acl/chmod.test
 delete mode 100644 nfs4acl/chown.test
 delete mode 100644 nfs4acl/computed-mode.test
 delete mode 100644 nfs4acl/create.test
 delete mode 100644 nfs4acl/ctime.test
 delete mode 100644 nfs4acl/delete.test
 delete mode 100755 nfs4acl/run
 delete mode 100644 nfs4acl/unrepresentable.test
 delete mode 100644 nfs4acl/write-vs-append.test
 create mode 100755 tests/generic/338
 create mode 100644 tests/generic/338.out
 rename tests/{xfs/006 =3D> generic/339} (74%)
 create mode 100644 tests/generic/339.out
 rename tests/{xfs/191 =3D> overlay/002} (53%)
 create mode 100644 tests/overlay/002.out
 delete mode 100644 tests/xfs/006.out
 rename tests/xfs/{096.external =3D> 096.out.external} (100%)
 rename tests/xfs/{096.internal =3D> 096.out.internal} (100%)
 delete mode 100644 tests/xfs/191.out
 create mode 100755 tests/xfs/263
 create mode 100644 tests/xfs/263.out
 create mode 100755 tests/xfs/264
 create mode 100644 tests/xfs/264.out
 create mode 100755 tests/xfs/265
 create mode 100644 tests/xfs/265.out
--=20
Dave Chinner
david@fromorbit.com

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8jr6AAoJEK3oKUf0dfodI1oQANE+Ss7W6UKh6K7VRYfMuIDe
xihMxmMoyqMIyUW4SJChfKjkmNS9HKW2EqMeklYafv9nqkrw687fLtbb5PNGy/+g
teeU1z31CurkqEjse7QSb7mkdq6u7V+ioy+8Z/PvuT8k5wuhTs5Sp0Ik2wCrS5e8
h+pwOFozh522zcYjj/ECbItociZgeHey4mP1jIv0LvO27mfBG99pPitlMoAvJBzz
9uwNW2SQ45YUYO8W1b6wkD8vBysv5CgEPCUUVlgKqh5hrKo0JOeN2MoxRDHdilcE
14/5eWm2KouTx8gGzFu5cLhmQ0cLJYVXdCxwc2Ne6vd3uPJbjyd7ngcWRqbuzNUP
pW+PNouGxWekoM39Y9k314b0CQhYzn9JAUtCAvq1zBHF8V6Dwu/VS0w2phaqyLhj
yefkRfrCBYlSb6AuwKz6ajKFlM0moB37RBbKfZcGAWSE/E+qAbsUUS06zvrvsS3B
Lek1Zs5DB8TofIW9S5ZfvZIiOZP//6xcu8IfzAi3J/O7zbWso1TvV0w4UfQ7AztP
uy4p0z3SL5Rqdz4emW1gdpL3BeGvC4kdlTwKWhu8+7xQPUmigcRzZqslVW9b5wf9
Hj2h0Mqktz/6sC3NzCOnifmjt+pVMr+zmfMCWpel7Z8vl8bVdXaBG/5ThRrmio3y
CrBw81fVShjLfa9ZtSb9
=y4J8
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
