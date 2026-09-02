Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485802D3225
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328853; cv=none; b=gxjYXP8IgO9oACVdia3mZWjfKtPaagTdlGlosGL0TkeSLdOvwYxJN514xDcXmZWZTVYAdzoqtcd0s0E0ecYXhQqTy/wqXe0mDggMWSwLLWhRnTzn0qEjdNGuq4UitcKdWTti/a6LV5yrgszebGlTo5p6KKoVQd3Ydl5y10eKJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328853; c=relaxed/simple;
	bh=G+SHQc/LRTG4ch0Ukymxfq5GED3X8EAKzwmyBJzwklc=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=ndfbm5ziZ8JcxYQXZemknwiZoo6r1R2JP6JcZoovgbSvy4jE6FL0wyFiHr8BuF/Vevrl08A2GUcpOSANi7ArcHO8W3ZhlW+Qj9S8XsQLskBTptubaZK1oEJfy4YyBgtXkyQUdCPf8CubhS2ZQ/jE36tmPc7nj2vLitFv1sXkScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMme52/L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMme52/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04021F000E9
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 06:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328850;
	bh=bQw+sIKgPNkKMY8UQ/9k16AaHeXrqdvF+lTIAWyXCl0=;
	h=Date:From:To:Subject;
	b=QMme52/LeLqDjldignnDOMEJdowvUf0tqb5Q/Tz78lWgrO8BWmN9ipScxtmtBUazG
	 0Zh51CuDW74J0K0jWmsx1Ep8kEATPWfCA4llikHuvVBVXJuQQ7skJ05Wv77cD4c3+J
	 S//TDhfaJ3UJytMabJmLFrK3Ue0PudkFEbhRV4ijUTYEWuPGBn4rLmbomaGtq9ikqN
	 UBi4n3Z4wrGYZsgrD3Vy4OOOppz9Rx/Sali7ZhxKEduhXuAJgE+nhQ+gYjFenC97EF
	 PCvc3k2HBs4FB6PS96N8F9LIxKsQM04TBzKcqVUJSswa9suQoTHYekVxStJDkokl3G
	 2RGvWyezojA0g==
Date: Wed, 02 Sep 2026 14:00:46 +0800
Message-ID: <e85e141f49cb0172dc59602700e2945c@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2026.08.17 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="QS63FWCK2gYQ"
Content-Disposition: inline

--QS63FWCK2gYQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2026.08.17 version.

Thanks,
Zorro

The new head of the master branch is commit:

a370dcbed435 generic/347: Fix sporadic test failures

New commits:

Anthony Iliopoulos (1):
      [be0d986ddfdf] xfs: use -w instead of --path for man program portability

Chao Yu (1):
      [7a6f7338d284] common/rc: support f2fs in _require_fanotify_ioerrors()

ChenXiaoSong (2):
      [3fec7b1d80ad] generic/002: add test to hardlink group
      [5249d98ebb3b] generic: new test to check nlink returned by fstat()

Christian Brauner (1):
      [8954caba9fc4] src/vfs: probe O_TMPFILE support on the base mount in the idmapped tests

Christoph Hellwig (1):
      [feb1bf12484d] generic/761: add to the rw group

Donald Douwsma (1):
      [65ac068039ea] xfs: test xfsdump subtree restores

Filipe Manana (1):
      [361b5e5d5bf9] btrfs: add missing commit IDs to kernel fixes of some tests

Jan Kara (1):
      [a370dcbed435] generic/347: Fix sporadic test failures

Jan Prusakowski (1):
      [bbb3a73297ab] generic/064: allow 50 extents on F2FS after fcollapse

Lin Jiapeng (1):
      [4a5ccb510273] xfs: verify CoW after exchangerange with FILE1_WRITTEN on shared extents

Lukas Herbolt (1):
      [140058abb86f] fstests: fix build errors on kernels before v5.1

Ojaswin Mujoo (1):
      [e846df8f7021] generic/645: notrun if FS doesn't have enough free inodes/blocks

Pankaj Raghav (1):
      [9b0f378ac991] generic: add unaligned boundary test cases for WRITE_ZEROES

Qu Wenruo (1):
      [b69358f4d8ad] fstests: add a dio-read-into-mmap and sync race test case

Rochan Avlur (1):
      [54422f9a4c09] exfat/001: test that rename and move preserve benign secondary entries

