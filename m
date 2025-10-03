Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AD927144B
	for <fstests@vger.kernel.org>; Fri,  3 Oct 2025 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534937; cv=none; b=M9rZOdep8xXH7495VmTUCMsOnGZaoxZ/7X1fjYLph4LTBTHI4pFMlcpZOXkg3hAXzA+ySW/qxs8u6VEin8al7DSHeQHjKly1QbaUUS7zynhyLk4YVGxi6nmm2e7c6ULet5fv9koVg86sCA0nruVyX6SWwTws1KRwrWtaV9l5Moc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534937; c=relaxed/simple;
	bh=tcg1k8qmcA7ppW89ThcuHm8QTTXa0pmI5k4i30Ab6zg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOK9iCJpKjQdLVcbtizCBrXws4hOmUggkuJN4jk5GoPIkGdYLCU3vjtcKPUx6bd9w+wgFyJAEXZ/QSufXDZSk1gvHQogO60DIn1N21pEkRmtkRPKi+H+wpcTitSwpg7DHe7nD+ncUx7nE97FS4hXugSdTBvVG6CRZRW7vuosxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPLejyu9; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPLejyu9"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-77f94aa7d42so15323027b3.3
        for <fstests@vger.kernel.org>; Fri, 03 Oct 2025 16:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759534935; x=1760139735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6y2imsz2UEzCeAk6bet/zQDziycQ2A4Fqgbbs/uLbIM=;
        b=JPLejyu9xZZQ1sboh9eXzs+5ncqO0v3qZ5Ha89L6GO6MQVBRcUxGW3aPz22Prj39jB
         dDiF3iy3P/umFnUOKsy4v+iEBe8O7hWuadIL0Nw0Ma1Id0TBpNtmwnER9NIwmFehBdVs
         PA3pGA94MV3pAvxOWONthJGFn5UsxsgGSbwzUbXtnCSAOaniFNTDav45PO2Y7lfuyF18
         qRnXt/hlb6BrX3zOWr98IdkF5tMPapBBy4l3QAbZ+PBu6RBIr1Cc4aOZO7Q4e3AoiC/W
         Bm2B8wxto3UZI6zvnIMGfl1Vdn1DDwgqjHYQeL5tfi5VsT6SscbmgAbJrNh05BT5aAej
         w3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759534935; x=1760139735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6y2imsz2UEzCeAk6bet/zQDziycQ2A4Fqgbbs/uLbIM=;
        b=ifLT++6gZQd30g5LoynkKUB/r2/3IwXxntmiTC8suz6KAcSo6m55wHdJo6v5/8oyCh
         efOACLyAx2glwmy0cMtEc6bCORQw53U/mRv8plUHEWQHULZXOjfpFsuMqk2xvbHdnDqi
         AOLjt/GgSv/rAP0C4CkqvduphF8Cn9CrziyZfUPfVg0PHMP7tM49l7t36782cqwvG7XM
         71lNlpWIyzhQvM0TrchaohQOrnV7jlJPjsA4YmB4+jumowLFIXm1f/RrJ8RhVmE2rGeH
         o2VCOSMKRNmm8yRLKLeIxRKgG4wvf7IDpU/Ue1vX8vQqk3gSnkLBBFND3sWj7rhRg1Da
         B7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTU5v/LA8ZlQlRQMNX930yZYqD1phhSo43+NF9MuJ6JgBFku2TLiaUSCz3OjqYvN4zh53IRv2p@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3YyehO58n/72g5jtuZnPoxrXwlzEMxSLqTF23ySnwnVcV+9hk
	ksakDKYrAtCYWcA4SPCSi19HThGXcYwrr1daQAJfOqexFnja+Zd9WRur
X-Gm-Gg: ASbGncvZJ7TqBJi5DgQeTRSJbX5m4hFRFsIQNJmSAaN2rkCG81k/eVytP74zfmxdkyZ
	+Pufsy1x2umWR0E3c4E2DrWoAce+Vgg1pfVyZcM/Mthse1IPdZ5Msv5xAYT+YJUl3bOMwKPeirD
	WN4e5gFgJm5MxVvR6TAOCdkHqFKXUM8NXK9IZnop2lPUOYS3khBs1ZqEj5BXa65PE0FzMhzd4dG
	RlkI2MjNqgRFQQ3avdiy5iOk2Xj3TyeBvwdAqTKzZlPpxMBVw/SrcvmlIW+ggOyfI/LOLts+whs
	syvWds0KyN+WZOYZV2pjSQHZN5t+uXxK2yW5WoInzHHdgssXCbZv3NHQ7VqvXcqo/s6DJp6D3rl
	wfwyjmpU02pKCubweNOb65u+bGNFOOLRyCwOw3TKHiSmWQ3mKu1h+
