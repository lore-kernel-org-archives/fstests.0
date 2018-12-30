Received: from mail-pg1-f194.google.com ([209.85.215.194]:45579 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeL3PPS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Dec 2018 10:15:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so11881291pgc.12
        for <fstests@vger.kernel.org>; Sun, 30 Dec 2018 07:15:18 -0800 (PST)
Message-ID: <5c28e104.1c69fb81.77776.e57f@mx.google.com>
Date: Sun, 30 Dec 2018 23:15:08 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to ff67bfc354fc
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ThX9k5wSLRvc"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--ThX9k5wSLRvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is the last update in 2018 that contains only
minor bug fixes.

Happy New Year!

Thanks,
Eryu

The new head of the master branch is commit:

ff67bfc354fc generic/466: explicitly request $SCRATCH_DEV to be a block device

New commits:

Hou Tao (3):
      [3f95ea9fb3fd] check: use _try_scratch_mount instead of _scratch_mount to mount SCRATCH_DEV
      [a6c53104a41e] generic/019: require scratch device to be a block device
      [ff67bfc354fc] generic/466: explicitly request $SCRATCH_DEV to be a block device

Theodore Ts'o (1):
      [deab8ca02e36] ext4/034: adjust commit which fixes the problem tested by ext4/034


Code Diffstat:

 check             | 2 +-
 tests/ext4/034    | 4 +++-
 tests/generic/019 | 1 +
 tests/generic/466 | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--ThX9k5wSLRvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcKOCcAAoJECZSqilcj+djGd0P/jGBKVPQ38bNfrNg6e32WbWO
vMZQjm9aPuhsG98EMB3cYFdQgT07USpXnL6bluRUr4m1e0Xp3B72Z5iNm0UYKJEV
iXnpEidg7qeIDc+dBCBogX6tELnZAU2N07qXiIvoY/zS4BfsDp0HEQmvrP5GmDux
+XjTGpLbINoK+lpa5ve2damxTk+s56ckx5j8P33yN47IEERZkd6yIrXSsSybcDzc
VT20dR2smhZ8X6jDv0y81QL8TLHdiMXT7rGPOLVvVrJIYnIVB0M5fdJA9tKGLK+V
KjnsgluI77eK+sXBFSK0Ln0tvHMVgffSnc7PdHOi0io98dfVY02ZBpzuQ2WGjrcO
EriRfFBI/rbkSSnxvQwxfsUXLqg0dqhGvGHfOybwlKVqSgzg7p8sP8jIqo7myTEu
aJmvKj0kmVYxuL8HV46wW0NKqNt5rnWb8aRhx85NtVSXqhbEFgjgeWU5UpEqY0it
+Q8xHErIdHXp9VqddPbPwZq1lmpTCUy3PGDtXUY+GXfdpKkDYviKC1PJOIaKIns3
Jq/k+f82u2NK7pZ1U51PJtyKc2gJ/yE6s9f8kCsHx3K1NvnWdzNxzKzXFT145PpT
n+/7LsAivBe/ae31qsU84qOq7FI4E4VFJlxkztIulQefUI9T555qkPqIJBNvEJKC
HBGpxTwxbpA6GqYJ5BcJ
=zqfp
-----END PGP SIGNATURE-----

--ThX9k5wSLRvc--
