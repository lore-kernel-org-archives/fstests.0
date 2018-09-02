Received: from mail-pl1-f175.google.com ([209.85.214.175]:42157 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeIBTIF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 2 Sep 2018 15:08:05 -0400
Received: by mail-pl1-f175.google.com with SMTP id g23-v6so7479882plq.9
        for <fstests@vger.kernel.org>; Sun, 02 Sep 2018 07:52:00 -0700 (PDT)
Message-ID: <5b8bf90f.1c69fb81.42085.1d7d@mx.google.com>
Date: Sun, 02 Sep 2018 22:51:52 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to f1666f8ec6d5
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vdcpLov5fPgA"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--vdcpLov5fPgA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update only contains a few minor bug fixes and
there should be no new failures introduced.

Thanks,
Eryu

The new head of the master branch is commit:

f1666f8ec6d5 generic/009: fix test failure with overlay over ext4

New commits:

Amir Goldstein (2):
      [c68495cd99f4] overlay: do not set OVL_BASE_FSTYP value to "overlay"
      [f1666f8ec6d5] generic/009: fix test failure with overlay over ext4

Luis Henriques (1):
      [ddd73c7a96b2] src/seek_sanity_test: skip test20 if file's too big


Code Diffstat:

 common/config          |  2 +-
 src/seek_sanity_test.c | 11 ++++++++++-
 tests/generic/009      |  3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--vdcpLov5fPgA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbi/jrAAoJECZSqilcj+djHp0P/ihDKf1MKxHA4MONDrVPUXKP
PAtthiMHdL7NpxF81Eo1eHDFJbKurIMjZ2bedpYoxKwrNEWQBcD5uIEbBKv5vRzo
7G9VM73AUYwGcMi6c99CZhvMEHBv6ibsSuAVT1sTtUaNJ9+mwEe1da8dSmLqr/Bq
dKOrFHH71qZlMFVZF7vHMdHxhTBp9i5q2y42FkxsEkIs9py+vzSeboE4B4PnBexP
BsVbG7CrfCtlg0lyHpMi3I/cQxb6ZLEv3n8laBGKei0U+abU/NDOs2/C6NE88G/n
tr43jb3J+NEZ0+OXDNd7Vh/Jk8kpf1/NSjccX4luan4xIsiNHHOMbEwTs7xeDc11
O65oIVaU8ria0e7GnnVRKurm4SbQKfStoZIJcZsr6j/Cq0WTvqERhpbASFSVmGqn
ANo1685t+vHriopAvWhG/+SltpI8u3Xmz+4jDbxjxEx5DC76ePdZ6/AcIDKlDNWL
PAGw4DAPrNK5eoUdk0Fa9Nkzq5sZDopprWcQt2jxeks3/VxpNqSsQ5EbHI9jMe4V
xqG+oEW66/biLG/k00/QlIOW6mr0V6zpCb2++4ux62vIfAU+xs3I0GrDSobsEjd2
kk8dqHjOf8x1X4K4KGhW58MW9pyqqONYu3/S49AEKk+MPUjLj4jWW74UEg79zml0
QbVKj4pKCljP7j+VMtba
=ufmP
-----END PGP SIGNATURE-----

--vdcpLov5fPgA--