X-Google-Smtp-Source: AGHT+IE3DmBIkqOFv87x0y1X1auPQLKd7FRAoNWobPV9xfptkh66yMw9S1n6km3PBokqeww8rH+8jw==
X-Received: by 2002:a05:690e:1584:20b0:635:4ece:20ab with SMTP id 956f58d0204a3-63b9a11110amr4605114d50.48.1759534934791;
        Fri, 03 Oct 2025 16:42:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63b84690b4csm2164978d50.21.2025.10.03.16.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 16:42:14 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: remove ffe RAID loop
Date: Fri,  3 Oct 2025 16:41:57 -0700
Message-ID: <a46aa0e4fb936ab73748fc9fd92a9404380769b1.1759532729.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759532729.git.loemra.dev@gmail.com>
References: <cover.1759532729.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes the RAID loop from find_free_extent since it
is impossible to allocate from a block group with a different
RAID profile.

Historically, we've been able to fulfill allocation requests
from mismatched RAID block groups assuming they provided the
required duplcation. For example, a request for RAID0 could be
fulfilled by a RAID1 block group.

2a28468e525f ("btrfs: extent-tree: Make sure we only allocate extents from block groups with the same type")
changed this behavior to skip block groups with different flags
than the request. This makes the duplication compatiblity check
redundant since we're going to keep searching regardless.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/extent-tree.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a4416c451b25..28b442660014 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4171,13 +4171,8 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	if (ffe_ctl->loop >= LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
 		return 1;
 
-	ffe_ctl->index++;
-	if (ffe_ctl->index < BTRFS_NR_RAID_TYPES)
-		return 1;
-
 	/* See the comments for btrfs_loop_type for an explanation of the phases. */
 	if (ffe_ctl->loop < LOOP_NO_EMPTY_SIZE) {
-		ffe_ctl->index = 0;
 		/*
 		 * We want to skip the LOOP_CACHING_WAIT step if we don't have
 		 * any uncached bgs and we've already done a full search
@@ -4477,9 +4472,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 search:
 	trace_btrfs_find_free_extent_search_loop(root, ffe_ctl);
 	ffe_ctl->have_caching_bg = false;
-	if (ffe_ctl->index == btrfs_bg_flags_to_raid_index(ffe_ctl->flags) ||
-	    ffe_ctl->index == 0)
-		full_search = true;
+	full_search = true;
 	down_read(&space_info->groups_sem);
 	list_for_each_entry(block_group,
 			    &space_info->block_groups[ffe_ctl->index], list) {
@@ -4498,30 +4491,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		btrfs_grab_block_group(block_group, ffe_ctl->delalloc);
 		ffe_ctl->search_start = block_group->start;
 
-		/*
-		 * this can happen if we end up cycling through all the
-		 * raid types, but we want to make sure we only allocate
-		 * for the proper type.
-		 */
 		if (!block_group_bits(block_group, ffe_ctl->flags)) {
-			u64 extra = BTRFS_BLOCK_GROUP_DUP |
-				BTRFS_BLOCK_GROUP_RAID1_MASK |
-				BTRFS_BLOCK_GROUP_RAID56_MASK |
-				BTRFS_BLOCK_GROUP_RAID10;
-
-			/*
-			 * if they asked for extra copies and this block group
-			 * doesn't provide them, bail.  This does allow us to
-			 * fill raid0 from raid1.
-			 */
-			if ((ffe_ctl->flags & extra) && !(block_group->flags & extra))
-				goto loop;
-
-			/*
-			 * This block group has different flags than we want.
-			 * It's possible that we have MIXED_GROUP flag but no
-			 * block group is mixed.  Just skip such block group.
-			 */
 			btrfs_release_block_group(block_group, ffe_ctl->delalloc);
 			continue;
 		}
-- 
2.47.3

