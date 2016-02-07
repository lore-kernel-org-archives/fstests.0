Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:26641 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755251AbcBGWb2 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 7 Feb 2016 17:31:28 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1aSXrZ-0006Wq-0l
	for fstests@vger.kernel.org; Mon, 08 Feb 2016 09:31:25 +1100
Date: Mon, 8 Feb 2016 09:31:24 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to d98149c
Message-ID: <20160207223124.GA19486@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--NzB8fVQJ5HfG6fxh
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

d98149c Fix prerequisite packages to build fstests on Ubuntu

New Commits:

Christoph Hellwig (3):
      [3cca509] xfs/139: fix scratch device filtering
      [06d19b0] reflink: also treat EINVAL as not supported
      [911efb0] reflink: change to relative margins

Darrick J. Wong (5):
      [589d17d] tools/mvtest: call out to the correct group sort program
      [a3d855e] reflink: fix off-by-one errors when iterating file blocks i=
n a loop
      [c0cfa56] xfs/122: update against xfsprogs 4.3
      [aa69397] dedupe: record dedupe errors in golden output
      [813524b] tests: use lowercase variables for all the new reflink tests

Dave Chinner (4):
      [f8c65ca] xfs: support realtime/log device setup changes in config se=
ctions
      [1e7a824] setup: add section support
      [bfffaa2] check: add exclude sections CLI parameter
      [9165a84] fsync-tester: reopen files with correct flags

Eric Sandeen (1):
      [1dfb505] quota: test Q_GETNEXTQUOTA

Eryu Guan (6):
      [931e5cb] generic/23[23]: some cleanups
      [4a32170] common: no need to parse config file in new
      [042dad6] new: create a default .out file
      [22bc781] common: add overlayfs isupport in _scratch_cleanup_files()
      [379d6e0] common: export overlay lower/upper/work directories as vari=
ables
      [115b41c] overlay: test copy up files from lower dir

Filipe Manana (2):
      [c327d5a] btrfs: fix test failures after commit 27d077ec0bda
      [84aea94] fstests: btrfs, test for send with clone operations

Jia He (1):
      [2013854] common: add names device mounted errors

Satoru Takeuchi (2):
      [d109d8c] aio-dio-eof-race should be ignored by git
      [d98149c] Fix prerequisite packages to build fstests on Ubuntu

Xiao Yang (1):
      [234f51e] fsx.c: Add header file stdbool.h


Code Diffstat:

 .gitignore             |   1 +
 README                 |   4 +-
 check                  |  17 ++++
 common/config          |  71 +++++++++----
 common/dmflakey        |   3 +-
 common/rc              |  59 +++++++----
 common/reflink         |   4 +
 ltp/fsx.c              |   1 +
 new                    |   6 ++
 setup                  |  70 +++++++++++--
 src/Makefile           |   2 +-
 src/fsync-tester.c     |   8 +-
 src/test-nextquota.c   | 163 ++++++++++++++++++++++++++++++
 tests/btrfs/117        | 109 ++++++++++++++++++++
 tests/btrfs/117.out    |  13 +++
 tests/btrfs/group      |   1 +
 tests/generic/002      |   2 +
 tests/generic/004      |   2 +
 tests/generic/110      |  24 ++---
 tests/generic/111      |  42 ++++----
 tests/generic/115      |  34 +++----
 tests/generic/116      |  42 ++++----
 tests/generic/118      |  42 ++++----
 tests/generic/119      | 112 ++++++++++-----------
 tests/generic/121      |  42 ++++----
 tests/generic/122      |  42 ++++----
 tests/generic/122.out  |   1 +
 tests/generic/134      |  90 ++++++++---------
 tests/generic/136      |  92 ++++++++---------
 tests/generic/136.out  |   3 +
 tests/generic/137      |  54 +++++-----
 tests/generic/138      | 100 +++++++++----------
 tests/generic/139      | 100 +++++++++----------
 tests/generic/140      | 100 +++++++++----------
 tests/generic/142      |  34 +++----
 tests/generic/143      |  34 +++----
 tests/generic/144      | 124 +++++++++++------------
 tests/generic/145      | 146 +++++++++++++--------------
 tests/generic/146      | 136 ++++++++++++-------------
 tests/generic/147      | 142 +++++++++++++-------------
 tests/generic/148      |  80 +++++++--------
 tests/generic/149      | 136 ++++++++++++-------------
 tests/generic/150      |  30 +++---
 tests/generic/151      |  46 ++++-----
 tests/generic/152      |  52 +++++-----
 tests/generic/153      |  52 +++++-----
 tests/generic/154      |  60 +++++------
 tests/generic/155      |  60 +++++------
 tests/generic/156      |  58 +++++------
 tests/generic/157      |  68 ++++++-------
 tests/generic/158      |  70 ++++++-------
 tests/generic/159      |  30 +++---
 tests/generic/160      |  30 +++---
 tests/generic/161      |  16 +--
 tests/generic/162      |  22 ++--
 tests/generic/163      |  22 ++--
 tests/generic/164      |  28 +++---
 tests/generic/165      |  28 +++---
 tests/generic/166      |  18 ++--
 tests/generic/167      |  18 ++--
 tests/generic/168      |  22 ++--
 tests/generic/170      |  22 ++--
 tests/generic/171      |  42 ++++----
 tests/generic/172      |  42 ++++----
 tests/generic/173      |  42 ++++----
 tests/generic/174      |  42 ++++----
 tests/generic/175      |  24 ++---
 tests/generic/176      |  24 ++---
 tests/generic/178      |  28 +++---
 tests/generic/179      |  46 ++++-----
 tests/generic/180      |  46 ++++-----
 tests/generic/181      |  34 +++----
 tests/generic/182      |  76 +++++++-------
 tests/generic/182.out  |   2 +
 tests/generic/183      |  48 ++++-----
 tests/generic/185      |  48 ++++-----
 tests/generic/186      |  54 +++++-----
 tests/generic/187      |  54 +++++-----
 tests/generic/188      |  40 ++++----
 tests/generic/189      |  40 ++++----
 tests/generic/190      |  40 ++++----
 tests/generic/191      |  40 ++++----
 tests/generic/194      |  46 ++++-----
 tests/generic/195      |  46 ++++-----
 tests/generic/196      |  40 ++++----
 tests/generic/197      |  40 ++++----
 tests/generic/199      |  60 +++++------
 tests/generic/200      |  60 +++++------
 tests/generic/201      |  34 +++----
 tests/generic/202      |  32 +++---
 tests/generic/203      |  32 +++---
 tests/generic/205      |  48 ++++-----
 tests/generic/206      |  48 ++++-----
 tests/generic/216      |  48 ++++-----
 tests/generic/217      |  48 ++++-----
 tests/generic/218      |  40 ++++----
 tests/generic/220      |  40 ++++----
 tests/generic/222      |  48 ++++-----
 tests/generic/227      |  48 ++++-----
 tests/generic/229      |  94 +++++++++---------
 tests/generic/232      |  17 +---
 tests/generic/233      |  20 +---
 tests/generic/238      |  94 +++++++++---------
 tests/generic/242      |  46 ++++-----
 tests/generic/243      |  46 ++++-----
 tests/generic/244      | 131 ++++++++++++++++++++++++
 tests/generic/244.out  |   2 +
 tests/generic/group    |   1 +
 tests/overlay/001      |  81 +++++++++++++++
 tests/overlay/001.out  |   2 +
 tests/overlay/Makefile |  20 ++++
 tests/overlay/group    |   6 ++
 tests/xfs/122          |  29 ++++--
 tests/xfs/122.out      | 265 ++++++++++++++++++++++++++-------------------=
