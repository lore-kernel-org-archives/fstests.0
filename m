Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACDD11C86
	for <fstests@vger.kernel.org>; Sun, 19 Nov 2023 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyFBtdgn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BD6C433C8;
	Sun, 19 Nov 2023 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700402011;
	bh=dleudZXks+8e0dDuorAwDkK5cHI/wwnFw/x57em6g18=;
	h=Date:From:To:Subject:From;
	b=iyFBtdgnMLD0oN/xDZRooTgGRFyONBfouZkRnPChV/Taisq1sMBAhdMW7P0hurShl
	 1nLlCRrjXA043XY7uZmxYiQ3xe3J67yuYTsE17q84DuXvu6NYNNB84/+0Egf7i5Uf3
	 FeWGQRbge9mKuguGAgthmCdD/GtJkPbGiWNoH7O6hYwkbP2rbQiHAyynfZiFwK8Aci
	 ZoCLEEEWcJh0j2SQogg0yW02iS/r29ML60JPuBYy7ovaxpw33BhF+87JzBsPENkBNh
	 Ou0EEpnYWY4u7a0mpkpwhjfpucS5+IIdHOZAFYEF7JSGNRuMCURNUyl5k0ANUTPtD1
	 1godENd5A9ySg==
Date: Sun, 19 Nov 2023 21:53:27 +0800
Message-ID: <736e225a5e86d6d33c21115d70b80f72.Zorro Lang <zlang@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.11.19
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lsuXSdyrY9EQ"
Content-Disposition: inline


--lsuXSdyrY9EQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.11.19 release.

Release Note:
1) There're 5 new test cases in this release, include  btrfs/303, generic/733,
   xfs/602, xfs/603 and xfs/604. There cases won't cause panic or hang on old
   downstream kernel, so this release is safe for downstream kernel testing.
2) The FIEXCHANGE ioctl is changed to be a xfs specific ioctl XFS_IOC_EXCHANGE_RANGE,
   Darrick helped to updated the testing.

More updates refer to below, thanks for all these contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

b9e1a88f8198 xfs: test refilling AGFL after lots of btree splits

New commits ([N]ew, [U]pdate):

Anand Jain (6):
[U]      [22bca8d9a6d9] common/rc: _fs_sysfs_dname fetch fsid using btrfs tool
[U]      [24c58f2d973c] common/btrfs: add helper _has_btrfs_sysfs_feature_attr
[U]      [7139a0600084] btrfs/219: fix _cleanup() to successful release the loop-device
[U]      [6a466743cd17] btrfs/219: cloned-device mount capability update
[U]      [47737bd3decf] btrfs/219: add to the auto group
[U]      [59372e8d3f96] common/btrfs: add _btrfs_get_fsid() helper

Christoph Hellwig (1):
[U]      [88334112f9cb] xfs/146: require fallocate support

Darrick J. Wong (5):
[N]      [848c6a882a6f] generic: test reads racing with slow reflink operatio
[U]      [59bf56a1a56e] common: make helpers for ttyprintk usage
[N]      [b5ba77147bf6] xfs: test unlinked inode list repair on demand
[U]      [3098851702d1] misc: privatize the FIEXCHANGE ioctl for now
[U]      [29c3cc742717] misc: update xfs_io swapext usage

Omar Sandoval (1):
[N]      [b9e1a88f8198] xfs: test refilling AGFL after lots of btree splits

Qu Wenruo (1):
[N]      [483b1f90c8aa] fstests: btrfs: test snapshot creation with existing qgroup

Yang Xu (1):
[U]      [5fdd34e76182] xfs/263: Remove mkfs.xfs data section argument


