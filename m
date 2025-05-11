Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198532BCF5
	for <fstests@vger.kernel.org>; Sun, 11 May 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746974412; cv=none; b=FuEO11C6QzEw6f3rPUxOWya+Jfog41pSdShcEDhTuvbGD6QXaxkdCI0nJ2YSkik9SCHvM6BzsNwyMwK8elAWAbWZQoA7dIvSMW53v4SRCawO7UIinV+NSL7ITDac3YwZCGm/MXRRn/IVzo6pZpocm5FLqel4RuZjRfKjPQ9QxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746974412; c=relaxed/simple;
	bh=OTg7//j4yiS1bnN3zWPhE80MbcUBzDfGpRCemYCHEns=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=QQkyn7BuleV4RdRfPf+8DXmOSDfRkH72mdms1PAQ/sPJfR6VtTGp/Gv3LDAdQj48Veji/QwVmgI5XO9xF8JrAYMKS+2lE2zmKChbqpvuamUjh6Ku9PwcOpzlKzCzcwV43M0WtCWntyDJsz54osxllAJMviwyQdNWH42bMUNz/Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ767XlM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ767XlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069D4C4CEE4;
	Sun, 11 May 2025 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746974410;
	bh=OTg7//j4yiS1bnN3zWPhE80MbcUBzDfGpRCemYCHEns=;
	h=Date:From:To:Subject:From;
	b=PQ767XlMUcV0V1nvTcNYbNW5+jakKoL3I2Mq0gk+9DMbaT5K5brltyIFaPkuCa0sP
	 roUMObwYK6v7Tw+7nPr2ARceW+XmIPJniCs1fqtmUTXvwtlvklWYKhRh3pcWSN8RFl
	 KBKANyB4D1CKxP0XByAxql2b7QS1UJ538sM1+9if6OIhy/Hh5RahemStIV7r3si9Mh
	 mq8clh3fIBxPSjWy3+O9Hg3xkC2M2fH3cUjE/p3uUpsG4T/EwLOA7pOb6CFu3aBlgO
	 eTUgxojObJftrU7FK1FrK9KdCrxEuan+01RyT72cHCDjesx6moV2ksixuRxBshq4kc
	 CID/tC3ZwpYYw==
Date: Sun, 11 May 2025 22:40:07 +0800
Message-ID: <790946215325cf510ddab07a44928d35@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.04.27 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OT0SZRtxV7yz"
Content-Disposition: inline


--OT0SZRtxV7yz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated v2025.04.27 version.

Thanks,
Zorro

The new head of the master branch is commit:

008ffc623232 fstests: common/btrfs: add _ prefix to temp fsid helper functions

New commits:

Anand Jain (1):
      [008ffc623232] fstests: common/btrfs: add _ prefix to temp fsid helper functions

Anna Schumaker (1):
      [f3cbd32a49f5] generic/033: Don't call 'fzero' with the KEEP_SIZE flag

Chao Yu (1):
      [22cffc73853b] f2fs/011: test to check out-of-space issue

Christoph Hellwig (2):
      [b3e7ac4c5ec1] generic/231: use relative path to invoke fsx
      [1f5cccd39e76] generic/233: use relative path to invoke fsstress

Qu Wenruo (3):
      [c2537798f311] fstests: btrfs/271: specify "-m raid1" to avoid false alerts
      [b51e55e7418c] fstests: btrfs/253: fix false alert due to _set_fs_sysfs_attr changes
      [a7640a40da64] fstests: btrfs/315: fix golden output mismatch caused by newer util-linux

Zorro Lang (1):
      [d56ff7a3a253] README: add supported fs list


Code Diffstat:

 README              | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 common/btrfs        |  6 ++--
 tests/btrfs/253     |  3 +-
 tests/btrfs/253.out |  1 +
 tests/btrfs/271     |  2 +-
 tests/btrfs/311     |  4 +--
 tests/btrfs/313     |  6 ++--
 tests/btrfs/314     |  2 +-
 tests/btrfs/315     | 27 +++-------------
 tests/btrfs/315.out |  2 +-
 tests/f2fs/011      | 53 +++++++++++++++++++++++++++++++
 tests/f2fs/011.out  |  2 ++
 tests/generic/033   |  4 +--
 tests/generic/231   |  6 ++--
 tests/generic/233   |  5 ++-
 15 files changed, 173 insertions(+), 40 deletions(-)
--
Zorro Lang
zlang@kernel.org

--OT0SZRtxV7yz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmggtk0ACgkQlNbPkfr2
tMyS6w//bng1RyYnvWKM5UngiN5wiRjqUVtiVfcBOMi+IVchYCHZq2JqvQe2VwMl
hyRIKsowWTaWOMZK84Z62nDx+VZugFzzhkM+OZgPmTtHS06loEANoJSv8kmLNn8w
P2Tm0FrQFzu/Ll1ZrXI9XoX1WazG2aeVnFlhmu2Y7KxxSyEGeig0Gnl2ykluLJcx
5ClCSY/cHcjka4TTfbqYN4q3LtkEogbHKDk73aujOv3BAjbl0PKOhj++/fDwxrsT
KyVnPiGvifQq3feO/kgRHLJIE5NJ4X4UfxgqOPZm0mDs1Vk2M5IAN6f+F02YKnFC
8w3pD3QmvqRul7yLmdjZJvwujZNxPFnR3gJsoVecCtnKZlPIeAlAqKndLr+QYNEJ
pMd88GdRJi5CPm5J/D9XUW0yZM1n3Ra6MpZNuJFbXM+YNt0z+e0MPRvSzJWzGJwX
TzM7lRN581VjOpbmzyCtpKMzgjsj11jJFjDzS+bF6j03N3Hls34U3h2Pj8QRY2DY
hRbkhE6hw4nemdteAP7sKbh8sffcD9L8WoOWbgKIx28euvGEKR6n37uju4a5FM5D
ywd4+K+IdBNSxDa8mNWJRyKK2l3cf5+/ULMHUX5WsxVqT5tPcjtmgFcV96c7VENd
9aFaCGbuBDyM3wTbKsWQtNhG2a75kb+K9NNsR3J2IFUXOyrhD1c=
=8D4P
-----END PGP SIGNATURE-----

--OT0SZRtxV7yz--
