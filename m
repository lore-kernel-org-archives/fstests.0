Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99C31C57B
	for <fstests@vger.kernel.org>; Mon, 19 Jan 2026 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840398; cv=none; b=MgZxEx3ReU+KPKfsgccdaGK3ECaKntOCUL26rqDPBrln3Nc35OosaO9kXnteSqCvpRuXv+zLk3FFb5oFeT8IvLe5X7dWyKv47TIleF9jiL5FPn/iJtYTmdoxTxiSnBtjpLrmNB7LfhAogTRO3VCOAnQbRomtu0fp/9UKpd9iOvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840398; c=relaxed/simple;
	bh=FI4NI8dl6jSoy/l8FdXI8/RsUN0G2gTdmtm2I6gBCHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XprhlWU/J4vXn7h2wi6/0390DHcA6p2luSbpmIj9RE9fWiLgNxB8cf+lO9h+SKA8/D06ALSU5X4XQGZLELQunLWzvck83TdLzI7pDikL/4tP1e7eTabsaHDbmjar7p6VMb17Fh5lyNwfjW5GZ5pgjHCSuh0DTiDQ/z72/L0FlCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOTguwKX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYKf2UZu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOTguwKX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYKf2UZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768840395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYmk9fWhdbdmEwLS9xqb5br63pURTJxhKqjK/z9PohM=;
	b=MOTguwKXDRn94xnaE9tmKeNJ52xyBV/4hBHXXv4TnHBMifooMxCe/8h0kgTW63L+1+kvmG
	Jh1Ok3OOzOc4oVw+mG3VuxL+455VFrqRurP3AwQb1DzNiYIpXFsTCiIfvM4xbojo4++Si2
	euWlDW9L34CJjdgS57gyNuxFMptruxA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-35GboYt6NR-Ri2Sh1SqUpw-1; Mon, 19 Jan 2026 11:33:14 -0500
X-MC-Unique: 35GboYt6NR-Ri2Sh1SqUpw-1
X-Mimecast-MFC-AGG-ID: 35GboYt6NR-Ri2Sh1SqUpw_1768840393
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-431026b6252so4663811f8f.1
        for <fstests@vger.kernel.org>; Mon, 19 Jan 2026 08:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768840392; x=1769445192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYmk9fWhdbdmEwLS9xqb5br63pURTJxhKqjK/z9PohM=;
        b=WYKf2UZuVRWiuxpdVqMRGCrFanp8jdd9AMXt0IQejmi1df853jSJ1z+m3TKoByyCiC
         Y4m+7orDhlvugQ86VcSmgAEoJ8mpK2zd27jXmvdWZRUCD/8sAZP8FXarUglX0Y1Pg7rM
         1wq3LfpEb9QESy6HIKneTyktf0JuUXQKT3TAhx3Ibgel/Q5GyY/cpfYEvqOUjVPfyuJv
         4gY4waMFfKQc5rMmw//pBgdPTl6/Myc5gZre+8fRMY0rtlhAjvqPvHR8V1uBkuXI0E4R
         n8KwWrTobWklLDa1kBTJ9DVyEASwFXEWgbfwyCnKfrjWrCBNSV+rFcHm3iHnCv8glJJp
         0R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840392; x=1769445192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYmk9fWhdbdmEwLS9xqb5br63pURTJxhKqjK/z9PohM=;
        b=Nqhy8DrD9GKf6M8ziEtLk1Db9xOcrRMuKx+k0NAToyVDoprgkWI221OBRd2DKnaGb6
         HoojRgVNppMxRzJ4u8LY8HX3QjI3s9MN9oRFQKzXfQhTRsVSINN1lwlPz1q8BLVCBovN
         5Ck3J9MYxo3IlMUZRUJY50u9bV719hSZdTL4Kl4k0ooIOrfGkQmBu9dwEAUossoXGu00
         rZMuzwKLLQ8zxXSLR1WsKTXfp1wIzgsxWWecduWRMRDP/lyRFdSiqSfY7lw/+GP+G3wY
         J8qGWB90KXaqniln3iQsZNZAZfgaKq6xjbMu6QW4H3jidsepxtG+jg0EDn9vF0V6PHP2
         Jm0A==
X-Forwarded-Encrypted: i=1; AJvYcCURXKLo6OyRz6HukKhzYBWGY/OtSANja0l3Aaft5jwbOvjm0FTngLeGijl0yE7RPwJt58G6F5AC@vger.kernel.org
X-Gm-Message-State: AOJu0YwXylb5WNXJUxFMOoqSNq/w7Hb4msqd3mIxPiYTuMMFOoTFmBn7
	vLKbbtvLpiI1ELLDUor3AdLXuOnIrTfg1vYaYiiJIVJ+WhoBELnt9Zw4by3SgLWDSmF5Y6Q4Xqx
	ETpWB+uMKThYLLuk7V3LG+hvMgDMzGGpab7eCj7oxo1MLcuv+yCMYcOLxextnY8EU+g==
