Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4DF1494C4
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753783; cv=pass; b=mvr2QHRmmxpIwKmFmHJUBoeRvw7RHi9qFgoH+3r+uXogXWYnD4cpLW42GLX7qHURyclf+KINxvjC5ssup9ScwzT+aVZZQ+Zo7lp3KZGwkwMEtkaLe6g5OBb0pEwBpfjSI5JMNXPklGxPdjBxq0jorSnkbbiecR5RXynHTGrhFa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753783; c=relaxed/simple;
	bh=f/ym/HhI+ad2ud3xHFvHvQqkvkiRfRFQ2kpUJ75CE8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zxb6eAtAePcZ+K782VNcqaCBIaZKlkW+3mgzca/stKVX/OXKgMooQqWap3hzX7oawJ8krT61TC8KcYHAxpUmJli1zJnksv/SLzhAspKTPqZKeZPS06S5uTbmpYabeWDMqg+HUGelGYi84HoO3tByQeO1fU7872wNPBzsDnsXgHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=PEM1nKIT; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="PEM1nKIT"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C814CC5186
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:34:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7E41AC51C0
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:34:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1723750491; a=rsa-sha256;
	cv=none;
	b=3fcPA54oTw5IU9TlWNtbLzpLvkluRxpQZZtAtOakDNQYRtWUbUAiKWKWpRs8QaJsXhDgd3
	jrBAzmnVn1Zsmev/SQjYeBgoHmVS5AQS0aacPtpXU/6gbOOCSvpl0cfzcPl6AURAZ+BOjv
	2cLX4dro61dq3ceJmRdXbnHMNgw1wlyKG/fND41I774l9rEUKglBDtoF2Q0yZdq4mNg9oC
	Qiee5GcPICbvwF8/ULL7JtjhjG7QJdGcAfQHnG6oHljNahXJ0MDMnxwJvWOtB2BWXZnAny
	4HtQWClAMmpzqYhaQoIeB95IQMcXOhPyAbNuwSYSZg4GEb90vO8tZrqP3x5pMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1723750491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OTZU2GHi0cFIUNIMsupcprXCrGD2KiplaAerMY4u130=;
	b=DqwlCoT+gQ8bpk0O1ql+2aL7enKdV6XEp0107a5Z1GFj20f1+SoTEY1+wjFHwCQ+5oA14x
	Y0AQDvtgYvLLQfVsIDxT2BbsK/4venp4UARQx/zpC5rUYFE5CjE4z5GgcgTSwXH3Wzq7EH
	jldcKL2JAWDRF9OazyoYH6NE/rdqTUo1S4QWXhTg8izBoqWKPMif1qjLF7zgkduFPEDZ/S
	BbWRWtTjVWbopd3j/o3SK2XZL8tiZJ/+PUV4vE66sLpdMUwGFaX2wn77bX0EJtoGHq2aKT
	/gRJmqhEFUqDBDdhyGuSTlQ2wKO+hV7rbOH0mSOgxl4MPiPOGFZH7scIi+tgEQ==
ARC-Authentication-Results: i=1;
	rspamd-587694846-g59mf;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Oafish: 307597c0594cc764_1723750491730_2484953318
X-MC-Loop-Signature: 1723750491730:4149103670
X-MC-Ingress-Time: 1723750491730
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.75.38 (trex/7.0.2);
	Thu, 15 Aug 2024 19:34:51 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4WlFgv09CJzK2
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1723750491;
	bh=OTZU2GHi0cFIUNIMsupcprXCrGD2KiplaAerMY4u130=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=PEM1nKIT1BH7+ik2YKZt7HZNGJQd8p5ZuaWO0oIdN0RyUFML+/ed22ceUzv/2f9AA
	 6xfVbmYtENt1Znvug+lXYCGnjRS2gKdk4gbau+QQeeQSfvRahO8u3pnH/GSg6y5v8x
	 TloOJ9y1jYB5NIHEnjbNqjSfrZ1nrS23we2XoiKK6T1q3Xmn9nDkwi9de5cWezB7DV
	 yEE2hFZTx0QZLHygLxRgiEng93Z5eZO1t0u4hwyDOAAGDR4fClSptLizTlale09+S/
	 afuEzAIwiFelf6rKfWKqDJy9V0PtNDgtn7JlRkHf1v+pCscZuzA4pla9d0JWkBcFa8
	 AU5rea3DlajRg==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0064
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Thu, 15 Aug 2024 12:34:49 -0700
Date: Thu, 15 Aug 2024 12:34:49 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Dave Chinner <dchinner@redhat.com>, Zorro Lang <zlang@kernel.org>,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 4/5] xfs: push the agfl set aside into
 xfs_alloc_space_available
