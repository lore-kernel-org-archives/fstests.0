Received: from mail-pg1-f179.google.com ([209.85.215.179]:38966 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfD1PTh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Apr 2019 11:19:37 -0400
Received: by mail-pg1-f179.google.com with SMTP id l18so3950610pgj.6
        for <fstests@vger.kernel.org>; Sun, 28 Apr 2019 08:19:37 -0700 (PDT)
Message-ID: <5cc5c488.1c69fb81.2e76.c686@mx.google.com>
Date: Sun, 28 Apr 2019 23:19:25 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 55f4ad17f3e4
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vrzQAnlm2pMI"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--vrzQAnlm2pMI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. The new btrfs test (btrfs/187) currently fails on
latest Kernel (v5.1-rc6). Apart from that, other commits are mostly minor bug
fixes and improvements.

Thanks,
Eryu

The new head of the master branch is commit:

55f4ad17f3e4 generic/487: reorder logdev detection after filesystem detection

New commits:

Darrick J. Wong (1):
      [26a0e060e431] misc: xfs_fsop_geom_t -> struct xfs_fsop_geom

David Sterba (1):
      [55f4ad17f3e4] generic/487: reorder logdev detection after filesystem detection

Filipe Manana (2):
      [8afebc02235e] btrfs: stress send with deduplication and balance running in parallel
      [195a650883b0] btrfs: fix filtering of scratch device in test case 048


Code Diffstat:

 dmapi/src/suite1/cmd/make_rt_sparse.c |   2 +-
 ltp/fsstress.c                        |   2 +-
 tests/btrfs/048                       |  10 +-
 tests/btrfs/048.out                   |  10 +-
 tests/btrfs/187                       | 226 ++++++++++++++++++++++++++++++++++
 tests/btrfs/187.out                   |   3 +
 tests/btrfs/group                     |   1 +
 tests/generic/487                     |   2 +-
 8 files changed, 243 insertions(+), 13 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--vrzQAnlm2pMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcxcQAAAoJECZSqilcj+djEKwP/0/vsRnsflPmQxwr18EVAjB8
32o76m2G8xqwa6Tk+9E0YbH338dF/tJ9Ea57J6nDtvcN82jbhdjL0/NZAt4pQD+e
tNGJTRK+XY3WlUh6a6hYDADVs7B547IC53zdTSQ2izeHaAY/Z63j1s2hK31q/Pnx
w+ozZ/N8qSzVkshJ/mxyUlxMi5/wM2D3dQhEhe9xnuKtn/pKvHF5LkCzZ2Cwl8u8
pRHVUtlbRTjtNE+YNZ586vTbBNpirj1Tm7N4BPzkMOrYqKjXho5ZTKS8CCAIe4Rp
PCT2lN9shQBvtbdR4TBkas2kV02FYpjDJLW4PIwdHscIe4LFpkjnBN7YEPwCrSS/
IAhRm2UZAPl/h+8MbypvosY1KOsPKz5qaSn3FhENfCiLovilSPfDyZKgR/AmP+mU
k6VtAVHtwHyhLs58TIzvButf/V/JP3GW04C53YYL76gT00CZi4Qlt3ptNmif34lP
A0ZvJk8jezVaH3C2IenA4ZIMYgTDrGDoiBH9OCEXXl5JxmSCSRZK6dqDks+lFYhW
b7pXOLv77GfQtg/U+DtUAe6gr3cpPL5n7SmswecQG+DWHV6to3V/8QEapOQJ9cnx
rLE/KoaVFzKVRzs9w5Krc6H8vPmHj9WZbnFrL1QNzfa/2kv5bykA2Zxsgwk7Q7Ii
oP/F2K7ytsgt5q0Rzm7o
=/wAl
-----END PGP SIGNATURE-----

--vrzQAnlm2pMI--
