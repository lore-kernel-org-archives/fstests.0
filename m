Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2F24A069
	for <fstests@vger.kernel.org>; Tue,  4 Nov 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270339; cv=none; b=UqrpmKNq8OFYRwVoBJEaltkAdXk1xfWxRDOMEBv4TN/qOEi0GkVGf0PDNahb8azi8oLWb79PuQWQhAynxDK4fOUDUSvM7PSvAdyP2AxYDavMQX4J306lrrJpkAW0T0l13ufW33A9TUMGM2sP8NWXajllKfrz5+zMIDxFWcC6uWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270339; c=relaxed/simple;
	bh=w5TXZv/vZRUJi4a6pYXQjFS9QVEEZq2cTgL2lo3Ha38=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=ZF9v+pkfAZ+0cgmtKJMlkXqtNozA9dKNYfn6bssYKEoTi5teIC0ZVsKFVW3c1cET5H6GdIARvTVnCIHcuQ1SjpRiT41q0QSzQY9txP7P4+DVlTcF3ErS11V1thgvqjQlXvMA6XaT3oFZWBR0EWvUxvkpVyAu1cBHlvBs87Hq/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHAAWwBw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHAAWwBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7505AC4CEF7;
	Tue,  4 Nov 2025 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270338;
	bh=w5TXZv/vZRUJi4a6pYXQjFS9QVEEZq2cTgL2lo3Ha38=;
	h=Date:From:To:Subject:From;
	b=XHAAWwBwBeXjCe2S6lkoL+SG9GNTi0mjOGC9UdFPjf8P3Rneyz4Mj4pUQ8NQhYawr
	 xxbsW6KRJpAhzzHB8JXWFQULZcdJgLhKP2XwpThAnJwVcXjcQEy/EltVtJTJHLOXOQ
	 Oh9xyoe8rw6A7bl4jy0ABpOV+RKBEt3Q+1avjXMQAn1poPSvdXCzrv6u7JlBAavpd3
	 12DwNllcSSWkHrTZ+B9hLkXDpSAsrIPLS4fW6UGqii5umXZOoiYoFnWFeGpiihVA8J
	 IyGekv7agSk6dW7jmDog76tSKGLCkJ5KWk/AZLjLJj5LeS6F4DzHg29YXTngifFqB7
	 xR7nDM+1IbSow==
Date: Tue, 04 Nov 2025 23:32:15 +0800
Message-ID: <3604cad45daa8ceda5ed7398cae25089@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.10.20 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nen5sO3jIr1c"
Content-Disposition: inline


--nen5sO3jIr1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.10.20 version.

Thanks,
Zorro

The new head of the master branch is commit:

c4980080ba76 ext4: Atomic write test for extent split across leaf nodes

New commits:

Chao Yu (3):
      [2323b5895033] common/config: source common/f2fs in _source_specific_fs()
      [220641d07dfc] common/rc: move _check_f2fs_filesystem() to common/f2fs
      [f38becbd9056] common/f2fs: introduce _require_inject_f2fs_command()

Jan Prusakowski (2):
      [3636f4c34799] common/encrypt: Explicitly set the test file to uncompressed
      [cd0431fa4fc5] f2fs/009: Add delay after killing socket tool

Nirjhar Roy (IBM) (3):
      [6a81db9f1809] generic/562: Make test compatible with block sizes till 64k
      [b0e58387ca45] btrfs/200: Make the test compatible with all supported block sizes
      [b2e5d361b2e5] btrfs/290: Make the test compatible with all supported block sizes

Ojaswin Mujoo (11):
      [9d7e60fead50] ext4/060: Skip for dax devices on non-4k page sizes
      [c6cffd0ae6d4] common/rc: Add _min() and _max() helpers
      [a346de1bb28b] common/rc: Add fio atomic write helpers
      [1ba22a572c92] common/rc: Add a helper to run fsx on a given file
      [e2bc78e9d340] ltp/fsx.c: Add atomic writes support to fsx
      [1499d4ff2365] generic: Add atomic write test using fio crc check verifier
      [9117fb93b41c] generic: Add atomic write test using fio verify on file mixed mappings
      [d2d43c22229f] generic: Add atomic write multi-fsblock O_[D]SYNC tests
      [df9d27baa9e9] generic: Stress fsx with atomic writes enabled
      [ca954527ff9d] generic: Add sudden shutdown tests for multi block atomic writes
      [c4980080ba76] ext4: Atomic write test for extent split across leaf nodes

