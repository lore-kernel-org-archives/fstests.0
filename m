Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795724976;
	b=iXuiTb2V1d3XyOBaT4yT/Np2+6LyNTHwz5UvM5Cqg9NbjGm1OJTAc9kOcvuPXaOUdAIe
	 KlTX0voAqjq+VY8zwqKUST96/d3h+IBuZg5lZRjYwtZ//5d45XX1BXf4PJzi6m0ax99c3
	 gLxMZQTR5VexBZtWF3S+Y0UgDbtO4O4tqS8ZHlAAcO2JgiH3nTalfGvZgmnn7NqTSK7UN
	 fT7jY5DZNBLn4b/v6UZzx7r2WQl8JWvZ84DuXIKfRz2VKLZjYqW9Le1U6cUWahGfsc09y
	 mqBHl5u/jk/C3i9/ptq5IDnA6JzyspusioBi0PPyMK6OalV6rqR94k7SZ0wZKPRRxHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724976;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=kXRR/58X6QlNh4CKAwejYAGWjkcx5ZuTkbmpK0Y7Lm0=;
	b=1inKMpT0uOxxWa7QdvjKB2eChx+8YpJutX5zhii7PTD7cV8h/i+R7lcabwzHi9x7eUR5
	 MJMfwA2Nog7QRhV5RLUJjm+Wx1qvgf/bubKlB0i2eI9G/hvOiicqBpMERdQD8PV0n3cpw
	 yCALqf18JtvjmF3EjjzeKHEKQCV4hqVdIeGIgaoBxL+fkhFKJN99MYs1eD9N8/FxDtAsI
	 FDD02JeD5tAmS6aQ63+NOC2Y3JoWrD/USrHtQxdBSqNSJ3AeHo1J1qING8aSXmGONBsH+
	 6KLMG/j3UjpRtJJn0rEvqZgWWxBwexgLjtXMuNpamWhBcXz5f0KFdLeTlcV+OPfjCxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XigDSjy/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5927606A31E;
	Thu, 26 Nov 2026 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XigDSjy/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795724975;
	b=FH0rBqyJR9XsgmpgqmgbeP5oK7DIeUFL/WK3VUU3cDodle3acQAuHxdxFkjAooekAfvT
	 8C3qQr0OKTbPKpqmnxP1/taAKz+P82+Ap3iRBALCErTF/Ly0BMVtuekiJnXrOOL2jIs7Q
	 Otz82mKbaRXtQmR9/RPoS7krV883BNMSXDx2iVsiXHMydxhol9JqQwxtmiwMPjZiESp8Y
	 dketLjUKfJceNDiGCQf4M4WrGYmy1JTyjm1hXoeAHs+/xBgZ41T+I0Mwkg7NPxir/tpCV
	 50YPPWIEEZdyRmTlxiA1FjM7hZei63ysQaSQobr5OzYp33tpnaGC81BTx2e03AAyZXA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795724975;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=kXRR/58X6QlNh4CKAwejYAGWjkcx5ZuTkbmpK0Y7Lm0=;
	b=Wcw9nmx68XfJnpPs7kPFxXPpwccYtn1hd4yvJvIfcDbksQ4g3hUw8boCQZhyrfgtWB7K
	 0hs4yAPYaPAKDNHe6w+gihxVXgsGfUCU+EhOnu4v+Cbxe1OnvWOo+mQo3LoVHxfKt3ufA
	 4INnelRsVJxjxRnVbVA6s7TIqKeL1tz3GAwvoxc7YytPSVp89KrVJkkr6IHLX2C/K/ve6
	 QtClgfDkkllNFNqEe+hkCV+V6AKvhzXPbFI8veTsCUiG7AaFEAhytrvXlYGQt5w0YiuhV
	 WNLf1G8ChoGMhOIBghowHi9I7yNKrOgsr3HB/x1qoyjuHwEF4BhY3OjY2LM/afMwWVA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D47A1F00899;
	Thu, 26 Nov 2026 20:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795724975;
	bh=kXRR/58X6QlNh4CKAwejYAGWjkcx5ZuTkbmpK0Y7Lm0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=XigDSjy/RSERTVD1GJFPOFhlXjpGcVTzEKSaZCXNXSbqDsmw92p5qVWuOweSlOqWN
	 oG9fmGgs5pe9pI/Vf3Xh4Ww/FgQHjlNILwejlsE7OwvZh+23gO6+LbiJIsTIbSbcY4
	 ZO+ozgBIpmCasWKGjY1kDdYg5/z64rs/Vm5mPsjFQ3CrctGQtwFThR0jLoontyhdDX
	 EwK2PA8AHz0Ly1tgypriA2UxP1QqdmH7sOU9uNoJ8nr20QWIDIuWf5yzoaeNZwYu3c
	 dfp4r7O2BY/SWhgFRelKVS2F4ju1RuuvRVGVnfRMbLj3oci2SuDXxy4K/x/KP3ZuoC
	 jsjZRJeFehPaw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 968D54D7F4;
	Thu, 26 Nov 2026 20:29:25 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Subject: [PATCH v2 0/4] fstests: ntfs support and three buffered write
 tests