X-Gm-Gg: AZuq6aLL7c7B76NrstAF3zpUD9mltcU5PJPM8bPUwcq4uYAYeEBvK+7MaHkeNk0c+Au
	vybv7B+HThfTXYmVQdJat1G6Vki+4mPITMMbBfiPsA1OUav2W+Kn9Yli/U8sQ4sTC2JkrYhwNZk
	zOxYnnB8r50osr0sfwF0nuE2e+PG/HjTxa9ZX4/hElvSewgRI3PHN+1Fll1oyI1uStNjg4vHw4B
	M0fF1TBqhw/XdgJkmo5yUyjwsx4D+EbL/2tGFaamSA36v+lFUQRO71gp6dTQYHBcPg0ovzPM3Ir
	tK8ty12WoFv1UMLYy1DqK+lg91wY6ccZ69/ln+9y/XWHF321LS1npEAMAjQSfxPk0u/SdkssNj+
	SvijYKdJLuB+wAQ==
X-Received: by 2002:a05:6000:26cf:b0:430:fa52:9ea9 with SMTP id ffacd0b85a97d-4356a089933mr17503089f8f.62.1768840392386;
        Mon, 19 Jan 2026 08:33:12 -0800 (PST)
X-Received: by 2002:a05:6000:26cf:b0:430:fa52:9ea9 with SMTP id ffacd0b85a97d-4356a089933mr17503038f8f.62.1768840391859;
        Mon, 19 Jan 2026 08:33:11 -0800 (PST)
Received: from thinky.redhat.com ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569998240sm23524318f8f.43.2026.01.19.08.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:33:11 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	djwong@kernel.org
Subject: [PATCH v2 2/2] fsverity: add tracepoints
Date: Mon, 19 Jan 2026 17:32:10 +0100
Message-ID: <20260119163222.2937003-4-aalbersh@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119163222.2937003-2-aalbersh@kernel.org>
References: <20260119163222.2937003-2-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs-verity previously had debug printk but it was removed. This patch
adds trace points to similar places, as a better alternative.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: fix formatting]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 MAINTAINERS                     |   1 +
 fs/verity/enable.c              |   4 +
 fs/verity/fsverity_private.h    |   2 +
 fs/verity/init.c                |   1 +
 fs/verity/verify.c              |   9 ++
 include/trace/events/fsverity.h | 143 ++++++++++++++++++++++++++++++++
 6 files changed, 160 insertions(+)
 create mode 100644 include/trace/events/fsverity.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 12f49de7fe03..17607340dfab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10311,6 +10311,7 @@ T:	git https://git.kernel.org/pub/scm/fs/fsverity/linux.git
 F:	Documentation/filesystems/fsverity.rst
 F:	fs/verity/
 F:	include/linux/fsverity.h
+F:	include/trace/events/fsverity.h
 F:	include/uapi/linux/fsverity.h
 
 FT260 FTDI USB-HID TO I2C BRIDGE DRIVER
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 95ec42b84797..8718d943b428 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -222,6 +222,8 @@ static int enable_verity(struct file *filp,
 	if (err)
 		goto out;
 
+	trace_fsverity_enable(inode, &params);
+
 	/*
 	 * Start enabling verity on this file, serialized by the inode lock.
 	 * Fail if verity is already enabled or is already being enabled.
@@ -264,6 +266,8 @@ static int enable_verity(struct file *filp,
 		goto rollback;
 	}
 
+	trace_fsverity_tree_done(inode, vi, &params);
+
 	/*
 	 * Tell the filesystem to finish enabling verity on the file.
 	 * Serialized with ->begin_enable_verity() by the inode lock.
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index dd20b138d452..4b7ae1748f4e 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -161,4 +161,6 @@ static inline void fsverity_init_signature(void)
 
 void __init fsverity_init_workqueue(void);
 
+#include <trace/events/fsverity.h>
+
 #endif /* _FSVERITY_PRIVATE_H */
diff --git a/fs/verity/init.c b/fs/verity/init.c
index 6e8d33b50240..d65206608583 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -5,6 +5,7 @@
  * Copyright 2019 Google LLC
  */
 
+#define CREATE_TRACE_POINTS
 #include "fsverity_private.h"
 
 #include <linux/ratelimit.h>
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 86067c8b40cf..940b8b956d7e 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -135,6 +135,9 @@ static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		/* Byte offset of the wanted hash relative to @addr */
 		unsigned int hoffset;
 	} hblocks[FS_VERITY_MAX_LEVELS];
