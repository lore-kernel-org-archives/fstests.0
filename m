Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7081E8F5B
	for <fstests@vger.kernel.org>; Tue, 27 Jan 2026 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497120; cv=none; b=e/sJkCjUBmZOcfFT7nEWfv7q89eKOvEdkbYTujKMTtVcIyFKOMoQFVZgYHhRuvLzgbMquHfgmEnOkbe07qFm7Es0w2/r7vn+O3flVEkcLq4En2Xen8Z3hBiiQRD3zwUwlVHzYm+CUuPBHNPJroJRLMvfqfxTwOYH17ITZp3FOgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497120; c=relaxed/simple;
	bh=A1T3ClGZndGivnVMdhdF35dA2NdNmDOay8jj7tPclM0=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=oM69sytOawSoCHOJreWYHY3hY/5UUlYhAc/YZEvko83jbAZmqzdu5QifHm4U2/dgmGQTgBFGs3q+Bl6OOYe1xhOPxvbsav4pNEQ2w92YgzijryFdLBT8nTRgBHXM0XeDySMvlD6Si7b/OxA2+EucFgGAfwKtq86pwVQDCO7eRxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPsWEBEQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPsWEBEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A8CC116C6;
	Tue, 27 Jan 2026 06:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769497120;
	bh=A1T3ClGZndGivnVMdhdF35dA2NdNmDOay8jj7tPclM0=;
	h=Date:From:To:Subject:From;
	b=NPsWEBEQf03fn2rUgP2sEKsmiUgQS28FXdOpO4wVAOzku4wkaRsSXHKvD/oyXj2tv
	 V9kI5d0KCJS6UdN9QbvtPOg3z2NPjp22eshAK5Hmdus/fPNVCPuLlYEMImC0Rq689o
	 MKnNXx0BiJyATe09aTY0TtNZTxfog4Vm7xMPo3zWZ/ImRnVLIzfv/KGrvytKHJaE9A
	 kYP5jCXAPf1HLJ6yVkT83iyP+9UdCu3pHuhSHrnpNs1UKy2Pb+98d8GYdv0FZXMN18
	 N2ABWNc+T3WFYg3i451g3b20OpP45zghMCC3xM4bdTxRtsbdd9BjVXSw0+FzwacFPW
	 IJhmW9BiOBBNg==
Date: Tue, 27 Jan 2026 14:58:36 +0800
Message-ID: <e722a754c0ae8ed500fcdc16736a9202@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.01.27
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H7cIdTZyGdmy"
Content-Disposition: inline


--H7cIdTZyGdmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.01.27 release.

Release Notes:
1) There're 3 new test cases in this release, includes btrfs/341, btrfs/342 and
   xfs/841.
2) fsstress and fsx don't fail when --duration=0.

More fixes on btrfs, ext4, f2fs, hfs and xfs, please refer to the details below.
Thanks for all these contributions.

Thanks,
Zorro

The new head of the for-next branch is commit:

69cd20bd0498 xfs: test reproducible builds

New commits ([N]ew, [U]pdate):

Darrick J. Wong (2):
[U]      [754368070ac5] xfs/614: fix test for parent pointers
[U]      [31f7192f90a8] misc: allow zero duration for fsstress and fsx

Filipe Manana (2):
[N]      [8dad086a4701] btrfs: test power failure after fsync and rename exchanging directories
[U]      [e0ded76267f9] fsx: add missing -T option to getopt_long()

Jaegeuk Kim (1):
[U]      [096adc20b3df] f2fs/015: Test correct mkfs options for error cases

Luca Di Maio (1):
[N]      [69cd20bd0498] xfs: test reproducible builds

Nirjhar Roy (IBM) (1):
[U]      [725b08a6d61a] generic/371: Fix the test to be compatible block sizes upto 64k

Ojaswin Mujoo (1):
[U]      [a4dbdc5486b4] generic/108: fix test hand upon failure to create LV

Qu Wenruo (2):
[U]      [8d2e1bd3d294] fstests: btrfs/131: add explicit v1 space cache requirement
[N]      [bc74aaf6859c] fstests: btrfs: add a new test case that is future-proof

Viacheslav Dubeyko (1):
[U]      [facf3325d90d] xfstests: hfs/hfsplus don't support metadata journaling

caokewu (1):
[U]      [42c2ccaf3700] ext4/307: allocate donor file size dynamically


Code Diffstat:

 common/btrfs                     |  25 ++++++
 common/rc                        |   2 +-
 common/xfs                       |   3 +
 ltp/fsstress.c                   |   5 +-
 ltp/fsx.c                        |   7 +-
 tests/btrfs/131                  |  12 ++-
 tests/btrfs/341                  |  73 ++++++++++++++++
 tests/btrfs/341.out              |  15 ++++
 tests/btrfs/342                  | 103 +++++++++++++++++++++++
 tests/btrfs/342.out              |  15 ++++
 tests/ext4/307                   |   5 +-
 tests/f2fs/015                   |  10 ++-
 tests/f2fs/015.out               |  92 ++++++++++----------
 tests/generic/108                |   7 +-
 tests/generic/371                |   2 +-
 tests/xfs/614                    |   1 +
 tests/xfs/614.cfg                |   4 +
 tests/xfs/614.out.lba1024_parent | 177 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/614.out.lba2048_parent | 177 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/614.out.lba4096_parent | 177 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/614.out.lba512_parent  | 177 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/841                    | 173 ++++++++++++++++++++++++++++++++++++++
 tests/xfs/841.out                |   3 +
 23 files changed, 1205 insertions(+), 60 deletions(-)
--
Zorro Lang
zlang@kernel.org

--H7cIdTZyGdmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAml4YfkACgkQlNbPkfr2
tMwOShAAnwKqx+57gUNOFEFj/ng8fwKexu+7n5CW6QZ7CsJZCC624vNrxYSxsmdY
/gBAka1BbJ2bE6CUhUogs04L5ecqvBsAwZisg/4l9tI1UXnpsLcSHffnnzCyU0Ur
GhkxWLSvhykOhQvHDh9dKZ3Xja1aFBV4uY7DxEr1gLm9sS6nLc5NcgtULmVaUlbF
w8h+dgWdY5SZCZzIuYqV9Q+xeAOZoV6uct6X6Mz9TxdzqXKC7Gp/bpC0zUj/KX5G
FJvzI+NtYQqS5UzUHIeBs9Uo3bDRkBvw9pHNu77YGYed9NmL0Ui0T40Dwf8xPng+
x2YlDzbateT4zIpczTdSHPThPnK2RlkAcpQGoUfJTnsNkprspzDsXi0c7B8FFKbP
IOORL9hHovW8FLIBufhFvPF8/UwwHJUI7yQm5ld2obp65CnppeGQRDXZtuqpb2Zz
tM49+TwNw6NNx38TtUpnAdxs0jDCmGjF8Lyj/7JGw2QqIFW0SQ6pWE4/G5EtRdIZ
weCKm9HpASlMdrP1WsdY3UGculOx/br+j2ERd8MJzmxZjgHwBgd4vfRoi578Em/7
TXJ1EKFmw9DSmelb0jdaB/LG7Lrc6lirPqRA/tszP9KMC2afHZ73HqzFviVl8BYJ
yaFxCTWiaCykqMjnOjl7UAllq9M1yIauL+wxpYyUFBBWMc4XAPA=
=0F9l
-----END PGP SIGNATURE-----

--H7cIdTZyGdmy--
