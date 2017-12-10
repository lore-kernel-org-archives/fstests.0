Received: from mail-pg0-f43.google.com ([74.125.83.43]:44339 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbdLJNXN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Dec 2017 08:23:13 -0500
Received: by mail-pg0-f43.google.com with SMTP id j9so9174230pgc.11
        for <fstests@vger.kernel.org>; Sun, 10 Dec 2017 05:23:13 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id q22sm24042828pfj.94.2017.12.10.05.23.10
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Dec 2017 05:23:11 -0800 (PST)
Message-ID: <5a2d353f.9623620a.50a1f.1088@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 10 Dec 2017 21:23:05 +0800
Subject: [ANNOUNCE] fstests: master branch updated to d79448aefec9
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Tg9nDrLkpZwp"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--Tg9nDrLkpZwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal new tests + bug fixes update. The new
tests are: new generic test for the new DAX MAP_SYNC feature and new btrfs test
for a raid6 bug. Note that for the MAP_SYNC test to run, you need DAX support
in dm-log-writes target (since v4.15-rc1), log_writes command and mmap -S
option support in xfs_io command (xfsprogs patches are under review). The bug
fixes are mostly build warning fixes seen with newer gcc.

New failures I've noticed in this update:
- btrfs/157 fails with v4.15-rc2 kernel

Thanks,
Eryu

The new head of the master branch is commit:

d79448aefec9 build: fix Wlog_Error_String overflow issues

New commits:

Anand Jain (1):
      [9ba09767dd76] btrfs/124: add balance --full-balance option

Liu Bo (1):
      [0920e161034a] btrfs: reproduce a read failure on raid6 setup

Ross Zwisler (5):
      [1475bdd1f7b6] dm-log-writes: only replay log to marks that exist
      [729b2bc7641c] generic: add test for DAX MAP_SYNC support
      [8b71ca416246] build: fix _BSD_SOURCE complier warning
      [ce00907d09db] build: fix TagName overflow issues
      [d79448aefec9] build: fix Wlog_Error_String overflow issues

yang xu (1):
      [bfef1cdccf6b] generic/459: Fix check for ro-remount in extN


Code Diffstat:

 common/btrfs          |  11 +++++
 common/dmlogwrites    |  38 ++++++++++++++++
 lib/write_log.c       |   7 +--
 ltp/doio.c            |   2 +-
 ltp/growfiles.c       |   2 +-
 ltp/iogen.c           |   2 +-
 src/fssum.c           |   1 +
 tests/btrfs/124       |   2 +-
 tests/btrfs/157       | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/157.out   |  10 +++++
 tests/btrfs/group     |   1 +
 tests/generic/459     |   9 ++--
 tests/generic/470     |  83 ++++++++++++++++++++++++++++++++++
 tests/generic/470.out |   2 +
 tests/generic/group   |   1 +
 15 files changed, 282 insertions(+), 10 deletions(-)
--
Eryu Guan
eguan@redhat.com

--Tg9nDrLkpZwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJaLTS3AAoJECZSqilcj+djVZUQAOHPGf2J9ca8hlA/2MCHJDVF
DZ0190sUib+nfk7YJzecZLLbSjh3pM1hzXz/bSQsAnY36xZo2YsI9sgAP/HIQISm
aEYCydbAxXH2vLLOBF4riOB9zSG1zJXY/57Hz3xiS/eSN1DDEEimjURu4mPY9r8e
BkFWM7TNoGvgighhEUJe5iUxgtSYaBz1fkSChZsiaSCPUQGbNaxXyjdrzmQ3tjJi
fAm9tTjxtSYuM+K2rehpFS8QP1PrNSZPhnds0vLSpI7M/rUwOtwJMeJwFFYyD8eO
4LPmC1ZvVhAfM7zdHMghLQn9tiYgVXU2lVjdYMAEEptz4MD0at9U3y4fRr95yP8j
S5mHXcT9YgLn7P6ODzA55Kw7Uesc/yfGAW8L5H3G8Wwh8iEJmITpO6TTpMnv4SY5
IGv6Ut+plTw6Wa37eUOP9UggA2zt/Krq9qLK1qh5zMO/c9z/nGQccDzqzGJHCWDr
l/tcBxvjCeX8Be4K1IkGZzWivjvV6cK4RRWbb9Qm7/xrVjGZz1DSX22fGSCRY3SM
Z5oWlgnX0bYFbQ7ys0PC8U8KIXUcD47immzoQWbo3tsJLAEVnf9OYkSgvjonWq90
D776w+QDPybrwI2lh5cyvjYRLSY68AnqsCwbbjKi0R2FAevgAFdRC3JMSEHUah32
gaJPOLQBgxcvzglzs/R3
=x5Wb
-----END PGP SIGNATURE-----

--Tg9nDrLkpZwp--
