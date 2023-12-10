Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA301C2C2
	for <fstests@vger.kernel.org>; Sun, 10 Dec 2023 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg7+hKHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3703C433C8;
	Sun, 10 Dec 2023 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702216721;
	bh=O4gKwpN0uxWnLUvcGQieotDSZkuTBHVX6w2t3HpC3bk=;
	h=Date:From:To:Subject:From;
	b=gg7+hKHUYrqpiY6ZbMrOk6bWL0NNUIaXnVVxEvxSDRz5thm3L/hWh7QvTwfOkzOMs
	 gHX3P1A5zsktEp1knmbT8kG6Tp7Da+QMm+aA31IZNVGRGBRFSNt3cLpjXkjPQi0w6A
	 Z0nShiW50YAnb9ahhH4gL0FVLUXmtGGaLDHkuJI5H2COrUedBc3rDyj1CaPjK27ahX
	 YjsArfKZJWPquIb7pqUVGZ6t+bh+nf2wUCcOJ00xmFaQDf5amKWz0YZkHL4zaMKSNQ
	 WeYSF0nhIpjptaqnFJyvGYCZQ8PgsfPvhekf6HB6siOUgdLK6UPv720li2Misgg8u8
	 D2b4lQOzwB56w==
Date: Sun, 10 Dec 2023 21:58:38 +0800
Message-ID: <44cd0a3eb3e52ce1116642af0934ead4.Zorro Lang <zlang@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.12.10
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1e21sdI0W5xs"
Content-Disposition: inline


--1e21sdI0W5xs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.12.10 release.

Release Notes:
1) There're 3 new cases -- generic/735, generic/736 and generic/737, they're
all generic cases. There won't crach/hang on old downstream kernel.
2) A xfs specific case is moved to generic, named as generic/734, to supports
   other fs testing.
3) Thanks for Brian Foster helps fstests to work with bcachefs better.
4) More btrfs cases be added into remount or compress (etc) test groups.

More details refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

f814a0d8b89c generic: Add integrity tests with synchronous directio

New commits ([N]ew, [U]pdate, [D]elete):

Alexander Larsson (1):
[U]      [2a4fef036ee7] overlay/026: Fix test expectation for newer kernels

Anand Jain (1):
[U]      [1d7a8c3a4d95] tests/btrfs: add tests to the remount group

Baokun Li (1):
[N]      [b05c808ce4a4] generic: regression test of ext4_lblk_t overflow

Boris Burkov (3):
[U]      [dd50c6276098] btrfs/303: use quota rescan wrapper
[U]      [bd64bed75325] btrfs/301: fix hardcoded subvolids
[U]      [c71b4e620375] btrfs/301: require_no_compress

Brian Foster (1):
[U]      [86f0e4f7c18a] generic/459: improve shutdown/read-only check to accommodate bcachefs

Darrick J. Wong (2):
[D&N]    [65e59370567a] xfs/601: move this to tests/generic
[U]      [19cf4208e749] xfs/604: add missing falloc test

Filipe Manana (3):
[U]      [fac81f816d7c] btrfs: add some tests to the 'compress' group
[U]      [98865122ed3c] btrfs/048: add missing groups 'subvol', 'snapshot' and 'send'
[N]      [ed058f1c6474] generic: test reading a large directory while renaming its files

Josef Bacik (1):
[U]      [72e7d9bfdd8b] fstests: don't test -o norecovery in btrfs/220

Ritesh Harjani (IBM) (2):
[U]      [985df7ef3051] aio-dio-write-verify: Add sync and noverify option
[N]      [f814a0d8b89c] generic: Add integrity tests with synchronous directio

Shiyang Ruan (1):
[U]      [9812168a1255] fsstress: unify verbose output format

Yang Xu (1):
[U]      [95a41c18dd45] generic/733: use correct kernel commit id