Ritesh Harjani (IBM) (2):
      [3a530a3f9e8b] ext4: Test atomic write and ioend codepaths with bigalloc
      [4bbc4694a052] ext4: Test atomic writes allocation and write codepaths with bigalloc


Code Diffstat:

 common/config         |   1 +
 common/encrypt        |   7 +
 common/f2fs           |  71 ++++++++++
 common/rc             | 132 +++++++++++-------
 ltp/fsx.c             | 117 +++++++++++++++-
 tests/btrfs/200       |   8 +-
 tests/btrfs/200.out   |   8 +-
 tests/btrfs/290       |  16 +--
 tests/ext4/060        |   4 +
 tests/ext4/061        | 155 +++++++++++++++++++++
 tests/ext4/061.out    |   2 +
 tests/ext4/062        | 203 ++++++++++++++++++++++++++++
 tests/ext4/062.out    |   2 +
 tests/ext4/063        | 129 ++++++++++++++++++
 tests/ext4/063.out    |   2 +
 tests/f2fs/002        |   1 -
 tests/f2fs/009        |   4 +-
 tests/f2fs/012        |   2 +-
 tests/f2fs/019        |   2 +-
 tests/f2fs/020        |   2 +-
 tests/f2fs/022        |   2 +-
 tests/generic/562     |   2 +-
 tests/generic/773     | 108 +++++++++++++++
 tests/generic/773.out |   2 +
 tests/generic/774     | 132 ++++++++++++++++++
 tests/generic/774.out |   2 +
 tests/generic/775     | 138 +++++++++++++++++++
 tests/generic/775.out |   2 +
 tests/generic/776     |  68 ++++++++++
 tests/generic/776.out |   2 +
 tests/generic/778     | 368 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/778.out |   2 +
 32 files changed, 1621 insertions(+), 75 deletions(-)
--
Zorro Lang
zlang@kernel.org

--nen5sO3jIr1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmkKHEsACgkQlNbPkfr2
tMzDNA//Tbm11PRLBaqAJ5rF1sORfOhKMSGPt2ii4YzA17NelM2iZ1NTq9v3b0gl
w31Fxkm9lD7H075B27p8yfTl9ucEHLvnhibWI6fZyHS2XfK0FFM5qVXIuFap2KT+
4YpRlVdMVvqkqwV/gHBiXLqG73XvpBOZrV0nJ1U7OwNb3KyzKNGiM2kv0MsgpPoT
+yHbVpI/JAoaUeJvHNrrj8vpTwaL8GyJ+0Xf8r7qPcP00gZXiT0bxOLg8yvJDi9M
FAp1xlQBaRimv1LoBOayDvOhfPT3CQ6g2etX1eltvX6Mz3Djev2z3Q4SYwucjE7y
4mYsoIY2+tQxpzckbF8kYvm2qKpz3eTRqUO3CT33WRWlyyFpbmWr6p7C8oHWl+qU
SFynM1mTBhq3pynVORz8UeREcrVMjvn+yzwBWXRa4J04v65bvhg5NV3xS+M093oD
F0lLhnZsSlj+tToIR5tjvVtB06tOogWPn3HolPsGaoV+t6RVUopef52ttF2gUHFc
hOC/XXXLiEZJxfUsmlcF5klGUD3dvGXAyOpQr8IHmzpgrnKjakFDKiiSj+NC2DgP
Zi5c4YEmbHvqsmj6itZ4Zwj4yuXgDD4QB1MLP+0Cg2c6qMRH+HgMniMxdt3czPuY
tcNSh0X5R9FWGvunDY3FfO3QtlmMQCMZ/bTybtLk795VIi2Qlp0=
=Yrii
-----END PGP SIGNATURE-----

--nen5sO3jIr1c--
