Received: from mail-pf1-f196.google.com ([209.85.210.196]:36616 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeHEQTs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Aug 2018 12:19:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so5564391pfo.3
        for <fstests@vger.kernel.org>; Sun, 05 Aug 2018 07:15:04 -0700 (PDT)
Message-ID: <5b670667.1c69fb81.5d828.b965@mx.google.com>
Date: Sun, 05 Aug 2018 22:14:57 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 3a64a884c440
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TTbpG4Qfp1u3"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--TTbpG4Qfp1u3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update is focusing on xfs and btrfs, each has a
new case and a bug fix. Many thanks to contributors and reviewers!

New failure I've noticed in this update:
- btrfs/169 fails on current Linus tree

Thanks,
Eryu

The new head of the master branch is commit:

3a64a884c440 xfs: test inode allocation state missmatch corruption

New commits:

Filipe Manana (1):
      [df949b94f055] btrfs: test send with prealloc extent beyond EOF and hole punching

Misono Tomohiro (1):
      [631dd76a3148] btrfs/057: Update test case to keep subvolume in any kernel version

Zorro Lang (2):
      [c911bcb568a9] xfs/288: use -d option of xfs_db write command for v5 XFS
      [3a64a884c440] xfs: test inode allocation state missmatch corruption


Code Diffstat:

 tests/btrfs/057     |   5 ++-
 tests/btrfs/169     |  83 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/169.out |  13 ++++++
 tests/btrfs/group   |   1 +
 tests/xfs/288       |   5 +--
 tests/xfs/490       | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/490.out   |   2 +
 tests/xfs/group     |   1 +
 8 files changed, 218 insertions(+), 5 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--TTbpG4Qfp1u3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbZwYQAAoJECZSqilcj+djhLAP/j5lyEnU+C9VTZLJpIxBqSo5
RQnrXOwimo+GN2E3PSqDHjsrlLPOk0F2mclK9KA4O8AwWhmlVjRznGq8/EiNe+RG
aZS48sW0oP37EK7FmedsEvyXQMSXb6eTWuBF0rmjkgnN4zphPRbuoNxCQDc+H86l
KVHgkZfnQFfNDDHYQCCUpMyxb31qCt//juELlRVTgr0FFmRQl9t8fAl/XhMJhrCL
+2PsHLk5VNabhgRUUzyuxiJvwzn1zgJDgpvq2cFLmz2oxz95xuQOHR60ERuLu61i
6XY2LQKBP0cw7d4EHt1VZD2aY/xKpMoRj5g57PbgmA80hl4BoOunDjmaNYQ9jfWV
TCyqck8AcT7kjFwK8FHLznCr5+1fvq9eOoYua0xps7Ech77gJr7jjghCC2nzRwKp
7/Klda8tXFpOdWmULnAxbyskA79FtuwZ9yp6XV9G83cI7VSgEqwecIL7HeC6UOYr
M7sea1GHemjSD8qE+tE+jco1UT8qXb8VZrs/vaEndr9gxZYJ8PX+0dvWMldNlldi
mkYCAquvv9BfihJOKKxCYvzgRxgKbt7TVsOuCQHh/YvQMM60eGEU3spRb2WaDzBN
STdkkJ6gqUC/hPUojUDQbxslcEgfJviykbnzK7cbHy3otagnY+5ZrufJP8M2W/ft
LngpNXvth/Zo6vbEFs5z
=54iX
-----END PGP SIGNATURE-----

--TTbpG4Qfp1u3--
