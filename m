Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7D019EED3
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331560; cv=none; b=hF8FPAT7WMwWCJyykxyf9MEwuIvvHhbPf+rqyOB/lmypsGq/YE0LdlscMoQmW+GZ4fzB868kbvk5/7QUPkGJmYdMT+wh/pOyhXNGX0mpKtOWv5+587dYm9PL7bizcbh+znWsLuNabBVIig0f7vZ3ipWBzIEd6dBEpZ7Qs70NYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331560; c=relaxed/simple;
	bh=Yq0tlfhLjgehU7iBFS5ikOosfLCCxfiEOAnBrEEjAek=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=cKpOgoetnLJ/vbDdowmTV6XBAbQdxTrjBo3I7CmpfkvS/0kcSMWKcFNbyJ6opGZPyDNF2Vidv+cqa1cX6Rhg9meyFENOX/7LXr/bAbxoHasip4ErBYUIt0MMJFlWOyt8K0lWt1oXNmtxZpFayBWi3BcEphtcpjl+WD6BF2j+gY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv9K8zP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv9K8zP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD331F000E9
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 06:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788331558;
	bh=x2KzoLMNMoK7/lrdLRR8G0lE44RMCBq4llEHwRzknww=;
	h=Date:From:To:Subject;
	b=Cv9K8zP3tDb2Qcu9H0/gI2NSySTDkZRtYMpB2uUd2qDevIK+XKarOZj3WxNgyCYmj
	 Sfpi6f8Fg/vuKWJUeqsSYzRndSuC6hEVjqgn2qysobRGqqon1U0d4OELTvjKDxQHU3
	 gyPOn6mh8WouIpRsWt2BnL9nn7p+qd6pUgsDK0aI7ZhzcjSpXSzlrsWcwG1RWSd5xO
	 KLfppCn6PB+Xy4YsIWDV44wAgQQrBmVuqp8WZb8xhXdL0E32Y+WUQXvx0JXyxx6HBu
	 ZqE+jMxULm0J97loBL5PbRPX1xYO9wzxK180lfc4A/dr6H7w21DOxh+K/T+lQAM47i
	 jYGp4S97m9wBw==
Date: Wed, 02 Sep 2026 14:45:54 +0800
Message-ID: <03ba84fcc4e3679b16d2e379239f6a2a@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.09.02
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="Yhxt5T6SH1lj"
Content-Disposition: inline

--Yhxt5T6SH1lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.09.02 release.

Release Notes:
1) There's 1 new test case generic/802 in this release, it uncovers a known
   CVE bug.
2) Refactor ./check CLI options to follow standard GNU getopt conventions,
   eliminating inconsistent and ad-hoc naming patterns for future
   extensibility. For backward compatibility, legacy options remain functional
   but are deprecated, please migrate to the new option syntax ASAP.
3) Enhance _require_chmod/chown/hardlinks/mknod checks to ensure smooth
   execution on non-POSIX file systems.

More fixes and updates for xfs, btrfs, nfs and zoned testing, thanks for all
these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

3e1ee800e52a check: add deprecated options warning

New commits:

Avinesh Kumar (1):
      [3084fca70da9] generic/798: chain xfs_io commands into a single invocation

Christoph Hellwig (3):
      [ec1de92a465e] generic/730: don't override $SCRATCH_DEV
      [63ff3b39b21c] xfs/649: don't override $SCRATCH_DEV
      [440d41ec2eac] xfs/073: destroy loop device when mount fails

Darrick J. Wong (4):
      [328d1f426d9b] generic: test reflux with exchange-range
      [a27e980f7d88] generic/800: TEST_DIR, not TEST_MNT
      [1b0edd611283] xfs/030: skip this test if metadir gets enabled anyway
      [329a50b47d25] xfs/837: set rtinherit on the root directory programmatically

Eric Sandeen (5):
      [dc4787e81310] generic: remove chmod of $seqres.full file
      [f94089087b34] Add _require_chmod as needed
      [3ad176c78926] Add _require_chown as needed
      [b9d514422d99] Add _require_hardlinks as needed
      [9ed087ccc9f2] Add _require_mknod as needed

Johannes Thumshirn (4):
      [c2d757a9d1bf] common/btrfs: fix awk field separator in _check_temp_fsid
      [45cc03678313] btrfs/199: skip on zoned devices
      [bcd1ff37a5cb] btrfs/284: skip on zoned devices
      [139aeb3493df] generic/781: fix copyright

Manognya Singuru (1):
      [623b555aa32a] common/xfs: filter mkfs.xfs stripe geometry warning

Zorro Lang (4):
      [984845aec939] check: refactor argument parsing with getopt
      [d0f510629f94] check: update usage and README to reflect new argument parsing
      [a5eccab3a040] check: consolidate argument handling into function
      [3e1ee800e52a] check: add deprecated options warning


