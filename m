Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795633429;
	b=BC8Z/xnp6eDjIWuXEERJk+6t+qVcSz9RuFlmgbGAPEub2okFmtiuyJFCE5MNqB1mzQYj
	 8tvOrAc37i4sB6Is+fiRupXHdIxx4Txkzg4wjJrBgtFCnzJYV7ZKo7r/6kpEjpIRTV3PG
	 COdoJLzihO5FJ0j90QuMlR+c0qK3W/v7+7sMG7CxK9W7RUafPshpYFCWwxFdiUDwuGb4j
	 ARJFX+aGIqNnm9aNMeGUKb9qtql0Gnq+Vg41aGP3loze6LXSWXkk7sJQAfVMOsig8osgH
	 iapf4yq1xoZi2+F3Ta7oh5oUpWA1DrEuE8EQ8aokdqJdeQep713fMgFOwa/qJSMSvSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633429;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=uV1aI5FL9ieuBnbzhsUSHEOnbwBzA9+r3BgTJtby51A=;
	b=LSU7lr+fpdiJTKzvhKLd52b/97QYlFLPaL6haeSbvyX62S7CskheE99ZRbYjhg5mP+ia
	 cr/94TsmaIPKEkWfKkoCNzvM9OU3YTq7u8cFxF2zfinFDX76ogFdx4mwdUcnd9cZJoaHN
	 hEtyDm74RHPyd4xEygz1BhHwLgXeiEHqrytLO7flDUPccgo/dn69mqBA1Aqfm2irkmJQx
	 xW+p9v8wKybvtvnh0AoFbvhQejMZYAiacHfc0qTMBZUWXiI+P5MhPbHPixUMWv6STLHsv
	 RGeKqi1cbY+Zg2i/K9VYoPug9lyo/ddDGmjk7tTGlq4gE/5kXyXRVa5GpCf9Cr9s9RQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFQKVfXU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C51606A31E;
	Wed, 25 Nov 2026 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFQKVfXU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795633429;
	b=TfE1kpfXpmVqOoqn/rZtO5BEByeqqlNOYxxLFHpkyiaYedB6AnJc2CtMGCUqQKlo6kjN
	 bN4cUdHNn8PmEEtzH48WnerhslDIbe4vK08Smg0rXLE24LlVvCUIUjF/g4qxPhsVMb75t
	 /hNFBDRNcd6WI9MjYuEghd27Un3kuK3Xn+xfoyzM2LGA+Kr78i3ZjxwQ5/GH5zdb0AFiv
	 NajHNA0AVnU9i9HOWpk7I3SrGhxzOoU29tehPxTJBuFXzggC5Uy3aj96o+jrP0fVK2a5p
	 FqBgg4s1+nu10es/9jS46vrQiaM3R+xXKeHUgCF+aDGB5C+vR7+WbDffG/K61iQxcrw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795633429;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=uV1aI5FL9ieuBnbzhsUSHEOnbwBzA9+r3BgTJtby51A=;
	b=wkTXZ3P+mFlNgYxxc1M0Nrqc2InrSninQx4uknwf6fGp6w2TaLho+0L45QUA+2Ek1A0D
	 SgD34UNJXsScZRx7BsI5O4U0mX5HkpVy+FzrLuOuz9PjtuiAMvJPrKrVtRXNjH/LRzaAH
	 Z9Ztl74fWzPHXuhy1gUB7pzJLLD5iSdC9C47ugRY2aLyvL+luxJg4X0qQ87w4+Rf1BvC1
	 oe78yvRHCGbx8F6PAs6DP8LSQ8YD01kb0L2TDk6vuyRCjKIihUwuisIrmCcTmJ5ynDKdn
	 Rd/7aSkTLUcSyr07JiayfWyyofs14G4tXGh90XP0xvhp191EYR/UAGYdq5jdJDUYinQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8FF6B1F000C6;
	Wed, 25 Nov 2026 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633429;
	bh=uV1aI5FL9ieuBnbzhsUSHEOnbwBzA9+r3BgTJtby51A=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=PFQKVfXUDZIQE/HIx1cVpZWp8l0eFirbuW1JCG4a574G9QZ+xJSIbB9YmlGO5CLgc
	 x9wbIJguZWvbYR6MFS0264sTeMnbUlOumHpvQz8BrwRDawdSJg0VyajN+FfIcgqY+A
	 wb5vBxwPJFhvo0UDfPTLZ7+m7u7aJpnKvSx0gBLs4/8jcmWJepu+dH7MJOXtmc8aH2
	 NGhLZ7cF82qr714UOuCoXHEY0myw/EbS0skIRWjkVL3owg56N1iJKxe4RIcm4FkRVv
	 A14K/Sbpz5kWCklKtLOJgTviosXCug55qWtOjKxFcdTKndUfPgwmgfI0Mh0P5YnYkz
	 wW2ntUPfJF6+w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E51FF4CFF4;
	Wed, 25 Nov 2026 19:03:43 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Subject: [PATCH 0/4] fstests: ntfs support and three buffered write tests
