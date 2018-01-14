Received: from mail-pl0-f48.google.com ([209.85.160.48]:40593 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeANPmA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Jan 2018 10:42:00 -0500
Received: by mail-pl0-f48.google.com with SMTP id 62so2012354pld.7
        for <fstests@vger.kernel.org>; Sun, 14 Jan 2018 07:42:00 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id z9sm10588530pgc.5.2018.01.14.07.41.56
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Jan 2018 07:41:58 -0800 (PST)
Message-ID: <5a5b7a46.097e630a.f6df2.94c0@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 14 Jan 2018 23:41:49 +0800
Subject: [ANNOUNCE] fstests: master branch updated to ee55ddd38f01
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eNb3w1vWlibc"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--eNb3w1vWlibc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. One notable change is that we're getting 9pfs support
in fstests, thanks to Toumas Tynkkynen! Other updates are normal new tests and
bug fixes/improvements patches.

I didn't notice any new failures introduced by this update.

Thanks,
Eryu

The new head of the master branch is commit:

ee55ddd38f01 fstests: Add 9p network filesystem support

New commits:

Chengguang Xu (1):
      [dbb857f8d17c] common/rc: perform _require_metadata_journaling check on overlay base fs

Darrick J. Wong (1):
      [dc325ce8cafd] xfs: find libxfs api violations

Eric Whitney (1):
      [2931de473cc1] common/rc: ext4 doesn't support O_DIRECT with data journaling

Hou Tao (4):
      [976c9ca6561c] dmflakey: support multiple dm targets for a dm-flakey device
      [b237e01b1288] dmflakey: support error_writes feature for dm-flakey
      [20cb5f11991c] common/rc: factor out _scratch_xfs_[get|set]_sb_field
      [8f20e80747d9] xfs: test for umount hang caused by the pending dquota log item in AIL

Nikolay Borisov (1):
      [97575acd7495] generic/015: Change the test filesystem size to 101mb

Qu Wenruo (1):
      [3651c38e0b9c] filter: Introduce filter to filter out offset for xfs_io

Tuomas Tynkkynen (1):
      [ee55ddd38f01] fstests: Add 9p network filesystem support


Code Diffstat:

 check               |   2 +
 common/attr         |   4 +-
 common/config       |   9 +++
 common/dmflakey     |  31 +++++++++-
 common/filter       |  10 ++-
 common/fuzzy        |  33 ----------
 common/rc           |  46 +++++++++++++-
 common/xfs          |  47 ++++++++++++++
 tests/btrfs/140     |   9 ++-
 tests/btrfs/140.out |  70 ++++++++++-----------
 tests/btrfs/141     |   9 ++-
 tests/btrfs/141.out |  70 ++++++++++-----------
 tests/btrfs/142     |   9 ++-
 tests/btrfs/142.out |  70 ++++++++++-----------
 tests/btrfs/143     |   9 ++-
 tests/btrfs/143.out |  70 ++++++++++-----------
 tests/generic/015   |   6 +-
 tests/xfs/007       |   6 +-
 tests/xfs/098       |   4 +-
 tests/xfs/186       |   3 +-
 tests/xfs/199       |  13 ++--
 tests/xfs/307       |  11 +---
 tests/xfs/308       |  11 +---
 tests/xfs/339       |   6 +-
 tests/xfs/340       |   2 +-
 tests/xfs/437       |  56 +++++++++++++++++
 tests/xfs/437.out   |   2 +
 tests/xfs/438       | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/438.out   |   2 +
 tests/xfs/group     |   2 +
 30 files changed, 564 insertions(+), 232 deletions(-)
--
Eryu Guan
eguan@redhat.com

--eNb3w1vWlibc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJaW3nSAAoJECZSqilcj+djTg0P/j1Q1Rn4AOfBotg6fIKYOTnu
ixIpj3Zm7WA3KKpVkMlQZUhnPWLE4X1y/OFbAo5Jec2s7tg8Gt+2hv75QilzVF7g
EWiXT1mVul0uAQhxfGqZD4AKlopRtY5NVBydjos7c3Tlam2hc3agA1CQGtm4S0Ie
YbKnZqaqSikBg2kB+00AnifEUjtCYaxRIPTMZ9C4URfEfEJ5VEGZLjBBv320qAea
umtQEaQ39S1508BnLkV5lhx8ifyUZcrLU3Ohd2rMyrZMY/yz2yXiL0bDAvPGbYh+
BcLHgclQAHQglIe00TcJuzjm+WeTHPiQIYPcfCrogAymXS9zbmUh4JkmXZMhOqWQ
R3nDo+FJaEjwQdzpOFly9rTS4ebvbAq2H6d/2a9px8iKPZAN4duBJEzaKD0ifQBN
os6BVBhbr8ev9Bux8Q3BgUqSkRlap96iHK96IR1TBSrAd8KLQwhmXJ8Tt6eQ18ab
0UmauobHtoRIU6K0ecRxkgIslzvW4yK6NrJJp5xpOgyoVqyxsO6Z7Taoil7iByaI
N+bXt3hEv5bOX0pgQ9xZ6O+0cOb6xQpnYXkfyQ8WsjNA7S0T8iC1jyEkiSEvmtbc
FLUmXMFGoCOwkwcmrgFTaPCdYu1orkPd4Fddj61EOUrbuDsEAmbhGo+V1iGkLvaQ
CuZi7m5+UeaHG/O1z1z5
=mLUy
-----END PGP SIGNATURE-----

--eNb3w1vWlibc--
