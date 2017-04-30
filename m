Received: from mail-it0-f66.google.com ([209.85.214.66]:34264 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424608AbdD3KGp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Apr 2017 06:06:45 -0400
Received: by mail-it0-f66.google.com with SMTP id c26so9952401itd.1
        for <fstests@vger.kernel.org>; Sun, 30 Apr 2017 03:06:44 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id b4sm13334333pfj.122.2017.04.30.03.06.42
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Apr 2017 03:06:43 -0700 (PDT)
Message-ID: <5905b733.0413620a.c7bf8.0b24@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 30 Apr 2017 18:06:38 +0800
Subject: [ANNOUNCE] fstests: master branch updated to ecc7b5c0bafa
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="P9Kr7OvBkG1E"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--P9Kr7OvBkG1E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Notably, the cross-compilation support has been
committed, this shouldn't break normal build process, if you see any build
failures please report and/or contribute patch.

Also, there're a few more new tests added than bug fixes, including generic
mmap test, ext4 fuzzer test and xfs growfs and repair tests. Thanks to all the
new test contributors!

New failures I've noticed in this update:
- generic/428 fails on dax mounts on all filesystems that support dax
- xfs/289 fails, the xfs_growfs fix is in review
- ext4/025 fails on 1k block ext4 if tested on RHEL7 hosts, that's a RHEL7
  e2fsprogs bug

Thanks,
Eryu

The new head of the master branch is commit:

ecc7b5c0bafa xfs: xfs_growfs target path must be an active xfs mountpoint

New commits:

Bill O'Donnell (1):
      [ecc7b5c0bafa] xfs: xfs_growfs target path must be an active xfs mountpoint

Filipe Manana (1):
      [255affa11c14] btrfs: fix local array declarations

Gwendal Grignou (1):
      [5d20084fefaf] build: allow cros-compilation on chromeOS

Ross Zwisler (2):
      [47a3f8a8308e] src/t_mmap_dio: fix incorrect argument count check
      [bba1b1b2b937] generic: add regression test for stale mmap reads

Xiao Yang (2):
      [427db760cfc7] ext4: check mount's handling for very large s_first_meta_bg
      [2385c5b4e8cb] btrfs: use $FILEFRAG_PROG instead of filefrag

Zorro Lang (2):
      [9518ef640254] xfs: xfs_repair should junk empty attribute leaf blocks
      [accf20216c71] generic: test eofblocks race with file extending aio dio writes


Code Diffstat:

 .gitignore                             |  14 ++
 Makefile                               |  14 +-
 aclocal.m4 => acinclude.m4             |  28 +---
 common/rc                              |   4 +-
 configure.ac                           |   3 +-
 include/builddefs.in                   |   9 +-
 install-sh                             | 259 ---------------------------------
 src/Makefile                           |   2 +-
 src/aio-dio-regress/aio-dio-eof-race.c |  76 +++++++---
 src/t_mmap_dio.c                       |   2 +-
 src/t_mmap_stale_pmd.c                 |  73 ++++++++++
 tests/btrfs/003                        |   2 +-
 tests/btrfs/004                        |   4 +-
 tests/btrfs/079                        |   4 +-
 tests/ext4/025                         |  65 +++++++++
 tests/ext4/025.out                     |   4 +
 tests/ext4/group                       |   1 +
 tests/generic/427                      |  87 +++++++++++
 tests/generic/427.out                  |   2 +
 tests/generic/428                      |  60 ++++++++
 tests/generic/428.out                  |   2 +
 tests/generic/group                    |   2 +
 tests/xfs/288                          | 109 ++++++++++++++
 tests/xfs/288.out                      |   2 +
 tests/xfs/289                          | 123 ++++++++++++++++
 tests/xfs/289.out                      |  23 +++
 tests/xfs/group                        |   2 +
 27 files changed, 656 insertions(+), 320 deletions(-)
--
Eryu Guan
eguan@redhat.com

--P9Kr7OvBkG1E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZBZRdAAoJECZSqilcj+djLtAQAKzmnPIDQQ5HeXiIwbYJrWzV
YUME1t0EwLzT/x0KiBVhkN8jtWHj2xBxNIhvTuITRWnmIe6vCejlLJ1iSpo0rlRh
Q7vdQTi7aSc2uvVSO2e27LgPO3ZB2RaZwp4pxuEEmLtQ7h8//dL1oP6KrLkkBZ/L
JGzIoxwXHhiMfLNojcXiJ7oQilqKVjbtVllaywsC4UpzYHO+o0MYNmzgZbZY/i8X
Wzfgvv5CoOG+gqHogyyPdyCFcV5HfY4f6pXCO0guM8PVRwNLLYgGZg/sjrfESQZR
XeUxwLgO2aKO6r/ZYmTL727Rd1cr4ytEzGZY695PXJq4C9sS9jdi6qeG7/OvAFpE
9O08AvCoECcLmyCcpdbnc4NQ3PGTUzwi6bQY6f96W7ZALKvWebmhls7WZrw86FkC
Gn9CBoZCYzDTM66sbuXSHcb2EcUeA7/V3TGpyfzf+uk3RQSBYneE4jQlLbSN1pn3
Sb/69/wlgoxHZzLHkunSIf3gmQExSRyN8fRCETHlh+yVmebLb71y1nzbtMxxRiYc
K+W3jPYMUY892U6FY7VisdPHQHQViunAO3B6QcGNGPH1cWkkeIRc5rRvy+XMRk6d
fXMTO92jX3yAb+9aS4dQwZpJ+Q/8uIeeRSIEneIRheL3iYsYzJ0b9fX4ayuxa/HD
aEX4VZ3AZUn3QuF5KPG8
=O9n6
-----END PGP SIGNATURE-----

--P9Kr7OvBkG1E--
