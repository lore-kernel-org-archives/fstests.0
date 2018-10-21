Received: from mail-pg1-f193.google.com ([209.85.215.193]:45062 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeJVA1Z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Oct 2018 20:27:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id s3-v6so4660958pga.12
        for <fstests@vger.kernel.org>; Sun, 21 Oct 2018 09:12:36 -0700 (PDT)
Message-ID: <5bcca573.1c69fb81.eb6c0.7ec4@mx.google.com>
Date: Mon, 22 Oct 2018 00:12:28 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 298be055a00d
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sfQ73DauCkKm"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--sfQ73DauCkKm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update pulls in new reflink tests from Darrick J.
Wong and new power failure test from Filipe Manana, along with other bug fixes.

btrfs currently fails generic/513 with v4.19-rc8 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

298be055a00d generic: test reflink side effects

New commits:

Chandan Rajendra (2):
      [9d8f4e1c86d0] xfs/139: work with 1k block size
      [b0c8d2f735b3] xfs/140: work with 1k block size

Darrick J. Wong (1):
      [298be055a00d] generic: test reflink side effects

Filipe Manana (2):
      [2b621418f4e9] generic: test fsync after fallocate on a very small file
      [da8ac46681d0] btrfs: fix test btrfs/007 to not leave temporary files in /tmp


Code Diffstat:

 tests/btrfs/007       | 33 ++++++++++++---------
 tests/btrfs/007.out   |  1 -
 tests/generic/512     | 61 ++++++++++++++++++++++++++++++++++++++
 tests/generic/512.out |  9 ++++++
 tests/generic/513     | 62 +++++++++++++++++++++++++++++++++++++++
 tests/generic/513.out |  2 ++
 tests/generic/514     | 49 +++++++++++++++++++++++++++++++
 tests/generic/514.out |  2 ++
 tests/generic/515     | 68 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/515.out |  5 ++++
 tests/generic/516     | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/516.out | 11 +++++++
 tests/generic/group   |  5 ++++
 tests/xfs/139         |  4 +--
 tests/xfs/139.out     |  4 +--
 tests/xfs/140         | 11 +++++--
 16 files changed, 386 insertions(+), 22 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--sfQ73DauCkKm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbzKU3AAoJECZSqilcj+djtFUQAMQ5oX/5K2BUi+adC5yJUxuk
2LK3UKcL6p5YCppXJFEkdHrqKX1s5A76EZ9Vp1xiMytcE1IJ6DlBhNRqezS9E/2Z
OZVrI0kJHAzNeykpDgDLn0O9AVhL9y7XWqoCarOBjMX+rE2cqFQr7t13cuXbvHT+
T09MFfvu3zs5mOtbvHprIIpDPjkmfCfTRk8hLAUHq27BB3zg2ilyqNYQ4JBmCfRm
mNugvbX35sPNQQMCRmwn9iaoPK3B/cN8zGvc0jkChgSXw6O6dl7XkCmpNz6Kn4W3
3G3DCFzd02BYv8QxrqMtMdxfLixsVx0w1f43GpDtVxvw9jLARB9omzrUmRwrYR4P
Y6+rochhnA3J6qMXkszMu0jijD1UEWK00M6c6d5vly7SentVd5PR815exQTM6Iq7
2idBLGKfCJkEZzNgkAGwY+skEg9lphWRCqf0mVCAa5nOJbeuL87q6ZEo8lsnTo47
5KbnvhKI78JIc2IHITeuGVXiZotolBlV1jFHaLQ4N685wa94ZiOQyVpx7zWOpFXu
OMst7nqKycemN6/TDF/V3N7sXq38x+dI/SX8oO5K9yYunQXh1ql4dI2+luJquqRy
mHHOSfx76e3uC5tRB6vGrE4tnBcJiC7BW3noiY2h0cpNlcbAYvhk5/fzECiy8vxI
u+NoI4SnjdenaCjq8mgA
=MetV
-----END PGP SIGNATURE-----

--sfQ73DauCkKm--
