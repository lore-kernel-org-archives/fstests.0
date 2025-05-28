Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB827511C
	for <fstests@vger.kernel.org>; Wed, 28 May 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423749; cv=none; b=WZp05G4I4KvXXpoGiZVuwpRUDRYJaTF6DU51R6/mmUNS8I7pMuX7KTDub3f1hrNNqYLcZdydjhtR40yck/kn0tEChrTZlK5lLtZSjH/06mwKfn/J1WUg+nNAXIInwhoatqB28FLZrqEeDK+KvyqoEBQ6p1+HN3Hoe92LZl2q/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423749; c=relaxed/simple;
	bh=ICHNk3GGGKFWuvM30zL5nHdbp6rh5nlQ6QIAkbOQbU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9zmdTjh7G6oxubg7bj/oqzGU7KSr5krUH4XFX3uutR1XwdWdlimZbNMkffGuSgZwICuFa860alrFZDlA9RvOmf5a4EPGoEbjlZ+J+lBNgniFe6k2ABl+bzzSVGDWTJwpLycBb6LxPEJl49EcW4ZD4O+FXzIHDKlYWVqyVswHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=hyIt1Q5q; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="hyIt1Q5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1748423748; x=1779959748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eE1Qf5YVQlEQ0VGtQnH7ca1Vy1tIo+uWJ2K5P3sdgHs=;
  b=hyIt1Q5qrx/DlYXNQIBZWNjNpzbAIsSYeDof0GCscnuBs4P2CkmmRk/m
   DbMMlq4HqCYuorQbi9C5iMakS1t/xwjyF1IEds5sBZPkicZfmY2yKV6iq
   RDBkqNUgE/Jg2GRsBfWd2VClW1bP6HHDwvDj/HT7+GVZhBXAK9Y1CBWaO
   TK8U037YwXpehX83sltf1Iu2eVdHGyYaEy5nwMixd2tjVaLgWPB/Qmy7Q
   WzIzvwk0UK8LlTOSSWKFGfbwXpQMB5BGWJF63JGpykSlGPP4RshQ0V8hA
   AwbGkd2qiGRbXIONg0sqlk0cq9HYjb5+LN6n5XOP69Pyn1aJz1a19C0iw
   w==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 18:15:34 +0900
X-IronPort-AV: E=Sophos;i="6.15,320,1739804400"; 
   d="scan'208";a="534970985"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 28 May 2025 18:15:33 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	friendy.su@sony.com
Subject: [PATCH v1 7/7] generic/633: add test requirements
Date: Wed, 28 May 2025 17:15:30 +0800
Message-ID: <20250528091530.1218188-8-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the following test requirements are required by the following
sub-tests, this commit adds them to this test to avoid failures on
filesystems that do not support them.

requirement | sub-tests
------------+-------------------------------------------------------
hardlink    | hardlink_crossing_mounts tcore_fsids_mapped
            | tcore_hardlink_crossing_idmapped_mounts
            | tcore_hardlink_from_idmapped_mount
            | tcore_hardlink_from_idmapped_mount_in_userns
------------|-------------------------------------------------------
symlink     | protected_symlinks symlink_regular_mounts
            | tcore_create_in_userns tcore_symlink_idmapped_mounts
            | tcore_symlink_idmapped_mounts_in_userns
------------|-------------------------------------------------------
chown       | hardlink_crossing_mounts rename_crossing_mounts
            | setid_binaries sticky_bit_unlink
            | symlink_regular_mounts tcore_acls
            | tcore_hardlink_crossing_idmapped_mounts
            | tcore_hardlink_from_idmapped_mount
            | tcore_protected_symlinks_idmapped_mounts
            | tcore_rename_crossing_idmapped_mounts
            | tcore_rename_from_idmapped_mount
            | tcore_setattr_truncate_idmapped_in_userns
            | tcore_setid_binaries_idmapped_mounts
            | tcore_setid_binaries_idmapped_mounts_in_userns
            | tcore_setid_binaries_idmapped_mounts_in_userns_separate_userns
            | tcore_sticky_bit_unlink_idmapped_mounts
            | tcore_sticky_bit_unlink_idmapped_mounts_in_userns
            | tcore_sticky_bit_rename_idmapped_mounts
            | tcore_sticky_bit_rename_idmapped_mounts_in_userns
------------|-------------------------------------------------------
chmod       | protected_symlinks
            | tcore_protected_symlinks_idmapped_mounts_in_userns
------------|-------------------------------------------------------
io_uring    | io_uring io_uring_userns tcore_io_uring_idmapped_userns
            | tcore_io_uring_idmapped_unmapped
            | tcore_io_uring_idmapped_unmapped_userns
------------|-------------------------------------------------------
mknod       | tcore_expected_uid_gid_idmapped_mounts

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Friendy Su <friendy.su@sony.com>
---
 tests/generic/633 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/generic/633 b/tests/generic/633
index f58dbbf5..e19a2043 100755
--- a/tests/generic/633
+++ b/tests/generic/633
@@ -13,6 +13,12 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
 . ./common/filter
 
 _require_idmapped_mounts
+_require_hardlinks
+_require_symlinks
+_require_chown
+_require_chmod
+_require_io_uring
+_require_mknod
 _require_test
 
 echo "Silence is golden"
-- 
2.25.1

