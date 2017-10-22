Received: from mail-pg0-f66.google.com ([74.125.83.66]:55369 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbdJVLhw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Oct 2017 07:37:52 -0400
Received: by mail-pg0-f66.google.com with SMTP id 15so5061110pgc.12
        for <fstests@vger.kernel.org>; Sun, 22 Oct 2017 04:37:52 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id n29sm7323124pgf.44.2017.10.22.04.37.50
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Oct 2017 04:37:51 -0700 (PDT)
Message-ID: <59ec830f.1da5630a.5403f.3579@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 22 Oct 2017 19:37:47 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 4edf3354c646
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EGHkQ8ncUr9X"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--EGHkQ8ncUr9X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update is fairly small with only one new btrfs
test and two minor fixes, because I was out for a few days last week and didn't
have much time working on fstests.. Many thanks to Amir for reviewing two of
the three patches in this update!

New failure I've noticed in this update:
- btrfs/151 currently fails with v4.14-rc5 kernel

Thanks,
Eryu

The new head of the master branch is commit:

4edf3354c646 overlay/038: Remove usage of _overlay_scratch_unmount

New commits:

Chandan Rajendra (1):
      [4edf3354c646] overlay/038: Remove usage of _overlay_scratch_unmount

Hou Tao (1):
      [14b71ba4db49] log-writes: fix possible infinite loop in zero_range()

Liu Bo (1):
      [f711dfad6c27] btrfs: test if device delete ends up with losing raid profile


Code Diffstat:

 src/log-writes/log-writes.c |  3 ++
 tests/btrfs/151             | 80 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/151.out         |  2 ++
 tests/btrfs/group           |  1 +
 tests/overlay/038           |  2 --
 5 files changed, 86 insertions(+), 2 deletions(-)
--
Eryu Guan
eguan@redhat.com

--EGHkQ8ncUr9X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZ7IJ3AAoJECZSqilcj+dj1FUP/inK6Zm4fAz5fMuKwLsK9Rjc
64kTX7sIdCjADLUw8Q19z16aw5Rjki7uC3hD4alVJb31UkCshVnEnBb+O1lhCo0A
vSFyKWvb3mwwSwgtgc3CYyOp3bBMd1kzOsd82edy9gaqKJiHiVvARV2MKhiH3QAZ
7fkm3Q/ue3EBPBk+fhfdoTqUuBmuqRAZve3Pxna//MAoApxXe+AkTzWvV1Gp4wVa
Fu29Xqaf6lsloEHC2dRodRHm0uqml9xY7v4NhYdRHulf96zxQn/z7HXLDTwuA9+V
OpTORtkdwD0CCjFgVvx2kN/7c0K6o9wu6fLDNP5oV0eF8iqvbMeKzHZLAGpQvmxK
lYROyP71P6ad/fDeYOxXYrs+WyGOPXkpgnVcUs0fmMSSXyVTH5PCs0zDEBwYBZvx
UktzXGVbopnModzQ1CUGg1CdjxFGEk9w9q+/o0dnLbW+vryjXPUMIsdLmZd1z5Yr
IpQsN2jv73Qhkwz1wC2lNCq1wqbyLy5adqNtFLBzQs6FgBOnAF7iNVSMhLYaR5iQ
Jcc7sSueWSEGg5y6a9WR7cKiRUA+4qeU67gdsko4p5AWE6sK3ZZusCTQEVdRkYyr
Fc7OAjjSsQ6Nv+Frho+4Rzj+ynWmHrsn/T5ML+SWCPeVrXl+KsmAQ+BctWZhEZCW
aTsZuVOF9fOdMZXbMELz
=Ea/a
-----END PGP SIGNATURE-----

--EGHkQ8ncUr9X--
