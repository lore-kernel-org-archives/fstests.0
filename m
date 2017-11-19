Received: from mail-pg0-f68.google.com ([74.125.83.68]:42993 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdKSL2B (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Nov 2017 06:28:01 -0500
Received: by mail-pg0-f68.google.com with SMTP id j16so5208868pgn.9
        for <fstests@vger.kernel.org>; Sun, 19 Nov 2017 03:28:01 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id f11sm12584441pgp.48.2017.11.19.03.27.59
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Nov 2017 03:28:00 -0800 (PST)
Message-ID: <5a116ac0.0b40650a.d1424.32e9@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 19 Nov 2017 19:27:54 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 80ec2dd71ceb
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lWzYKtQwwilm"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--lWzYKtQwwilm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal "new test and random fixes &
improvements" update. The new tests are two for generic and one for btrfs, and
one notable change is that _check_dmesg starts to fail if UBSAN complains.

New failures I've noticed in this update:
- generic/468 fails on ext4, I think that's an ext4 bug and sent a patch for it
- generic/469 fails on XFS if you're using v4.14 kernel, latest kernel passes
- btrfs/154 fails on btrfs with latest upstream kernel

Thanks,
Eryu

The new head of the master branch is commit:

80ec2dd71ceb generic: test zero page cache beyond new EOF on truncate down

New commits:

Anand Jain (1):
      [742facac0d33] btrfs: test for device dynamic rescan

Chandan Rajendra (1):
      [9edb6cd35d13] src/t_dir_type.c: Use strtoul() instead of atoll()

Chao Yu (1):
      [eb48c305021f] generic: add testcase to test fallocate & f{data,}sync

Darrick J. Wong (5):
      [01140c76e485] common/fuzzy: if the fuzz verb is random, keep fuzzing until we get a new value
      [90eaf3d7447c] generic/45[34]: add emoji to the unusual fs naming test
      [b5b3e2220ace] aio-dio-append-write-read-race: abort if we encounter syscall errors
      [dca116873788] common/rc: check dmesg for UBSAN errors
      [6ee333cec470] xfs/122: don't check xfs_iext_cursor

Eryu Guan (1):
      [80ec2dd71ceb] generic: test zero page cache beyond new EOF on truncate down

Liu Bo (1):
      [53803e93a00c] btrfs/143: make test case more reliable


Code Diffstat:

 common/fuzzy                                       |  11 +-
 common/rc                                          |   1 +
 .../aio-dio-append-write-read-race.c               |  44 +++--
 src/t_dir_type.c                                   |   2 +-
 tests/btrfs/143                                    |  20 +--
 tests/btrfs/154                                    | 185 +++++++++++++++++++++
 tests/btrfs/154.out                                |  10 ++
 tests/btrfs/group                                  |   1 +
 tests/generic/453                                  |   5 +
 tests/generic/454                                  |   5 +
 tests/generic/468                                  | 124 ++++++++++++++
 tests/generic/468.out                              |  13 ++
 tests/generic/469                                  | 135 +++++++++++++++
 tests/generic/469.out                              |   9 +
 tests/generic/group                                |   2 +
 tests/xfs/122                                      |   1 +
 16 files changed, 531 insertions(+), 37 deletions(-)
--
Eryu Guan
eguan@redhat.com

--lWzYKtQwwilm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJaEWorAAoJECZSqilcj+djOVEQAJbTUhB1GrffpzScGc7Kpz4b
Nj0UKSlZaXm7Sl6UgtsUCMOXb4SFT/fH9Xz7Pykmt4oRgOHCHyQXc9GKQSJfdp5E
oYWFEkcGas59h/dRgtmz5l6yMuiEXwOK6P887H41gKdBwvQz4GsM4jrKrVKRNBa0
q8u7y87fKtOdIbP5fRdIIRbjGMpgEmyBqOVGxyo7D3BNJz2LtgdtUgatQS2gMyZC
cl1/JlyY69zIpI9GyVGmrq1BZg6677VpWRSMcpgAfSIefS0KOz4+VfTIA8duvTrV
pJvHX5uwnZVYn92+WkeYvcYpBgnKWqu3jArnN2XOB7yWeGZV0IsYe3AhkRHyahY/
BFOzekHKcW6I7hLXDfhPGswqQcIULI6XYUYiGwA3g/dufTtNA9rDjQLvUhYuEUm5
WfyaquRNPyUKtwBvVm6GR7ob25wGXxbb1Siy9Y7gzrL8148/OkWGS1oVy2R2YEi3
SaxyIK7bKBAcjivOZjycei50Fyp3Z7j3+rJNcdPFVQpj75WY8yMTLKvl3O3ClDDI
i3V89uVVwwmWSQ213pG5P2DikNZ21G2X3EHCf55n4C0KJ5EvhFM9KC0lhvDK57y5
2FbmjZJirOCuoPV6vzsYQFFwLx0XJImQqnuglf6IjPThHS5deBy6chdP8+3bLqDA
PXz8ZhsfefjRUuLIIh7g
=kaec
-----END PGP SIGNATURE-----

--lWzYKtQwwilm--
