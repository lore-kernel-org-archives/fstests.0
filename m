Received: from mail-pg0-f68.google.com ([74.125.83.68]:32976 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdHMMi5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Aug 2017 08:38:57 -0400
Received: by mail-pg0-f68.google.com with SMTP id u185so6633263pgb.0
        for <fstests@vger.kernel.org>; Sun, 13 Aug 2017 05:38:56 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id s67sm9221528pgb.13.2017.08.13.05.38.54
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Aug 2017 05:38:55 -0700 (PDT)
Message-ID: <5990485f.465e630a.ba320.362c@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 13 Aug 2017 20:38:49 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 101f0c34ef68
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TTtZzFmKo2Xf"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--TTtZzFmKo2Xf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a small update that only contains reviewed
patches from last two weeks, because I was on vacation in most time of last
week. There should be no new failures after this update, if you see one please
report and/or contribute patches.

Thanks,
Eryu

The new head of the master branch is commit:

101f0c34ef68 generic/307: add test to acl group

New commits:

Darrick J. Wong (1):
      [4cca8b4ced05] common/inject: refactor helpers to use new errortag interface

Ernesto A. Fernández (1):
      [101f0c34ef68] generic/307: add test to acl group

Eryu Guan (1):
      [65e0cd588d7e] common/config: unset TEST_FS_MOUNT_OPTS across config sections

Xiao Yang (1):
      [adf56068b5c2] common/config: add acl and user_xattr support for TEST_DEV


Code Diffstat:

 README.config-sections | 10 ++++-----
 common/config          |  5 +++++
 common/inject          | 59 ++++++++++++++++++++++++++++++++++++++++++++++++--
 tests/generic/group    |  2 +-
 tests/xfs/141          |  5 +++--
 tests/xfs/196          | 17 +++++----------
 6 files changed, 77 insertions(+), 21 deletions(-)
--
Eryu Guan
eguan@redhat.com

--TTtZzFmKo2Xf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZkEdsAAoJECZSqilcj+dj1T4P/iuwhvdrfeLZ4T7YZ4FW1D9T
xKKAK87/gD13L1RnaA8a0cpP9Icr7ZVt/F5WYvlWG8NdkXP2NJYYv5LYbIaDADaw
kGSEsL9CKiAXc2D65mqRUWJF8/a37cIMIZ+nEeRuVWfxeOXsRM0cp/Mi5dCWKw1+
lJj9QdAUhxXzMoyxJkNgFp8kwx7YZ7enYHWZhqtkcSOCMaKGas+1qPBnfv2pV/tW
KtQeyt+myXIqpAEYfI8B90LhPFfaDkegSVTSaU8s7RQeQCAbKAsN2n1iAMhygdm2
pGcNEVA5j01fmGpgAIXkHtznqsAlqv9CvECUB9M3WjST7HKB2c1bjA1/lUHuxh00
wp8T1nrTB5TprVNlL/3bKn4mlIZXOYTRf8OYXFmp8FRUM9B+SgDhOEwQeb8eX6SN
ZWm3qLAl6LZr3xNG4VFYZwmW/A24NxPiLRsvzeBbN0rawW44dR6E333AFECWn9ZH
lDH6NCavkYMVE7GCe8I7EsCuGzKWTilvtVE1KbCNVZQJc0kscayhVmWe2mY00I7r
oA04A75Jmbxl0KEgp7EFzzbPndFOhfY1Cdm9+TvcT0NEQ5IxAzyYLxaAow2s3ceS
qfYG3pi2M5XmHBrDa7lQAuIEUt8zwpvG0gC1hHAV1kcztCQTxkcTvPsKckBKarKx
RX4uO+BwRB4KpIgWy5R2
=eVbV
-----END PGP SIGNATURE-----

--TTtZzFmKo2Xf--
