Received: from mx1.redhat.com ([209.132.183.28]:60314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754690AbcLaS7n (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 31 Dec 2016 13:59:43 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 897124D685
        for <fstests@vger.kernel.org>; Sat, 31 Dec 2016 18:59:42 +0000 (UTC)
Received: from localhost (vpn1-4-31.pek2.redhat.com [10.72.4.31])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBVIxfK6015837
        for <fstests@vger.kernel.org>; Sat, 31 Dec 2016 13:59:41 -0500
Message-Id: <201612311859.uBVIxfK6015837@int-mx14.intmail.prod.int.phx2.redhat.com>
Date: Sun, 01 Jan 2017 02:59:40 -9900
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to 06557299a5ed
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YtvxbsbYQWtx"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--YtvxbsbYQWtx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is the last fstests update in 2016, also a small
one. I pushed out three btrfs test fixes, left patches that still need further
review/discussion (ubifs support and XFS malformed inode mode tests) to 2017.

Thanks all who have made contributions to fstests in 2016, either patches or
reviews or both. Happy New Year!

Thanks,
Eryu

The new head of the master branch is commit:

06557299a5ed btrfs/104: Redirect mkfs output to avoid false alert

New commits:

Chandan Rajendra (1):
      [f7a52fc6db34] btrfs/012: Enable test to be executed on non-4k block size filesystems

Qu Wenruo (1):
      [2333197d308e] btrfs/132: wait the writer to avoid EBUSY

Su Yue (1):
      [06557299a5ed] btrfs/104: Redirect mkfs output to avoid false alert


Code Diffstat:

 tests/btrfs/012 | 4 +++-
 tests/btrfs/104 | 2 +-
 tests/btrfs/132 | 7 ++++---
 3 files changed, 8 insertions(+), 5 deletions(-)
--
Eryu Guan
eguan@redhat.com

--YtvxbsbYQWtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYZ2pgAAoJECZSqilcj+djbuAQAOTgCGsupO7HMEmFgwNdksJ4
K3lJb93kpHTNsYQN/QRhtbQCskPl9j5qUXLNBE5J5RU1qQ3x19irvgxve71601ih
gNqexINbuptzhDxIAuMu9CpwvywuAcSTqFi/ojyWPEmeUJdfXAvaRTx+LOmLj+a1
ZVJl5Aqvp2YM38vS9+Y/SC2wFVk3jvh9g1yO9cxr2yZ3rkOk16xhULPfbX+xOCzt
RVjoGsofe7dvisPBnXVAWlL7iTOf7zBgMpW27ulU2n1Liij5In6P9JqPlNpINwB9
h8hJ++rIPSd6SqUiNiu+6DUD9uOug/4zcUw506QMhiYhcuMU46sS7on5vxfkCVSx
TXpMZWGd+AaJUZWb0nYa9KAzzKGl/fT2l41cyK0L5Avonso1sOC61myNZZoD/REB
irs1oCILsiBqRe4rt1M8y507UXgvUY4lkO1ZHZDubHFbhlYvIO+ufKr2v2fTLEfP
Ie8sypxScFo9O6NLjVbzBeI6KaFJYNaK0mfw23xOxu0hqlvw3mVGgM+y+rEL5m2V
Tn9yz7s/oTNUA6FMbhQcaS0nU/RhWo+QMWxBptM1NC8Vh2rUlipkyWEXlfakYGaU
mn2eLYRiIQHsWVyMvIwAC1WiD2xwcAFCEx2bHSgJjBTBYcOEjL3KqeaSgEcO/AJq
ZNP7qQHoyYBXmnGfsckt
=dU/h
-----END PGP SIGNATURE-----

--YtvxbsbYQWtx--