+
+	trace_fsverity_verify_data_block(inode, params, data_pos);
+
 	/*
 	 * The index of the previous level's block within that level; also the
 	 * index of that block's hash within the current level.
@@ -214,6 +217,9 @@ static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			want_hash = _want_hash;
 			kunmap_local(haddr);
 			put_page(hpage);
+			trace_fsverity_merkle_hit(inode, data_pos, hblock_idx,
+					level,
+					hoffset >> params->log_digestsize);
 			goto descend;
 		}
 		hblocks[level].page = hpage;
@@ -232,6 +238,9 @@ static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		unsigned long hblock_idx = hblocks[level - 1].index;
 		unsigned int hoffset = hblocks[level - 1].hoffset;
 
+		trace_fsverity_verify_merkle_block(inode, hblock_idx,
+				level, hoffset >> params->log_digestsize);
+
 		fsverity_hash_block(params, haddr, real_hash);
 		if (memcmp(want_hash, real_hash, hsize) != 0)
 			goto corrupted;
diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
new file mode 100644
index 000000000000..1825f87a00d6
--- /dev/null
+++ b/include/trace/events/fsverity.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fsverity
+
+#if !defined(_TRACE_FSVERITY_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FSVERITY_H
+
+#include <linux/tracepoint.h>
+
+struct fsverity_descriptor;
+struct merkle_tree_params;
+struct fsverity_info;
+
+TRACE_EVENT(fsverity_enable,
+	TP_PROTO(const struct inode *inode,
+		 const struct merkle_tree_params *params),
+	TP_ARGS(inode, params),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, data_size)
+		__field(unsigned int, block_size)
+		__field(unsigned int, num_levels)
+		__field(u64, tree_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->data_size = i_size_read(inode);
+		__entry->block_size = params->block_size;
+		__entry->num_levels = params->num_levels;
+		__entry->tree_size = params->tree_size;
+	),
+	TP_printk("ino %lu data size %llu tree size %llu block size %u levels %u",
+		(unsigned long) __entry->ino,
+		__entry->data_size,
+		__entry->tree_size,
+		__entry->block_size,
+		__entry->num_levels)
+);
+
+TRACE_EVENT(fsverity_tree_done,
+	TP_PROTO(const struct inode *inode, const struct fsverity_info *vi,
+		 const struct merkle_tree_params *params),
+	TP_ARGS(inode, vi, params),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(unsigned int, levels)
+		__field(unsigned int, block_size)
+		__field(u64, tree_size)
+		__dynamic_array(u8, root_hash, params->digest_size)
+		__dynamic_array(u8, file_digest, params->digest_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->levels = params->num_levels;
+		__entry->block_size = params->block_size;
+		__entry->tree_size = params->tree_size;
+		memcpy(__get_dynamic_array(root_hash), vi->root_hash, __get_dynamic_array_len(root_hash));
+		memcpy(__get_dynamic_array(file_digest), vi->file_digest, __get_dynamic_array_len(file_digest));
+	),
+	TP_printk("ino %lu levels %d block_size %d tree_size %lld root_hash %s digest %s",
+		(unsigned long) __entry->ino,
+		__entry->levels,
+		__entry->block_size,
+		__entry->tree_size,
+		__print_hex_str(__get_dynamic_array(root_hash), __get_dynamic_array_len(root_hash)),
+		__print_hex_str(__get_dynamic_array(file_digest), __get_dynamic_array_len(file_digest)))
+);
+
+TRACE_EVENT(fsverity_verify_data_block,
+	TP_PROTO(const struct inode *inode,
+		 const struct merkle_tree_params *params,
+		 u64 data_pos),
+	TP_ARGS(inode, params, data_pos),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, data_pos)
+		__field(unsigned int, block_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->data_pos = data_pos;
+		__entry->block_size = params->block_size;
+	),
+	TP_printk("ino %lu pos %lld merkle_blocksize %u",
+		(unsigned long) __entry->ino,
+		__entry->data_pos,
+		__entry->block_size)
+);
+
+TRACE_EVENT(fsverity_merkle_hit,
+	TP_PROTO(const struct inode *inode, u64 data_pos,
+		 unsigned long hblock_idx, unsigned int level,
+		 unsigned int hidx),
+	TP_ARGS(inode, data_pos, hblock_idx, level, hidx),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, data_pos)
+		__field(unsigned long, hblock_idx)
+		__field(unsigned int, level)
+		__field(unsigned int, hidx)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->data_pos = data_pos;
+		__entry->hblock_idx = hblock_idx;
+		__entry->level = level;
+		__entry->hidx = hidx;
+	),
+	TP_printk("ino %lu data_pos %llu hblock_idx %lu level %u hidx %u",
+		(unsigned long) __entry->ino,
+		__entry->data_pos,
+		__entry->hblock_idx,
+		__entry->level,
+		__entry->hidx)
+);
+
+TRACE_EVENT(fsverity_verify_merkle_block,
+	TP_PROTO(const struct inode *inode, unsigned long index,
+		 unsigned int level, unsigned int hidx),
+	TP_ARGS(inode, index, level, hidx),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(unsigned long, index)
+		__field(unsigned int, level)
+		__field(unsigned int, hidx)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->index = index;
+		__entry->level = level;
+		__entry->hidx = hidx;
+	),
+	TP_printk("ino %lu hblock_idx %lu level %u hidx %u",
+		(unsigned long) __entry->ino,
+		__entry->index,
+		__entry->level,
+		__entry->hidx)
+);
+
+#endif /* _TRACE_FSVERITY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.52.0

