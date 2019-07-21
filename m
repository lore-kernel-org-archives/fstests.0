Received: from mail-pl1-f195.google.com ([209.85.214.195]:42991 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfGURBc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jul 2019 13:01:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so18005463plb.9
        for <fstests@vger.kernel.org>; Sun, 21 Jul 2019 10:01:32 -0700 (PDT)
Message-ID: <5d349a6a.1c69fb81.84578.1d86@mx.google.com>
Date: Mon, 22 Jul 2019 01:01:25 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 69c6da403991
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OsRUrwKsu3ah"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--OsRUrwKsu3ah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update pulls in the remaining copy_file_range
tests from Amir and Dave, a new btrfs regression tests and moves shared/011
into generic.

The two new copy_file_range tests should not fail if you're testing with latest
Linus tree (v5.2.0+), but you may still see btrfs/191 failure.

I'm sorry that I still don't have much time reviewing the fsverity patches, but
that doesn't mean I forget about it :)

Thanks,
Eryu

The new head of the master branch is commit:

69c6da403991 generic: cross-device copy_file_range test

New commits:

Amir Goldstein (3):
      [3996a90a471f] common/rc: check support for xfs_io copy_range -f N
      [f60eeb9a2197] generic: copy_file_range bounds test
      [69c6da403991] generic: cross-device copy_file_range test

Chao Yu (1):
      [3bfeb4d53f5e] common/rc: set max label length for f2fs

Christoph Hellwig (3):
      [e678a7cc9ca6] common/cgroup2: better error message if cgroup2 fs is not mounted
      [02994bdad6c7] shared/011: run for all block device based file systems
      [1a4485f2fafe] shared/011: move to generic/

Filipe Manana (1):
      [901c4e5d19b0] btrfs: test incremental send after deduplication on both snapshots


Code Diffstat:

 common/cgroup2                            |   5 ++
 common/rc                                 |  12 ++-
 tests/btrfs/191                           | 110 ++++++++++++++++++++++++
 tests/btrfs/191.out                       |  19 +++++
 tests/btrfs/group                         |   1 +
 tests/{shared/011 => generic/563}         |   5 +-
 tests/{shared/011.out => generic/563.out} |   0
 tests/generic/564                         | 134 ++++++++++++++++++++++++++++++
 tests/generic/564.out                     |  37 +++++++++
 tests/generic/565                         |  64 ++++++++++++++
 tests/generic/565.out                     |   4 +
 tests/generic/group                       |   3 +
 tests/shared/group                        |   1 -
 13 files changed, 392 insertions(+), 3 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--OsRUrwKsu3ah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl00mhYACgkQJlKqKVyP
52PTFQ/+Jh2Zdm2Oe0LbKRaGEBM+bXJAaCY2J9ibp6qFyI017RsykKHk+7u7+L+T
2bfoSR35eo94LT4OzlHNZlakYuvZ8IliB3DU5i5RcVkJ49Jnzx9uBsNTs1CBpsuN
pzGozqp12BYoMt9H+EAVMDRMJjF2IlJf1I6EN36YmjAjQrXjr+kX8ik7I601lmWy
ohyjLcInbh3sHEHgvjYwKhl7aEdSKq7Hl5hX/f080GCasgBVDr7vosZeqNxqrIn9
Q0HUZAjSxjEHTIcm4KPdfIEL2H1Qr1TuiPh2TyEiHv76DmS0n9XEtgNZDGrC1+oW
jf3OZtiTDbUi9DqlgBJjW2TPe4RRIwNS90YxGM7si2FNsIWyXlPks1o9Y3AEyTOE
KmVRPnc6M0O7b73Y8Jreqe15uSs35Ho/c29QPGLNI31FrKjV9uMh0MALXBzA3wLZ
zU00D6C8g2EQlQgZcmCu6jw52nH69/dfJEbTI30N30L6nJa0t+DbKM7GEJktwSLq
l9mGGHUwDLd2txJLRkx6KqhZwxIN+EbahSIJwcO0/JmeoTrjlTeAZbH6vAMLWXnC
Fro4tqzJ4r1ReY01eBn3Glfxn6g7yD62uoO9fjLZPz7X2Sgz73hjDJI1VoD44aBO
yQYVjqTwXH+Y/XNEz+miMHpfMxjeElXoKO0tZdddm+NGdulaRZQ=
=toTZ
-----END PGP SIGNATURE-----

--OsRUrwKsu3ah--
