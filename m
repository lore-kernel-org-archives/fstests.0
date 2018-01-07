Received: from mail-pf0-f176.google.com ([209.85.192.176]:43269 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753452AbeAGP7G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Jan 2018 10:59:06 -0500
Received: by mail-pf0-f176.google.com with SMTP id e3so4258257pfi.10
        for <fstests@vger.kernel.org>; Sun, 07 Jan 2018 07:59:06 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id t4sm25292689pfj.56.2018.01.07.07.59.04
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jan 2018 07:59:05 -0800 (PST)
Message-ID: <5a5243c9.8467620a.10c7f.cc40@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 07 Jan 2018 23:58:58 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 95c924c65113
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eMvz7ftlHJzD"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--eMvz7ftlHJzD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. clonerange and deduperange operations are added to
fsstress in this update, so we get more test coverage on FICLONERANGE and
FIDEDUPERANGE syscalls. Two new tests that run fsstress are added too, one runs
fsstress on dmerror device to simulate disk falures and another runs fsstress
in write-only mode. We also have two new ext4 regression tests on DAX mount,
and a new btrfs test on raid6 scrub code.

New failures I've noticed in this update:
- generic/475 sometimes fails on ext4, I saw ext4 corruption after test (around
  20% reproducibility)
- generic/232 fails post-test fsck on reflink enabled XFS, I guess it has
  something to do with the new clonerange and deduperange operations
- generic/083, generic/269 and generic/270 would hang (soft lockup) on reflink
  enabled XFS, they all exercise behavior near ENOSPC, and generic/269 would
  hit the soft lockup more easily
- btrfs/158 fails on btrfs, the fixes are referenced in the test

Perhaps there're other failures that're caused by the new clone and dedupe
operations in fsstress, please report and/or contribute patches if you think
that's a case bug that needs fix.

Thanks,
Eryu

The new head of the master branch is commit:

95c924c65113 ext4: test for inline data + DAX corruption

New commits:

Darrick J. Wong (4):
      [ce02f1b2f8ed] generic: test error shutdown while stressing filesystem
      [e76e13ce8c0b] fsstress: implement the clonerange/deduperange ioctls
      [3b1382f992bf] generic: run a long-soak write-only fsstress test
      [451504891031] xfs/068: fix clonerange problems in file/dir count output

Liu Bo (1):
      [70138c383bf5] btrfs: make sure scrub fixes raid6 corruption

Luis Henriques (1):
      [ebe1aa88a197] generic/050: fix _require_local_device $SCRATCH_DEV check order

Ross Zwisler (2):
      [750a24e99e48] ext4: test for DAX + journaling corruption
      [95c924c65113] ext4: test for inline data + DAX corruption


Code Diffstat:

 .gitignore                          |   2 +
 common/dump                         |  11 +
 ltp/fsstress.c                      | 391 ++++++++++++++++++++++++++++++++++++
 src/Makefile                        |   3 +-
 src/t_ext4_dax_inline_corruption.c  |  70 +++++++
 src/t_ext4_dax_journal_corruption.c | 102 ++++++++++
 tests/btrfs/158                     | 114 +++++++++++
 tests/btrfs/158.out                 |  10 +
 tests/btrfs/group                   |   1 +
 tests/ext4/030                      |  74 +++++++
 tests/ext4/030.out                  |   2 +
 tests/ext4/031                      |  86 ++++++++
 tests/ext4/031.out                  |   2 +
 tests/ext4/group                    |   2 +
 tests/generic/050                   |   2 +-
 tests/generic/475                   |  97 +++++++++
 tests/generic/475.out               |   2 +
 tests/generic/476                   |  64 ++++++
 tests/generic/476.out               |   2 +
 tests/generic/group                 |   2 +
 20 files changed, 1037 insertions(+), 2 deletions(-)
--
Eryu Guan
eguan@redhat.com

--eMvz7ftlHJzD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJaUkNCAAoJECZSqilcj+djM5AP/08gAZqrCe9gzglLyXigyOuU
/PlC9rc70xx0G8qU6YjLiKLQWkti6I8qSjbmvRyZwaAY58yznf9YT6Kmf0eZApMY
WuPPFt8/VsWv8KsTsJIEPLBn1YygN4Zp9NRwO8LVAiyKlnHxOFVuwmwKV8jekvWe
I8xsuuqZKRga7aLgzbr7DJQhlvEozAewTXRSlXoB4Zn6BELqTpd9HHiVtpE6nWGL
gwKpnf/o+oFU5SqzW6/IUXwlNWbvGsIXwOHcSJubAIBVBKE17eYXMXnjdaiDgPAh
HLXFtUyb7lWBgTttTt86r1ulDDmGzPwLHop5Yb85NfAIgGz4ySPM4a5ClnOP1jsK
Q4A0ddDhsPdQfmjRQwbPTW9HHnLQdB5BvC3yH0HQ/p4K/7ZK5vQCYHwXdqzbsDKd
qoHcrF7Jkt6RlLzeHRKgZR8xkg5+y3W+uw21GDt0bdCVfrEewj7eJuHC0DIjWRvC
UWSmbRgGQ7C7Sli90zEPk7CrQ8bfinH/Os/wjITgwKtX7Uu8y6QSlbbrUBqmXoRA
Bh4ylXJWAoouaBfhhRsm1DYIp9P3rPKt80kNBq/brhnAR8d4+76Ic7SCgWFnZZPz
KVdF+6SlXrrQG/19cxnBaehymlI+wZm2FRjKouEHN9Ujf7182z+f+VD5N8ivpHRM
6JW6UGn623lbkqy4Ntjc
=UV6x
-----END PGP SIGNATURE-----

--eMvz7ftlHJzD--
