Received: from mail-pg1-f181.google.com ([209.85.215.181]:46651 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfAMP0H (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Jan 2019 10:26:07 -0500
Received: by mail-pg1-f181.google.com with SMTP id w7so8370770pgp.13
        for <fstests@vger.kernel.org>; Sun, 13 Jan 2019 07:26:07 -0800 (PST)
Message-ID: <5c3b588d.1c69fb81.7265a.0775@mx.google.com>
Date: Sun, 13 Jan 2019 23:25:58 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 8fc1e7c157fb
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xnDbiE5hvy2Q"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--xnDbiE5hvy2Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal new test & bug fix update. The new
generic/523 test fails with XFS due to a xfs_repair bug, and btrfs/179
currently hangs the kernel.

Thanks,
Eryu

The new head of the master branch is commit:

8fc1e7c157fb btrfs: test for deadlock between snapshot delete and other read-write operations

New commits:

Cui Yue (1):
      [50076fc291e3] generic/423: statx mask of the reference file is different from the original file

Darrick J. Wong (1):
      [e492e5157df8] generic: test that xattrs can have slashes in their names

Qu Wenruo (2):
      [a4235f29f780] btrfs: Make seed device test cases into their own group
      [8fc1e7c157fb] btrfs: test for deadlock between snapshot delete and other read-write operations


Code Diffstat:

 src/stat_test.c       |   8 ++--
 tests/btrfs/179       | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/179.out   |   2 +
 tests/btrfs/group     |   7 +--
 tests/generic/523     |  50 ++++++++++++++++++++++
 tests/generic/523.out |   6 +++
 tests/generic/group   |   1 +
 7 files changed, 182 insertions(+), 8 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--xnDbiE5hvy2Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcO1gDAAoJECZSqilcj+djUpcQAJPsVG0EaSaczmEs41j3Uq+R
XlsA+CUxIrlGSlkqk5wHDG0lbAeymmgsyfxV3eigZl6GVlc+ZUUEr7wABXerVrwK
DEm6AHsoIvhe9kr/Mt52MOZ5SS5g4u9Z4Api/TnnQgQaQ2oc7BRy2b+o+A2e42uB
b0wq7iYwfq4YNzSNlOhA1Q2ji9iUB8opgCLSk9JxIkVfDg1xo3haBRuhGzwMaQcY
3QWC1lfpL5REtikWjnVxeda/FoMgQmYN/idTckHpq/Vu14ddrFZznX7I+A8VcbL9
ULCp1OLX/MSmWRWTHBoBoV2Te/kGb1+panlY3UPlsTBRhsQqcXrpvLTuU+TTcJ5G
jK8jwUGoNSw2L98VjZ+ZY/yF5fLjazoobgxSwNzQXdyu4l5fHfW60ZC8OyLAhn98
h4J+uCTrM1iHMLnj3USRulBBrY14nceyjq+ZkVXznJ9DDL0Uh1UwOhwHnRrzG16u
aVPl744fuy8KC18pg1ggebRgqQpQfu4Bmra5pg9YFXav1q2IDV8s9hZQNcOu5qnL
VaaiVxfqNrO8sS6wRhjHvR/R7RGiGhlnz8U8ZbkvHqzOJM3z50IgqaFSzgtoTlml
VbLrXQRfF83n/YXLVmwlguoYLlYYeViggZUqxVn/o/zbUMBEK6Vc92EOymLdJwko
hnRCZd0qGd/jG7Xj7J1B
=PzMi
-----END PGP SIGNATURE-----

--xnDbiE5hvy2Q--
