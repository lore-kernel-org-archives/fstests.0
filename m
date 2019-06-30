Received: from mail-pg1-f195.google.com ([209.85.215.195]:44100 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3OuK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Jun 2019 10:50:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so83043pgl.11
        for <fstests@vger.kernel.org>; Sun, 30 Jun 2019 07:50:09 -0700 (PDT)
Message-ID: <5d18cc20.1c69fb81.d9000.7bf0@mx.google.com>
Date: Sun, 30 Jun 2019 22:50:01 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to f769a923f576
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MJDd3ZcASd54"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--MJDd3ZcASd54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly adds two new xfs specific tests, and
I don't see any new failures when testing with 5.2-rc6 kernel and latest
xfsprogs from for-next branch.

There're still some patches pending for review (e.g. the fs-verity tests from
Eric Biggers), I'll try to go through them next week, but it's really
appreciated if someone could help with reviewing!

Thanks,
Eryu

The new head of the master branch is commit:

f769a923f576 xfs: project quota ineritance flag test

New commits:

Amir Goldstein (1):
      [fdb698644d53] overlay/061: remove from auto and quick groups

Darrick J. Wong (1):
      [55867bd3a8fb] xfs: check for COW overflows in i_delayed_blks

Murphy Zhou (1):
      [2effc0975a1f] generic/486: filter out irrelevant attrs

Zorro Lang (1):
      [f769a923f576] xfs: project quota ineritance flag test


Code Diffstat:

 tests/generic/486   |   4 +-
 tests/overlay/group |   2 +-
 tests/xfs/507       | 199 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/507.out   |   8 +++
 tests/xfs/508       | 117 ++++++++++++++++++++++++++++++
 tests/xfs/508.out   |  23 ++++++
 tests/xfs/group     |   2 +
 7 files changed, 353 insertions(+), 2 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--MJDd3ZcASd54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl0YyxUACgkQJlKqKVyP
52M9pg/9FScGQN7nH6AWglBAiPg0Vu6S4GgQMRDYhorYJ+D22EwSkKaK+yqyF5jN
HmKH6jJAtAE9pZ4n9gILjrNl+KGlC++n0MkajWnHsxpNfS7uFiS3Cgdj3CZ7gxGQ
+fNR7Zwp4Z7UId8Rv4V6TbwLNpXlJZX750Cre/T1iDgXJD6VdU/QEf531QT8qSZ7
rsZ/83k2WR3nKrbAW8ASG2l06UCtbw8AU3l6yVhSXztgXVUd14FibWI+4jXS3kBQ
WTPy+m3/lAnseefqrOH2Q6L4aAl5NT+dna4K+gTYEwPHmFhJFQ+csCMtd6Ot11D1
0zOm1RtMFDx6CXSgUzAgRME+XvzUzN01Ekm0fxqp5i9xQG6dF9KVGtbOZ0kFCysW
HGnHAMvpkoQVyhPeLon3PeL1VxB5pg9lhgsaI36D1TG3aHrHWYs31G5Bd23SU414
ph8jITXGH6eIMnwfQ4LBGjn0skwzi7zOvyc2kiLTwp3SD6N9WZMXNHnIuqPW/vxJ
2DUXrgYMTO8d/PdKie3866PWzytcrXZkfYeWwLQcW3YEu3SBtDc8CRBgYEhq4NGC
fKB7Q/mU+417T4cx2Tm+YNpDtD/7NTyrRxvBYRoAXdALEQ3zsBiQ6469wpjGO8qd
KUVssOGsliZHR6spNsBSNoTqrlw+tLztixoOLwvN3p6IzHfKmmI=
=AVn2
-----END PGP SIGNATURE-----

--MJDd3ZcASd54--
