Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:51685 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751364AbbEZC4r (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 25 May 2015 22:56:47 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1Yx52o-0007RI-T8
	for fstests@vger.kernel.org; Tue, 26 May 2015 12:56:42 +1000
Date: Tue, 26 May 2015 12:56:42 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 78bbab9
Message-ID: <20150526025642.GY4316@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repository at git://oss.sgi.com/xfs/cmds/xfstests has
just been updated. Patches often get missed, so please check if your
outstanding patches were in this update. If they have not been in
this update, please resubmit them to fstests@vger.kernel.org so they
can be picked up in the next update.

The new head of the master branch is commit:

78bbab9 config: Fix sysfs paths for partitions

New Commits:

Andreas Gruenbacher (2):
      [35a192a] generic: Fix _is_block_dev quoting
      [51a36c7] generic/087,126: Test the permission to set file times

Andrew Price (2):
      [3f47f3c] common: set VFS_QUOTA for gfs2
      [02f29ec] generic/082: add to the quota group

Brian Foster (1):
      [50ea2c6] xfs/007: use gquotino for project quotas on pre-v5 superblo=
cks

Dave Chinner (7):
      [ae3d215] filter: latest mkfs.xfs makes logical sector size noise
      [e9cf80e] filter: latest xfs_repair is more verbose
      [da8f501] xfs/045: can't change UUID on v5 filesystems.
      [c5223b9] filter: inode size output of mkfs.xfs can change
      [81d9c70] generic/018: use xfs_io and larger buffers for writes
      [6bd4b51] generic/223, xfs/203: IO is not well aligned
      [9816be5] generic/275: writes may not partially succeed

Eric Sandeen (3):
      [fa4fcb5] xfs: test repairing false positive reserved attr name use
      [ac6c6b9] xfs/032: properly test for corruption from xfs_copy
      [f4eee51] xfs/111: make it work better

Eryu Guan (2):
      [a276c26] check: set failure status before exit
      [90a3bfc] xfs: be compatible with older mkfs.xfs which has no v5 supp=
ort

Filipe Manana (2):
      [2ba510d] btrfs: regression test for file range cloning
      [917efe2] btrfs: test for send with compressed file extents

Josef Bacik (1):
      [1c22274] generic: add a test for fallocate+truncate

Matthew Wilcox (1):
      [78bbab9] config: Fix sysfs paths for partitions

Omer Zilberberg (2):
      [32d2a17] generic/076: fixed incorrect fsstress parameters
      [2624425] _require_command: quote commands correctly

Wang Sheng-Hui (1):
      [a397d1a] xfstests: correct comment in generic/135


Code Diffstat:

 check                  |  20 +++++---
 common/config          |  11 +++++
 common/quota           |   2 +-
 common/rc              |  40 +++++++++++-----
 common/repair          |   1 +
 src/fs_perms.c         |  85 ++++++++++++++++++--------------
 src/itrash.c           |  21 ++++++--
 tests/btrfs/088        |   6 +--
 tests/btrfs/093        | 120 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/093.out    |  20 ++++++++
 tests/btrfs/094        | 128 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/btrfs/094.out    |  15 ++++++
 tests/btrfs/group      |   2 +
 tests/generic/018      |  19 +++++---
 tests/generic/019      |  12 ++---
 tests/generic/076      |   2 +-
 tests/generic/087      |  77 +++++++++++++++++++++++++++++
 tests/generic/087.out  |   7 +++
 tests/generic/092      |  71 +++++++++++++++++++++++++++
 tests/generic/092.out  |   6 +++
 tests/generic/126      |   2 +
 tests/generic/135      |   2 +-
 tests/generic/223      |   2 +-
 tests/generic/275      |  10 ++--
 tests/generic/group    |   4 +-
 tests/xfs/007          |  12 +++--
 tests/xfs/032          |   3 +-
 tests/xfs/045          |   5 +-
 tests/xfs/053          |  84 ++++++++++++++++++++++++++++++++
 tests/xfs/053.out      |  11 +++++
 tests/xfs/073          |   9 +++-
 tests/xfs/096          |   6 +--
 tests/xfs/096.external |  12 ++---
 tests/xfs/096.internal |  12 ++---
 tests/xfs/111          |  19 ++++++--
 tests/xfs/111.out      |  89 +---------------------------------
 tests/xfs/187          |   4 +-
 tests/xfs/194          |   4 +-
 tests/xfs/199          |   2 +-
 tests/xfs/203          |   4 +-
 tests/xfs/206          |  10 ++--
 tests/xfs/206.out      |  12 ++---
 tests/xfs/259          |  21 ++++++--
 tests/xfs/292          |   4 +-
 tests/xfs/292.out      |   2 -
 tests/xfs/300          |   3 +-
 tests/xfs/group        |   1 +
 47 files changed, 793 insertions(+), 221 deletions(-)
 create mode 100755 tests/btrfs/093
 create mode 100644 tests/btrfs/093.out
 create mode 100755 tests/btrfs/094
 create mode 100644 tests/btrfs/094.out
 create mode 100755 tests/generic/087
 create mode 100644 tests/generic/087.out
 create mode 100644 tests/generic/092
 create mode 100644 tests/generic/092.out
 create mode 100755 tests/xfs/053
 create mode 100644 tests/xfs/053.out
--=20
Dave Chinner
david@fromorbit.com

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVY+DqAAoJEK3oKUf0dfod0+MQAIBwT8skHiXhk88tmUZWlGNP
YN6c3V3wzUAPbSOp3goaSR8XMisNsn/qMX8snwLB/gBeboue1II06s3ZtjO2WII7
/rZJ4hZw3wWRrmuVnAnq5Pl/wm0bXRNl6Brs3skORMWTpFJ/QLUkoJB/eBGLT3uM
WXtaIIVpJniH5vAzo23o7CAq2PiLivAYqMGB44AnTse11qy/UOy0abkbSwE+vBhg
N2ykakPxY1Ip+DaFm+GtYXoHE2RVGhRZmZkC/eVhmR6rCGalCMO/iNh3IX/oxUGw
8HOXDTu6niTQg/lDWsbTfs6vSHtpi6sFuVYaXCNQtd/0tP7ZVcMECShg75YhP7yq
5Boy0miQc6+O4LGtHF/Zq2N0gCJrjUsCwKx502zAFchYmMPVxE9XHxMKtY04n822
SuSHB8MvE0MT7IOZZa6JcSyqzdMzpHk9RbPZDZlE1S2GFgVw94sSQW5ci7VB9rC9
7YZ0Hsn1z9I6UJIybQU1b+6xbZtu5ubZC1ue+PFcQJh1DagrUh14/2+wb9euXhs5
C82L7udjFW3hCtuL4QibsoqUjSthhl9yIE75WjkEvCxYpFlhB0E7yvJBxQyaR9mV
bXWF6QZD/u/lrBTc4XBXXD2NIbQk7HvwbqmhbmmFE/0r8c6gjEuiX7nRgoLS1Hcz
rzG8dhB2PefGM5HeWGBj
=6T6+
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