Code Diffstat:

 .gitignore                                 |   1 +
 common/overlay                             |  19 ++++
 ltp/fsstress.c                             |   8 +-
 src/Makefile                               |   3 +-
 src/aio-dio-regress/aio-dio-write-verify.c |  29 +++--
 src/readdir-while-renames.c                | 146 ++++++++++++++++++++++++
 tests/btrfs/004                            |   2 +-
 tests/btrfs/005                            |   2 +-
 tests/btrfs/015                            |   2 +-
 tests/btrfs/048                            |   2 +-
 tests/btrfs/052                            |   2 +-
 tests/btrfs/056                            |   2 +-
 tests/btrfs/059                            |   2 +-
 tests/btrfs/094                            |   2 +-
 tests/btrfs/112                            |   2 +-
 tests/btrfs/150                            |   2 +-
 tests/btrfs/163                            |   2 +-
 tests/btrfs/164                            |   2 +-
 tests/btrfs/167                            |   2 +-
 tests/btrfs/173                            |   2 +-
 tests/btrfs/174                            |   2 +-
 tests/btrfs/220                            |   8 +-
 tests/btrfs/233                            |   2 +-
 tests/btrfs/258                            |   2 +-
 tests/btrfs/259                            |   2 +-
 tests/btrfs/263                            |   2 +-
 tests/btrfs/276                            |   2 +-
 tests/btrfs/293                            |   2 +-
 tests/btrfs/301                            | 174 +++++++++++++++++------------
 tests/btrfs/303                            |   2 +-
 tests/generic/459                          |  28 +++--
 tests/generic/733                          |   5 +-
 tests/{xfs/601 => generic/734}             |   3 +-
 tests/{xfs/601.out => generic/734.out}     |   2 +-
 tests/generic/735                          |  54 +++++++++
 tests/generic/735.out                      |   2 +
 tests/generic/736                          |  37 ++++++
 tests/generic/736.out                      |   2 +
 tests/generic/737                          |  54 +++++++++
 tests/generic/737.out                      |  22 ++++
 tests/overlay/026                          |  42 ++++---
 tests/overlay/026.out                      |   2 -
 tests/xfs/604                              |   3 +-
 43 files changed, 551 insertions(+), 137 deletions(-)
--
Zorro Lang
zlang@kernel.org

--1e21sdI0W5xs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmV1w80ACgkQlNbPkfr2
tMzKbhAAn6bi127bh9zXz+5b0NtFN1yJr6TaFeZ2w4fLV3nZaTzI0U2Zbv28HauM
LhWEqVK0Qeo2CBVPeUXkmIctnhYSIeoG7oJKzwoZTb1n44/13SqoPg6yi7DJzfwY
fH8uQFbeFZhZFHMjw/aAU+qGIG85dpuHIm3T+iOE+iJbM5losihyVhaVgpCbo1Yy
sQVYDfxBJd6NahRu9kk3P3i82gl2UnVSEwl1Nh41knM0HR7qsN19LeCovdGRXkLh
H+cUhcTuWYfZjU1a40MwI7IDSf9oUh0SawefNMHxsTJiBS1uR7uzLRaKY40uICh+
IoWcm+f2CLHOs8ShF3kdZxMqvPEnPQ8fs8S5CxhVPYfNj6rMnxXVeBUMFurhFC1+
L80clpr3wWFPd0MpDToffzjUg71+y3rwHEbpkYdqwKlrP9oxgxBnvfc83do+S2nK
L1QE5jwqhhkk4LOO0H2v+khQagXTl39Th3LXGZ8lGYIyInYqu/vSCHsl3XD3kIqK
Xxo5OKVTZVe3sHdmT+rl9tBO4ctqZwtgfIjE68FlrxmPY/M6CSY+1dSEcWCQHOgu
kS/IeyrzgitvoEsepN/O3xxwCrPWwf+W5vVpNaekIuux+xyBk8Y2mDMNxhELIKB1
wtQVoSyYLLzA9tXe8I+wWDN553JRKuTYA8ZQGHE2PZUd1NKafYM=
=bqAm
-----END PGP SIGNATURE-----

--1e21sdI0W5xs--
