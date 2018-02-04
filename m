Received: from mail-pl0-f49.google.com ([209.85.160.49]:43660 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeBDNyX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Feb 2018 08:54:23 -0500
Received: by mail-pl0-f49.google.com with SMTP id f4so9951219plr.10
        for <fstests@vger.kernel.org>; Sun, 04 Feb 2018 05:54:23 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id r29sm2355929pfb.40.2018.02.04.05.54.20
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Feb 2018 05:54:21 -0800 (PST)
Message-ID: <5a77108d.1d5d620a.68406.557d@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 04 Feb 2018 21:54:14 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 27f7ed634816
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2ykTgS2ssDBp"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--2ykTgS2ssDBp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is mostly an overlay update. Thanks to Amir, along
with some random bug fixes, we're having 7 new tests for overlay, and most of
them are filehandle tests. Note that these new overlay filehandle tests require
the new "nfs_export" feature, which hasn't been merged in upstream kernel yet,
so these tests are _notrun currently (v4.15).

New failures I've noticed:
- overlay/049 fails with v4.15 kernel

Thanks,
Eryu

The new head of the master branch is commit:

27f7ed634816 overlay: test overlay file handle of dir with ancestor under lower redirect

New commits:

Amir Goldstein (12):
      [aee21da0fd05] ovelray: drop explicit use of OVERLAY_MOUNT_OPTIONS
      [7aa1d4bcd429] overlay/036: fix upper/lower dir mismatch
      [8a2d6ed9fcd9] overlay: consider index dir with whiteouts clean
      [2d9c37702515] overlay/017: require and enable redirect_dir
      [1fa396719e77] overlay: add a test for multiple redirects to the same lower dir
      [ea7ad43185ca] fstests: implement require of multiple overlayfs features
      [a97f4505f252] overlay: test encode/decode overlay file handles
      [1af8bac6c98c] overlay: test encode/decode of non-samefs overlay file handles
      [c68eba8a2b5b] overlay: test encode/decode overlay file handles with renames
      [c2e7f1d84228] overlay: test encode/decode of non-samefs overlay file handles with renames
      [ce9707ccd089] overlay: test overlay file handles of lower dir with non-indexed ancestor
      [27f7ed634816] overlay: test overlay file handle of dir with ancestor under lower redirect

Rostislav Skudnov (2):
      [e9dc7dc6cec6] generic/307: Require ACL support
      [dc9f8c9ac02e] generic/{274,315}: Require falloc -k support


Code Diffstat:

 common/overlay        |  27 +++++-
 common/rc             |   2 +-
 tests/generic/274     |   2 +-
 tests/generic/307     |   2 +
 tests/generic/315     |   2 +-
 tests/overlay/017     |   8 +-
 tests/overlay/033     |   8 +-
 tests/overlay/034     |   8 +-
 tests/overlay/036     |   4 +-
 tests/overlay/041     |   6 +-
 tests/overlay/043     |   6 +-
 tests/overlay/044     |   7 +-
 tests/overlay/048     |   4 +-
 tests/overlay/049     | 109 +++++++++++++++++++++
 tests/overlay/049.out |   2 +
 tests/overlay/050     | 239 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/050.out |  31 ++++++
 tests/overlay/051     | 256 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/051.out |  31 ++++++
 tests/overlay/052     | 184 ++++++++++++++++++++++++++++++++++++
 tests/overlay/052.out |  22 +++++
 tests/overlay/053     | 200 +++++++++++++++++++++++++++++++++++++++
 tests/overlay/053.out |  22 +++++
 tests/overlay/054     | 160 +++++++++++++++++++++++++++++++
 tests/overlay/054.out |  11 +++
 tests/overlay/055     | 170 +++++++++++++++++++++++++++++++++
 tests/overlay/055.out |  10 ++
 tests/overlay/group   |   9 +-
 28 files changed, 1510 insertions(+), 32 deletions(-)
--
Eryu Guan
eguan@redhat.com

--2ykTgS2ssDBp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJadw8kAAoJECZSqilcj+dj5fMP/jg6Sy0mkHV/utMZD5FXolqF
XyV0dnCNzZptk5m9PYCMId3BUoNGTGEPzxXB4wAHXLqHD+WCARHDUJku9wh71IM5
0JRxYJduCFuUSycuQv8YF0ERdNIIenPwk/snM4pmqSPW/uJI7SMPOynVO2MUeDFI
iKxtZgIunrdoM8lUguqLfch8uRUPNAGgo4eSTH1KsSY1S6o/aOSrBtnvuDNWEQXs
zGeaVj5PawiHkgpDmWfPtZm7BxCxbYnCNsbtTHDvU61ee5H//0rTwLX/rrTmbCDE
nmIEfVKXMpAoHva/W/OESOlQniPu6OgB3x0s/99RJ/nJqWbbzPNWsYsWfdBTm2EQ
rmcEwJwo8VAzy24OsmW0IqL2b/bdIbD56sFx2t4trcf2XVue0tCv+DoyAMmvVy9F
kNvI4C36ndxxw5jq6a9TzO/u8NXqW9hk9sD4Ym5EWaVCTyc+BSi5lpCYCQMCjbEd
j3cLxTMM1bZ9QKOGj7soJpirV4VMlE8vUGFF8Wo3OtOWn0+rm9n35CxieBJpHYuS
7UImbGXfEzT7GYCuMOaASCIGO8JX622uf5lys0gwA9qe7yfgJiYS36+cHlL6DpJB
1IhUKeToTsJCMJ8MA0nL8bXapNsaxqxOQVtsx2uMe/70c9rc6En7AinifJbowDJ0
uXqD2yKx2UGO55ZAGQu+
=/5fH
-----END PGP SIGNATURE-----

--2ykTgS2ssDBp--
