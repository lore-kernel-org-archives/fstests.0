Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520AC5C5EE
	for <fstests@vger.kernel.org>; Sun, 14 Apr 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103655; cv=none; b=pviZ2RAbOsZ+Q/bmgzq8Eh+YWAMoR4Q8u86mtAYjHt2QgStJCUFwQhYub4kx+R//f1kEjv7Z09AVCjweU++HvRjpWzzZcqSsp9HN5jq1wklQcm7hHLeq7/FPyhv1aefonG0NSOPZtQo/CToj/ZH/6eOK8d5FxDGXqgx5xcYCGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103655; c=relaxed/simple;
	bh=Z9rE2itwBfCVaSbSjeCZpbZnpFLoHwPnAHZXSuoP9mk=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=GEHonPoEKj1ahwh4rRDHD+ban91ilvzHnibHW1QnaVk1tditSUEaqmBUdXNiRmH4HoWoT7MCciFlqj0+JFPR9lpUTv0yoYx15uiXuQptlY37cHQwzdHlEQIIEZkCYF0imY1XXmBiHDwaqpcceAonRpcNVNd9IftqGmMmWK/N8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSjftq9G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSjftq9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD53C072AA;
	Sun, 14 Apr 2024 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713103654;
	bh=Z9rE2itwBfCVaSbSjeCZpbZnpFLoHwPnAHZXSuoP9mk=;
	h=Date:From:To:Subject:From;
	b=aSjftq9GajcYE39T/NzzuH7Dnukt4X1O37NGsPGX1uDttDug9PO7ClS56vf4f2kDW
	 8q8wmXtn3F9BeUz/i9mYBNWDzVKyEcfSJHJ33arWmWJkRDmV+bKlZNX0iGWOMzuki8
	 ysacohA4aAVdsg5RYoE9k+EM1fpdjQUtzWHRbOCy/cy/8FB+XyQLk3rYE7OadiiMF3
	 FiYas0hTXm9NJ3Aqxb4V3w5XXOGz7OeU2dw3uyUxpxh0BYuXxwxnCOjm6c7q3B08+z
	 BhJHt/ovN2f9BCW43fwknWkcLPvmhTCif5TaWHX9tDpUZTLljcMDkTApSfOrl1Q6BD
	 UitMnsWc7tj9w==
Date: Sun, 14 Apr 2024 22:07:31 +0800
Message-ID: <b5b40b87d8650d86cd56d32bf5c1632a@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.04.14
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4fdtsIZb1t58"
Content-Disposition: inline


--4fdtsIZb1t58
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.04.14 release.

Release Notes:
1) There's not new test case in this release.
2) Btrfs side provided more helpers for btrfs testing.
3) XFS side did a cleanup for v4 xfs, some helpers about v4 xfs and xfs/096
   are removed.
4) Ext4 fixed an invalid mkfs option (the old one was changed)

Thanks for all these contributions! More details as below.

Thanks,
Zorro

The new head of the for-next branch is commit:

0e5c12dfd008 xfs/522: use reflink instead of crc as test feature

New commits ([N]ew, [U]pdate, [D]elete):

Anand Jain (1):
[U]      [8aab1f166303] common/btrfs: lookup running processes using pgrep

Christoph Hellwig (4):
[U]      [39afc0aa237d] xfs: remove support for tools and kernels without v5 support
[D]      [049ae4265e4d] remove xfs/096
[U]      [013d374aac54] xfs/078: remove the 512 byte block size sub-case
[U]      [0e5c12dfd008] xfs/522: use reflink instead of crc as test feature

Filipe Manana (10):
[U]      [aa4799f3d2ef] btrfs: add helper to kill background process running _btrfs_stress_balance
[U]      [1237986570e1] btrfs/028: use the helper _btrfs_kill_stress_balance_pid
[U]      [011174eab1c2] btrfs/028: removed redundant sync and scratch filesystem unmount
[U]      [b2a3bc018fe0] btrfs: add helper to kill background process running _btrfs_stress_scrub
[U]      [d6b4a1531fbb] btrfs: add helper to kill background process running _btrfs_stress_defrag
[U]      [058e46de642c] btrfs: add helper to kill background process running _btrfs_stress_remount_compress
[U]      [1305165c278e] btrfs: add helper to kill background process running _btrfs_stress_replace
[U]      [d2e240298b8c] btrfs: add helper to stop background process running _btrfs_stress_subvolume
[U]      [ec3953895cad] btrfs: remove stop file early at _btrfs_stress_subvolume
[U]      [c4d674bcd342] btrfs/06[0-9]..07[0-4]: kill all background tasks when test is killed/interrupted