----
 tests/xfs/127          |  16 +--
 tests/xfs/128          | 140 +++++++++++++-------------
 tests/xfs/129          |  28 +++---
 tests/xfs/131          |  16 +--
 tests/xfs/132          |  68 ++++++-------
 tests/xfs/139          |  26 ++---
 tests/xfs/139.out      |   4 +-
 tests/xfs/140          |  34 +++----
 tools/mvtest           |   4 +-
 123 files changed, 3251 insertions(+), 2549 deletions(-)
 create mode 100644 src/test-nextquota.c
 create mode 100755 tests/btrfs/117
 create mode 100644 tests/btrfs/117.out
 create mode 100755 tests/generic/244
 create mode 100644 tests/generic/244.out
 create mode 100755 tests/overlay/001
 create mode 100644 tests/overlay/001.out
 create mode 100644 tests/overlay/Makefile
 create mode 100644 tests/overlay/group
 mode change 100644 =3D> 100755 tests/xfs/139
--=20
Dave Chinner
david@fromorbit.com

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJWt8W8AAoJEK3oKUf0dfodeEEP/3XgMykeOlCkz6YVomJ5YULh
gSfqhUX+0aa1Tl7HmUcAuXaC9ZmR6m5mjNjajQMgZ0mmb1UaWAByStdNwkB0WmVn
PiB++PtvIvW1zLd8tZVM/OSZtati6XSVeQswQ1nLqaqKUcP0nETrjQ9uRzc5we7a
wtuKTrP9B3BNQ1pccV9QF2Gqv+agOaeTg/x2bXLDbn0ZmW3xbah4S9phqWZQYqOG
hFZcKgqQ9AwcLUndsvP5W3SbUjulPRQW840FPInXYX2s9u/eW3Y7g2BL2TcMRDxL
24xGa2Kn/iIOQsz6p/mT1e+wlGd7Mw8CQGsIqaLInNQrKCW3dYNAls0fuSbdZZ9i
LnmujAcTOtqqo/e1BlxyM1ox4CUIG5daApQD1RqDdhtnQfZ+jGOqeqf7cHCG+R+I
bqQL8K7qJ/hhTiAcogMda1AFbwo+/r56jnMgkNxpG86uCkJnEWEynaulRlAWC78W
CYtrWFrGBKxrXrBW4vHldmSAliw2/Oomwm4IbLgciVLfyHGy6oTM0STkBfom1tA/
0biJJ4SH9s0Of7dED/riInXHnSYp+q8l0keibvuiR42w/TWN3jwVnsdpSe5EDQA4
+HVfaNzc+2O4f3ZG7UvUERCtAnUKl6Wy3EMt10V8s+WRXS35iK8s8quPmRyTTCFZ
ieufIy2h637sYIqvrLqR
=tRVH
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
