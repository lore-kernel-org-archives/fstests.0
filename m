Received: from mail-pl1-f195.google.com ([209.85.214.195]:45916 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJ1Xmh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Oct 2018 19:42:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id o19-v6so2576213pll.12
        for <fstests@vger.kernel.org>; Sun, 28 Oct 2018 07:57:47 -0700 (PDT)
Message-ID: <5bd5ce69.1c69fb81.dc027.81d7@mx.google.com>
Date: Sun, 28 Oct 2018 22:57:36 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 0a53bf6c33a4
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bYpXuBm1Eryp"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--bYpXuBm1Eryp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a minor update that contains one bug fix and
some group annotations, so there should be no new failures introduced by this
update.

Thanks,
Eryu

The new head of the master branch is commit:

0a53bf6c33a4 generic: update group file to indicate generic/456 uses {collapse,zero}_range

New commits:

Chao Yu (1):
      [d98030d21291] generic/508: fix to check inode creation time feature on scratch mountpoint

Filipe Manana (2):
      [3193e55a97cd] btrfs: fix classification of a couple btrfs tests
      [03f07aaba6b5] fstests: add some tests to the 'log' group that use dmflakey

Theodore Ts'o (1):
      [0a53bf6c33a4] generic: update group file to indicate generic/456 uses {collapse,zero}_range


Code Diffstat:

 common/rc           | 13 +++++++++++++
 tests/btrfs/group   | 16 ++++++++--------
 tests/generic/508   |  2 +-
 tests/generic/group | 50 +++++++++++++++++++++++++-------------------------
 tests/shared/group  |  2 +-
 5 files changed, 48 insertions(+), 35 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--bYpXuBm1Eryp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJb1ctFAAoJECZSqilcj+djMd0P/0s6NaGdCvhCsDSj1lxUqMj4
QpPTlJ/B1Cqz2khMC6x/z7M3CeWeLLCV9PGlFlH4ggMeZu/kpP9OhSZrkFXshTdP
SfN4Z1l4H7LI1DaWnUze1MC3yvsTMPkc5dWHjSkhiBGxzFQ0DjeKnnaf/uw9Ktzt
3g+bMiIkYs3kMw7TLkNTmohnSX48cvdeHeo+lTb3c0uBQ5+zBpjCyU0BQFTa4xaI
Pvz/+UWCqmmthDTCVEnzMAtEaBmgG0omeR/Am9AQIUPnJ3lpjnIhF6hqnAHNLMRn
wPOk62KQqFTE4uDbfYMLkclOdJ1alyZem4Dl945qUVUwV8gkuGkX5gi5Xl5gLln9
lYK/UPkASW3teU+heAWLiZci4ux4M0CKKETtuqKLU01iOO9ZHYwZE1Q9r9otPxx2
0AZc7fbF0PRW2vnNhAu64OlmloFqpsbjV91B2EF7ZJSc8q0pveCPfGivNIKkW8FZ
hxDyXF7Jb9oPRYZHRwMkjMX+jkokPJgB+657QCIuAN1iIIOOstKKFdTRQ5lqyCqs
waE5mbTTbik4s4u/2GgjYbPpHWSjMBaxIKS++kL0+8wb3Y2VMfz7bJhum+0P7pKP
yMPluc4gI+VH9k546I6D1yo/qJjiXjxKNqg4Wh/Rm7U2bmLDLfvn7guY2uUj4f49
XWOgs4LPCu4fW2eLY4r/
=b62r
-----END PGP SIGNATURE-----

--bYpXuBm1Eryp--
