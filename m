Received: from mail-pg1-f194.google.com ([209.85.215.194]:46494 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfBXOv5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Feb 2019 09:51:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id 196so3251471pgf.13
        for <fstests@vger.kernel.org>; Sun, 24 Feb 2019 06:51:57 -0800 (PST)
Message-ID: <5c72af8b.1c69fb81.9f4cf.e64a@mx.google.com>
Date: Sun, 24 Feb 2019 22:51:50 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 0680ff2ea531
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CpVy3bFvEBQk"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--CpVy3bFvEBQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly fixes some issues introduced by last
update, there're also some other random fixes and improvements, but no new
tests. Many thanks to those who contributed and/or reviewed patches!

Thanks,
Eryu

The new head of the master branch is commit:

0680ff2ea531 shared/298: Wire btrfs support in get_free_sectors

New commits:

Christoph Hellwig (2):
      [ca513ad171d1] xfs/42[01]: remove from the dedup group
      [6fd9210bc977] fstests: add a seek group

Darrick J. Wong (4):
      [1d32301394c4] xfs/450: require working falloc command
      [e7046479b477] xfs/500: fix reflink support detection and add new groups
      [5fd70db390dd] src/t_open_tmpfiles: flush log when shutting down filesystem
      [23b1f2ccba1d] src/t_attr_corruption: fix xattr.h include problems

Nikolay Borisov (1):
      [0680ff2ea531] shared/298: Wire btrfs support in get_free_sectors

Xiao Yang (1):
      [202779bc0989] src/Makefile: Link clock_gettime(2) with -lrt


Code Diffstat:

 src/Makefile              |   2 +-
 src/parse-dev-tree.awk    |  64 +++++++++++++++++++++
 src/parse-extent-tree.awk | 144 ++++++++++++++++++++++++++++++++++++++++++++++
 src/t_attr_corruption.c   |   2 +-
 src/t_open_tmpfiles.c     |   6 +-
 tests/btrfs/group         |   2 +-
 tests/generic/group       |  12 ++--
 tests/shared/298          |  33 ++++++++++-
 tests/xfs/450             |   1 +
 tests/xfs/500             |   5 +-
 tests/xfs/group           |   6 +-
 11 files changed, 258 insertions(+), 19 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--CpVy3bFvEBQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJccqy6AAoJECZSqilcj+djulIP/3yUDrD4GNbz888nifLCyK3H
6RcAuHJtuQOtaFwmCNJQzK3Ei1RToSR4n199b4j//6XTBiitkFi6lGtBRHeWlguE
2As+8XmPq9Vgfh9v9gYm8MJqagfoAeEjgtP/X/hv/t8lXxDn75ou+dkB7fEETwA7
EaMxeB2CDcjd4T+9SrVp9VAWYcAJhjfp9CHugUWDRzDufLUKBDtUwcwCS5ZIGczs
zhCN1e7bNGOOIP3EDZ4MED5yuukyYIINi1O3MtIYI+ipPzvkd5KOVjjHd/XjWAzu
zcbQZDrSzMGtcmISRAJIDfYE/M8duGr1EOx4divA5UqUNcpHEZGG22PFcYj9zDAI
UuYWjQUZMZuxAaHZAVenlfd8sQVhemYj6RI70s2Hc8y1RB444vaqiBzJDSludYPm
uEutR5PGDRks8kmFQRUtfcteSVJjcYi7tZIzwdet9kaaEe9+uwNgmHS0l3ueVA48
ohUSPqsTVWAfQD4rr2tVS4dyQViaNDdOn6V5Np1iSezMnE673X1+jml/ucDfwRnS
p0FgDSMkdB8mEMglIHJz3jcCRPg/RvunmLXGwhRXP4ftFsudxz5xYljtlemKvYh4
W/1NOrmpeIdZ3/sjJNsggvJpMR+ZDyO1IouKIJ/esLBXHsB882TM4muTiL+cWFrW
1Ydu5NIsC4kCEpzzWVNH
=JPRw
-----END PGP SIGNATURE-----

--CpVy3bFvEBQk--
