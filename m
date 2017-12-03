Received: from mail-pl0-f68.google.com ([209.85.160.68]:34645 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdLCGoX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Dec 2017 01:44:23 -0500
Received: by mail-pl0-f68.google.com with SMTP id d21so8617005pll.1
        for <fstests@vger.kernel.org>; Sat, 02 Dec 2017 22:44:23 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id i20sm20947252pfj.58.2017.12.02.22.44.21
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Dec 2017 22:44:22 -0800 (PST)
Message-ID: <5a239d46.9457620a.b9928.6ce8@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 03 Dec 2017 14:44:16 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 88231c0c0b9d
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9nbYH2fDeJe4"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--9nbYH2fDeJe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly contains new regression tests for
btrfs and overlay, along with other minor bugfixes.

My test host that's hosting all my test vms broke down last week, which slowed
down my review process. There're still around 10 patches sitting in my
'to-review' mailbox, so please be patient. I'd really appriciate if someone
could help review the pending patches!

Nov 28   Darrick J. Wong    [2.3K] [PATCH] common/rc: report kmemleak errors                                                                                                                                
Nov 29   Xiao Yang          [3.6K] [PATCH] generic/473: test return EBUSY from BLKRRPART for mounted whole-dev
Nov 29   Goldwyn Rodrigues  [1.7K] [PATCH 1/3] Check pwrite parameters                                                                                                                                      
Nov 29   Goldwyn Rodrigues  [4.3K] ├─>[PATCH 2/3] generic/470: Test RWF_NOWAIT                                                                                                                              
Nov 29   Goldwyn Rodrigues  [4.7K] └─>[PATCH 3/3] generic/471: Partial direct write test                                                                                                                    
Nov 30   Nikolay Borisov    [ 10K] [PATCH v7] generic: initial fiemap range query test                                                                                                                      
Nov 30   Ari Sundholm       [0.9K] [PATCH 1/2] fsstress: Fix memory leaks
Nov 30   Ari Sundholm       [1.1K] └─>[PATCH 2/2] fsstress: getcwd() return value fixes
Dec 01   yang xu            [1.2K] [PATCH] generic/459: Fix check for ro-remount in extN

New failures I've noticed in this update:
- btrfs/15[56] both fail with current v4.15-rc1 kernel
- overlay/047 fails with v4.15-rc1 too

Thanks,
Eryu

The new head of the master branch is commit:

88231c0c0b9d btrfs: make sure btrfs can handle full fs trim correctly

New commits:

Amir Goldstein (3):
      [77847f3e4489] overlay: regression test for hardlink breakage after unlink and mount cycle
      [be7b6165bc20] overlay: regression test for orphan index cleanup on mount
      [959081e0d3ca] overlay/042: remove wrong check for empty index

Darrick J. Wong (1):
      [f210cedc0015] generic/388: use TIME_FACTOR to scale test duration

Filipe Manana (1):
      [d0bbfca132b3] btrfs: test send for files with multiple hard links renamed

Qu Wenruo (1):
      [88231c0c0b9d] btrfs: make sure btrfs can handle full fs trim correctly

Xiao Yang (1):
      [2428c08a6025] generic/465: just check the actual read data under dio read/write


Code Diffstat:

 .../aio-dio-append-write-read-race.c               |  11 +-
 tests/btrfs/155                                    | 147 +++++++++++++++++++++
 tests/btrfs/155.out                                |   6 +
 tests/btrfs/156                                    | 120 +++++++++++++++++
 tests/btrfs/156.out                                |   2 +
 tests/btrfs/group                                  |   2 +
 tests/generic/388                                  |   2 +-
 tests/overlay/042                                  |   4 -
 tests/overlay/047                                  | 107 +++++++++++++++
 tests/overlay/047.out                              |  16 +++
 tests/overlay/048                                  | 141 ++++++++++++++++++++
 tests/overlay/048.out                              |  18 +++
 tests/overlay/group                                |   2 +
 13 files changed, 568 insertions(+), 10 deletions(-)
--
Eryu Guan
eguan@redhat.com

--9nbYH2fDeJe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJaI5zWAAoJECZSqilcj+djjJ8P/R4pQ2IJooV59tFGiWjlv4Bg
FczFuYo2mx02b3VPbMKqDBn3iIaERW8FvrAnn6P7I9ApEnaS/dTTdRnC4sGK4Rud
wVnPe4XCZeU2EmLadBNcDlIxeIRSMpCp/qBnYJYfhw+ZF0XZN5sY6zaNLAD7Mzqh
B/jgVyHQcEqVnXebwJVrYbk7+aJERjagyt5ME2hHMjkQBrcY1hOXUUjo1MuZwjQz
+xsye6sbvXPHhJh6pdpLwS+gjy2QZUu2Wg7DqFP1FfQTtKuWU6x7c6Q0F4MqqxEQ
9InmHv2Ew5t3XMvQc/ixc6UJ66rY5A3z9PBmGobmYWttD7S3/2wIPbSGl0KmXeLu
KGbfXgq3pwMTH+XCuvaBrOYnpI6vsQtWbmRBlUuYiYSGIa/kqe/sBd9AeJ45C15y
I25p/9DhfzZrMuD6DdMmwxOgnSmSxrlDhVEtj5wmzOByF04nW01jdO4xmDrX0Uic
eBuYYodzNLSD9joX6FNd/csGANwKxtA21AD/v0o72A/e6cxS3PMkXWf4Tovkay+8
OatybZJB0Y6aCTr5kDq3V7Axnin03pHLi28rqi86+fxCpj+fMwmmSL+4GBhmKehF
ZllYeMESs/GFARSBgpKBxjsutjTx2n7K+2NQ1Ysnj1Lwfrgjyqk1V3np4uvjKJvF
8u0XgxSjqNMI8YySYIf1
=KONg
-----END PGP SIGNATURE-----

--9nbYH2fDeJe4--
