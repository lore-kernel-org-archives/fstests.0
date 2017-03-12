Received: from mx1.redhat.com ([209.132.183.28]:46884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933059AbdCLHyK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 12 Mar 2017 03:54:10 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B9EF61D1B
        for <fstests@vger.kernel.org>; Sun, 12 Mar 2017 07:54:10 +0000 (UTC)
Received: from localhost (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v2C7s8uM024561
        for <fstests@vger.kernel.org>; Sun, 12 Mar 2017 03:54:09 -0400
Message-Id: <201703120754.v2C7s8uM024561@int-mx11.intmail.prod.int.phx2.redhat.com>
Date: Sun, 12 Mar 2017 15:54:06 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to 6b825e018ed9
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LUPIwpgoy0bs"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--LUPIwpgoy0bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. A test result report generator and infrastructure has
been added in this update by Dmitry Monakhov, it now supports and only supports
xunit format report. There're also new generic tests added and bug fixes in
this update.

New failures I've noticed in this update:
- generic/417 fails on XFS, kernel patches are sitting in XFS list for review

Thanks,
Eryu

The new head of the master branch is commit:

6b825e018ed9 filter: match $TEST_* $SCRATCH_* in beginning of path string

New commits:

Amir Goldstein (1):
      [6b825e018ed9] filter: match $TEST_* $SCRATCH_* in beginning of path string

Dmitry Monakhov (2):
      [e11c5199183e] check: prepare test report generator infrastructure
      [f9fde7db2fa5] report: Add xunit format report generator

Eric Sandeen (1):
      [265c1037eeaf] generic: test orphan inode recovery on RO mount

Eryu Guan (2):
      [11a3e8bd821c] generic: require journal in shutdown tests
      [5e6892dd8be6] common/rc: use findmnt to check mounted device

Gwendal Grignou (1):
      [d8b1dc1d2db9] common/config: make SELinux protection conditional

Qu Wenruo (1):
      [726726d71d77] generic: Test space allocation when there is only fragmented space

Zorro Lang (2):
      [be5b594a4c3f] generic/409-411: remove all after unbind mountpoints
      [f94708819874] xfs/078: instead file image by mkfs on loopback device


Code Diffstat:

 check                 |  67 ++++++++++++++-----
 common/btrfs          |   8 +--
 common/config         |   3 +-
 common/filter         |  31 +++------
 common/rc             |  52 ++++++++++-----
 common/report         | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++
 common/xfs            |  22 ++-----
 tests/generic/042     |   1 +
 tests/generic/043     |   1 +
 tests/generic/044     |   1 +
 tests/generic/045     |   1 +
 tests/generic/046     |   1 +
 tests/generic/047     |   1 +
 tests/generic/048     |   1 +
 tests/generic/049     |   1 +
 tests/generic/051     |   1 +
 tests/generic/052     |   1 +
 tests/generic/054     |   3 +
 tests/generic/055     |   3 +
 tests/generic/388     |   1 +
 tests/generic/392     |   1 +
 tests/generic/409     |   3 +
 tests/generic/410     |   3 +
 tests/generic/411     |   3 +
 tests/generic/416     |  99 +++++++++++++++++++++++++++++
 tests/generic/416.out |   3 +
 tests/generic/417     | 118 ++++++++++++++++++++++++++++++++++
 tests/generic/417.out |  13 ++++
 tests/generic/group   |   2 +
 tests/xfs/078         |  49 +++++++-------
 tests/xfs/078.out     |  16 ++---
 31 files changed, 573 insertions(+), 110 deletions(-)
--
Eryu Guan
eguan@redhat.com

--LUPIwpgoy0bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYxPHkAAoJECZSqilcj+djLm4QAN3yJj1MGYErGrqoa7tfJZEj
1fUyiOTn388ftwa3okMunB7nxqHmQR3eBNVHTWD0N4dzKvg3vuh3CNH8rsV/WEZW
cuhOIJvDQ5DskvtOE08bEqRaxDgSwkC4EZiYXbKr2OZ9JfvXPkOaoK9/g/Of2i9H
SSzcBVJJN7vOjpVRuaLTXdTaImNOBdr58ryLxPWL+hEYEXTytJScl1JGWVme6c2A
4NGAvmdJYllPaQCv5UDOCJx/7Npq0Ss04QmeIG4hsnHIb8erTNSI7lNY4KOs/1s0
6f4Aa2aCCvWZdbrIgUeUvh7TZ0rq1azazz94cmRjV+3paYX4SdhCMJ4JPVbAtoMD
KD99ZvTlNqJc2TPaIT8pfDiu11kYGc0Xt8KPFBRa/a6b8+k49/TKp0Dnb7s09BeN
ciJaB3suzsutddSu/czuhITlGQV+SpL8KRFzPMXjVrtKGvDGu/UbmSvcvA07bjqh
MyGV9v98u5fL2jCnjfSmlPgDmcLCw5EcIqO/CA0AXv8Jdv5m1pFSgPS/KM9DD4Wq
bgO59z9Gvr2XrJnhbsCtwVxAxG16jc1OnkK+uoIP40ZwgE1VZkd2PLUj2IXwxaGl
hcqs61meh2TXxBiNYfNKQToV5cyw0MFl1AkMA/XvVon1LnfF94ZP/+5LtP/J1qKP
eywY0zkPnBqUX7aVO1wE
=NJYg
-----END PGP SIGNATURE-----

--LUPIwpgoy0bs--
