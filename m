Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:21535 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852AbbJNFlC (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 14 Oct 2015 01:41:02 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1ZmEnu-00044P-JX
	for fstests@vger.kernel.org; Wed, 14 Oct 2015 16:40:46 +1100
Date: Wed, 14 Oct 2015 16:40:46 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 0e6ead5
Message-ID: <20151014054046.GM31326@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--w7PDEPdKQumQfZlR
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

0e6ead5 btrfs/035: check for data loss

New Commits:

Andreas Gruenbacher (1):
      [bd1af95] src/runas: Fixes and cleanups

Darrick J. Wong (1):
      [c892a79] xfs: fix merge errors in fuzzer tests

Eric Sandeen (2):
      [50266c2] generic: _require_dm_target() helper
      [cef2e7a] generic: test extending sub-block AIO writes for races

Eryu Guan (1):
      [7e938cf] xfs/167: wait for fsstress to exit

Filipe Manana (8):
      [88b71e7] btrfs: incremental send after replacing a file
      [7f0a867] btrfs: test read corruption of compressed extents different=
ly
      [f1b304a] fstests: test btrfs send for reflinked files
      [71d8215] btrfs: send with shared and compressed extents
      [a2bfff4] btrfs: send/receive across different filesystems
      [be61229] btrfs: test sending snapshots received from other filesyste=
ms
      [ddb4e4c] btrfs: test for cloning of inline extents
      [0e6ead5] btrfs/035: check for data loss

Mark Fasheh (1):
      [4067308] btrfs: add test for quota groups and drop snapshot

Qu Wenruo (1):
      [08a516f] fstests: btrfs: Check if fallocate re-truncates page beyond=
 EOF


Code Diffstat:

 common/dmerror                         |  14 --
 common/rc                              |  24 +--
 src/aio-dio-regress/aio-dio-eof-race.c | 173 ++++++++++++++++++++++
 src/runas.c                            |  50 ++-----
 tests/btrfs/035                        |  14 ++
 tests/btrfs/035.out                    |   9 ++
 tests/btrfs/049                        |   2 +-
 tests/btrfs/056                        |   2 +-
 tests/btrfs/085                        |   2 +-
 tests/btrfs/095                        |   2 +-
 tests/btrfs/098                        |   2 +-
 tests/btrfs/100                        |   2 +-
 tests/btrfs/101                        |   2 +-
 tests/btrfs/104                        | 166 +++++++++++++++++++++
 tests/btrfs/104.out                    |   1 +
 tests/btrfs/105                        | 112 ++++++++++++++
 tests/btrfs/105.out                    |  11 ++
 tests/btrfs/106                        |  97 +++++++++++++
 tests/btrfs/106.out                    |  17 +++
 tests/btrfs/107                        |  83 +++++++++++
 tests/btrfs/107.out                    |   3 +
 tests/btrfs/108                        | 102 +++++++++++++
 tests/btrfs/108.out                    |  13 ++
 tests/btrfs/109                        | 111 ++++++++++++++
 tests/btrfs/109.out                    |  13 ++
 tests/btrfs/110                        | 120 +++++++++++++++
 tests/btrfs/110.out                    |  14 ++
 tests/btrfs/111                        | 133 +++++++++++++++++
 tests/btrfs/111.out                    |  14 ++
 tests/btrfs/112                        | 199 +++++++++++++++++++++++++
 tests/btrfs/112.out                    | 257 +++++++++++++++++++++++++++++=
++++
 tests/btrfs/group                      |   9 ++
 tests/generic/034                      |   2 +-
 tests/generic/039                      |   2 +-
 tests/generic/040                      |   2 +-
 tests/generic/041                      |   2 +-
 tests/generic/056                      |   2 +-
 tests/generic/057                      |   2 +-
 tests/generic/059                      |   2 +-
 tests/generic/065                      |   2 +-
 tests/generic/066                      |   2 +-
 tests/generic/073                      |   2 +-
 tests/generic/081                      |   2 +-
 tests/generic/085                      |  22 +--
 tests/generic/090                      |   2 +-
 tests/generic/101                      |   2 +-
 tests/generic/104                      |   2 +-
 tests/generic/106                      |   2 +-
 tests/generic/107                      |   2 +-
 tests/generic/114                      |  65 +++++++++
 tests/generic/114.out                  |   2 +
 tests/generic/237                      |   2 +-
 tests/generic/311                      |   2 +-
 tests/generic/321                      |   2 +-
 tests/generic/322                      |   2 +-
 tests/generic/325                      |   2 +-
 tests/generic/group                    |   1 +
 tests/shared/002                       |   2 +-
 tests/shared/051                       |   4 +-
 tests/xfs/051                          |   2 +-
 tests/xfs/085.out                      |   2 -
 tests/xfs/098.out                      |   1 -
 tests/xfs/099.out                      |   2 +-
 tests/xfs/100.out                      |   2 +-
 tests/xfs/101.out                      |   2 +-
 tests/xfs/102.out                      |   2 +-
 tests/xfs/167                          |   2 +-
 67 files changed, 1805 insertions(+), 121 deletions(-)
 create mode 100644 src/aio-dio-regress/aio-dio-eof-race.c
 create mode 100644 tests/btrfs/104
 create mode 100644 tests/btrfs/104.out
 create mode 100755 tests/btrfs/105
 create mode 100644 tests/btrfs/105.out
 create mode 100755 tests/btrfs/106
 create mode 100644 tests/btrfs/106.out
 create mode 100755 tests/btrfs/107
 create mode 100644 tests/btrfs/107.out
 create mode 100755 tests/btrfs/108
 create mode 100644 tests/btrfs/108.out
 create mode 100755 tests/btrfs/109
 create mode 100644 tests/btrfs/109.out
 create mode 100755 tests/btrfs/110
 create mode 100644 tests/btrfs/110.out
 create mode 100755 tests/btrfs/111
 create mode 100644 tests/btrfs/111.out
 create mode 100755 tests/btrfs/112
 create mode 100644 tests/btrfs/112.out
 create mode 100755 tests/generic/114
 create mode 100644 tests/generic/114.out
--=20
Dave Chinner
david@fromorbit.com

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBAgAGBQJWHereAAoJEK3oKUf0dfod7U0P+LFbfZdDWK5qE9Jaib21tIYC
I1yAvMc88wXuIJKlEN41uvYvalrSYy+5btVb14gT92UZkoN+3+IshrwJid406K9J
j4UM2Z/2kiztuT6t3944LU+cU8zKyi4ryze/DxDdejMOKR+5VFTuao7D6A8qIjZs
uxYhznNSkySAOcFwII2Ae31lFlqGBccgZz1KePy200LEtLghMWdSwoomFgmtBZBn
QBaNOAszRKPF4YLbm8PBjX+Zoh+BRv/xKxxUpG2303/Co2dZIgH0im1iNyntP9Ef
6+E2KOYyoT+h9bN2BJkM2XkMrdWWs+7qAy6hv3QcHruk6YvzMlhQCgaa9Ld2ZYd/
rLZ7XyePTvAQGLdmjZxyYOnEscoANVwY18Dw2ITTxE5cBsgHNkzXeV1h8fOZD6Nb
Xaw19hffur5d5l8kEwR0kapZ0+Nu4C1lHGhWiminDbPkntj9I+GMNqeEqSmeOuoO
dC5unK40Wz241OQg4yqG2jp71AgM8u5QoA5PXHcGrdtkhc9ZwIG/UAUxJDCzaS/T
/ndJfehe6ipI1LIhyk1SUab7rrFyGnYhX2L7+MVUOO1B9CVRDQMjR1FVBRqw2dQo
1QV2auEPZeX7lVmJ/6cxX/khN4FmMVozUSL/9dXi8PBIwga2gsZc27QpKpsLPDtV
u4qvkGrNKd6WVU41nHA=
=ViIx
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
