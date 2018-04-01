Received: from mail-pf0-f175.google.com ([209.85.192.175]:36046 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbeDAOri (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Apr 2018 10:47:38 -0400
Received: by mail-pf0-f175.google.com with SMTP id g14so7998089pfh.3
        for <fstests@vger.kernel.org>; Sun, 01 Apr 2018 07:47:38 -0700 (PDT)
Message-ID: <5ac0f108.44cc620a.fa6f7.e188@mx.google.com>
Date: Sun, 01 Apr 2018 22:47:30 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 03d77eb7539b
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Gysw85tHYss9"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--Gysw85tHYss9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly improves overlay and xfs tests, by
adding new tests and fixes.

New failures I've noticed in this update:
- xfs/278 fails if you're not using xfsprogs for-next branch
- xfs/444 is a new test and fails with current Linus tree

Thanks,
Eryu

The new head of the master branch is commit:

03d77eb7539b overlay: test decoding overlay file handles with warm/cold dentry cache

New commits:

Amir Goldstein (5):
      [10a56715e9b2] overlay/05[45]: Document the fix commit
      [fbc0f6913e44] open_by_handle: make -h (help) a valid option
      [63e83951ff2d] open_by_handle: add -n option to suppress drop caches
      [555cdbee5647] open_by_handle: add -s option to sleep and keep files open by handle
      [03d77eb7539b] overlay: test decoding overlay file handles with warm/cold dentry cache

Darrick J. Wong (2):
      [e873eb985788] xfs: test agfl reset on bad list wrapping
      [d75c76f63d43] xfs/278: find sfdir inode field prefix


Code Diffstat:

 common/rc             |  30 +++++-
 src/open_by_handle.c  |  59 ++++++++----
 tests/overlay/054     |   3 +
 tests/overlay/055     |   3 +
 tests/overlay/058     | 137 +++++++++++++++++++++++++++
 tests/overlay/058.out |   9 ++
 tests/overlay/group   |   1 +
 tests/xfs/278         |  38 ++++++--
 tests/xfs/444         | 258 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/444.out     |  13 +++
 tests/xfs/group       |   1 +
 11 files changed, 522 insertions(+), 30 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--Gysw85tHYss9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJawPBVAAoJECZSqilcj+djM6EQAM5JNyl2+7knoS5M4Sa+3PF7
dkWgKlLNu0z7lZV9kf1mOKR/7H5J+a6sXUv2p1Ql9lDDRssFrdC4ha2w0fy4s7bV
keiyapA4z1q8NTbbWEtBDKHS0WEVkPNCp41kv4CM4neqzIWjy0AJZgI42+auBu19
1MIzDn7YguARNoIyH+ohUwuzbCqRra4A3dtKAkA0Vn00tq1XM2Ht0xS4bGI5J+AS
tpmTmtGDrIYZAZa6e+jT9OwweljBx8dZyC8wZf41g6Mb1JKiq1riIuBbtd1iZSe0
pZhB/LiLu2VA+Fd5m5DieCbHOdG8lVX9j5+XS6SkHFtpoWopspSMTYrlzydLBTdM
2rWtbxCrxL8ffypiQgCzsPH2pfCvqFieHwt56V993wkK8xfo2GzR760rqjxaNXwi
B+5ytD+W0bw63R0meRXJzwty7q8MZUCn1EFg8tYXDIMV9OzBitS4SaQSTGTbWRJr
p6Mpn/WNhgmI1Upz55KyFmUhQpVCCE782F+X3PWAz9SqHlw/4hnAiNj77A9tlrtG
2FbNuWk/xnVZ/NxyYkcoZr9jTX5dgEKLwUw+j+211UNAQinFIaiRJEERZXVQCqS/
jzLpIVoB5bCngkJjSh9c9gS8CUK+Uz10N1ChehW9djmVT93vePZDWq4oLI38jF+K
CCposPXlK8uS7AQuVSzr
=BY89
-----END PGP SIGNATURE-----

--Gysw85tHYss9--