Luis Henriques (SUSE) (1):
[U]      [e024c6f28b8b] ext4/01{2,9}: fix invalid filesystem option 'journal'


Code Diffstat:

 .gitignore                 |   1 -
 common/btrfs               |  84 +++++++++++++++++++++++++++++
 common/config              |  13 -----
 common/xfs                 |  35 ------------
 tests/btrfs/028            |  16 ++----
 tests/btrfs/060            |  33 ++++++++----
 tests/btrfs/061            |  30 +++++++----
 tests/btrfs/062            |  30 +++++++----
 tests/btrfs/063            |  30 +++++++----
 tests/btrfs/064            |  30 +++++++----
 tests/btrfs/065            |  33 ++++++++----
 tests/btrfs/066            |  33 ++++++++----
 tests/btrfs/067            |  33 ++++++++----
 tests/btrfs/068            |  33 ++++++++----
 tests/btrfs/069            |  31 +++++++----
 tests/btrfs/070            |  31 +++++++----
 tests/btrfs/071            |  31 +++++++----
 tests/btrfs/072            |  31 +++++++----
 tests/btrfs/073            |  30 +++++++----
 tests/btrfs/074            |  30 +++++++----
 tests/btrfs/132            |   2 +-
 tests/btrfs/255            |   8 +--
 tests/ext4/012             |   2 +-
 tests/ext4/019             |   2 +-
 tests/xfs/002              |   3 --
 tests/xfs/005              |   1 -
 tests/xfs/077              |   1 -
 tests/xfs/078              |   9 +---
 tests/xfs/078.out          |  18 -------
 tests/xfs/083              |   2 -
 tests/xfs/096              | 130 ---------------------------------------------
 tests/xfs/096.out.external |  50 -----------------
 tests/xfs/096.out.internal |  51 ------------------
 tests/xfs/132              |   1 -
 tests/xfs/148              |   1 -
 tests/xfs/263              |   5 --
 tests/xfs/299              |   2 -
 tests/xfs/304              |   2 -
 tests/xfs/305              |   2 -
 tests/xfs/522              |  58 ++++++++++----------
 40 files changed, 451 insertions(+), 517 deletions(-)
--
Zorro Lang
zlang@kernel.org

--4fdtsIZb1t58
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmYb4wEACgkQlNbPkfr2
tMzKsRAAiTtwdjMGhS4CbP2s/MvBBjwG77ffr9QSVKW4BuW7yCgID4qBahbZTYlx
knCyNm+BmpeqJ8/Cad7EIl++ULhG8jLWqBk6Hpc5O4QO5TNYHEUt6B+qe32cJFjm
JeJVPg4QoUrnfGTJfPHxqzTQ3+JFagcRfj8jk6PNZgJJjZTWN3bpOb70UXzdRg00
U3gm7JZkQYsvs+W/X8T044lpIKvzGEe+MSjy7CMquGJQpkPjoXPcG6zqYamUc3VL
8qEi4kX6dHTeNFAJdfBHNIyTvryy5gthPenrYpPk35637GJjysAp6QX5qgAP11ld
h3qap1445YpJH8J79v8MVcJbZFXr/SqBZntUiqXRx0dvV9RR37imKii3UXCTr7JO
MPcrNAwNHehmw1/AQlEL6B6oPatVediZ2O6lKlV0btDk/crBQOrA8c/2mSV26tE3
iS0NH/QjAuBjZJjU9daRWYvlLLkSHxhc4TJDS+CxBoqglBCeKSSE9pp2U4U+pQi4
7hcAdFOkX2+l4PvixHu/XtrCR7GZc6NHZFNpbrQu6t1drjtpDIsOcp85JVXuyFhH
v6TRlSXYN7IudNDE81/p0HHKhtX5x7FihAE5VVEWWp2UnjH8+BIH3480ulOOKzDS
s2/VH5o8U/IqHU+UQyxE2XLzdO8xxDStFcm4pJzUZyi5sI932OQ=
=pXYK
-----END PGP SIGNATURE-----

--4fdtsIZb1t58--
