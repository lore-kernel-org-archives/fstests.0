Received: from mail-pf0-f193.google.com ([209.85.192.193]:36228 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdJHINH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Oct 2017 04:13:07 -0400
Received: by mail-pf0-f193.google.com with SMTP id z11so3677655pfk.3
        for <fstests@vger.kernel.org>; Sun, 08 Oct 2017 01:13:07 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id q73sm12438929pfl.146.2017.10.08.01.13.05
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Oct 2017 01:13:06 -0700 (PDT)
Message-ID: <59d9de12.cca3620a.4fbd7.9b91@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 08 Oct 2017 16:13:00 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 64b90915304c
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9p39eI3977oW"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--9p39eI3977oW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a small update that only contains some small
straight-forward fixes, no new tests are added, as I was in holiday in the past
week. There should be no new failures after this update.

Thanks,
Eryu

The new head of the master branch is commit:

64b90915304c writev_on_pagefault: Use ssize_t type for write(2) return value

New commits:

Chandan Rajendra (1):
      [0e8adbc0bf28] overlay/038: Remove af_unix program requirement

Dave Chinner (1):
      [6ba637e0cdc0] fstests: update mkfs.xfs filters for new refactoring

Rostislav Skudnov (2):
      [ebd721deac57] fsstress: Fix wrong size argument to getcwd()
      [64b90915304c] writev_on_pagefault: Use ssize_t type for write(2) return value

Theodore Ts'o (2):
      [285a1d2215fb] report: encode XML Character Entities in xUnit report
      [48d7ba426e6d] report: fix summary statistics in xUnit header


Code Diffstat:

 common/report             | 19 ++++++++++++++-----
 common/xfs                |  3 ++-
 ltp/fsstress.c            |  2 +-
 src/writev_on_pagefault.c |  4 ++--
 tests/overlay/038         |  1 -
 tests/xfs/206             |  3 ++-
 6 files changed, 21 insertions(+), 11 deletions(-)
--
Eryu Guan
eguan@redhat.com

--9p39eI3977oW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZ2d1wAAoJECZSqilcj+djQU8P/iN/Lce1Hmcjhi8ZqweuNNXs
iXG9P7CVdOwPuO2loURkYtZWxdVvD8q6b4Ubx93XQrAwn+K0U8MxAp5MuhEhzVPT
2MrIYjiewKBiDBftiULwodnOY8L24YxsCzyCcjbwTOMJrGBYmRWpE1ETBj7434zE
ixxM5Sxi+9pXyFo9MOVmRb/CS0hQMge8byaT+p6ZjrXkapTxn4CwlT+IrKgB2JjG
yy8MgumNvVzZRPbyqJzVehVqQK+qLmOCfUVLG2+TQtrIBX4Z7l3YSOtU/21VN57A
jk4a9TpcvGYWpe59nCrGfs2vhZodmUQbG3AGc6zi1bFr+jMjVFCPaayMVSzArutB
gA/nO8MPNdtnRkd/wiH/MLLzOsZawCfyIXpD5K1rGRAC0UkxPDYqTQtqHQkTFKaN
7YNxpWAcNtuhS/BxRdLPieVMQV/bouR2bku2U1on8NBYU9o3yGR2+XoEKKn+/6T/
M5Z7ohOA2xAkmhCgXIws2GVmp4J61PTn93aYejIflFTIP42Hq56fi5uSmfzQ/m3q
NKU4kiSJk0OsaomYM81fNSigxyQvvR7sVYWeaxIt+MSG9hP3MH9HW7ORw12dWt0u
y9yRMAST5eqZ4WuzxPJ0wg7ku8wGGWeNOZ0gPGROEdZyrhK+c6wug1NWY3uQ8rRW
mkhlIiZHzu9BWrnMslHc
=0TTD
-----END PGP SIGNATURE-----

--9p39eI3977oW--