Code Diffstat:

 README                |  10 +-
 README.overlay        |  18 +--
 check                 | 440 +++++++++++++++++++++++++++++++++-----------------
 common/btrfs          |   2 +-
 common/config         |   8 +-
 common/rc             |   2 +-
 common/xfs            |   3 +-
 tests/btrfs/199       |   1 +
 tests/btrfs/284       |   1 +
 tests/generic/066     |   1 +
 tests/generic/084     |   1 +
 tests/generic/093     |   2 +
 tests/generic/099     |   2 +
 tests/generic/105     |   1 +
 tests/generic/184     |   1 +
 tests/generic/193     |   1 +
 tests/generic/219     |   1 +
 tests/generic/230     |   2 +
 tests/generic/235     |   1 +
 tests/generic/237     |   1 +
 tests/generic/244     |   1 +
 tests/generic/256     |   1 +
 tests/generic/305     |   1 +
 tests/generic/314     |   1 +
 tests/generic/317     |   1 +
 tests/generic/318     |   1 +
 tests/generic/326     |   1 +
 tests/generic/327     |   1 +
 tests/generic/328     |   1 +
 tests/generic/355     |   1 +
 tests/generic/370     |   1 +
 tests/generic/375     |   2 +
 tests/generic/378     |   1 +
 tests/generic/379     |   4 +-
 tests/generic/380     |   1 +
 tests/generic/384     |   3 -
 tests/generic/398     |   2 +
 tests/generic/400     |   1 +
 tests/generic/423     |   1 +
 tests/generic/440     |   1 +
 tests/generic/444     |   2 +
 tests/generic/449     |   1 +
 tests/generic/462     |   2 +
 tests/generic/479     |   1 +
 tests/generic/495     |   1 +
 tests/generic/505     |   1 +
 tests/generic/514     |   1 +
 tests/generic/520     |   1 +
 tests/generic/535     |   1 +
 tests/generic/556     |   1 +
 tests/generic/566     |   1 +
 tests/generic/572     |   3 +
 tests/generic/573     |   1 +
 tests/generic/581     |   1 +
 tests/generic/587     |   1 +
 tests/generic/597     |   3 +
 tests/generic/598     |   2 +
 tests/generic/603     |   2 +
 tests/generic/622     |   1 +
 tests/generic/636     |   1 +
 tests/generic/641     |   1 +
 tests/generic/673     |   1 +
 tests/generic/674     |   1 +
 tests/generic/675     |   1 +
 tests/generic/681     |   2 +
 tests/generic/682     |   3 +
 tests/generic/683     |   1 +
 tests/generic/684     |   1 +
 tests/generic/685     |   1 +
 tests/generic/686     |   1 +
 tests/generic/687     |   1 +
 tests/generic/688     |   1 +
 tests/generic/698     |   1 +
 tests/generic/699     |   1 +
 tests/generic/709     |   1 +
 tests/generic/710     |   1 +
 tests/generic/721     |   1 +
 tests/generic/726     |   1 +
 tests/generic/727     |   1 +
 tests/generic/730     |  11 +-
 tests/generic/781     |   2 +-
 tests/generic/782     |   1 +
 tests/generic/789     |   1 +
 tests/generic/790     |   1 +
 tests/generic/792     |   1 +
 tests/generic/798     |  19 ++-
 tests/generic/800     |   6 +-
 tests/generic/802     |  65 ++++++++
 tests/generic/802.out |  16 ++
 tests/xfs/030         |   1 +
 tests/xfs/073         |   1 +
 tests/xfs/649         |  17 +-
 tests/xfs/837         |   6 +-
 93 files changed, 524 insertions(+), 200 deletions(-)
--
Zorro Lang
zlang@kernel.org

--Yhxt5T6SH1lj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmqXxeYACgkQlNbPkfr2
tMzTiw/+NdfblcANFolLIkwPkAHB2IWzq0cfastBIBKgK3o4W8enRevjzjKhWP+p
kdOA03TQiR7wbMAvfELAOFuj2ym9QBUA3hhByjnOmXRjspM5iDXJSrDvevySnoZ+
JbahXeKBKqw/BeV1YVUzgbDcAKaxSVwu1eLo/ZiJWpnVVY7btU73N4ZzO17ddF5C
jjLsmDA2J6vyvI+o5TG6n8czUZrckmSAO/z3D7i0588+P8xA42pq/UGITH5OYZ4P
WGP3oRdQw/NC+uYW6YahitgtFgeoKV6L5fyDUHxJ6rUW70Uhufm/t/9P9yvB6Uon
sqNKByNwWbm5u+cTtEFCnKcX9OJ1W6N5peniPMuBjnTODlzY4s+t6f2Y6nwBuHN6
OJ98GFwUhICuYCvdpnv30ayguXa9Qb1SxtRPEolQqtyB59dKlfpk9234Mm9f9/0S
6WjDHgqRBhm6fqqM+PVPQIHVbu/afr2/i5XrAQKgukukhslwsrAJv8vU+/ifgDFM
BaA2dX2k6qcmZheCWtaEB/uApj2Rhn/6QSFAGEiiajWYbwsNK/G4A8RP6YaXbDqa
cFYwtiyw8oWPbUp1RavtQbUfy+fPsPj6ZGPJm6RLT7YbNRidKsiA/ULpWhXLTNLz
7Eq8ud5AEW1YOthb0QH+ZMkuIhd1b9JaY1Xx9+g+A7rj7Kh58qA=
=0nD4
-----END PGP SIGNATURE-----

--Yhxt5T6SH1lj--