Shin'ichiro Kawasaki (2):
      [29d735f251c3] common/rc: add argument to _create_loop_device() to specify device size
      [83760720b81e] generic/563: limit loop device size

Sun YangKai (1):
      [92711dbe73aa] btrfs: test POSIX ACL changes for RO btrfs property

Zorro Lang (1):
      [7536b334c492] Revert "fstests: vfstest: skip rejected tmpfile creation"


Code Diffstat:

 .gitignore                     |   1 +
 common/rc                      |  13 ++-
 configure.ac                   |   1 +
 include/builddefs.in           |   1 +
 m4/package_libcdev.m4          |  14 ++++
 src/Makefile                   |  11 ++-
 src/dio-read-into-mmap.c       |  81 +++++++++++++++++++
 src/exfat_inject_vendor_ext.py | 155 ++++++++++++++++++++++++++++++++++++
 src/exfat_verify_vendor_ext.py |  62 +++++++++++++++
 src/vfs/idmapped-mounts.c      |  12 +--
 src/vfs/utils.c                |   6 +-
 tests/btrfs/349                |   2 +-
 tests/btrfs/350                |   2 +-
 tests/btrfs/351                |   4 +-
 tests/btrfs/353                |  95 ++++++++++++++++++++++
 tests/btrfs/353.out            |  39 +++++++++
 tests/exfat/001                | 171 +++++++++++++++++++++++++++++++++++++++
 tests/exfat/001.out            |   6 ++
 tests/exfat/Makefile           |  23 ++++++
 tests/generic/002              |   2 +-
 tests/generic/064              |   8 +-
 tests/generic/347              |  13 ++-
 tests/generic/563              |   4 +-
 tests/generic/645              |   8 +-
 tests/generic/761              |   2 +-
 tests/generic/799              |  59 ++++++++++++++
 tests/generic/799.out          |   2 +
 tests/generic/800              |  79 ++++++++++++++++++
 tests/generic/800.out          |   2 +
 tests/generic/801              | 177 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/801.out          |  19 +++++
 tests/xfs/293                  |   2 +-
 tests/xfs/505                  |   2 +-
 tests/xfs/514                  |   2 +-
 tests/xfs/515                  |   2 +-
 tests/xfs/539                  |  62 +++++++++++++++
 tests/xfs/539.out              |   8 ++
 tests/xfs/671                  |  65 +++++++++++++++
 tests/xfs/671.out              |   3 +
 39 files changed, 1190 insertions(+), 30 deletions(-)
--
Zorro Lang
zlang@kernel.org

--QS63FWCK2gYQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmqXu1AACgkQlNbPkfr2
tMwqyxAAuiOFeTJOH3ZEWLTe+LbM83+rp2R4hY4tntM3wmawpjtDIPu2rh41Mq60
e36jOaGQH5D95Arcu+zOoUyYLolgZP+FVG689mT2jXFb3keuOstjT9OzjK58wT5r
0RhTwbjvQrAxVvEJZA711UdIMPETJ4rebtn6m3S8AN/DnNvuKyHvovAT3W3li4HG
iDswFVyfL3tjxlZbCppUcxgeMBqNDXROEGKLrjmzC2VlCS+xYExYMIs9MrjOeHfD
0VyMQysgac7VWLcITOADNWyttfuqcazgjdUwn1L3mfCc1Q5SOjfHG5z9P782CN3e
+0+C5Qwc6hrkW+t3iBAnM6+3KyG12rg+eHg6ZY2SqwiN3t+8AuyQ2KnSJH7dpyZE
w8zW0sNVm3NPiBu3zkdiJD9Xj+C6wYmLlrhRwh9kmrf06TJymCSZqyfxhrssE3dF
TEGpy0jz2PT5YJPp6WXxf4ihI+nHd7mKj98H9s/hstTse4nR4nv2FisYxj5Wk+OE
wss6FRe9c2MIk8nv3zQnCrLf6azE5RxiSrsghru9D18mikGwyO7UI3i9FlyidToa
kJbmozWkOAfRLkrHtBhQAJuxbsGZaREpGdrQpeWbACC0aZkWqsKy86Xyr1E2Vl6Q
INOx0M2YIBvr1JE0cl3/pk5xvUy1jBo2z1w6xpt9KXh6MtdQTkk=
=zAuG
-----END PGP SIGNATURE-----

--QS63FWCK2gYQ--
