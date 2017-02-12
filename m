Received: from mx1.redhat.com ([209.132.183.28]:44544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbdBLITE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 12 Feb 2017 03:19:04 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EABD33D944
        for <fstests@vger.kernel.org>; Sun, 12 Feb 2017 08:19:04 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v1C8J37r026647
        for <fstests@vger.kernel.org>; Sun, 12 Feb 2017 03:19:04 -0500
Message-Id: <201702120819.v1C8J37r026647@int-mx13.intmail.prod.int.phx2.redhat.com>
Date: Sun, 12 Feb 2017 16:19:01 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to 7e4f7a370ca4
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JCSE4jMwcRlU"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--JCSE4jMwcRlU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're mainly bug fixes and improvements in this
update, notably that we have log state support for ext4, which enables
generic/05[24] on ext4, though the kernel support is not ready yet.

Thanks,
Eryu

The new head of the master branch is commit:

7e4f7a370ca4 common/fuzzy: discard xfs_io stdout in _scratch_fuzz_modify

New commits:

Anand Jain (1):
      [96459fb68785] fstests: btrfs: Use compressible data

Omer Zilberberg (1):
      [6d0d254312dc] generic/074: _cleanup potentially removes local FS files

Theodore Ts'o (3):
      [3e42a35711e1] generic: honor the FSSTRESS_AVOID environment variable
      [b4d4037eeb3b] common/log: add ext4 support for log state probing
      [c7320b4cacf6] generic/052,4: filter out lost+found when running "ls $SCRATCH_MNT"

Xiao Yang (1):
      [7e4f7a370ca4] common/fuzzy: discard xfs_io stdout in _scratch_fuzz_modify


Code Diffstat:

 common/filter     |  5 +++++
 common/fuzzy      |  2 +-
 common/log        | 41 +++++++++++++++++++++++++++++++++++++++++
 common/rc         | 13 +++++++++++--
 tests/btrfs/002   |  6 +++---
 tests/btrfs/003   |  4 ++--
 tests/btrfs/008   |  4 ++--
 tests/btrfs/011   | 11 ++++-------
 tests/btrfs/016   |  2 +-
 tests/btrfs/022   |  6 ++----
 tests/btrfs/027   |  9 +++------
 tests/generic/051 |  2 +-
 tests/generic/052 |  2 +-
 tests/generic/054 |  4 ++--
 tests/generic/074 |  2 +-
 tests/generic/232 |  2 +-
 tests/generic/388 |  2 +-
 17 files changed, 82 insertions(+), 35 deletions(-)
--
Eryu Guan
eguan@redhat.com

--JCSE4jMwcRlU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYoBluAAoJECZSqilcj+djQRUQANZvoJUB5z4YQuwYXRqV0p15
GQ4IED5WW4jj02sOWjr0rjLKEVOST112Ip8DVgq89RpLavcknvRdThgys4dEKPe2
q2zbX8xgskTj9mePg7oLOd1/zwcq2ZnXbIjiOiY1wS0n9G030wx08u/NwyLoDdU5
0zW8/LrtngyPF2vMCDHF+rpiVlKx4QrMfHAZ4w/Tom9Da5MlLa+8xzxHThWQP+EV
CCBQ4N/C4PLgQTW3uHOI6SzhK211nTUUaYQCtFrj6RW8zNwxXn8LDGy1mRETBWnz
KFPZqirhQA6YfyMZA5B+gG/tx1ys1WO2J9qo2qCm71Yv9WHjcgnC37RWVN1tzGa5
FcwmvOWHt/5aIeF714ZCdC3XPlTdWDPQ4nrwCVstHCxyrNGE4LeZl7062ooB3ZGH
xNSbDUIx1xTdPBzow3XUNeQ6ifBNmSFNWnuYXa7GsCRzF3nA/vGnQIO5g0wCG+ix
vGuF0WcDzyqmz50cJKtRMTSaYxAoc9unJyvjMIOH2BW/LNK3F+FFb/AHzERR4xzQ
Sn5esUo3/W80J+wE/sF8Cr3ZxyJRF0EVE6YR03TFV5lGmzE1hZosWHZu6WmfKPyA
shEneaVUvPOX1LtkogMNZNWP7gKoEoKRjHJMZZQoZqOrAMoI/zscMxt2x906xKDV
LdZdrr+zAhZJPTZ+BlNu
=tRvd
-----END PGP SIGNATURE-----

--JCSE4jMwcRlU--
