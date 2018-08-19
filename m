Received: from mail-pf1-f194.google.com ([209.85.210.194]:40907 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeHSTbp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Aug 2018 15:31:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so5570607pff.7
        for <fstests@vger.kernel.org>; Sun, 19 Aug 2018 09:19:46 -0700 (PDT)
Message-ID: <5b7998a1.1c69fb81.17213.1de9@mx.google.com>
Date: Mon, 20 Aug 2018 00:19:40 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 84fdfc5d8a1c
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="iHdpEDzGqjOg"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--iHdpEDzGqjOg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Again, this is a small update that contains only one
new btrfs test and a bug fix to aiocp alignment issue.

The new btrfs test btrfs/171 should fail with v4.18 kernel, btrfs check
complains about qgroup inconsistency.

Thanks,
Eryu

The new head of the master branch is commit:

84fdfc5d8a1c fstests: Fix buffer alignment of aiocp

New commits:

Qu Wenruo (1):
      [55566e7f7cdd] btrfs: Add test for corrupted childless qgroup numbers

Xiao Yang (1):
      [84fdfc5d8a1c] fstests: Fix buffer alignment of aiocp


Code Diffstat:

 common/filter.btrfs |  9 ++++++
 tests/btrfs/171     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/171.out |  2 ++
 tests/btrfs/group   |  1 +
 tests/generic/252   |  3 +-
 tests/generic/329   |  3 +-
 tests/generic/330   |  3 +-
 tests/xfs/237       |  3 +-
 tests/xfs/239       |  3 +-
 9 files changed, 107 insertions(+), 5 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--iHdpEDzGqjOg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbeYgKAAoJECZSqilcj+djWaYP/imAfKszulWFV1kW9TMPSnF9
dmQ2hhc6Lku4j87liLetb/eJGlwcYa5pEYf4OVGnCKuHfMeQf///ZTvjPpD3fEVG
5RkngQ8ZTYzBiuwupN11D67XbuE1BvOmAhRCIO7GHoGPvFv5jk/yd28X0rfbtmZM
5Ef7H395s6UmmkXDBy4v1+Jhj8FW/ek0NhCpPH46Tt1Wwoz0ZJGWNXWpUqnb5kRe
ytSEgFiuqsi1EWyHEIW3rbfejHlO/cTcIBJV1ZWMVXxHGm7sA/orn+3Hz50VSMEx
RF3EMuiISh7sBnwFrUJSW30pe6gtNhOsrMD9R7LGEMNLyro7v/s4oxZ86Qt9U6GU
u4e/ChrBJ5xOE69hB5qtB0cuZGWpkkB8fva3K1cUz906vRWOpL07cgwYaMGkCHP9
8Hmu1XJevEJy8GrppQR8DFSETsue2m9Q6Ci7cy3WOuMztRWGih7lLS6fAeoOpDeQ
ULw9hz2HYuPx9oV2bvhOiQ87SPPqYGeP+qOs/Vedg6mkI3avcJx4KPvz37oFT+gj
R/+qG0VCFJWMpXmqRW5DIpIaiKpwN3VuEIWqX0LuiMHSNbOF5IwEGyu7YXIVRuUV
cEbc+e2c1IzjjsiUtSlDQZTphAjCfyENqGl/Hvxyx0E3WC0ZOlpAq+TUSEfG4DFQ
bgIn6okqUOFVYLiJmAPp
=iydW
-----END PGP SIGNATURE-----

--iHdpEDzGqjOg--