Date: Thu, 26 Nov 2026 21:29:23 +0100
Message-Id: <20261126-ntfs-reproducers-v2-0-7d5fa5a688b9@proton.me>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ6CMBCEX4Xs2ZrdEvDn5HsYDtAuUhNbsi1EQ
 3h3C949fpmZbxaILI4jXIsFhGcXXfAZ9KEAM7T+wcrZzKBR10S6Uj71UQmPEuxkWKKyyNQhXbC
 mFvJsFO7de1femx/HqXuySZtnawwupiCf/XOmrfdHP5NChcbUp6os7RnLW85S8McXQ7Ou6xcH2
 TiEwgAAAA==
X-Change-ID: 20261125-ntfs-reproducers-d0e1b019061a
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>, 
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
 Ernest Borowski <ernest.borowski.git@proton.me>, 
 Baolin Liu <liubaolin@kylinos.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3814;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=SWS0raqeCoHoC84Ueny9Tod2CHfP/gGmqWmXz0vLsv8=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmyOaUtiVrgVVeYp1V/VUyjkX3n2XfPy50W/XZTbUj5t+
 nPTcGN/RykLgxgXg6yYIkvH/xshPiHfPi2L0+qDmcPKBDKEgYtTACaSH8DIsLBsUpVz+RTzBr9I
 56Zlxy643HASNXae9P+/Qc2Fq2sCmxj+6UmaLnn2e7Lh/2Zz78VX5c7PlXVX+BR4JPad40+hW43
 ZfAA=
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
  at v11 now [2].
- generic/817 runs fallocate, punch hole, collapse and insert range after
  a buffered write that faulted. Fixed by patches 7 and 8 of the ntfs
  delalloc series [3].
- generic/818 makes a short copy into a hole over freed blocks and checks
  that no old data shows. Fixed by patch 10 of the same series.

The tests need only xfs_io and one small helper, src/pwrite-short-copy.c.
I ran them on ntfs-next at cluster sizes 512, 4096 and 65536, and with
4096 byte sectors and clusters. All three fail on ntfs-next as it is; with
the delalloc series 817 and 818 pass; with Zhan's patch on top all three
pass. On XFS and ext4 (mounted with buffered_iomap), with 1k and 4k
blocks, all three pass.

[1] https://github.com/ntfsprogs-plus/ntfsprogs-plus
[2] https://lore.kernel.org/r/20261126015731.3254689-1-zhanxusheng1024@gmail.com
[3] https://lore.kernel.org/r/20261124-b4-ntfs-delalloc-fixes-v2-0-f394c800ec03@proton.me

---
Changes in v2:
- common: pass -i in _mount(), so that it also reaches mounts with
  MOUNT_OPTIONS or TEST_FS_MOUNT_OPTS set (Baolin)
- common: count the size for _scratch_mkfs_sized in sectors of the -s
  size when MKFS_OPTIONS gives one (Baolin)
- generic/816: fail on write errors other than ENOSPC, and report "not
  run" after the checks when the write stored nothing (Baolin); start the
  write one unit before the end of the file, so that XFS and ext4 come up
  short instead of failing with nothing written
- generic/817: add Baolin's Reviewed-by
- generic/818: check the helper's exit status and that the write returns
  between one byte and the readable length; fill the filesystem with data
  first, so that the hole gets blocks that held data; skip with the
  discard mount option and with compression (Baolin)
- all: the added lines pass shellcheck; variables in arguments are
  quoted, and each line that keeps a warning on purpose (MKFS_OPTIONS
  split into words, _scratch_cycle_mount without its optional argument)
  has a disable comment with the reason
- Link to v1: https://patch.msgid.link/20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me

---
Ernest Borowski (4):
      common: add support for the ntfs driver
      generic: check the size after a buffered write runs out of space
      generic: test fallocate after a buffered write that faulted
      generic: test a short copy into a hole of reused blocks

 .gitignore              |   1 +
 common/config           |   9 +++++
 common/rc               |  52 +++++++++++++++++++++++--
 src/Makefile            |   2 +-
 src/pwrite-short-copy.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/816       |  91 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/816.out   |   2 +
 tests/generic/817       |  84 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/817.out   |   2 +
 tests/generic/818       |  88 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/818.out   |   2 +
 11 files changed, 430 insertions(+), 4 deletions(-)
---
base-commit: 71641219a506ac62bfa231592394265ca812670e
change-id: 20261125-ntfs-reproducers-d0e1b019061a

Best regards,
--  
Ernest Borowski <ernest.borowski.git@proton.me>


