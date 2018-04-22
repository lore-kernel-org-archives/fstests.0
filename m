Received: from mail-pf0-f171.google.com ([209.85.192.171]:45295 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeDVLC1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Apr 2018 07:02:27 -0400
Received: by mail-pf0-f171.google.com with SMTP id l27so6918360pfk.12
        for <fstests@vger.kernel.org>; Sun, 22 Apr 2018 04:02:27 -0700 (PDT)
Message-ID: <5adc6bc1.08ab630a.5bafa.5782@mx.google.com>
Date: Sun, 22 Apr 2018 19:02:21 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to d4da414a9a9d
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MD3NlciDkg90"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--MD3NlciDkg90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is mainly a bug-fix update, with one new test for
btrfs. Thanks a lot to those who contributed and helped review patches!

I was travelling in the last two weeks, so there're some review backlogs. I'll
try to catch up in the next week, and I really appreciate if fs-specific
tests/patches could be reviewed by the corresponding fs community.

I didn't notice any new failure introduced by this update when testing with
v4.17-rc1 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

d4da414a9a9d common/rc: raise btrfs mixed mode threshold to 1GB

New commits:

Darrick J. Wong (1):
      [a738e04549ab] generic/304: only dedupe the last 64k of the single byte file

Filipe Manana (1):
      [9302f745791e] btrfs: fsync after hole punching with no-holes mode

Miklos Szeredi (2):
      [c0ae9162cac7] overlay/040: clean up properly after setting immutable
      [792514c38480] overlay/013: do not expect failure

Omar Sandoval (2):
      [fdd096c9499a] src/aio-dio-eof-race: handle aio pwrite errors and short reads
      [d4da414a9a9d] common/rc: raise btrfs mixed mode threshold to 1GB

yang xu (1):
      [7ed53b9342ae] common/xfs: Add require_xfs_db_write_array function


Code Diffstat:

 common/rc                              |   2 +-
 common/xfs                             |  20 ++++++
 src/aio-dio-regress/aio-dio-eof-race.c |  22 ++++++-
 src/t_truncate_self.c                  |   3 +
 tests/btrfs/159                        | 115 +++++++++++++++++++++++++++++++++
 tests/btrfs/159.out                    |   9 +++
 tests/btrfs/group                      |   1 +
 tests/generic/304                      |   2 +-
 tests/overlay/013                      |   3 +-
 tests/overlay/013.out                  |   2 +-
 tests/overlay/040                      |   4 +-
 tests/xfs/444                          |   1 +
 12 files changed, 178 insertions(+), 6 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--MD3NlciDkg90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJa3Gs2AAoJECZSqilcj+djW2QQAN+qARojRl0dBuKFMdSEenWV
3ft2eOwdtdVNAHeTFVTSZ9KeIxHjyFNiqZ77j/+z5qNWfoktap2Tpa/wil7TVv8w
QsIAIFdfGpq3ngfBo94gFeRoQ9WrZTyLnevPRkyH7H+eC/I9vWBG34IFrpQPrqfJ
OzJLUWkPWTlDQaUCvRI/PbFXfvYgJGfflyOdJRYiUY/9NEr1sXBJR3c7f9B20eZP
/jtwjAsBDYBmwGy6YxZTq48/sKyko/xwtcc/bZXUA98jAqx0X5N1T0apX6gV7TiT
C7q/zm/aiYjNMK84GgPIj7/6kzsRwH+bLuAaCokAxuOc4au9luGPTO9ZTKW4Kenu
2sOW6WA9KuZiSwWt+kfixt1/bCkBnKsBpieLuh3O1gHUelrPSN0ua9o8xfiHf7jz
wppS0iU7/2YkFHM5jFcWnDe2PmUb+/aH46lJtmZbvXluZAatbCqCNwH/Z6K1nJw+
pW3u2bNoq/IZs3oCPFilWcmCCBZmhG8wtVTTt/V6YavwK8pbA8ezXjFJifDgBVkd
Rt9x1nTpBLEim55OuERyhCYHWx8W1vadN40buvaFbqBXght/vx31xf1lnNxxwanI
AkHXU/xUIDUo0Dw36JDei6suwobxoF2pmOC40xLmKgcEONxG+wVPNZU9+gYCptK3
NqrQ3vi6befv5QMHTbpK
=d111
-----END PGP SIGNATURE-----

--MD3NlciDkg90--
