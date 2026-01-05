Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28B3054FB
	for <fstests@vger.kernel.org>; Mon,  5 Jan 2026 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625697; cv=none; b=QDRaJOPUt0DL/x+k1AzoaA+Yh29ORcvzR0vKnw6Rl6/3z4rDIrLYwuf9ZT2og9UtY0n6kaimdO9bqMw89nOt7dfiXoSifFm9mNQ1xo4hg15MbjrP/qpQSoM9VvAX9zmB9DnWQHNm9obTZUWFImSSoCAvWUmCYbYks9fh5GmsSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625697; c=relaxed/simple;
	bh=+cpgp130cCJGCA/cuJgj4XzcwGAQGePHInoPosMJ4N4=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=VfDj9bokYGzUZiaERwoCxGTyWb+X27kgRsfFRJyb3iTbG7xc9om5Bbq3DVvGkOwSa3Gg6S2ESmnkhKpNMwL7MXfpiugXlOXN0PhDzQ9tGKye6bfZp0voeN0UGkRbvk7DT5PUdovItr9jfcrBwAgk2CWTCGQqX3g7kajKh2RgyuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhXHTpjL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhXHTpjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DC4C116D0;
	Mon,  5 Jan 2026 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767625697;
	bh=+cpgp130cCJGCA/cuJgj4XzcwGAQGePHInoPosMJ4N4=;
	h=Date:From:To:Subject:From;
	b=BhXHTpjLr1MCnDYaWnabn4w0zajyHoZ0qK584FCzyOqWwRrlpVTdUeGd1GlT4PLLr
	 WBjO1jqVMxuOCDsYO3OJZrMCz5g/oHQYLdCnd/Z29xcEixNdb2Mr4SNR1uHIQw/2EJ
	 vMnlzRjrXC4lsMGyHY9Tehmv8rS6jnnAKnOZT714A04mf44WumJL58P3OrtEoBkDq0
	 efwPs9AYGGgbijSkKCxHipCzELfy/eXtNLAP97BWxBO7ouLbnLUO5oBC1cqVCnkQn/
	 ZrsNqOutCCQkZF5YIxiTH1tKYn41Ic/E+8NpWyB4y07Z2oySN6Qd9fP/jMveGMLvQM
	 OWGsxPtkzUOdA==
Date: Mon, 05 Jan 2026 23:08:14 +0800
Message-ID: <7d314111eda2840970d4a9331de9dbe0@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.12.09 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wrxrz8hHInKv"
Content-Disposition: inline


--wrxrz8hHInKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.12.09 version.

Thanks,
Zorro

The new head of the master branch is commit:

df16c93a89d3 generic: add tests for file delegations

New commits:

Christoph Hellwig (2):
      [37a5ef84413e] generic/484: force I/O to the data device for XFS
      [74c8afa4f132] xfs/049: create the nested XFS file systems on the loop device

Darrick J. Wong (1):
      [1b37d45c4373] fsstress: allow multiple suboptions to -f

Donald Douwsma (1):
      [5760b2105985] xfs: test case for handling io errors when reading extended attributes

Filipe Manana (2):
      [7e5537c5ec3f] generic: test a scenario of power failure after renames and fsyncs
      [3970e305333e] generic: test journaling after renaming fsynced file and fsync parent dir

Jeff Layton (3):
      [bf6ed3418e0f] common/rc: clean up after the _require_test_fcntl_setlease() test
      [4e77fcc28c03] generic: add tests for directory delegations
      [df16c93a89d3] generic: add tests for file delegations

Sidong Yang (1):
      [d569940311fd] btrfs/339: test receive dump stream for different user


Code Diffstat:

 common/locktest       |  19 +-
 common/rc             |  11 +
 common/scsi_debug     |   8 +-
 ltp/fsstress.c        |  43 ++--
 src/locktest.c        | 621 +++++++++++++++++++++++++++++++++++++++++++++++++-
 tests/btrfs/339       |  32 +++
 tests/btrfs/339.out   |   2 +
 tests/generic/484     |   3 +
 tests/generic/784     |  76 ++++++
 tests/generic/784.out |  19 ++
 tests/generic/785     |  73 ++++++
 tests/generic/785.out |   4 +
 tests/generic/786     |  19 ++
 tests/generic/786.out |   2 +
 tests/generic/787     |  20 ++
 tests/generic/787.out |   2 +
 tests/xfs/049         |   5 +-
 tests/xfs/649         | 139 +++++++++++
 tests/xfs/649.out     |   2 +
 19 files changed, 1068 insertions(+), 32 deletions(-)
--
Zorro Lang
zlang@kernel.org

--wrxrz8hHInKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmlb07YACgkQlNbPkfr2
tMy8ixAAjDQl3aR4KBtZi+9UXqWR7CYodgKFJLH37uyYPup0gRqVGjoo97dvfXFO
7rtetmfbBzRvfS+6Z2NkANOaUgnv49jzNTCkSgm9E+MqCfyUU7vFDd2PkWCtkRYp
hAAGwckl1RsnbkUgPVKvOX7E2TfO2PuuYtGWdTtRahmZlUd/DIP936aJch10+hoZ
choVgQpnLX9Cc/OEAKDinxxgW2Mu0WCm65XIWyl6UBWNWTj/2daHKLCs16dqWpAN
R/F02BYsSVA13f7B2IZZPqUGvuAanJB7Ar53+9qSl7o5bQp8SicOEoqbx0a+CBZ3
4eSK154WS1KL8Cc6OT0Z3NpHJ4oI0ECzvbYQ/cxA3F/fa3+AXExcuzivc203e+lY
AqXARdgSDph9Oq7aND9TAR/dVE3YaVGefbuvUwMIxjhq6Yt22wbza25spoRVCsfa
7a4U9q+odq4Qcdb0uq0q4rhyDMazjDKiD6/VAJbPUHveyH+6Z4cBvmScufklAZPP
E/CtfQ1fKiuqODzANDMn9yMorbUzbh4Fwqtnz49GOx80EOrPU7pu7R15eH3IzaGI
T3AD8qlI1LLVwDn+tGdpo20LAK44Pg2iEhmCR5Cq1fMdo1xUIWpq85H63/xDWAU2
JLOYgzc8D78d3BC2x26hfBv7HhVB+cu5rZUi/6ZAu8fuim+qTGU=
=NyBg
-----END PGP SIGNATURE-----

--wrxrz8hHInKv--
