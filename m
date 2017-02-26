Received: from mx1.redhat.com ([209.132.183.28]:50908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751997AbdBZLPs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 26 Feb 2017 06:15:48 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20BE03B707
        for <fstests@vger.kernel.org>; Sun, 26 Feb 2017 11:15:23 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v1QBFLhl006306
        for <fstests@vger.kernel.org>; Sun, 26 Feb 2017 06:15:22 -0500
Message-Id: <201702261115.v1QBFLhl006306@int-mx14.intmail.prod.int.phx2.redhat.com>
Date: Sun, 26 Feb 2017 19:15:19 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to 07e89f0913cf
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Ph9dKvWobmNa"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--Ph9dKvWobmNa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're mainly several new overlayfs tests added in
this update, along with other small buf fixes. Many thanks to Xiong and Amir
for writing and reviewing these new tests!

There should be no new failures introduced in this update.

Thanks,
Eryu

The new head of the master branch is commit:

07e89f0913cf overlay: accessing stacked overlayfs files

New commits:

Dmitry Monakhov (1):
      [f64fb746abe6] check: fix incorrect interrupt detection

Theodore Ts'o (1):
      [96bb374aa331] generic,ext4: add defrag group

Xiao Yang (2):
      [6e56c6b59aa7] shared/005,7: fix making sure debugfs sets negative i_size
      [cf895a2a0590] xfs/133,4: make sure xfs_db sets negative i_size

Xiong Zhou (8):
      [223352946292] overlay: disallow overlayfs as upperdir
      [1cd821c2c335] overlay: work dir in overlay inherits no ACLs
      [69d6ea934697] overlay: test workdir cleanup in mounting
      [3eb12b45efa2] overlay: permission check with cached acls in tmpfs
      [ddac6e077318] overlay: filter out xattr starts with "trusted.overlay."
      [276523adae8e] overlay: can not change underlying immutable file
      [59c2158c2504] overlay: test flock after copied up
      [07e89f0913cf] overlay: accessing stacked overlayfs files

Zorro Lang (1):
      [46a1e87e51f1] generic/095: fix duplicate variable name


Code Diffstat:

 check                 |   4 +-
 common/config         |   1 +
 common/rc             |   9 +++++
 tests/ext4/group      |  14 +++----
 tests/generic/095     |   4 +-
 tests/generic/group   |   4 +-
 tests/overlay/022     |  82 +++++++++++++++++++++++++++++++++++++
 tests/overlay/022.out |   2 +
 tests/overlay/023     |  77 +++++++++++++++++++++++++++++++++++
 tests/overlay/023.out |   8 ++++
 tests/overlay/024     |  80 ++++++++++++++++++++++++++++++++++++
 tests/overlay/024.out |   2 +
 tests/overlay/025     |  82 +++++++++++++++++++++++++++++++++++++
 tests/overlay/025.out |   2 +
 tests/overlay/026     | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/026.out |   6 +++
 tests/overlay/027     |  87 +++++++++++++++++++++++++++++++++++++++
 tests/overlay/027.out |   2 +
 tests/overlay/028     |  81 +++++++++++++++++++++++++++++++++++++
 tests/overlay/028.out |   2 +
 tests/overlay/029     | 100 +++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/029.out |   5 +++
 tests/overlay/group   |   8 ++++
 tests/shared/005      |   9 ++---
 tests/shared/007      |   9 ++---
 tests/xfs/133         |  12 +++++-
 tests/xfs/134         |  19 +++++++--
 27 files changed, 792 insertions(+), 29 deletions(-)
--
Eryu Guan
eguan@redhat.com

--Ph9dKvWobmNa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYso1KAAoJECZSqilcj+dj2owQAKZvSvuFdFnDOFfR69wnrb6T
576yUitg3CPqV76vcZOajTV8Ip3q2XDNpIEUF/hI5GY+wJzZvuvms5LBtcP7dsbS
duFiPqbpZGTTn4FzvFge4K9tYnfkvB4GDfqMOcde6nsCqwlLoMwOUFU+zaBElra4
AiuITUjY+JZstgrFkp+/riMdCZHy/WLzGKRzYqeH6mNDlsIpXWc75uoU7cB6/jwo
V+vD4/zl85+YDp5FuP3yozEqzem84X5rrFxIEQzQwQFfS4VoeL4PKNZZLqvqGHnj
AU52L9K8elrUr4gDX9QN6UTg/bhY6yxxGWxoDZASnw+AUSsEqjnWBfaKTemeBIkd
2E+qQx1SUmBqv1xnsix99h9voDGqd7NSr7jjLzkDJQ6MV5fUtA1LSsUF450wjmr5
nzDpVp1ROEyYB2x+42QPZvYxy4Zbp6T6I1n0JJD3wXvaaoepqjvYvs9r75AGhSN7
2nkyLPz22QNmC82Z0aEU6HtV1TWOSk7fFR0RYL/9sQ+3MA1h+oVsgBF/CqR/Iv1j
IWuuxZP0iDIU46Zo0lL3xv61U+7WuYZSqX4L38rOel61wmY4R4EjmAO1a+xPw5XD
+N/Dg/dF4n+82xJGzHNIQLzJZ15GEiQ2cSKuX+Vs3tVOhrnhwM2y759pBIE/txC/
T0YvoNIR7orVqs1/vbm6
=glOk
-----END PGP SIGNATURE-----

--Ph9dKvWobmNa--
