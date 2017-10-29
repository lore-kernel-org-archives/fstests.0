Received: from mail-qk0-f173.google.com ([209.85.220.173]:55939 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdJ2Lsa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Oct 2017 07:48:30 -0400
Received: by mail-qk0-f173.google.com with SMTP id x82so13046711qkb.12
        for <fstests@vger.kernel.org>; Sun, 29 Oct 2017 04:48:29 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e190sm2925497qkf.55.2017.10.29.04.48.27
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Oct 2017 04:48:28 -0700 (PDT)
Message-ID: <59f5c00c.c7b5370a.d4a8d.1c13@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 29 Oct 2017 19:48:25 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 4b69106b60cb
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J3LC8yiZ55ij"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--J3LC8yiZ55ij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a small update that contains only minor random
fixes. Please note that the sporadic XFS test failures in generic/{23[123],270}
should be fixed if you have xfs_spaceman built/installed.

I didn't see any new failures after this update.

Thanks,
Eryu

The new head of the master branch is commit:

4b69106b60cb common/fuzzy: online re-scrub should not preen

New commits:

Darrick J. Wong (3):
      [148090c1c440] quota: clear speculative delalloc when checking quota usage
      [a7ee21e5cbec] generic/45[34]: force UTF-8 codeset to enable utf-8 namer checks in xfs_scrub
      [4b69106b60cb] common/fuzzy: online re-scrub should not preen

Qu Wenruo (1):
      [fb26a0cf51c5] btrfs/130: Remove from auto group

Robbie Ko (1):
      [23e7ba4e1047] btrfs/010: fix offset in test Btrfs delalloc accounting overflow


Code Diffstat:

 common/config     | 1 +
 common/fuzzy      | 2 +-
 common/quota      | 6 ++++++
 tests/btrfs/010   | 2 +-
 tests/btrfs/group | 2 +-
 tests/generic/453 | 2 +-
 tests/generic/454 | 2 +-
 7 files changed, 12 insertions(+), 5 deletions(-)
--
Eryu Guan
eguan@redhat.com

--J3LC8yiZ55ij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZ9btKAAoJECZSqilcj+djuyYP/0EjWO9lCrKYz6/sFJrVgqHc
ba2OZUeRoyVN1QUjRqnbzxFwPeZfvuSjka/QJoZZNEZUpHe6HC3a22X2HJ2/j4P2
5i9m1cVRNsE0pbftlETv7KOEHaWnf4TcM0vZUM/TeLx2U3o9nJEfKZ2ESJEOtYUH
hNPFAULQZlSdX6YgEJJ2VpgeiI+/6rm2rqETH0po0cY797iVnjXpUMhLGC7iANYW
BuHIJ2ROFi2w9NmV6/PyUixcmyv8L/AkA6C7VVTZF1csWfnLg8gj9tcJ3UhnHk6M
4TCY8aXquvRFi8pdZGEW7Q5YymPtM0A5xNFd61IMfZyJMLHAxKz0UN+UTfuZdILf
tBKP9YQdr/jnQhN2nYwmypn8y1yaTY0AYfMe0EDlHN1Uy/bxcOdFGzyWrPfiUU3J
AtXin0U9HdZ955O2EGc50XrAYB4lDFMEosS8j7Lk6lBxe+tMEUjvQAWwrjZhRoKG
H0XNk+Rr5H3UxX8bs11bmlx5W2HAaMTrDWH0UmYc8xPWh1RfLvVmskBzBswwraRU
0MkoU13r6n6pQGufP22wLn7XJ3eUYEDYSdr4ASnfJegltVDEyL3bBM6FCUlFwOEM
rrOm+1OIPpPstzZLR5KhaVr07BPlbvwPha9ICLdFGTu4B9kY1hvrLM+Pm3oW73qE
8heiVkfs5dDcYeIE/zHZ
=vfu0
-----END PGP SIGNATURE-----

--J3LC8yiZ55ij--
