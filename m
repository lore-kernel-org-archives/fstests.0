Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8C4126C02
	for <fstests@vger.kernel.org>; Sun,  7 Sep 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757253734; cv=none; b=NBUsKxw7u6TCQBDxavxYSyot7B1EMZRIVQ+WKXUTMQJM1Jwm6lzfRKmz34c4uQE2rzlcu1gjRHuOqrBM8yLhvmQjvt5tm26r0RnCrxYsWQN1Q88o8KSOmcUhAFa80Z4Iln3gYo+4xQxdYKCRbsZjZytop32vTmQzeDPLWmd4U+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757253734; c=relaxed/simple;
	bh=pJI3SPni4wEaTlj9eUR7Ei9RGK2ncOjdhWx1WZuhATw=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=BB1pKXSyVZDmWGeae+sR/63NyN4yiomBVRR//mw3jWvAGI1yeTSEcLK41IdMQ3PvCNBr3XVRfDHQG4n8n28tMnft9AV/ZgJe5Ou7AtTS9ERGNYqlbVoWE5Y2+NAcYFfriahddm4lLacOoEEfqZIiR43p6LJpWfl7uYpOb/+txf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeFl+MZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeFl+MZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D28C4CEF0;
	Sun,  7 Sep 2025 14:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757253732;
	bh=pJI3SPni4wEaTlj9eUR7Ei9RGK2ncOjdhWx1WZuhATw=;
	h=Date:From:To:Subject:From;
	b=OeFl+MZQQPnWh0LDbOMad6BF0/BJ5IuOml4pjNps8E64nH6L+OnvOQlzNOQ2V/UQT
	 ASM3tUZ1yzpBzDGdSCn+Cr6BvIP5FfZnd/z6l4ibiKtHwz0E3izmKBQtZ4yIz1XA2s
	 3ePyHQkXMTT5SqFJ62gfO5SrWJilpC6jDGHmAuqZgXPeay8Qn/9oZYF5v++oNt4Xz8
	 ZSxzVDDG9aLhFxt2al6YaYnTzb41AVW7HdMhTT7/+gpvOyEGtKGEpK7ykig7gLkyNI
	 VjXV+4YnsyJ5Tz5nTSjhptfLG+I2gRZZAzKjkZwQflPML1HXeirWApUoNVx4/+BHGO
	 zveKy3Bsd2E2Q==
Date: Sun, 07 Sep 2025 22:02:08 +0800
Message-ID: <dc12aabf7d5a337098d1b52f19dd728c@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.08.17 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pNNYPsVtqQFj"
Content-Disposition: inline


--pNNYPsVtqQFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.08.17 version.

Thanks,
Zorro

The new head of the master branch is commit:

5a9cd3ef1b33 f2fs/012: adapt lookup_mode=x mount option

New commits:

Brian Foster (1):
      [3e802fc7c387] xfs: test iomap zero range via fsx and error tag

Chao Yu (7):
      [88aa818b3325] f2fs: test common mount options
      [f1cb492c2b65] f2fs: test special mount options
      [785d75ac4918] f2fs: test mount options for zoned device
      [3c4fce2127c9] f2fs: check data eof after partial truncation on compressed cluster
      [7d38f690bf85] f2fs: do sanity check on mapping table
      [97faf40fc28d] f2fs: do sanity check on i_xattr_nid
      [5a9cd3ef1b33] f2fs/012: adapt lookup_mode=x mount option

John Garry (1):
      [00dced3f6730] generic/765: modify some steps to fix test

Zorro Lang (1):
      [b076a3a72941] overlay/005: only run for xfs underlying fs


Code Diffstat:

 common/rc          |   3 +
 tests/f2fs/012     |  13 +++-
 tests/f2fs/015     | 121 +++++++++++++++++++++++++++++++++++++
 tests/f2fs/015.out | 173 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/016     |  50 ++++++++++++++++
 tests/f2fs/016.out |  33 ++++++++++
 tests/f2fs/017     |  40 +++++++++++++
 tests/f2fs/017.out |  21 +++++++
 tests/f2fs/018     |  84 ++++++++++++++++++++++++++
 tests/f2fs/018.out |   2 +
 tests/f2fs/019     |  42 +++++++++++++
 tests/f2fs/019.out |   2 +
 tests/f2fs/020     |  51 ++++++++++++++++
 tests/f2fs/020.out |   2 +
 tests/generic/765  |  40 +------------
 tests/overlay/005  |   1 +
 tests/xfs/131      |  26 ++++++++
 tests/xfs/131.out  |   2 +
 18 files changed, 666 insertions(+), 40 deletions(-)
--
Zorro Lang
zlang@kernel.org

--pNNYPsVtqQFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmi9kAQACgkQlNbPkfr2
tMyJaxAAkQ9B5JLBfhd6d529AWQwT+ERu07cl1IFA9b8kjHu9eVZIH7Mrv0E+VkE
1zSRYQ8zDm23WOih0fsRy1GbzJI3ETW2oT4yqZHBU2HRS1P7xOmraNsBtTkZx557
vFLIn5bjLlG7NOYTVNrmzuJ/A7xLaymCAuAtyXjgH5GWIxY4aQp4C64PrHXlSrGA
mb7Japft8Htf56PFbenaJSmaOjNSvtsHmWEF1SFnhTHRq0yma37LCJTdfZe3LImo
S9/+Sxazg0ONKvBOQIWFOxayZfdHuYsoTz6zA4jE2SjptfVRz/pQ8YSs/5yuQQRU
VK/h9c7UMBZ28Oe/oxR5wmEUepFv0w+iaRHz5iCpeT7ZhnkT6e20zRT0voI+gX1Z
6+hmGdPuA8Ribk96zowdH9vya296BVLX6Pf1fUEkG3aND3xOofyktmyTX7S2zp4t
xXvyBA2lma19nWiWg1zNqwAnibOU9mNn7fH3pnZelYBZ5DP/J4a+saQwY8ACYu6g
FDlV4xXAF8r0Q//UyfhEbpc9k5O6TPGqveuPnE7RFAsc4nkYlNs11x7AyON7brts
B+cDGAqxVyDFEUzLEA0q2QY3577diWAnAe2j9j57QIsIzk1h0Dki9eQHiu8DFSh6
BTy2utC2LzNhQvxn1HPopziINoc9W+OvkDYjQZ37cUU7cnDlh2I=
=ube5
-----END PGP SIGNATURE-----

--pNNYPsVtqQFj--
