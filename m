Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B13C38
	for <fstests@vger.kernel.org>; Sun, 26 May 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716735569; cv=none; b=sMGDaG4IKUwYPHh3bV/iD7yiorCpA0ZTNQt+bQZQfuSZnAL0JUANEN8PP0jIcgAaNt83wv/rr5cD0tj8cDmRuuEapJTre73BRgM58hTELZpCSd6WGEaqP2oAUdXg7aHLQU69DWoXiOG8bx5OPuKRu6yueWM1mXLj0SJF0NzQlM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716735569; c=relaxed/simple;
	bh=l0C2drrrJkXvSx1g0+AQTfwBa1y9ROffAgfENHX5opw=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=LHh+dr8RdjxYsZnh68WBH6sv6CeOf/bndBKjUeVobTiPMtbhTTli6QM0OrUxG/5MjgBTO2WVCnB9CEa+lVwLj2Z0x0OWIzbSpP6euKg2peiJqMm6CPhVH/jKtUcV2SYcDRSvp4tfQ5u5Lb9xXUI8Z/TiZQLzp8mlEdPMvLSwPBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c884L9SK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c884L9SK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEA3C2BD10;
	Sun, 26 May 2024 14:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716735569;
	bh=l0C2drrrJkXvSx1g0+AQTfwBa1y9ROffAgfENHX5opw=;
	h=Date:From:To:Subject:From;
	b=c884L9SK2S0XS/wA+P1X/TxrpocPBAjcAEcG/WBswNlHiIE3RViHcpLLTmZGZg+e2
	 6YOsA8RxDJcK+SOujd97alwQeFWWaj1kBJ9TXATPKDo1tJKC4j5xtbowCuZOl1bf1s
	 TG/cdQIv0WMbHBiIsS7Q/vyKY9Ok86Bzp0iKsPFWSVPB1NnGNC/WUE/f8ZTY0s1RZL
	 oqZW9VPP5RvCQl7ktFeaCoYx7kQmxbTP1XIVNCnWkj+PcGH36gmIcslWrpdhBY0Yl9
	 2q7rkcppn7cpE6/LzPi+GldJzCEsBVI1G5IZAsh3qi2PuCv14N9w4BrdONL3YsBATz
	 SoSxfmDOntpng==
Date: Sun, 26 May 2024 22:59:25 +0800
Message-ID: <e0dfd44590cf51b6b2186caa041bdcca@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.05.26
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n65CGqJL8BVu"
Content-Disposition: inline


--n65CGqJL8BVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.05.26 release.

Release Notes:
1) There's not new cases in this release.
2) All richacl related tests have been removed.

More updates and fixes refer to below. Thanks for all your contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

e46fa3a7dae4 Remove richacl support

New commits:

Anand Jain (1):
      [692bef09cfad] btrfs/741: add commit ID in _fixed_by_kernel_commit

Carlos Maiolino (1):
      [e099ba0087d8] check: log kernel version in check.log

Chandan Babu R (1):
      [86e123019c81] _test_mkfs: Include external log device (if any) when creating fs on TEST_DEV

Chen Hanxiao (1):
      [be5ec474127b] generic/742: require FIEMAP support

David Sterba (1):
      [e46fa3a7dae4] Remove richacl support

Filipe Manana (1):
      [26d69e8df390] generic/733: add commit ID for btrfs

Josef Bacik (5):
      [e0aca4b09d81] generic/352: require no compression
      [c99901745c41] generic/027: require no compression
      [a0e33b4b4731] generic/269: require no compression
      [73f45a1ff44e] btrfs/{140,141}: verify read-repair test data by md5sum
      [a42f8a6be29e] fstests: mkfs the scratch device if we have missing profiles

Qu Wenruo (1):
      [fa81eef946b9] fstests: btrfs/301: handle auto-removed qgroups


Code Diffstat:

 check                 |   1 +
 common/config         |   2 -
 common/ext4           |   9 ----
 common/rc             |  55 +-------------------
 doc/group-names.txt   |   1 -
 tests/btrfs/011       |   6 +++
 tests/btrfs/140       |  15 +++++-
 tests/btrfs/140.out   |  34 ------------
 tests/btrfs/141       |  16 +++++-
 tests/btrfs/141.out   |  34 ------------
 tests/btrfs/301       |  14 +++--
 tests/generic/027     |   4 ++
 tests/generic/269     |   2 +-
 tests/generic/352     |   4 ++
 tests/generic/362     |  93 ---------------------------------
 tests/generic/362.out |  94 ----------------------------------
 tests/generic/363     |  86 -------------------------------
 tests/generic/363.out | 139 --------------------------------------------------
 tests/generic/364     |  67 ------------------------
 tests/generic/364.out |  39 --------------
 tests/generic/365     |  61 ----------------------
 tests/generic/365.out |   9 ----
 tests/generic/366     |  54 --------------------
 tests/generic/366.out |  11 ----
 tests/generic/367     |  53 -------------------
 tests/generic/367.out |  11 ----
 tests/generic/368     |  53 -------------------
 tests/generic/368.out |   7 ---
 tests/generic/369     |  94 ----------------------------------
 tests/generic/369.out |  24 ---------
 tests/generic/370     |  58 ---------------------
 tests/generic/370.out |  19 -------
 tests/generic/733     |  15 ++++--
 tests/generic/741     |   2 +-
 tests/generic/742     |   1 +
 35 files changed, 72 insertions(+), 1115 deletions(-)
--
Zorro Lang
zlang@kernel.org

--n65CGqJL8BVu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmZTTi4ACgkQlNbPkfr2
tMz8/Q//SNQd/DI4pdoWJy/YyeQRYKTPvb3wQnHR8rE71Ejmj8n/SywPVfG/8exH
UJUSgVaLcfODvbcHR7uZZlJSQScCSMJvGoy+XWCwX9l+WHfaIthi5VtkejiKxuBX
ard61LQyKPeesXUOzlIH9t18DieAg/4PJqjmcJTOOH2dCiDYp4qnzryifrW43Ty7
84dCC7SsP9DTCWoXy9cPEFmM4gWiO86rYn1JSzOdOUMvLCVJkjbX27dG5OgUAOAA
snYAc+koZmK1d+6zeKKhL4vIMVpnCiXNkoaXvFR2Re2L9dNOurw+lwezB5tRrOOu
sHTT99XV1gybHm0zNKAhkjuWI6KH641y+Gxp5Ox8OtGB4loZYl2obGDhrqh4cI0f
RXPpkYgSyLbTSuIcRrkfQx1Adt9K2vvWcLW8pnZU3/heEQnOP3iJdBX52ZLonlLp
ed4G17nprwxzF3aA6yfCGTGrEryYhZE0ajuugMAxDjVM4+cM+8CKkljS1oEFEBSi
EW/dX7n1Wuf0PQFXVzj70xF+fI5yxI5gNJwRXKtHcUC8lIvUjJVufMgoZZ2m7h4K
fxhUbZomKMhiqe9cMlJ5+CJ4ONkBqNGDg0Vrd77VSgCSc+lSREFWJ1ip090lSJjv
TKC05+oKyzOk4B8vwnwmmYlhSNjhqUScl9mdtnaIkvxF9V6NjVg=
=Hg2B
-----END PGP SIGNATURE-----

--n65CGqJL8BVu--
