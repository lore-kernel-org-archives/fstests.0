Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18741EB9E8
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680279; cv=none; b=RWl6ZD0ksI7UdqezOX47hIKglSBD4Mt67s0OrNw7Gni/JTHhnjSSGtSfrk81h6ANGu1vfzE46x6c84dVWh05jvIs/ZxHkCdeKu8fDUSXj8TQ5k6DEewiySca4t6Ho2nC3KmnFB9jO7SvwjGkVl8re4wElDVLkK/zMQrlnWJN2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680279; c=relaxed/simple;
	bh=JtORvqb0o9MIu77+gkKC9qpeB7WkMNSWAwBvZCooKgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFJCDbONrQqp1mE1NE4zk1NR6EDcjx2Ph2CRmzTex+tQtjD6KtIXrch5CeNIa9jYlQradtKih2iKH0Y4WWfCIhZIvCXIUW1/tj92dtphNoFn6v5Eh0a1R5fUxWUtvy+JQHs4bNgt404QKa4ezFYFaBrjE8Af6ou3x/ZdFUXSk0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6x1kcSE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6x1kcSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF84C4CEE9;
	Tue, 11 Mar 2025 08:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741680279;
	bh=JtORvqb0o9MIu77+gkKC9qpeB7WkMNSWAwBvZCooKgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6x1kcSEGedOAfnUUBoYd6b3rklwKu7mUOC57IkZrcjgZczC6iflr/LxLiYhARSFP
	 KYGnV968XQgulgJyEQ+6uNzgNRWc3ev+Aaw93Z8vSt8kz07m5UxpAnVGSZS4b6sZo3
	 HZCJY2pCAX9nlxzxoWK+MoSiVDikbi4UmUgz5GD/6BmOg1MBmCNKvlQAhXomF1dM1V
	 j4TPRTJRwPBSvHR9+vTsaHprfft7vGp/ZNX2oVEPBXusHzx8K34tOmk4gckg19RhGN
	 Twk2dyeZgCeDatHM23IGxxkBdnaalHjBSFiQAhwse80aDJbxeRuHl5yJp8MnYzI3UB
	 5ckN3gsBcD8xg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 3/6] common/config: export F2FS_FSCK_PROG
Date: Tue, 11 Mar 2025 16:04:27 +0800
Message-ID: <20250311080430.3696582-3-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250311080430.3696582-1-chao@kernel.org>
References: <20250311080430.3696582-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's export F2FS_FSCK_PROG, then we can use it in
_check_f2fs_filesystem() later.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- export F2FS_FSCK_PROG, and it will be used latter
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index 7d017a05..79bec87f 100644
--- a/common/config
+++ b/common/config
@@ -317,6 +317,7 @@ export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
 export DUMP_F2FS_PROG=$(type -P dump.f2fs)
 export F2FS_IO_PROG=$(type -P f2fs_io)
 export F2FS_INJECT_PROG=$(type -P inject.f2fs)
+export F2FS_FSCK_PROG=$(type -P fsck.f2fs)
 export BTRFS_UTIL_PROG=$(type -P btrfs)
 export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
-- 
2.48.1

