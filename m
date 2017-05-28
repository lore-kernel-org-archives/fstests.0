Received: from mail-pf0-f175.google.com ([209.85.192.175]:35843 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdE1Is6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 May 2017 04:48:58 -0400
Received: by mail-pf0-f175.google.com with SMTP id m17so35091555pfg.3
        for <fstests@vger.kernel.org>; Sun, 28 May 2017 01:48:58 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id g63sm11005088pgc.59.2017.05.28.01.48.56
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 May 2017 01:48:57 -0700 (PDT)
Message-ID: <592a8ef9.426b630a.63702.84dd@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 28 May 2017 16:48:51 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 16985be90e5e
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XLdWZvusQT12"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--XLdWZvusQT12
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. The first NFS specific test has been added in this
update, hope that we'll have more NFS tests. Another major change is that
OpenSSL is not required anymore for building fstests. Other changes are all
minor bug fixes and build warning fixes.

There should be no new failures introduced in this update.

Thanks,
Eryu

The new head of the master branch is commit:

16985be90e5e nfs: test nfs4_getfacl near page size ACL from server

New commits:

Eryu Guan (1):
      [16985be90e5e] nfs: test nfs4_getfacl near page size ACL from server

Luis Henriques (1):
      [890f2b5ae24f] src/seek_sanity_test: fix test15 SEEK_HOLE expected results

Nikolay Borisov (2):
      [2d77f8580636] xfs/293: Make 'man' hard requirement
      [c51ab0a8502e] generic/108: Fix return value check from _get_scsi_debug_dev

Richard Weinberger (1):
      [b14d1bb8b3f6] src/stat_test: Fix stx_attributes check

Theodore Ts'o (2):
      [7ee1b53d77e5] src: fix compiler warnings
      [d0ef33ce972d] build: Stop relying on OpenSSL

Zorro Lang (2):
      [1262cc70fa42] xfs/196: fallback to fail_writes for old kernel
      [ce16ed94a8d9] xfs/288: filter out extra mkfs warning


Code Diffstat:

 README                                   |   2 +-
 common/config                            |   3 +
 common/nfs                               |  35 ++++
 common/rc                                |   1 +
 configure.ac                             |   1 -
 include/builddefs.in                     |   1 -
 m4/package_ssldev.m4                     |   4 -
 src/Makefile                             |  18 +-
 src/aio-dio-regress/aio-dio-eof-race.c   |   3 +-
 src/aio-dio-regress/aio-dio-fcntl-race.c |  32 +++-
 src/dio-invalidate-cache.c               |   6 +-
 src/fssum.c                              |   6 +-
 src/holetest.c                           |   8 +-
 src/md5.c                                | 291 +++++++++++++++++++++++++++++++
 src/md5.h                                |  45 +++++
 src/seek_sanity_test.c                   |   5 +-
 src/stat_test.c                          |   4 +-
 src/t_rename_overwrite.c                 |   3 +-
 tests/generic/108                        |   2 +-
 tests/nfs/001                            |  77 ++++++++
 tests/nfs/001.out                        |   2 +
 tests/nfs/Makefile                       |  20 +++
 tests/nfs/group                          |   6 +
 tests/xfs/196                            |  16 +-
 tests/xfs/288                            |   2 +-
 tests/xfs/293                            |   6 +-
 26 files changed, 549 insertions(+), 50 deletions(-)
--
Eryu Guan
eguan@redhat.com

--XLdWZvusQT12
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZKo5AAAoJECZSqilcj+djtNMQANfl3cZ34MVnSZ6F+e5v9YZZ
+TjcZwBEg6ijDJj1FLi85r+xWKOf11dGORk2NIbPqv//g9wXpwwYRj+OpZk8v0t8
1fuWxZ4Bsah3CYs00WfQT/8O73Ft2ZMUIkzZ27HlA4EuRUILvrhzQPWVVYcA8q6u
7hB8lcQL2X7Wq/2wSqLf8Nc6XfEyZTrXQXFc6iRKOsaBahUHjuoeUECuizE8CIWB
LpGy5zO9eF86gXusPi+FoiAe7pwOpBK0kByqnQJ2+UaPtSkcw2jml0aZ/CIuzJS5
NVTNZc9L68NHC5F/b3LtpBLlmmLpTJMjbCpmiX5NrgUiqCimR1mwPFecTN//yR9C
RLze5RKSYVGLdVhfjEsBct6dydAXEleYGBEKDjW9Qh1/XWbgsWz7dTVP7pO1eVat
hKzCQ77fiq+IUZCnlVdsT47+HVU1CzS7HJNOeS8QOQGYHlwCZVHGGRRaAPpxYv2r
/AssX2gUIm4qF4lJ9bkHjpx3mpq5skPEUPQuGrHHba9moFLtpydrjoq2IJJQcuQV
asyWoObCtVOx5JZj10SK3DaHBqWcDertdF2iJw7JPRsuLjUjZvlrue9xrSluZ4kS
i5EBCjxZpACIdHT8MayOIm8MdNiWBaj2QkUahJh7FwpEYoiP5WpEhyiAmgGR35uu
hPHMUQUihYOcUbq9muOJ
=hMei
-----END PGP SIGNATURE-----

--XLdWZvusQT12--
