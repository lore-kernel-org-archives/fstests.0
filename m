Received: from mail-pl1-f179.google.com ([209.85.214.179]:37944 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbeKZD1N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Nov 2018 22:27:13 -0500
Received: by mail-pl1-f179.google.com with SMTP id e5so12682938plb.5
        for <fstests@vger.kernel.org>; Sun, 25 Nov 2018 08:35:47 -0800 (PST)
Message-ID: <5bfacf61.1c69fb81.7731a.4a9b@mx.google.com>
Date: Mon, 26 Nov 2018 00:35:27 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 15b13f7fcb85
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wkV2jt4OevCi"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--wkV2jt4OevCi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update contains fixes for 64k blocksize fs testing
from Chandan Rajendra and two bug fixes from Xiao Yang. The CrashMonkey test
and clone/dedupe/copy range support to fsx/fsstress patches are still in
review, hopefully they'll get merged in next update.

Thanks,
Eryu

The new head of the master branch is commit:

15b13f7fcb85 ext4/021: Work with 64k block size

New commits:

Chandan Rajendra (3):
      [89e42dcda50f] src/t_stripealign.c: Use block size reported by fstatfs()
      [6b06a9bb6fb0] ext4/002: Work with 64k block size
      [15b13f7fcb85] ext4/021: Work with 64k block size

Xiao Yang (2):
      [ded188b86096] xfs: Fix the situation that mount operation rejects corrupted XFS
      [c1cef1bd82a9] common/rc: Add _require_filefrag_options() to check options for filefrag


Code Diffstat:

 common/rc           | 15 +++++++++++-
 src/t_stripealign.c |  8 +++----
 tests/ext4/002      | 68 +++++++++++++++++++++++++++--------------------------
 tests/ext4/002.out  | 18 +++++---------
 tests/ext4/021      | 11 +++++----
 tests/generic/519   |  2 +-
 tests/xfs/086       |  3 +--
 tests/xfs/086.out   |  3 +--
 tests/xfs/087       |  9 ++++---
 tests/xfs/087.out   |  3 +--
 tests/xfs/088       |  3 +--
 tests/xfs/088.out   |  3 +--
 tests/xfs/089       |  3 +--
 tests/xfs/089.out   |  3 +--
 tests/xfs/091       |  3 +--
 tests/xfs/091.out   |  3 +--
 tests/xfs/093       |  9 ++++---
 tests/xfs/093.out   |  3 +--
 tests/xfs/097       |  8 +++----
 tests/xfs/097.out   |  3 +--
 tests/xfs/099       |  3 +--
 tests/xfs/099.out   |  3 +--
 tests/xfs/100       |  3 +--
 tests/xfs/100.out   |  3 +--
 tests/xfs/101       |  3 +--
 tests/xfs/101.out   |  3 +--
 tests/xfs/102       |  3 +--
 tests/xfs/102.out   |  3 +--
 tests/xfs/105       |  3 +--
 tests/xfs/105.out   |  3 +--
 tests/xfs/112       |  3 +--
 tests/xfs/112.out   |  3 +--
 tests/xfs/113       |  3 +--
 tests/xfs/113.out   |  3 +--
 tests/xfs/117       | 11 ++++-----
 tests/xfs/117.out   |  3 +--
 tests/xfs/120       |  3 +--
 tests/xfs/120.out   |  3 +--
 tests/xfs/124       |  3 +--
 tests/xfs/124.out   |  3 +--
 tests/xfs/125       |  3 +--
 tests/xfs/125.out   |  3 +--
 tests/xfs/126       |  3 +--
 tests/xfs/126.out   |  3 +--
 tests/xfs/235       |  3 +--
 tests/xfs/235.out   |  3 +--
 tests/xfs/337       |  3 +--
 tests/xfs/337.out   |  3 +--
 48 files changed, 122 insertions(+), 151 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--wkV2jt4OevCi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJb+s8IAAoJECZSqilcj+djeZgP/3uSCzH7qcYdqC2vpJvTvMtB
cwUl9DN72Cxf7+FDN8izoUT/oHU+usZpTHXmq6nJx3drE3VceV2060YbIDFsyR21
aeW0XZiL+Kyda7wTNXamXLN02rxRBLf9b1rFc8y6FvVIsLoUwCiqqQUpJlYKF1ka
Avav/g5kmgYcQvkLX0l7pkMewt22roAhS/msXl6fvXhabx7ug3CcaILwZCAVonmO
Ue1HY/xBD/4q4UkS7aOKSqa5rsMH7RfYcuSJkw17IOI3tZDQ9d09UaG5GC0SPVp4
YyLafbFT5E5OziyxUK3kMVXzc73nLnFadhr++s20jWkpX49yOrV1r/n2XZA47bf+
1sMb6d74gThdFXg7uyb00SeSdiybbxc1waT9x2++dGcc4iO2pTGZbDso2fChEwbv
dsaovREGEo77WyIykoxgKuxQ8lQGnyQsehh1q+e6JMKYacrc/Jz/e0WDYUWGqV09
YbycwNpOi3VOthFIe9hHV6pj7OQKkReO2pBJP3+JTKffXL8aMTd4U8ztU4lbArJH
m5opich5k0UbbLAMceNuNLb6RNafvYN1mM+tRFVi9wfwKZ7eA1LiUpjj+f+H+9yq
xetRtxkOMnvblwPxJPYeCTEOrAkdRZVoD2H5GRWj99K18YTMHKwv52wsVIOCoXnC
WbuwnJJYxu+LV+lPx85r
=dLFD
-----END PGP SIGNATURE-----

--wkV2jt4OevCi--