Code Diffstat:

 common/btrfs              |  26 +++-
 common/fuzzy              |   4 +-
 common/rc                 |  38 +++++-
 common/xfs                |   2 +-
 configure.ac              |   3 +-
 doc/group-names.txt       |   2 +-
 include/builddefs.in      |   3 +-
 ltp/Makefile              |   4 +-
 ltp/fsstress.c            |  10 +-
 ltp/fsx.c                 |  20 +--
 m4/package_libcdev.m4     |  19 +--
 m4/package_xfslibs.m4     |  14 ++
 src/Makefile              |   8 ++
 src/fiexchange.h          |  48 +++----
 src/global.h              |   4 +-
 src/t_reflink_read_race.c | 339 ++++++++++++++++++++++++++++++++++++++++++++++
 src/vfs/Makefile          |   4 +
 tests/btrfs/219           |  74 +++++-----
 tests/btrfs/303           |  77 +++++++++++
 tests/btrfs/303.out       |   2 +
 tests/generic/709         |   2 +-
 tests/generic/710         |   2 +-
 tests/generic/711         |   2 +-
 tests/generic/712         |   2 +-
 tests/generic/713         |   4 +-
 tests/generic/714         |   4 +-
 tests/generic/715         |   4 +-
 tests/generic/716         |   2 +-
 tests/generic/717         |   2 +-
 tests/generic/718         |   2 +-
 tests/generic/719         |   2 +-
 tests/generic/720         |   2 +-
 tests/generic/722         |   4 +-
 tests/generic/723         |   6 +-
 tests/generic/724         |   6 +-
 tests/generic/725         |   2 +-
 tests/generic/726         |   2 +-
 tests/generic/727         |   2 +-
 tests/generic/733         |  76 +++++++++++
 tests/generic/733.out     |   6 +
 tests/xfs/122.out         |   1 +
 tests/xfs/146             |   3 +-
 tests/xfs/263             |   5 +-
 tests/xfs/329             |   4 +-
 tests/xfs/434             |   2 +-
 tests/xfs/435             |   2 +-
 tests/xfs/436             |   2 +-
 tests/xfs/444             |   2 +-
 tests/xfs/516             |   2 +-
 tests/xfs/602             | 111 +++++++++++++++
 tests/xfs/602.out         |   5 +
 tests/xfs/603             | 215 +++++++++++++++++++++++++++++
 tests/xfs/603.out         |   6 +
 tests/xfs/604             |  69 ++++++++++
 tests/xfs/604.out         |   2 +
 tests/xfs/789             |   2 +-
 tests/xfs/790             |   2 +-
 tests/xfs/791             |   6 +-
 tests/xfs/792             |   2 +-
 59 files changed, 1137 insertions(+), 141 deletions(-)
--
Zorro Lang
zlang@kernel.org

--lsuXSdyrY9EQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmVaEysACgkQlNbPkfr2
tMxjeRAApYf3UmcgXaGdGMbpslw8gifoMk8FcrGKJ94IImVoHxK38B+ROTaduVLw
H9kVoW8yd/FVygqZ0+4MFp8dConToukyZ+vD7r3eoJYG+4SuWjUuo577LTNvadUx
sXRn9kcYIGJXbcBo2z1pOoM1bYeWcvRbAAnABwL9PeCX3gZE3cbobuqgd5VrCKXx
yHtFqEk5ErlZdCsCHDn2Ylf618ydXjttOke132KReEh1sTdUWY65oC0h0yttVthn
Nc65rCs5nYkEk+4r2pOelltvn3k4dBG2SVqihZFvxsIHHHuwX3pZICN8NVg/j6hf
pJC2RKuKLOzZ812f35sv3SrKxEH9QxE70YN0OQULCnV7Gf/2LDx8klUM6i7/nasf
6xaXRKh9seBt0DKrGRJuk+rQ02lO83tLcp7ryGa6ajloRl/dbvR/g1hjM85gb5iX
HGdSuRgPbsq3UbPx9m2CKty0QknGRroVawsLh4VHEbbX+R5QSgGW13bbtGGhPTEl
EAypSHj60B2RsGzT0SZBGRxIKzkF0z7r7wZvLBoHh9uzCpROQa3/nHb9lkdeTWGw
m++CiuAlrIUK+O4R88+n9JgjRGKkWpcFiIv4BdJKtk/HOmhujYhvwy0iCr/wz041
KAW0xhGIU8U++UvCsm93t2tQa8VhTBE0a7Bcw/fSChTq4OWKCsA=
=mhUP
-----END PGP SIGNATURE-----

--lsuXSdyrY9EQ--
