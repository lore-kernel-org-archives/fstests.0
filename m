Received: from mail-pf0-f196.google.com ([209.85.192.196]:35128 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbdFJPpl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 10 Jun 2017 11:45:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so11736103pfd.2
        for <fstests@vger.kernel.org>; Sat, 10 Jun 2017 08:45:41 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id 65sm8754295pgf.14.2017.06.10.08.45.38
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Jun 2017 08:45:39 -0700 (PDT)
Message-ID: <593c1423.4405630a.41f5.21dc@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sat, 10 Jun 2017 23:45:36 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 034744b82385
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="S8bNVz5XBZn5"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--S8bNVz5XBZn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. fstests gains ubifs support in this update, many thanks
to David Oberhollenzer! Besides that, there're two new btrfs tests and a minor
bug fix added in this update.

New failures I've noticed:
- btrfs/144 fails on latest 4.12-rc4 kernel

Thanks,
Eryu

The new head of the master branch is commit:

034744b82385 btrfs: test incremental send after renaming and linking file

New commits:

David Oberhollenzer (4):
      [d4c9003b5294] common/rc: Add tests for character devices
      [cc34c5f81f26] fstests: Add support for UBIFS
      [62de87749aeb] generic/398: Accept failing with EPERM in addition to ENOKEY for rename without key
      [1cc2487f501f] fstests: Fix block device requirements and manual scratch mounts

Filipe Manana (1):
      [034744b82385] btrfs: test incremental send after renaming and linking file

Nikolay Borisov (1):
      [7b6729e9ab5a] generic/019: Silence possible kill failure

Omar Sandoval (1):
      [ff1f614f3373] btrfs: test Btrfs delalloc accounting overflow


Code Diffstat:

 check                 |   2 +
 common/config         |  17 ++++++--
 common/encrypt        |   4 ++
 common/rc             |  68 +++++++++++++++++++++++++++++
 tests/btrfs/010       |  75 ++++++++++++++++++++++++++++++++
 tests/btrfs/010.out   |   2 +
 tests/btrfs/144       | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/144.out   |   6 +++
 tests/btrfs/group     |   2 +
 tests/generic/019     |   2 +-
 tests/generic/076     |   2 +-
 tests/generic/398     |  10 ++++-
 tests/generic/398.out |   4 +-
 tests/generic/409     |   8 ++--
 tests/generic/410     |   8 ++--
 tests/generic/411     |  10 ++---
 16 files changed, 316 insertions(+), 22 deletions(-)
--
Eryu Guan
eguan@redhat.com

--S8bNVz5XBZn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZPBOCAAoJECZSqilcj+dji9UP/jKhngaF2lfmr1Yb1UmARCdp
RpaK8XLxCOb5Hd50fUyRBKZQ6XmE5B0vOrVW16s5FmFLe152FVCrHbypMeLLw7qy
T5Gb1Cq3lmAx/pIcd1bYShYm7ypu1FTvOLAPM5XClPkRxiF83WvtpQM587aRbO3j
D2EG9G7qf7WOu+oZAhdFD8A0YjYH9MUP9H3MlL+fEiSwdou7CGeH0Vw9+BdcDa5o
5fSbcvqAGmRrrcO98sVFcE/9SyLwAv6WkGv/j5jfrcg90mA6Nfo9eJTDnAwXgboF
CCApYcIt+PLR/SWRaAcKcTeuRwwCbJeK6y7qentiE6kbwrRyzj2HxZn8eusoyZzN
63AjqXqcFTA5ZUm/Mb+9ea608V8+cQ2/s3OcjCg71joG9+kPjLX4P2iR8Y5xEo+B
9bzsoPG6SfgfUL03a7Xpe69donXB68SW4bCkGmD10iF4WdQr+Wd3rPvE0pnEO1sN
WceXka4nPcoAobUH0f6iG+VtMQIc2LWAE7uRRvDxzXJF34fjzqGiH0fN7BFgdb1N
/65uI1n6G3A139gIbBoBtVn0abifSyR9yWEhPiIJ5L/L+TJZrIrfrSXw+QKRbL5S
XFO9oSl20Cngf+z70dSiidFKXZHLwYNiMVZEk5kXACOIGYr1fxrsHPwplGLqmxtS
GyjPQrgTMG47IGD65dk4
=gO+Q
-----END PGP SIGNATURE-----

--S8bNVz5XBZn5--
