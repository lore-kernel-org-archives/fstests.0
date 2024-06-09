Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5421E498
	for <fstests@vger.kernel.org>; Sun,  9 Jun 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717944099; cv=none; b=Gjzf2LzRAsPHRPIsdcG3JlqTs/2z2CPcn/YYDalQwVA29ZVUr603L0njSdC1TWwzEFdcMrj3evW7zR6Mh6tU0pfEWfAzCkqIleqxoBUZ1j27rhgRyAipaBs/E/zxsplZMZK70rRspabey3xN4LgKhr+ECPpO6/k/YMDXEaQtM0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717944099; c=relaxed/simple;
	bh=keGbWKjpQsjAnNkUCV5IINgwpvSsZA97YwFhitNbgGo=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=RNegGn1UIjpB24+eo+CRcidnsYTKcGLmBZZEzSKhD2hK7syNbsBFrz5MlzjUgd4EK0unSk07ZK7ShMh2uoTtxEaJOFb/KHAM/2gmNljkphQga0mGtjQU6AL7F2lw7WTfujkYbTGX7Ed7sZttxbIcCbq7QPNnIvmwSabT4ppjSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqDONpMb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqDONpMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2134C2BD10;
	Sun,  9 Jun 2024 14:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717944098;
	bh=keGbWKjpQsjAnNkUCV5IINgwpvSsZA97YwFhitNbgGo=;
	h=Date:From:To:Subject:From;
	b=SqDONpMbDkmlDYxQy0WK5ISMFmyikxzZhMZZEULG85So4PAzP8Wr5sj/XKih7qAPa
	 WKOQUnkkGnYc0IGX0JsYGgT7aOi9AKPoGwOo2Qu2uXmnApII3YgfVe7zkccwZmo8+1
	 +DtHdanQVA2I4/TNdPRiWzN9PE7W4inOEga1og1DBsE2SPh4u0SorJkSGhZDMf/dwW
	 oHWjQ/0nMuHvCYp5UQk0yjUBPgIfarSfadS3X5S8Y4FB8McXXe/LT11C6OylCGHus9
	 KA3e5AUwo/R790m+gGJIT9wzJI8OVuVq384QIWEuwAAUax6lF3mNj8GGLPTtGc5x88
	 x96membCWNWqw==
Date: Sun, 09 Jun 2024 22:41:34 +0800
Message-ID: <2416f53ef09e6ec083b540bc7aa4e33f@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.05.26 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iajw0hcuWCMr"
Content-Disposition: inline


--iajw0hcuWCMr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.05.26 version.

Thanks,
Zorro

The new head of the master branch is commit:

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

--iajw0hcuWCMr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmZlvvQACgkQlNbPkfr2
tMz9uxAAwI0uEnEdrdatkMHQpxZsdKeEY85EJTOyElfH5yIUE3IonToOsyf6NNqv
a0ilSs/DfExalVWZlPn3LR+yPM8BqZmSQYa+lGvNTyXvnb9WB5hfDZPO5UvOU5Y0
/lg8mkHDY1OADvAjOeRAL4LwPX2SNkfUu2kuZ8V8qnNgNg4jvY2CbVzSq9Raf72p
aR5e07eKLEnmBs/zXd9sfKyx50YneU74kGzpaRs6vKuFq3tPQbigfaxok7hNBabc
AHYLhEAmDO0RNIPo3yGvjhYOfj8QG2ZBxiCFv64upeViYQzuBCJAVX2nvDSegkY6
1JY3SpCglB0RHYdidJFqRQJjNWbHrtfBpT5SUarAO+lzVAsH+gLzPepZeUVGsCNy
Et5l6YzlZafK8FskgUvuxVj5Cc37BX7hEKJoybyhle5kWavCJ450m/VhjLTKlR++
iUMMEA4HFiCptvGGSUpkDKjtpYlPjoljHBsAs7zAYHy1mVqQIRYkrLQucPcncyGK
qD6Ig+D5OD95vVT6Ui9pShl2/v63xzYZXkFvew7syr+AQa43YpLYS+Rlnwj63DfW
SZxpnHD0kzheCA98LLX6hJdd1YCdwjdnCSp8vJsPLNIPzuqtQY+64qVh3rFcbphQ
WjLpHZe5Ug59fsdQ75EOjsMn1EzOjFnA1WknGqddoJC+B34Q9YY=
=EDMO
-----END PGP SIGNATURE-----

--iajw0hcuWCMr--
