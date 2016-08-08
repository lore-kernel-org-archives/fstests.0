Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:58150 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750801AbcHHGyq (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 8 Aug 2016 02:54:46 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1bWeS5-0001Kh-6j
	for fstests@vger.kernel.org; Mon, 08 Aug 2016 16:54:21 +1000
Date: Mon, 8 Aug 2016 16:54:21 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] fstests: master branch updated to b7d908a
Message-ID: <20160808065421.GO16044@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

Thanks' to Eryu's great work, I've just updated the xfstests
repositories at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
	git://oss.sgi.com/xfs/cmds/xfstests

This update has changes from Eryu's last two weekly requests, and
adds a lot of fixes and new tests for overlay, ext4, xfs and some
generic tests as well.  The full commit list is below for those
curious enough to read on.

-Dave.

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

b7d908a README: document Fedora, RHEL, and CentOS dependencies

New Commits:

Christoph Hellwig (1):
      [700b17b] generic/095: update warning whitelist

Darrick J. Wong (13):
      [7c61e4c] xfs/26[34]: remove duplicate tests
      [946b199] xfs: use rmapbt-checking helper
      [1496a4f] xfs/310: fix the size calculation for the huge device
      [c85204b] xfs/122: list the new log redo items
      [2f8d7b2] common/reflink: actually test dedupe on scratch device
      [b85dfac] xfs/129: fix post-metadump remounting idiocy
      [7c848d2] xfs/179: use scratch device helpers
      [49b0eda] xfs/234: use scratch device helpers
      [dd6eca7] common/rc: optionally test xfs_repair index rebuilding
      [f9261d3] xfs/128: cycle_mount the scratch device
      [27516d4] common/dmerror: fix mount option issues
      [73f8e85] xfs: test attr_list_by_handle cursor iteration
      [7c0b493] generic: test accurate shared extent reporting

Eric Sandeen (1):
      [b7d908a] README: document Fedora, RHEL, and CentOS dependencies

Eric Whitney (1):
      [60f3461] common/defrag: rework _require_defrag for ext4

Eryu Guan (3):
      [226279c] overlay: dump overlay private xattr
      [5f29278] overlay: remove stale file from upperdir
      [2d7ed0c] overlay: truncate running binaries from lower and upper dirs

Jan Kara (1):
      [f45cb67] ext4: Test expansion of inode size

Omar Sandoval (1):
      [6ba4f8a] check: allow comments in exclude files

Wang Xiaoguang (1):
      [4427c1a] generic: run write(2) and fallocate(2) in parallel

Zorro Lang (1):
      [b18191a] xfs/106: rewrite to make it a reliable regression test


Code Diffstat:

 .gitignore                            |   2 +
 README                                |  18 +-
 check                                 |   4 +-
 common/defrag                         |  17 +-
 common/dmerror                        |   9 +-
 common/rc                             |  29 ++
 common/reflink                        |   2 +-
 src/Makefile                          |   5 +-
 src/attr-list-by-handle-cursor-test.c | 118 ++++++
 src/t_truncate_self.c                 |  20 +
 tests/ext4/022                        | 183 +++++++++
 tests/ext4/022.out                    | 432 ++++++++++++++++++++
 tests/ext4/group                      |   1 +
 tests/generic/095                     |   6 +-
 tests/generic/371                     |  75 ++++
 tests/generic/371.out                 |   2 +
 tests/generic/372                     |  90 +++++
 tests/generic/372.out                 |  17 +
 tests/generic/group                   |   2 +
 tests/overlay/011                     |  79 ++++
 tests/overlay/011.out                 |   2 +
 tests/overlay/012                     |  77 ++++
 tests/overlay/012.out                 |   2 +
 tests/overlay/013                     |  74 ++++
 tests/overlay/013.out                 |   2 +
 tests/overlay/group                   |   3 +
 tests/xfs/106                         | 361 ++++++++++-------
 tests/xfs/106.out                     | 790 +++++++++++++++++++++---------=
-------
 tests/xfs/122.out                     |   8 +
 tests/xfs/128                         |   6 +-
 tests/xfs/129                         |   6 +-
 tests/xfs/179                         |  10 +-
 tests/xfs/234                         |   6 +-
 tests/xfs/263                         | 179 ---------
 tests/xfs/263.out                     |  13 -
 tests/xfs/264                         | 180 ---------
 tests/xfs/264.out                     |  13 -
 tests/xfs/269                         |  64 +++
 tests/xfs/269.out                     |   5 +
 tests/xfs/310                         |   9 +-
 tests/xfs/314                         |   4 +-
 tests/xfs/317                         |   4 +-
 tests/xfs/322                         |   4 +-
 tests/xfs/group                       |   7 +-
 44 files changed, 2025 insertions(+), 915 deletions(-)
 create mode 100644 src/attr-list-by-handle-cursor-test.c
 create mode 100644 src/t_truncate_self.c
 create mode 100755 tests/ext4/022
 create mode 100644 tests/ext4/022.out
 create mode 100755 tests/generic/371
 create mode 100644 tests/generic/371.out
 create mode 100755 tests/generic/372
 create mode 100644 tests/generic/372.out
 create mode 100755 tests/overlay/011
 create mode 100644 tests/overlay/011.out
 create mode 100755 tests/overlay/012
 create mode 100644 tests/overlay/012.out
 create mode 100755 tests/overlay/013
 create mode 100644 tests/overlay/013.out
 delete mode 100755 tests/xfs/263
 delete mode 100644 tests/xfs/263.out
 delete mode 100755 tests/xfs/264
 delete mode 100644 tests/xfs/264.out
 create mode 100755 tests/xfs/269
 create mode 100644 tests/xfs/269.out
--=20
Dave Chinner
david@fromorbit.com

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXqCycAAoJEK3oKUf0dfodijQP/13AemZoqNx/eYcXEC0ehTac
YKLThPZrHJqVPDfQydo+tZH5c73FjH6T6BbkktMuoMLKjmDNYB/RZjiKW0g9Wmpd
5V0ABDta14gwioaX00AClxYbZzilt+Neklwost/sOtmEgDmwlgcqn5hKTCJOtobe
GQFavp+JNQsVn92x/0q6HWv4w+thr+WvLxUGiRFh6jl/D1o8vkUvQ6tJr0KHTjBo
k8wKqdDEE1XZGyoss0CyRXKBeM6hwoHhHdTmXHsqhzyMAZeGlI3TEWtFDTuNcsUI
9tzXLyuD6WulputgfkfUBeQ0ZdHbYg4M6Q6zoDHWcpxrWRZFZP4nEi/rXq1E11Vt
bwbg8l0hLcrapSRe3H595nYmoG3iNYyc3KM3MqK9rBsNbujtxMfyBKSHPDoer/QV
S1bfrtQCWWg5YKCKjBbKt21FIKuACcZPly6r9nF2GVLT6tE/vLaxDlSzhehgMmQO
N/+J6D1ya3c7XsQpgASnyoI4StI0wM/MouiBB8euTsvl3Nfhv2ScziMkyS2b2xEB
9h8gOhR8q6b4X+qZE8lsB0XWxy9SGEvKp5p0RNV+e+BYCIJ/CRibJcCD9J7GJU+9
OIAiQQqKfseljBaUM6xSEWhOaI2OntH4QEtUulCIXoO+fYMJQPYvS61t7cDKTfr4
1G7lNkM6NxwB/CFNP1FU
=ROdj
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--
