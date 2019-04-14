Received: from mail-pg1-f171.google.com ([209.85.215.171]:33192 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfDNQHE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Apr 2019 12:07:04 -0400
Received: by mail-pg1-f171.google.com with SMTP id k19so7419882pgh.0
        for <fstests@vger.kernel.org>; Sun, 14 Apr 2019 09:07:03 -0700 (PDT)
Message-ID: <5cb35aa6.1c69fb81.2a264.f9c9@mx.google.com>
Date: Mon, 15 Apr 2019 00:06:55 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 830349865e71
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FE4m0JGNrwXT"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--FE4m0JGNrwXT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in the various clonerange
tests from Darrick J. Wong, along with some random fixes.

There're still some pending patches, e.g. the fsstress improvements from Filipe
Manana, hopefully I can get to them next week.

Thanks,
Eryu

The new head of the master branch is commit:

830349865e71 clonerange: test remapping the rainbow

New commits:

Anand Jain (1):
      [4529b20e1aa8] btrfs/048: amend property validation cases

Brian Foster (1):
      [2516e6cd4e98] fsx: test copy_file_range() using non-zero length copy

Darrick J. Wong (1):
      [830349865e71] clonerange: test remapping the rainbow

Murphy Zhou (1):
      [13818987d557] generic/504: fix hard coded fd number

Xiaoli Feng (1):
      [c1edf46dbc2b] common/rc: use _try_scratch_mount for scratch_remount

Yang Xu (1):
      [b1887f84e6f7] common/populate: decrease the step of rm file

Zorro Lang (1):
      [fe234188282c] src/t_attr_corruption: covert value to little endian order

zhangyi (F) (1):
      [4fbdfbe246cd] generic/230: reset grace time before overcome hardlimit


Code Diffstat:

 common/populate         |   2 +-
 common/rc               |   2 +-
 common/reflink          |   7 +-
 ltp/fsx.c               |   6 +-
 src/t_attr_corruption.c |  12 +--
 tests/btrfs/048         |  23 ++++++
 tests/btrfs/048.out     |  16 ++++
 tests/generic/230       |   8 ++
 tests/generic/504       |   5 +-
 tests/generic/540       |  92 ++++++++++++++++++++++
 tests/generic/540.out   |  14 ++++
 tests/generic/541       |  97 ++++++++++++++++++++++++
 tests/generic/541.out   |  16 ++++
 tests/generic/542       |  93 +++++++++++++++++++++++
 tests/generic/542.out   |  14 ++++
 tests/generic/543       |  97 ++++++++++++++++++++++++
 tests/generic/543.out   |  16 ++++
 tests/generic/544       | 197 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/544.out   |  62 +++++++++++++++
 tests/generic/group     |   5 ++
 tests/overlay/035       |   2 +-
 21 files changed, 772 insertions(+), 14 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--FE4m0JGNrwXT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcs1pEAAoJECZSqilcj+dj/pIP/Avo0ZVRtQOuFc+zdv1WSbg8
65ATzmlcq7cL1IALzfFqXngRFgXLwSExq22rImCcBm73kv9hI3Dn634+MeamDcP6
KD2EYl1v0zIFdTRihERov7LOhZjFso8wMtCM9pO6AyF9h24upKZbQXuHGHPxb2rF
UP47B5SkFw7IMQQ5KupZmKh4HdJHDeqR7iPpQ6hNaoIysa4UocBEW39wK/XsbpgK
FhUzah5lz/GNBD7Yhib5c8nfzaIaEIoe3TJ0xIaQw8QFN9O8VCXScw+yp2hH31Z0
d3O9WKW6bcKoT2x52sw/MzBhs5qtdIF/jZxT7FfR6MDgnf03wZ59zk1Nubbv3L4K
czbb33l0iqRT2qASN3GFcvFVcdbK0bAm0zLIlq0C32W9aU/gF0Vd3Z24SYW10BVH
ukPxFXSROgkA7Fg5bE3tBbuJjILl9wzVUy94vqu/rc5VGYePEKCe4ozA9bv1lxB1
vtUrozyHSvGW/ro3JN0HXT6Yn8pmABf1kdDdUmWnyczUEvp0D1H1RiXh++zG55Z6
zEWxdwkYaLZmqajuIg/9lzQupKH53ISrvwc6Fj/LURgXYMH+xalLQIy6gqtR26tE
hjh6xQuti98f+RAVX7NKP7kpZSjFwZvMxpXfdR4dPK9/mKt/GxkRTuT8H65Sk5Tm
Q3nH+re0wlC361eIz6ZO
=fv7V
-----END PGP SIGNATURE-----

--FE4m0JGNrwXT--
