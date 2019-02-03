Received: from mail-pl1-f175.google.com ([209.85.214.175]:44825 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfBCMur (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Feb 2019 07:50:47 -0500
Received: by mail-pl1-f175.google.com with SMTP id p4so2250497plq.11
        for <fstests@vger.kernel.org>; Sun, 03 Feb 2019 04:50:47 -0800 (PST)
Message-ID: <5c56e3a5.1c69fb81.40a19.61e3@mx.google.com>
Date: Sun, 03 Feb 2019 20:50:40 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 6d17c9076fe9
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KOvMagNcLZ8d"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--KOvMagNcLZ8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. We have new btrfs tests and bug fixes for overlay & xfs
tests in this update. Note that currently the three new btrfs tests
(btrfs/18[012]) all fail with latest RC kernel (v5.0-rc4).

I'll be on public holiday next week, so the response and review might be slow,
but I'll do check emails from time to time, and hopefully I can do another
update next Sunday as usual :)

Thanks,
Eryu

The new head of the master branch is commit:

6d17c9076fe9 common/dump: do not override test cleanup trap

New commits:

Amir Goldstein (2):
      [43c35280910e] overlay/061: enhance mmap ro/rw inconsistencies test
      [6d17c9076fe9] common/dump: do not override test cleanup trap

Darrick J. Wong (2):
      [141c0f5a9a20] xfs/093: make sure the scratch directory still exists after repair
      [f479ce6186d0] xfs/138: format the scratch device before using it

Qu Wenruo (3):
      [04e1a5e0678b] btrfs: Test if btrfs hits EDQUOT without trying to reclaim some space
      [3bea049648f8] btrfs: Test if btrfs will commit too many transactions for balance
      [7f3a0bf60d6e] btrfs: Test if btrfs will report false ENOSPC error balancing small metadata chunk

Vivek Goyal (1):
      [ebc6c083d3bc] overlay: Do not lose security.capability xattr over metadata only file copy-up


Code Diffstat:

 common/dump           |   6 +--
 tests/btrfs/180       |  62 +++++++++++++++++++++++++++++++
 tests/btrfs/180.out   |   3 ++
 tests/btrfs/181       | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/181.out   |   2 +
 tests/btrfs/182       |  61 ++++++++++++++++++++++++++++++
 tests/btrfs/182.out   |   2 +
 tests/btrfs/group     |   3 ++
 tests/overlay/061     |  36 ++++++++++++++----
 tests/overlay/061.out |   4 +-
 tests/overlay/064     |  22 ++++++++---
 tests/overlay/064.out |   3 +-
 tests/xfs/022         |   9 ++++-
 tests/xfs/023         |   9 ++++-
 tests/xfs/024         |   9 ++++-
 tests/xfs/025         |   9 ++++-
 tests/xfs/026         |   9 ++++-
 tests/xfs/027         |   9 ++++-
 tests/xfs/028         |   9 ++++-
 tests/xfs/035         |   9 ++++-
 tests/xfs/036         |   9 ++++-
 tests/xfs/037         |   9 ++++-
 tests/xfs/038         |   9 ++++-
 tests/xfs/039         |   9 ++++-
 tests/xfs/043         |   9 ++++-
 tests/xfs/046         |   9 ++++-
 tests/xfs/047         |   9 ++++-
 tests/xfs/055         |   9 ++++-
 tests/xfs/056         |   9 ++++-
 tests/xfs/059         |   9 ++++-
 tests/xfs/060         |   9 ++++-
 tests/xfs/061         |   9 ++++-
 tests/xfs/063         |   9 ++++-
 tests/xfs/064         |   9 ++++-
 tests/xfs/065         |   9 ++++-
 tests/xfs/066         |   1 +
 tests/xfs/068         |   9 ++++-
 tests/xfs/093         |   3 ++
 tests/xfs/138         |   1 +
 tests/xfs/266         |   9 ++++-
 tests/xfs/267         |   9 ++++-
 tests/xfs/268         |   9 ++++-
 tests/xfs/281         |   9 ++++-
 tests/xfs/282         |   9 ++++-
 tests/xfs/283         |   9 ++++-
 tests/xfs/287         |   2 +-
 tests/xfs/296         |   1 +
 tests/xfs/301         |   1 +
 tests/xfs/302         |   1 +
 49 files changed, 534 insertions(+), 51 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--KOvMagNcLZ8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcVuNVAAoJECZSqilcj+djbzUQAN1bkqVlg51PuxkzTgpmh0Ab
eo9tTlRDO/7pURA9J6VC8GVo1+yeNJMNLyQssVErvQvc24QyYz8eyYegqkWmlkuH
EQHdqWLnrCDbrreyMpVPOMFn25NuilmtIxOu8DPyQl1Eg7dema+2/4WsMDwx4RyP
ZNgk//cxM0D4tDeIx8MIGa9Kk3iusQrH/iKNC8uga2S8CaOqihIehUg2a3zf7Cus
lJ3gFGJSbcy7dcN3eMZ3jGlANSeKeD5Rkqbm0NXDz9VKNYORgTgYahYm5oYsTQ42
VxQRJRNdISDpAiQXH7diCagi153HF4siDXVNOtGRlAHso5DGSjvkXyoRbx7A0JlR
Z87NONNWWdOmOjK4ADB6pGleTub5oXS//4SRbnBIDwPrFqE+XtpSrqTiedcbLxoK
D0BkZZLytDzyS7Xo5tz2kzvnFt8s89F6MGmz7or+fChiZdEwHlVvImct66rHg9X0
8RhWBTHiPcTzRJQiUbTZT3wCGPjX5nKNyC34R+KiXKpSKfAsuM/pRO7A7NCOBIRr
5dDKRztxhamOsx4J8MU76ShUqEjPFSF3AMTeLNLj1p17VLf/ImAurbBLbibl5beh
uypLctGHX7gWOFjuaEjHEem7/fumPmBIqJr7C61OlqaRrrzhdlhQnNrrG1pwqveO
SLF1rI5rwvHao9Q5PBSK
=k0OD
-----END PGP SIGNATURE-----

--KOvMagNcLZ8d--
