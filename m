Received: from mail-pf0-f172.google.com ([209.85.192.172]:37014 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbeCDKmn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Mar 2018 05:42:43 -0500
Received: by mail-pf0-f172.google.com with SMTP id h11so5589019pfn.4
        for <fstests@vger.kernel.org>; Sun, 04 Mar 2018 02:42:43 -0800 (PST)
Message-ID: <5a9bcda1.c31d620a.edb61.3cb2@mx.google.com>
Date: Sun, 04 Mar 2018 18:42:33 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 204860fa5c45
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bRdx36kltrzj"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--bRdx36kltrzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in the second part of
zhangyi's fsck.overlay patches (you need fsck.overlay compiled by yourself),
which hooks the overlay fsck helpers to _check_test_fs and _check_scratch_fs so
test/scratch fs get checked after each test. Many thanks to zhangyi's work and
Amir's review! There're also two new generic tests that test power fail behavior.

New failures I've noticed in this update:
- generic/479 generic/480 fail on btrfs

Thanks,
Eryu

The new head of the master branch is commit:

204860fa5c45 generic: test fsync new file after removing hard link

New commits:

Filipe Manana (2):
      [5db58785e620] generic: add test for fsync after renaming and linking special file
      [204860fa5c45] generic: test fsync new file after removing hard link

zhangyi (F) (5):
      [69f7669ef698] common/rc: improve dev mounted check helper
      [a90243882b97] overlay: hook filesystem check helper
      [4a73ad6ec8a9] overlay/003: fix fs check failure
      [3ba014aaba1c] overlay: skip check for tests finished with corrupt filesystem
      [697e465ca335] overlay: correct scratch dirs check


Code Diffstat:

 README.overlay        |  10 +++-
 common/config         |   4 ++
 common/overlay        | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++
 common/rc             |  47 +++++++++---------
 common/xfs            |   2 +-
 tests/generic/479     | 112 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/479.out |   2 +
 tests/generic/480     |  83 ++++++++++++++++++++++++++++++++
 tests/generic/480.out |   2 +
 tests/generic/group   |   2 +
 tests/overlay/003     |   1 -
 tests/overlay/005     |   7 ++-
 tests/overlay/010     |   7 ++-
 tests/overlay/014     |  10 +++-
 tests/overlay/019     |   2 +-
 tests/overlay/031     |   2 +-
 tests/overlay/035     |   7 ++-
 tests/overlay/036     |   6 ++-
 tests/overlay/037     |   7 ++-
 tests/overlay/038     |  10 +++-
 tests/overlay/041     |  10 +++-
 tests/overlay/043     |   7 ++-
 tests/overlay/044     |   8 +++-
 tests/overlay/049     |   2 +-
 tests/overlay/051     |  10 +++-
 tests/overlay/053     |  10 +++-
 tests/overlay/055     |  10 +++-
 27 files changed, 464 insertions(+), 44 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--bRdx36kltrzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJam8vEAAoJECZSqilcj+djdZ8QAL2i8/Pn62Kd7iPFeWADPy+e
n0ndBwkJ9Th4YXH/92/KSViLe/FuhIfIXVx+c8M5TpovVUey1mVI8StQ2YhWs8mS
cpFJFYv4oWQlLtN+e0KZIdIoAsZGtSzMplnMy4tP9CIFxSJ8+insjoDYFx0MoL2f
7l1ItcTH461T9bL0iHyzal4gFxpbLvv7CASSiWAOTiFkmma1rl+W/qnRu1Yn9wCJ
g9+vRrVa3/Y8/QSJVlGZuhfUm/Sp6/GrVfSIa/SqH9VzG+k2msh30FUeQBo1f7EK
uMGh/DU57qoKUP/V13nDJeVVfkMETS9Xu+U+sac0DMpHBv6ECBPccDXNudrC8UJA
KZs27agVKODXeHnaHHbcR1Iic2Sm1yty1orZhejhYksiLFdc38TlvYaVHRJ/+zHU
FsI2GCegBIsbsV3N40ZT8ugFooMTqd8Q+w6I7i8rAFesYKA0p99wtsZf5JWkHpqG
vzUViBMdkqwtGwYkly2fkFAi7/EREy8Fo6JIwEhVzTd3/UG6SXJMHGCFm2ixIkAM
JEf83b0C8apBU1J9lUC998H7dmqPeftIfgpkSeyWlrCVnVcH56zwVgsjcOdPqdG7
2n9NcFt4ItGYJyqwLuVRExoo9qUKuhJxNGO6TBMNtrU4bwpYigW1GUhJLMT2cyE9
1NYYRvlFIQCkSxMhH7QM
=Ey+e
-----END PGP SIGNATURE-----

--bRdx36kltrzj--
