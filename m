Received: from mail-pf0-f195.google.com ([209.85.192.195]:33545 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbeBYPqz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Feb 2018 10:46:55 -0500
Received: by mail-pf0-f195.google.com with SMTP id q13so5530740pff.0
        for <fstests@vger.kernel.org>; Sun, 25 Feb 2018 07:46:54 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id l129sm133397pfl.46.2018.02.25.07.46.52
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Feb 2018 07:46:53 -0800 (PST)
Message-ID: <5a92da6d.8725620a.76336.041c@mx.google.com>
Date: Sun, 25 Feb 2018 23:46:46 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 5e6514523342, and Eryu's comming role change
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HpE30thYyJmB"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--HpE30thYyJmB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. One notable change is that _scratch_mount will make
tests fail if the mount operation fails, and please take use of
_try_scratch_mount if a test cares about the mount status. This change should
not break any existing tests (I've tested it on different filesystems with
various test configs), but if you find any unexpected failure please report
and/or contribute patches.

Other changes are mostly minor bug fixes and improvements. And there should be
no new failures introduced by this update.


Regarding to my role change, I'll leave Red Hat at the end of February and stop
using Red Hat email eguan@redhat.com. But I'll continue maintaining fstests, so
please use my personal email guaneryu@gmail.com if you want to cc me in patch.

Also, my response might be slow in this transition period. I'll try to make
this period as short as possible, but it still could be as long as several
weeks to months, please be prepared/patient :)

Thanks,
Eryu

The new head of the master branch is commit:

5e6514523342 fsstress: avoid infinite loops in clonerange_f

New commits:

Andreas Gruenbacher (1):
      [b8b56f24d917] fsx: Fix -P errors

Chandan Rajendra (1):
      [6702176b9340] common/rc: Fix fcollapse require code to work with 64k block size

Darrick J. Wong (1):
      [5e6514523342] fsstress: avoid infinite loops in clonerange_f

Dave Chinner (3):
      [729381bda427] generic/25[02]: increase filesystem size
      [7aaf557970c0] common/xfs: Initialise OPTIND for getopts calls
      [715eac1a9e66] generic/47[23]: remove from auto/quick groups

Eryu Guan (1):
      [69eb6281a9d3] fstests: _fail test by default when _scratch_mount fails

Misono, Tomohiro (1):
      [bf382b0e7730] btrfs/150: add _scratch_dev_pool_get/put to run the test as expected