Message-ID: <d6841bd2b2c91912e361063d0f4ac0344298f0a3.1723688622.git.kjlx@templeofstupid.com>
References: <cover.1723687224.git.kjlx@templeofstupid.com>
 <cover.1723688622.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723688622.git.kjlx@templeofstupid.com>

The blocks that have been set aside for dependent allocations and
freelist refilling at reservation induced ENOSPC are deducted from
m_ag_max_usable, which prevents them from being factored into the
longest_free_extent and maxlen calculations.  However, it's still
possible to eat into this space by making multiple small allocations.
Catch this case by withholding the space that's been set aside in
xfs_alloc_space_available's available space calculation.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 15 +++++++++++++--
 fs/xfs/libxfs/xfs_alloc.h |  1 +
 fs/xfs/xfs_mount.c        |  1 +
 fs/xfs/xfs_mount.h        |  5 +++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 826f527d20f2..4dd401d407c2 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -153,7 +153,7 @@ xfs_alloc_min_freelist_calc(
  * middle of dependent allocations when they are close to hitting the
  * reservation-induced limits.
  */
-static unsigned int
+unsigned int
 xfs_allocbt_agfl_reserve(
 	struct xfs_mount	*mp)
 {
@@ -2593,6 +2593,7 @@ xfs_alloc_space_available(
 	xfs_extlen_t		reservation; /* blocks that are still reserved */
 	int			available;
 	xfs_extlen_t		agflcount;
+	xfs_extlen_t		set_aside = 0;
 
 	if (flags & XFS_ALLOC_FLAG_FREEING)
 		return true;
@@ -2605,6 +2606,16 @@ xfs_alloc_space_available(
 	if (longest < alloc_len)
 		return false;
 
+	/*
+	 * Withhold from the available space any that has been set-aside as a
+	 * reserve for refilling the AGFL close to ENOSPC.  In the case where a
+	 * dependent allocation is in progress, allow that space to be consumed
+	 * so that the dependent allocation may complete successfully. Without
+	 * this, we may ENOSPC in the middle of the allocation chain and
+	 * shutdown the filesystem.
+	 */
+	if (args->tp->t_highest_agno == NULLAGNUMBER)
+		set_aside = args->mp->m_ag_agfl_setaside;
 	/*
 	 * Do we have enough free space remaining for the allocation? Don't
 	 * account extra agfl blocks because we are about to defer free them,
@@ -2612,7 +2623,7 @@ xfs_alloc_space_available(
 	 */
 	agflcount = min_t(xfs_extlen_t, pag->pagf_flcount, min_free);
 	available = (int)(pag->pagf_freeblks + agflcount -
-			  reservation - min_free - args->minleft);
+			  reservation - min_free - args->minleft - set_aside);
 	if (available < (int)max(args->total, alloc_len))
 		return false;
 
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index fae170825be0..7e92c4c455a1 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -70,6 +70,7 @@ typedef struct xfs_alloc_arg {
 /* freespace limit calculations */
 unsigned int xfs_alloc_set_aside(struct xfs_mount *mp);
 unsigned int xfs_alloc_ag_max_usable(struct xfs_mount *mp);
+unsigned int xfs_allocbt_agfl_reserve(struct xfs_mount	*mp);
 
 xfs_extlen_t xfs_alloc_longest_free_extent(struct xfs_perag *pag,
 		xfs_extlen_t need, xfs_extlen_t reserved);
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index ec1f7925b31f..1bc80983310a 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1002,6 +1002,7 @@ xfs_mountfs(
 	 */
 	mp->m_alloc_set_aside = xfs_alloc_set_aside(mp);
 	mp->m_ag_max_usable = xfs_alloc_ag_max_usable(mp);
+	mp->m_ag_agfl_setaside = xfs_allocbt_agfl_reserve(mp);
 
 	/*
 	 * Now we are mounted, reserve a small amount of unused space for
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 800788043ca6..4a9321424954 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -220,6 +220,11 @@ typedef struct xfs_mount {
 	 * one.
 	 */
 	uint			m_ag_resblk_count;
+	/*
+	 * Blocks set aside to refill the agfl at ENOSPC and satisfy any
+	 * dependent allocation resulting from a chain of BMBT splits.
+	 */
+	uint			m_ag_agfl_setaside;
 	struct delayed_work	m_reclaim_work;	/* background inode reclaim */
 	struct dentry		*m_debugfs;	/* debugfs parent */
 	struct xfs_kobj		m_kobj;
-- 
2.25.1

