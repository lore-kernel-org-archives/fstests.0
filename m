Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E25524A2
	for <fstests@vger.kernel.org>; Sun, 28 Apr 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714303179; cv=none; b=BFPeX3AlRQjbyoOeSIoBQ1K52gDWbaxZ2Z9AjJ+ZGN3GWMHJ+i9RiKDlAxjWi+nCruBbAzbswa8ohZ1XlQ5gyHhl5hQVMnkxzqhyk6Mp2VS0fI91Ga1VitWTCstQTpwRIRVqqgf0qr1OW/anqlX9ILbm5CHad0fGyCZ7MLzUvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714303179; c=relaxed/simple;
	bh=K9oThOvobcQvaZ+m9D4agxA6cUedjTJCgAmgSElBSlE=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=pgHDuR6LGHZ/1Dg+REWrmFeRlY/4U8tS8jOs9+mqxvUJBQWwI64oKRdSUQFxqyPDlN60EwKNV7oP6BcSXxy7laoybYQhf7lUx1DYZ4zO1St1D8oc/LpLNWJD3rqeLMG4Wuzg10uvbyob+ogrS1JEH70dsxgjPlydJWi4ifuUcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmOe6GtL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmOe6GtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C02C113CC;
	Sun, 28 Apr 2024 11:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714303178;
	bh=K9oThOvobcQvaZ+m9D4agxA6cUedjTJCgAmgSElBSlE=;
	h=Date:From:To:Subject:From;
	b=VmOe6GtLvidSInsMdr28twZ2CzW0vQLF/VKhaTSYft2CbSUwlAikwP1xbocdk4d8W
	 zSwSBq7qFS4EgkVwWxIZwO/GgcYl/2Nrwhy4HLfi9HVjnNc+/LOxMDshE8gINLx7zy
	 CkpHlWh8iFlSMGm74rI47Dt57p87sXBfN3+hkGYPuIZ4chxe77JqkoLGr/2OeDtQql
	 OhxM7wR4Vs/nAR3E+SEKh5uSTcX1uuEcRfdGwvc8kZaEmQxfoswQGuFwykq6wim2kq
	 dTba6lgt1duG6OzLk+64xLbOerc4jDbwgKBLZ4r6zCtP4o2ff7Q+UigKUYPvapgDx4
	 p+d7LczeLmusQ==
Date: Sun, 28 Apr 2024 19:19:35 +0800
Message-ID: <b2667753ee766dad50986cab0072c62b@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.04.14 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IQ6wcPpCxkWN"
Content-Disposition: inline


--IQ6wcPpCxkWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.04.14 version.

Thanks,
Zorro

The new head of the master branch is commit:

0e5c12dfd008 xfs/522: use reflink instead of crc as test feature

New commits:

Anand Jain (1):
      [8aab1f166303] common/btrfs: lookup running processes using pgrep

Christoph Hellwig (4):
      [39afc0aa237d] xfs: remove support for tools and kernels without v5 support
      [049ae4265e4d] remove xfs/096
      [013d374aac54] xfs/078: remove the 512 byte block size sub-case
      [0e5c12dfd008] xfs/522: use reflink instead of crc as test feature

Filipe Manana (10):
      [aa4799f3d2ef] btrfs: add helper to kill background process running _btrfs_stress_balance
      [1237986570e1] btrfs/028: use the helper _btrfs_kill_stress_balance_pid
      [011174eab1c2] btrfs/028: removed redundant sync and scratch filesystem unmount
      [b2a3bc018fe0] btrfs: add helper to kill background process running _btrfs_stress_scrub
      [d6b4a1531fbb] btrfs: add helper to kill background process running _btrfs_stress_defrag
      [058e46de642c] btrfs: add helper to kill background process running _btrfs_stress_remount_compress
      [1305165c278e] btrfs: add helper to kill background process running _btrfs_stress_replace
      [d2e240298b8c] btrfs: add helper to stop background process running _btrfs_stress_subvolume
      [ec3953895cad] btrfs: remove stop file early at _btrfs_stress_subvolume
      [c4d674bcd342] btrfs/06[0-9]..07[0-4]: kill all background tasks when test is killed/interrupted

Luis Henriques (SUSE) (1):
      [e024c6f28b8b] ext4/01{2,9}: fix invalid filesystem option 'journal'


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

--IQ6wcPpCxkWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmYuDVoACgkQlNbPkfr2
tMxSZxAAlqGPBk2Db7G/ybVFZdcoFtR2O+Hy1zeqR4XwAlNeQcKqUPNep4UDsHi6
/18mtzgFC/IMaM+ZRHoVXjw8OfpOC7ZmYw1VSRyE+66w8QLH1k6I3445q14CLjDp
1a7fzHbCzO2FnYelgIfutJl6e32jprVxkSf0op9VLWuPDHxR4mMJbhL2tPqTK/FI
K4mMYEOXhgDlwy2bHDbXEV2jK+5mEJMB6ZamUk34uCyZyQn3B1fK72L/BHiO98G8
69gGpuXd+e/59+9JUKtprLDZDZseAEcte1F2Z6Y357cuIzHmRvXDAowvdOi3FTFd
IOqeJ9A/uhvAGZ7xvqITGeVg1HalKsiiA3uR4FZQER/EttVJPkowGqv83UoIsM1f
a1KlxEqhuhoeN6Nmuq0NFRxlHT+H7RkGQimlcz+ro/zd0AApTOV5FJ4Ib6tjjp6x
79Zw47jQ206Wck+EnKpyvzJzqjGjZxCmfXPP40beXfVr+u1MUmMEVhKvEqrVvn9s
tP37hNuVhqWepnyGdrDD7zza3Ji287Q4dWkcQr25SAnENHeKutSj5pK7t1sdRO8G
NgmsrSB6YkfA5uEqRooxOmlb5yVhIgL+y6Qhc3KkqWQMOASzoFi5Wcaly5zB6cu0
GyCUf1DoEZKofRHtoItHQ+b8Fg5Tucprp2613xQ09WYHIb4YNmw=
=OXon
-----END PGP SIGNATURE-----

--IQ6wcPpCxkWN--