Date: Wed, 25 Nov 2026 20:03:42 +0100
Message-Id: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrBvIBBTaq4gLTX7tdBFlRosg3
 t20Lr/FewcZVGD0qg5SfMVkzgX8qCi++zzBSSqm4EPDHGqX19GcYtE5bRFqLnnw4PnpG+6pZIt
 ilP2/bLvbtg0fxPX3ofO8AJT3HC50AAAA
X-Change-ID: 20261125-ntfs-reproducers-d0e1b019061a
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>, 
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2462;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=XBaQBfKYzKkAfsMoyeeX7k9F8LyBCcyRyZ9ahXpBzLg=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmx2Q75f0vVsKXEdK/d+MrKc/PqpwykPZudlG65fm+R76
 cyqJ+ZlHaUsDGJcDLJiiiwd/2+E+IR8+7QsTqsPZg4rE8gQBi5OAZhIpgEjw5OvIRu/XxN5v72A
 rUYucZa4p9a8BwlRn/kTQxZoqPbXmTAyPBSJvuPLs+//w+i4ggNVMjMcK0NnLjB5P/vM8od+cp7
 JnAA=
X-Developer-Key: i=ernest.borowski.git@proton.me; a=openpgp;
 fpr=88FFD8544C54F6F2A65E2A8E730769A37A6214FF
X-Endpoint-Received: by B4 Relay for ernest.borowski.git@proton.me/default
 with auth_id=1589
X-Original-From: Ernest Borowski <ernest.borowski.git@proton.me>
Reply-To: ernest.borowski.git@proton.me

This series lets fstests run on the ntfs driver in fs/ntfs and adds three
generic tests for buffered write bugs found in it.

Patch 1 adds FSTYP=ntfs for the kernel driver. Volumes are made with
mkfs.ntfs and checked with fsck.ntfs from ntfsprogs-plus [1]. Mounts pass
-i, so that mount(8) always uses the kernel driver.

Patches 2-4 add the tests. Each names its fix with _fixed_by_fs_commit;
none of the fixes is merged yet:

- generic/816 checks the size after a buffered write runs out of space.
  Fixed by "ntfs: trim the sizes after a short write" from Zhan Xusheng,
  at v10 now [2].
- generic/817 runs fallocate, punch hole, collapse and insert range after
  a buffered write that faulted. Fixed by patches 7 and 8 of the ntfs
  delalloc series [3].
- generic/818 makes a short copy into a hole over freed blocks and checks
  that no old data shows. Fixed by patch 10 of the same series.

The tests need only xfs_io and one small helper, src/pwrite-short-copy.c.
I ran them on ntfs-next at cluster sizes 512, 4096 and 65536. All three
fail on ntfs-next as it is; with the delalloc series 817 and 818 pass; with
Zhan's patch on top all three pass.

[1] https://github.com/ntfsprogs-plus/ntfsprogs-plus
[2] https://lore.kernel.org/r/20261125051247.2880928-1-zhanxusheng1024@gmail.com
[3] https://lore.kernel.org/r/20261124-b4-ntfs-delalloc-fixes-v2-0-f394c800ec03@proton.me

---
Ernest Borowski (4):
      common: add support for the ntfs driver
      generic: check the size after a buffered write runs out of space
      generic: test fallocate after a buffered write that faulted
      generic: test a short copy into a hole of reused blocks

 .gitignore              |   1 +
 common/config           |   9 +++++
 common/rc               |  37 +++++++++++++++++-
 src/Makefile            |   2 +-
 src/pwrite-short-copy.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/816       |  67 ++++++++++++++++++++++++++++++++
 tests/generic/816.out   |   2 +
 tests/generic/817       |  83 +++++++++++++++++++++++++++++++++++++++
 tests/generic/817.out   |   2 +
 tests/generic/818       |  58 +++++++++++++++++++++++++++
 tests/generic/818.out   |   2 +
 11 files changed, 362 insertions(+), 2 deletions(-)
---
base-commit: 71641219a506ac62bfa231592394265ca812670e
change-id: 20261125-ntfs-reproducers-d0e1b019061a

Best regards,
--  
Ernest Borowski <ernest.borowski.git@proton.me>


