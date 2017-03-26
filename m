Received: from mail-pg0-f67.google.com ([74.125.83.67]:32935 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdCZFTp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Mar 2017 01:19:45 -0400
Received: by mail-pg0-f67.google.com with SMTP id 79so4977090pgf.0
        for <fstests@vger.kernel.org>; Sat, 25 Mar 2017 22:19:36 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id l28sm13325776pgc.11.2017.03.25.22.19.35
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Mar 2017 22:19:35 -0700 (PDT)
Message-ID: <58d74f67.1c70630a.f33df.3595@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 26 Mar 2017 13:19:29 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 7400c10e503f
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xO0JphtiPhLg"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--xO0JphtiPhLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is relatively a small update, two fs encryption
tests and one dio test are added, along with a glusterfs test fix. Most patches
reviewed last week are still in the review-revision process.

There should be no new failures introduced ater this update, if you hit one
please report bug and/or contribute patches.

Thanks,
Eryu

The new head of the master branch is commit:

7400c10e503f ext4: test mounting filesystem with encrypted inode on orphan list

New commits:

Eric Biggers (2):
      [0753e1278f4d] generic: test renaming encrypted files without key
      [7400c10e503f] ext4: test mounting filesystem with encrypted inode on orphan list

Eryu Guan (1):
      [9953b149b5e1] generic: test pagecache invalidation after direct write

Zorro Lang (1):
      [7687a3293c96] common/rc: support gluster volume start with a slash


Code Diffstat:

 .gitignore                 |   1 +
 common/rc                  |   4 +-
 src/Makefile               |   3 +-
 src/dio-invalidate-cache.c | 325 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/024             |  87 ++++++++++++
 tests/ext4/024.out         |   2 +
 tests/ext4/group           |   1 +
 tests/generic/418          | 122 +++++++++++++++++
 tests/generic/418.out      |   2 +
 tests/generic/419          |  84 ++++++++++++
 tests/generic/419.out      |   3 +
 tests/generic/group        |   2 +
 12 files changed, 633 insertions(+), 3 deletions(-)
--
Eryu Guan
eguan@redhat.com

--xO0JphtiPhLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJY10PcAAoJECZSqilcj+dj3PQP/Aw8QEJAFLs2AKkuhN8iLh75
W87WkAvOJLK/PEaj+v2O9maa4PGaaZJ86tUdAcinxNNUuONktYYagjGUdvqQRUZk
BMEgFPYyndjBnjmFRWXFO4UrGYv5lJ68MJ5VFjd7RSfgIDcvxhe9BOXfhH/bDMbT
JgQeuGUDCHvro7Dyq8pVwy2+jXaiHIkhGRQceVUuMJuUrmsQYbGHLmUyeJeK9rLM
eGiQsBzVfeQv35DjEHuUVt+KWb+BI++kcx3lTQ13JAHjYq+344zhXVPYmnkpDivB
U7+utJ+610CgnnGFq19VNYC76nL5oocJnOP2C9Szg9xZJqVo82OSJXh7NLFHB0x8
xtnY4kNmPoQAPyv79sXNT1oPeVAkiHuH/pNrvkc8ZDQmopMRBsav6m55yHogtFBr
vQWZ7D1jIL83T3n4hpQ0c68/ewF2o1sMY6C5csbu9m/Puk5iHixu8kcqI1x0W8Kq
5+AvB9JhNUlV4le0W0ClDXie5iLHIxSlvkK/RjqrODcFFKtoMxx1eixemDORbDz8
I3SJxJagXmR0U9NnLbyPASrmLs+3OQrY8iDweKZYu6O77kNkCQQc+6oDW2WS03uZ
He6ojrn/c9Ozs5VikAvGjOgPTVXsK1+1e6zGgtJgASFuuI8PKY4TidA3k4iOcHyH
Cw2LeCFHhr355G9wfxW6
=op/S
-----END PGP SIGNATURE-----

--xO0JphtiPhLg--
