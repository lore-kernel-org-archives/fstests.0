Received: from mail-pf0-f194.google.com ([209.85.192.194]:37547 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbeA1M3L (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Jan 2018 07:29:11 -0500
Received: by mail-pf0-f194.google.com with SMTP id p1so2602020pfh.4
        for <fstests@vger.kernel.org>; Sun, 28 Jan 2018 04:29:11 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id q10sm25619207pfh.178.2018.01.28.04.29.08
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Jan 2018 04:29:09 -0800 (PST)
Message-ID: <5a6dc215.0ae1620a.cc0fc.acb9@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 28 Jan 2018 20:29:04 +0800
Subject: [ANNOUNCE] fstests: master branch updated to dae4fcad54be
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EDv29uoVyCy6"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--EDv29uoVyCy6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update includes several pieces of fixes and
improvements:

- new file handle test and fixes
- kmemleak support
- build support against musl libc
- new ext4 online resize test with bigalloc feature

Note that the kmemleak support is marked as EXPERIMENTAL in the
$seqres.kmemleak file, as "Due to the way kmemleak works, the leak might be
from an earlier test, or something totally unrelated", so a 'kmemleak' failure
could be a false failure, you need to analyze the failures case by case.

New failures I've noticed in this update:
- generic/477 fails on NFSv3/v4.0, but not v4.1/2.

Thanks,
Eryu

The new head of the master branch is commit:

dae4fcad54be src/metaperf: Include linux/param.h explicitly for HZ macro

New commits:

Amir Goldstein (3):
      [259cf891310f] src/open_by_handle: verify dir content only with -r flag
      [3e729f31b42a] generic/exportfs: golden output is not silent
      [6fd4ec6c1a5c] generic: test decoding file handles after cycle mount

Darrick J. Wong (4):
      [074740a32c6a] common/rc: report kmemleak errors
      [a6b5c98da8c4] xfs/122: fix xfs header ordering problems
      [9385d3a90113] generic/403: don't spew '$GETFATTR_PROG: Killed' messages
      [f6c3b373bb53] xfs/24[356]: checking cow fork bmap requires CONFIG_XFS_DEBUG=y

Luis R. Rodriguez (2):
      [cdd360da7b27] check: move expunge test into a helper
      [8ebb071eb8a5] check: expunge tests when doing a dry run

Rostislav Skudnov (8):
      [8c0fc542ed51] fsstress: Include stddef.h for ptrdiff_t
      [836ed899ae22] fstests: Replace all __[u]intNN_t types with standard [u]intNN_t
      [57b7c3bac421] doio, growfiles: Use standard signal name SIGCHLD instead of SIGCLD
      [53b8b92652aa] src/fssum: Use htobe64() instead of a custom macro
      [38a006979b36] src/t_mtab: Replace sys_siglist[] with strsignal()
      [04b7f069f1b7] src/pwrite_mmap_blocked: Include signal.h instead of sys/signal.h
      [1b4f24662e7e] src/dmiperf: Include sys/types.h for u_int32_t
      [dae4fcad54be] src/metaperf: Include linux/param.h explicitly for HZ macro

harshads (1):
      [f2afd6331d2f] ext4: Ext4 online resize with bigalloc tests.


Code Diffstat:

 check                     |  26 +++++--
 common/rc                 |  60 ++++++++++++++++
 ltp/doio.c                |   2 +-
 ltp/fsstress.c            |  85 ++++++++++++-----------
 ltp/growfiles.c           |   2 +-
 src/alloc.c               |   2 +-
 src/dmiperf.c             |   1 +
 src/feature.c             |   2 +-
 src/fssum.c               |   9 +--
 src/getdevicesize.c       |   3 +-
 src/global.h              |   1 +
 src/loggen.c              |   6 +-
 src/makeextents.c         |  10 +--
 src/metaperf.c            |   1 +
 src/open_by_handle.c      | 143 +++++++++++++++++++++++++++++---------
 src/pwrite_mmap_blocked.c |   2 +-
 src/randholes.c           |  30 ++++----
 src/t_mtab.c              |   2 +-
 tests/ext4/032            | 170 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/032.out        | 172 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/group          |   1 +
 tests/generic/403         |   6 +-
 tests/generic/426         |   1 -
 tests/generic/426.out     |   1 -
 tests/generic/467         |   1 -
 tests/generic/467.out     |   1 -
 tests/generic/477         | 107 ++++++++++++++++++++++++++++
 tests/generic/477.out     |   5 ++
 tests/generic/group       |   1 +
 tests/xfs/122             |   5 ++
 tests/xfs/243             |   1 +
 tests/xfs/245             |   1 +
 tests/xfs/246             |   1 +
 33 files changed, 740 insertions(+), 121 deletions(-)
--
Eryu Guan
eguan@redhat.com

--EDv29uoVyCy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJabbv0AAoJECZSqilcj+djM3oQANpWt4rlzmyreBLZQZQSrO5c
qTA+WYWc1WAWKShhQd0l867uraSVzsTlaa8crZpYVpx2795ImLjqSjK6VcLZUzda
k4FOV5PGmk5TQFjqMIprR6lQrdYuOgikMAKSYo/12QtrjwMMg2p+nxs/tEWKRwIh
IUhLiIbiqy3w3OBuJQy3FqDLCSdOOvqU2l2eUEWubXrIvYdCimDcX1gNONoZ+97V
kl1+I0HdtkyCWUpp5QecK1ixS0sJY08ICbRCORcTbwLVd7B6n0Js3KT+bMgdTMBk
MYhVH36g4m4Fx5dAFpkADIQYrcOIs73IshKr6B1P7/8TSBDIJ+yg8hYGSxj0HY/H
Woo+Xy/xMx4S1cuQfDCB1nhxBcmO3wo1MxJBBUX7XbntOdi/1QqBQSkVlB6HMNXM
X8LuWNpshD7GuzeGln8250sl7JU1CWLd0IRcqmSbNn5zad5VyBUrgHHJUxFBj/m2
qsIMvDlrhe451/mwK1eQsUKi7u9tjY4KQ23ZzBY2HjoXAvYAK/udOcyru39KZr6F
SCm3+dPADstd8AA7UCO8TEzAds8Q/vZkvuVEObue099Tj4WY+Vl1kw0j7wYSBtcP
xWWVHc9NSPj8qire280E/z+Eghf+08KPQHDpkS5dStN5iM9uoa5F6zXUlKv6Mx4r
F206pyqXi04YcDhw4zAF
=WqDY
-----END PGP SIGNATURE-----

--EDv29uoVyCy6--