Code Diffstat:

 common/attr         |  2 +-
 common/dmapi        |  4 ++--
 common/dump         |  4 ++--
 common/encrypt      |  2 +-
 common/filestreams  |  4 ++--
 common/fuzzy        |  4 ++--
 common/log          |  6 +++---
 common/overlay      |  2 +-
 common/punch        |  2 +-
 common/quota        |  4 ++--
 common/rc           | 46 ++++++++++++++++++++++++++++------------------
 common/xfs          | 13 +++++++------
 ltp/fsstress.c      |  4 +++-
 ltp/fsx.c           | 31 +++++++++++++++----------------
 tests/btrfs/004     |  6 +++---
 tests/btrfs/007     |  4 ++--
 tests/btrfs/009     |  2 +-
 tests/btrfs/012     |  4 ++--
 tests/btrfs/042     |  2 +-
 tests/btrfs/057     |  2 +-
 tests/btrfs/091     |  4 ++--
 tests/btrfs/131     |  4 ++--
 tests/btrfs/136     |  2 +-
 tests/btrfs/150     |  2 ++
 tests/ext4/003      |  2 +-
 tests/ext4/006      |  4 ++--
 tests/ext4/007      |  2 +-
 tests/ext4/008      |  2 +-
 tests/ext4/011      |  4 ++--
 tests/ext4/012      |  4 ++--
 tests/ext4/024      |  2 +-
 tests/ext4/025      |  2 +-
 tests/ext4/305      |  2 +-
 tests/ext4/306      |  2 +-
 tests/generic/015   |  2 +-
 tests/generic/019   |  4 ++--
 tests/generic/050   | 10 +++++-----
 tests/generic/052   |  5 ++---
 tests/generic/053   |  2 +-
 tests/generic/054   |  4 ++--
 tests/generic/055   |  4 ++--
 tests/generic/062   |  2 +-
 tests/generic/064   |  2 +-
 tests/generic/068   |  3 +--
 tests/generic/069   |  2 +-
 tests/generic/074   |  1 +
 tests/generic/075   |  1 +
 tests/generic/076   |  3 +--
 tests/generic/077   |  3 +--
 tests/generic/079   |  2 +-
 tests/generic/082   |  4 ++--
 tests/generic/083   |  3 +--
 tests/generic/105   |  2 +-
 tests/generic/112   |  1 +
 tests/generic/117   |  3 +--
 tests/generic/120   |  2 +-
 tests/generic/169   |  3 +--
 tests/generic/235   |  4 ++--
 tests/generic/250   |  6 +++---
 tests/generic/252   |  5 +++--
 tests/generic/270   |  2 +-
 tests/generic/294   |  2 +-
 tests/generic/317   |  2 +-
 tests/generic/318   |  2 +-
 tests/generic/388   |  2 +-
 tests/generic/390   |  2 +-
 tests/generic/403   |  2 +-
 tests/generic/466   |  2 +-
 tests/generic/group |  4 ++--
 tests/shared/003    |  2 +-
 tests/xfs/005       |  2 +-
 tests/xfs/009       |  2 +-
 tests/xfs/016       |  2 +-
 tests/xfs/017       |  7 +++----
 tests/xfs/019       |  2 +-
 tests/xfs/021       |  3 +--
 tests/xfs/034       |  3 +--
 tests/xfs/041       |  4 ++--
 tests/xfs/042       |  4 ++--
 tests/xfs/044       |  4 ++--
 tests/xfs/045       |  4 ++--
 tests/xfs/057       |  2 +-
 tests/xfs/067       |  2 +-
 tests/xfs/072       |  2 +-
 tests/xfs/073       |  2 +-
 tests/xfs/075       |  4 ++--
 tests/xfs/077       |  4 ++--
 tests/xfs/079       |  2 +-
 tests/xfs/083       |  6 +++---
 tests/xfs/085       |  2 +-
 tests/xfs/090       |  2 +-
 tests/xfs/092       |  2 +-
 tests/xfs/094       |  2 +-
 tests/xfs/098       |  2 +-
 tests/xfs/103       |  2 +-
 tests/xfs/104       |  2 +-
 tests/xfs/111       |  2 +-
 tests/xfs/121       |  8 +++-----
 tests/xfs/130       |  2 +-
 tests/xfs/137       |  4 ++--
 tests/xfs/141       |  2 +-
 tests/xfs/177       |  6 ++----
 tests/xfs/181       |  3 +--
 tests/xfs/183       |  3 +--
 tests/xfs/189       | 14 +++++++-------
 tests/xfs/263       |  2 +-
 tests/xfs/270       |  4 ++--
 tests/xfs/297       |  2 +-
 tests/xfs/333       |  2 +-
 tests/xfs/338       |  2 +-
 tests/xfs/340       |  2 +-
 tests/xfs/433       |  2 +-
 tests/xfs/434       |  2 +-
 tests/xfs/435       |  2 +-
 tests/xfs/436       |  2 +-
 tests/xfs/439       |  2 +-
 tests/xfs/442       |  2 +-
 tests/xfs/443       |  2 +-
 118 files changed, 220 insertions(+), 218 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--HpE30thYyJmB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJakthsAAoJECZSqilcj+djPAgP/AklE1lBBj8yUdhPp+POtCZl
IDpPC37rCpE+Vmrq8u7ly6A/vHs1k+Ms3nPhYl8iEIBAYgm/h92crHXcr8/nzC8T
X/4qUDEq4KJEnRhQfDeTHhzvoxoPh7cEdWFLROTipZhgSyr9UeeuHlo4YHhTM+ks
t/jCYSiXlHsrK0L0fRckUiqbMk9fZUOjtgChHbDWiQe2uKWBK/d/UV2I6y6JvEBF
Qf8s+oD3Ha4wMCvqPbZY0hVs8t/5YGZDO/CW7Pq5Z54z+OcC0SeQC5KDIwovEi93
j2Pgc6Xak/Bk8PDPpWDVIYDhKUA9IXRccHZWgG5DjAqgCVa7UI8m8qbjIhjo7lJO
63n/sjnLAEwWEmrTjAuRFwu3xVniDHEQN4euk+YGzmbd1w93LiT8XS2NyEXv8fnw
OOjHw3ugQcxpNwMoKnyFPAhn1DPknjc3kVIG9+1purBUZqJVhzD34w9kZ5Kh3KPR
F51whRcrAX5tJkIKIKZt0nxSMXFwSTRlxtMjMWqGsgoA6A9fJtmK2amgZxBs1Kqp
+mvAwNhe3F0waE5NUdwtj0VgJqflc/rhn9iUWIlzIDQLnrrV0bjcfnyxWsuip25g
Q3DLUTcGi0SnHy1Z9zeXEiLp8b4LPl3KulIhBwudnSstPcRikcP7+zWwZcsvbu61
qV4vus5y7SFchBvmJzuL
=qi9f
-----END PGP SIGNATURE-----

--HpE30thYyJmB--
