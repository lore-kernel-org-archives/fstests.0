Received: from mail-pg0-f51.google.com ([74.125.83.51]:33620 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeEFONp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 May 2018 10:13:45 -0400
Received: by mail-pg0-f51.google.com with SMTP id i194-v6so18448523pgd.0
        for <fstests@vger.kernel.org>; Sun, 06 May 2018 07:13:45 -0700 (PDT)
Message-ID: <5aef0d98.4e21620a.be12e.c614@mx.google.com>
Date: Sun, 06 May 2018 22:13:39 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 00e3549c659c
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CvQAG2IXMWMk"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--CvQAG2IXMWMk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Notably, the default behavior of a pure './check' has
been changed in this update, it now runs tests only in 'auto' group by default,
instead of all tests. But you could still use './check -g auto' as usual to run
'auto' tests.

There're also two new generic tests and some random test fixes & improvements.
The two new tests both should not fail on latest Linus tree (v4.17-rc3+).

Thanks,
Eryu

The new head of the master branch is commit:

00e3549c659c xfs/132: remove duplicate test

New commits:

Amir Goldstein (1):
      [00e3549c659c] xfs/132: remove duplicate test

Darrick J. Wong (7):
      [38cdd5be450e] generic: test XATTR_REPLACE doesn't take the fs down
      [524a7061a1f4] generic/45[34]: add unicode directional override checks
      [2daf94ec9143] generic/45[34]: check unicode names only if xfs_scrub linked against libicu
      [2426366fc31f] generic/45[34]: test unicode confusables
      [d2603933ebc5] generic/453: test creation of malicious directory entries
      [e2fd1a080ece] xfs/422: add fsstress to the freeze-and-rmap-repair race test
      [0828657542ea] xfs: fix blocktrash fuzzers

Dave Chinner (2):
      [b4c032f1bd30] check: run auto test group by default
      [60af5cc1e243] README: document the new default run mode

Eric Biggers (1):
      [d0f42b253010] generic: test exceeding max file size via INSERT_RANGE

Jeff Layton (1):
      [0c2896508f44] src/fsync-err: don't truncate files on second open

Theodore Ts'o (1):
      [da7916f72206] build: Use the original install-sh file from SGI


Code Diffstat:

 .gitignore              |   1 +
 Makefile                |   1 +
 README                  |  38 +++---
 check                   |  34 +++--
 include/install-sh      | 351 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/Makefile            |   3 +-
 src/attr_replace_test.c |  67 +++++++++
 src/fsync-err.c         |   8 +-
 tests/generic/453       | 100 +++++++++++++-
 tests/generic/454       |  66 ++++++++-
 tests/generic/485       | 115 ++++++++++++++++
 tests/generic/485.out   |   4 +
 tests/generic/486       |  71 ++++++++++
 tests/generic/486.out   |   2 +
 tests/generic/group     |   2 +
 tests/xfs/086           |  15 ++-
 tests/xfs/087           |  19 +--
 tests/xfs/088           |  15 ++-
 tests/xfs/089           |  15 ++-
 tests/xfs/091           |  15 ++-
 tests/xfs/093           |  19 +--
 tests/xfs/097           |  19 +--
 tests/xfs/099           |  11 +-
 tests/xfs/100           |  11 +-
 tests/xfs/101           |  11 +-
 tests/xfs/102           |  11 +-
 tests/xfs/105           |  11 +-
 tests/xfs/112           |  11 +-
 tests/xfs/113           |  11 +-
 tests/xfs/117           |  25 ++--
 tests/xfs/120           |  17 +--
 tests/xfs/123           |   7 +-
 tests/xfs/124           |   9 +-
 tests/xfs/125           |   9 +-
 tests/xfs/126           |   9 +-
 tests/xfs/132           | 126 -----------------
 tests/xfs/132.out       |  12 --
 tests/xfs/235           |  11 +-
 tests/xfs/337           |  11 +-
 tests/xfs/422           |  18 ++-
 tests/xfs/group         |   1 -
 41 files changed, 996 insertions(+), 316 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--CvQAG2IXMWMk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJa7wBpAAoJECZSqilcj+djTtAP/0dZOdkhvwBtP7uUmidFKxNT
ZlEHECb2wR/iKtDbS7ijQEhcTQlkmrCVK3svkJBCp+wiWUeuOAOHrtviZCIN56Pj
Nk6ESErTwEBvyBAUtrfcQH7CLWs3opXRTM4Fj9hFVcrLBD3JJ9wvbrPEPhclKvXa
WkdbUyMRvmlR/QD3v0H+0dlVUe09dFCFWld/sYjUj8LYrtcnmSTioMjjPez5Dv4n
4PpxDjHOvGAHyEPIIUphq7+3OkkqbKJSgVIfBqzKkT977p1IQY6/TnzXaCob4OCC
vgENrvJchOAFhqs83GSJNhdZ6kJXnI2SczdnQ5m2o2gPh+2/S0dkHRBLDxSM01Lp
RfXjCUwEucfNlG9L8uTH5VpIKdvYEkmCH9jgF/a1tzBEZdQa3KfIk7DrKjkqPYX1
FaSn5qjmVIJug6vMVxM1meb0Ykymxy8kWQNw2TuyWM77UFf80ZbyGvD5u8ckJ+7g
X0BBv4PXGvZcZROeOfsgryi4rUWH+spg3n2ofkzmSUkIiPWQJLP+cZJcHZ91Fgjb
7JluTXWFo4enXwQz9YSy/OrgpLO2+ulMlDWcBwixqHLk2ZxXomm+TN8HSj5VXWuQ
1rkwDwEJPsEC8Xwt2NEeByvuhH3zQAGmFP7zSQZESyVKUoCcAxcg2tXphl45kD6I
OKmLe/4L99EefRz6qnRE
=7HzV
-----END PGP SIGNATURE-----

--CvQAG2IXMWMk--
