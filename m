Received: from mail-pf0-f169.google.com ([209.85.192.169]:43803 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdIQOdj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Sep 2017 10:33:39 -0400
Received: by mail-pf0-f169.google.com with SMTP id y29so3607302pff.0
        for <fstests@vger.kernel.org>; Sun, 17 Sep 2017 07:33:39 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id y16sm9133026pge.92.2017.09.17.07.33.36
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Sep 2017 07:33:37 -0700 (PDT)
Message-ID: <59be87c1.10b5630a.f16f4.5c6d@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 17 Sep 2017 22:33:34 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 11cf6e7a4a23
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Zz6dsFQaWLuU"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--Zz6dsFQaWLuU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly contains new tests, there're 5 new
tests pushed out to upstream. Two regression tests from Carlos, which were
posted & reviewed a few weeks ago, are merged late because the fixes are just
included in upstream kernel, otherwise the two tests would both hang the
kernel. Besides that, two overlay regression tests from "zhangyi (F)" and one
generic test from myself are added too.

New failures I've noticed in this update:
- generic/460 ensures XFS reserves reasonable indirect blocks in write path,
  and it currently fails only on XFS with 1k block size and rmapbt enabled

Thanks,
Eryu

The new head of the master branch is commit:

11cf6e7a4a23 overlay: test chattr lower file in overlay

New commits:

Carlos Maiolino (3):
      [461dad511f6b] generic: Test filesystem lockup on full overprovisioned dm-thin
      [b4d6db82e208] common/xfs: Add helpers for checking CONFIG_XFS_DEBUG availability
      [642eb97b9f99] xfs: Test infinite loop while searching for a free inode slot

Eryu Guan (1):
      [71d1ae5b8f5c] generic: reserve correct indirect blocks for delalloc write path

Jeff Layton (1):
      [39f31eb2838f] src/fsync-err: write to different offset on each fd

Ross Zwisler (1):
      [37d7344ab692] gitignore: ignore cscope files

zhangyi (F) (2):
      [d83632b9aaac] overlay: test relatime for directories
      [11cf6e7a4a23] overlay: test chattr lower file in overlay


Code Diffstat:

 .gitignore            |   4 ++
 common/xfs            |  13 +++++
 src/fsync-err.c       |   4 +-
 tests/generic/459     | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/459.out |   2 +
 tests/generic/460     | 113 +++++++++++++++++++++++++++++++++++++
 tests/generic/460.out |   2 +
 tests/generic/group   |   2 +
 tests/overlay/039     |  89 +++++++++++++++++++++++++++++
 tests/overlay/039.out |   2 +
 tests/overlay/040     |  85 ++++++++++++++++++++++++++++
 tests/overlay/040.out |   2 +
 tests/overlay/group   |   2 +
 tests/xfs/115         |  89 +++++++++++++++++++++++++++++
 tests/xfs/115.out     |   2 +
 15 files changed, 560 insertions(+), 2 deletions(-)
--
Eryu Guan
eguan@redhat.com

--Zz6dsFQaWLuU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZvoZkAAoJECZSqilcj+djj7kP/RObuDiCWpzgyz747r8eudXc
cFkzbuMZUTYEbHvp87pBTHhUg7iFVvnOcOsnfkVtngVjoqqsjWmHNxEPgiETNQur
ZTfVu2tETw1DZgU+kSJG/W7anR7z9McXVDS3Syp+EVM4ysAwQ8eeoPrh9p9uh4UU
YghuG6OXQlnWntzflvY23rhRkSDPnXELwfLUv4mhNJRfck/t03xztckHOJwB7au/
OoEnI6/LoFmC2thlulF3Sz+ulAwQFWyNMJO9GpGFVIXIUDV+VSahSzSMy88GwNow
X6bShIxzqTRENpVt5Q7MQ5rjMYwplvJ73SR5XtCqCuGsQnS7XuMkHn+hZ9YQQ23F
Gz48utZSCf0SSguG/SXCy6R2eF3X/o+wx/sYPe1mW00c7VyX9MW/RP+ML/KnPrv0
zoSE/m91jPQLOSw3FNoktE+FSbX++lavXhMuoLYZtkWot4MU1BkDvX/5QWD1hmmy
Kl6hvdBlR+COXI4juXxH3UION4PvrwDkhC5YhznjS6fdhS7PkUj2YcmxborGwxFV
vY+2eNanDAIf8NyIKe96Yni7W39gvxSdTZIf7SH1pBWM02d2tKmLW3B4TjNjCN9A
8Fdmfru78QAV46TArY1gSz/hXIzPJ8fyYuP6YzgZfnfnEM5i6EwJTJnLD3YgR7Gg
Tk92kILkZK+oG0sNuYnZ
=ggrI
-----END PGP SIGNATURE-----

--Zz6dsFQaWLuU--
