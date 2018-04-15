Received: from mail-pl0-f46.google.com ([209.85.160.46]:34154 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbeDONvC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Apr 2018 09:51:02 -0400
Received: by mail-pl0-f46.google.com with SMTP id z12-v6so1125309plo.1
        for <fstests@vger.kernel.org>; Sun, 15 Apr 2018 06:51:02 -0700 (PDT)
Message-ID: <5ad358c4.8d5d650a.3ccb9.5ec5@mx.google.com>
Date: Sun, 15 Apr 2018 21:50:54 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to fdf6d4bc862b
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SqpnFKEiVmrp"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--SqpnFKEiVmrp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update declares all non-global variabls in
common/rc as 'local', this should not introduce any behavior change, but if you
find any new issues caused by this change please report bug and/or contribute
fixes. This update also contains a new generic test and two minor bug fixes.

Note that I was travelling last week and will be on travel next week too, and I
have limit network connection, so my response might be slow.

New failures I've noticed in this update:
- generic/483 fails on btrfs, the fix is not in upstream yet

Thanks,
Eryu

The new head of the master branch is commit:

fdf6d4bc862b xfs/187: fix ftype brokenness

New commits:

Darrick J. Wong (1):
      [fdf6d4bc862b] xfs/187: fix ftype brokenness

Eric Biggers (3):
      [1ddae54555b6] common/rc: add missing 'local' keywords
      [09c5e9bc8916] common/rc: fix up variable naming
      [d7b767f90586] common/config: support f2fs-tools v1.9 and later

Filipe Manana (1):
      [858c39281e1e] generic: test for fsync after fallocate


Code Diffstat:

 check                 |  14 +-
 common/config         |  17 +-
 common/rc             | 419 ++++++++++++++++++++++++++------------------------
 common/report         |   6 +-
 tests/generic/483     | 124 +++++++++++++++
 tests/generic/483.out |  13 ++
 tests/generic/group   |   1 +
 tests/xfs/187         |  11 +-
 8 files changed, 382 insertions(+), 223 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--SqpnFKEiVmrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJa01hbAAoJECZSqilcj+djsncQAIAofhcPUDLhXXlZzv2S1om8
sO0B7DOM6QnOPAS3NJ4orwndCrJQoIUu904dOwjzaIqjO7fasfD2gdIaLocLkgah
zM01oS9YC768X/y2FtasMiDM/p6QCPhWBImPymNNFBG2L2YyUxxzrCZ2VvyEiDNw
rOjKpq8VbIQVrjBrBD/rk0DRgoc1vXNnWQKs91gdcyYtg8wbdroAYwzA3ttiu0Wv
kmdxhMhjOWqDBIEv0IRnImqlf4/wtKAXgGf2DHxgNybyHodlL9WxacclXX9KVkfZ
Kr6+dHKvh/GDNUnMSGwHu3raHXB8qHnVVLPz9v0sSCPreBsB5kW/1Tl3gEAjCX2v
xbTFj5n+Pu+BODHhxHT14egcLaY+PaqpWf1ydt+ShsWyW0bt59ZJtf/m3rk0YN6N
iCdw3bg31pdgaSQPuxtot9m8HmYiplfLiHgmLozxbOGSjUY4KKSD8Iol59mxhWhp
BTXHH3AC2yi4JqvGiJ69fiUjDu8y9cmOS+dkMuD9PTfSvdhaEiz6fwTiP83sIJoX
w9FzvuNeUScOi0JUNMAxoP2uESa9iMchRNSZJoEo7HGAhiTaymle1tYY9BKMDOy7
RSjUqg+0hpkqxuUSXLitX5i1Jk1z7EGcub6oD8M+O7g/3hlnJvvi4wl9TrOOZGCv
2Ie68+74H8z1u36ZXsQT
=nqs0
-----END PGP SIGNATURE-----

--SqpnFKEiVmrp--
