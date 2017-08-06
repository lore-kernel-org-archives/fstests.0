Received: from mail-pf0-f193.google.com ([209.85.192.193]:33293 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdHFIxj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Aug 2017 04:53:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id c65so6108726pfl.0
        for <fstests@vger.kernel.org>; Sun, 06 Aug 2017 01:53:39 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id p62sm3669614pfd.108.2017.08.06.01.53.37
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Aug 2017 01:53:38 -0700 (PDT)
Message-ID: <5986d912.4195620a.9b08e.85bf@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 06 Aug 2017 16:53:33 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 81aa85deac1f
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Ivm3J2timy5i"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--Ivm3J2timy5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Except the new ext4 fsmap tests, this is mainly a
bugfix update, several minor bugfixes and small improvements are included.
Many thanks to all the contributors and reviewers, especially Brian Foster, who
has helped review many new tests and bugfixes!

One note on generic/449, which is a new test from last update, one improvement
to generic/449 makes it start to fail on XFS (it was _notrun previously).
Usually we don't introduce such 'regression' to existing tests, but this is a
pretty new test and has been there for only one week, I think it's fine to
incorporate the fix to generic/449 instead of making a new test.

New failures I've noticed in this update:
- generic/449 starts to fail on XFS, which was a _notrun previously, see above
  for notes on it

Thanks,
Eryu

The new head of the master branch is commit:

81aa85deac1f fstests: remove tmp files properly

New commits:

Darrick J. Wong (2):
      [93d6007671f5] xfs: only run scrub in dry run mode
      [fed90418a77e] ext4: fsmap tests

Eric Biggers (1):
      [85e3bf85c67c] src: include <sys/sysmacros.h> for major() and minor()

Ernesto A. Fernández (1):
      [6cce8575a5d5] generic/449: make the test effective against xfs

Eryu Guan (5):
      [9c129c6887eb] new: validate groups when creating new test
      [505cb261e0fb] generic/224: filter out expected XFS warnings for mixed direct/buffer I/O
      [9b897c805550] common/xfs: add iomap_dio_actor() to the dmesg filter
      [ce4616c88899] fstests: batch update of test file mode
      [81aa85deac1f] fstests: remove tmp files properly


Code Diffstat:

 common/rc          | 25 +++++++++++-------
 common/xfs         | 10 ++++---
 new                | 14 ++++++++--
 src/fssum.c        |  1 +
 src/stat_test.c    |  1 +
 tests/ext4/027     | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/027.out |  7 +++++
 tests/ext4/028     | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/028.out |  3 +++
 tests/ext4/029     | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/029.out |  4 +++
 tests/ext4/group   |  5 +++-
 tests/generic/100  |  2 +-
 tests/generic/224  | 11 +++++++-
 tests/generic/260  |  2 +-
 tests/generic/340  |  0
 tests/generic/341  |  0
 tests/generic/342  |  0
 tests/generic/344  |  0
 tests/generic/345  |  0
 tests/generic/346  |  0
 tests/generic/354  |  0
 tests/generic/408  |  0
 tests/generic/449  |  8 +++++-
 24 files changed, 279 insertions(+), 21 deletions(-)
--
Eryu Guan
eguan@redhat.com

--Ivm3J2timy5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZhtffAAoJECZSqilcj+djry8P/AnYwR2ZQpk638w6K5++F+q5
SZzmA685AHtWhw9/hOtFp3EcrIHgRxR90C4zcTfmNQ0F75uW8/KWdSzJzbGJgW0B
ed+UUM6vNRV5fRJQO7QBCp4gACRyhmL+kdGyh67Xx94h0qeizMg6BNLSYPWbohbF
pDwtdFIbkCna7osi43ol0KgmRa51YnCd/xG3FK4Ve0UFPnaSQ3GL3XpGDiH6pymX
aEhai5EMw42qaQslZ7QoveF/hkUjjI6xBZh3cgFj2qP7SygvNblMy6AoZRZElKGN
3ZZxgWNo4qjpoNEydhisuCpaZ5TQrh7WjhzKd18H/+Y5Wre6dz7L+hBVuWwCB6iY
UBV2jnnmjgEXKpJqcFScbD8B7pZEvmPaFLFWUnznRR/CW0xiaz+X+AyGvyP3gv15
+Yjvn/EsJwUz2n6hx/DI0xSU/wGHTWuZBFsS/hsG5px76f290Dav9MmV8nT6g076
g6wvkWfsa9edrzxwUzQ3nXKJyDZL3W9EmRv8/LFSHcAHLqjSAablbkkwXDHP/wdR
3zapN66rQYJdVBAQXR9NVx8lnRoOfxB2VdZUCb/fZW2ae1Oks6lHseBy//3scfNy
DcDtgodnBlxtCq7Hue3PeT1fp698cTKi27KkkYMWd8QvHDVovhpIBQiQwckZnzFe
L+ZSN3oyxxqH7aCdoIPr
=u1hS
-----END PGP SIGNATURE-----

--Ivm3J2timy5i--
