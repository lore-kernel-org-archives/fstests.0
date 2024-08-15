Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C81DDF5
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750777; cv=pass; b=pntekevT3wx/FhPsfLa3Kc9K2CGEx4CnO3qL/RFDPPrjiF3u66LHvQ+KqywzaEoJk7GkxpLc/NwofjC9wnxcmH9Alm6vL2RPZSAOUwG1C/Rlq4GoAcF8qWjS7lVV+rQeTlkFj4xB89BB1vTXp3inUiSLiHzrJvbdGdTznGTR0Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750777; c=relaxed/simple;
	bh=oN/PUDnAjVWq+DgxdfEgfhbKENytoMooS7/fbncWYqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbrQEBqCvP3O/mkCZT8MVj3oQzB2LsDaeb1eGc6v2XvKbs69aRzA3X/u4n/+M0ERsktCVbZk8g8ESqL5Wgjk/NIswCxYWz8C3xewIdzqLRQkjZeR7dZ9Ux74xVFHAzu7KKR2iECiCffMwLBqC6iikVDNt4k4EEBKj92fAuRZiD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=igNweWcX; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="igNweWcX"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A1DE48678E
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:32:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 53497862FC
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:32:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1723750369; a=rsa-sha256;
	cv=none;
	b=aoCc+yptAe1jr5ARdQRdrG05e1KZW1phfy7zu4RnaEUW216Sx/XxwtratMAQAZuT+th7iN
	F8qtCXIupbg4kcrRwARGE16QyC3TUb6oz1Gzm8vonRIiyF0XoeDSoi0eDE2FEyw91MP1pM
	UeP/dlQheD/NWYcLePknj+0sDRLzS84aRGms5st6ysDEdsElyQ2IYigXd2eAh48Nlmg7uX
	lFAPeRAIvkWXSqDDv0MWBYR9Rqu46Wlafujq0KUfrZTuG4//FS3G42CWoGMhfC1DxpEThR
	jUJ5XsOs5gB6lhZVjLmPvo2rAztBPqG1hcFXVEezr3lI4MfwAezfDGEe/dzIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1723750369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ONJXDFMJbMD3oLnJMrIEFCbjfNXrSfx2YBc+dEYC7bM=;
	b=AmE9pqe8VR9pSbz97HvUDyclquw9A5dRWh8FmQY65fqhS99gDO3d2nznN9gBJPajxbsfQm
	GYSuB0ym7FyKV2mBnPo2S4U1GsHl/YXwN6jBguoYa3O3F6MJTq+AIONdQHPBLU6WCDjtbf
	rhPtTtBxdSd6CUk9iyxCzoFqni473ATwVVzlu34xlM8H+KIjcmgM6G4LKXQBbl0AeL/1F5
	ThuEMUf3BkTPvlOdwn9acWlZpujhGB7aNoQxOorSfbeYWhYsT3+Gwaav3T4Hc1CTZ34dc5
	yWtddL1f59WP9LC2D/6+LADmkHi+vfdmusNIq1tP2a0Oe7Ufc0Sf/eJkhAQQCg==
ARC-Authentication-Results: i=1;
	rspamd-c4b59d8dc-cwtkn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Power: 7da51090505eb2e0_1723750369558_3525630920
X-MC-Loop-Signature: 1723750369558:1707946835
X-MC-Ingress-Time: 1723750369558
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.126.110.135 (trex/7.0.2);
	Thu, 15 Aug 2024 19:32:49 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4WlFdW1FghzZM
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1723750367;
	bh=ONJXDFMJbMD3oLnJMrIEFCbjfNXrSfx2YBc+dEYC7bM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=igNweWcXlmO9kRDqrJY24K7BXyP4O0LIPZy6HVMtAvxAGiCCt1qHiaLiou/OIJAA7
	 i34offxByXO3ZgXQjNO0T37Mrjo7psmC06a4xdcVYKPTYayOrz/GJa8Jr8WzbrRVU0
	 KmRHg9Rkzoog7DZoEdlnz3UhBuub40mB3vmqPHMS2yCmdUUee1zQJoBk3rh1UmzCo9
	 z3t5Lg4uESfsVi5IS1C4Z5xJy1Jb/TdEw0P+0OBYQAwNohw+G7iKaXQVfp0uxNVWhk
	 swrWr0VF1KUeizYJaXWkTKtyC25SB02WYXZ148jVco+/nLrX0XuWya2404CAE5YbXw
	 7UdSlRI6K0tZA==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0064
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Thu, 15 Aug 2024 12:32:45 -0700
Date: Thu, 15 Aug 2024 12:32:45 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Dave Chinner <dchinner@redhat.com>, Zorro Lang <zlang@kernel.org>,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 2/5] xfs: move calculation in xfs_alloc_min_freelist to its
 own function
Message-ID: <7e4310e32168cc4aa9f3a0782a6f6fabcaf476d5.1723688622.git.kjlx@templeofstupid.com>
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

This splits xfs_alloc_min_freelist into two pieces.  The piece that
remains in the function determines the appropriate level to pass to the
calculation function.  The calcution is extracted into its own inline
function so that it can be used in multiple locations in xfs_alloc.

No functional change.  A subsequent patch will leverage this split.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 75 +++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 59326f84f6a5..17e029bb1b6d 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -79,6 +79,46 @@ xfs_prealloc_blocks(
 	return XFS_IBT_BLOCK(mp) + 1;
 }
 
+static inline unsigned int
+xfs_alloc_min_freelist_calc(
+	const unsigned int bno_level,
+	const unsigned int cnt_level,
+	const unsigned int rmap_level)
+{
+	unsigned int		min_free;
+
+	/*
+	 * For a btree shorter than the maximum height, the worst case is that
+	 * every level gets split and a new level is added, then while inserting
+	 * another entry to refill the AGFL, every level under the old root gets
+	 * split again. This is:
+	 *
+	 *   (full height split reservation) + (AGFL refill split height)
+	 * = (current height + 1) + (current height - 1)
+	 * = (new height) + (new height - 2)
+	 * = 2 * new height - 2
+	 *
+	 * For a btree of maximum height, the worst case is that every level
+	 * under the root gets split, then while inserting another entry to
+	 * refill the AGFL, every level under the root gets split again. This is
+	 * also:
+	 *
+	 *   2 * (current height - 1)
+	 * = 2 * (new height - 1)
+	 * = 2 * new height - 2
+	 */
+
+	/* space needed by-bno freespace btree */
+	min_free = bno_level * 2 - 2;
+	/* space needed by-size freespace btree */
+	min_free += cnt_level * 2 - 2;
+	/* space needed reverse mapping used space btree */
+	if (rmap_level)
+		min_free += rmap_level * 2 - 2;
+
+	return min_free;
+}
+
 /*
  * The number of blocks per AG that we withhold from xfs_dec_fdblocks to
  * guarantee that we can refill the AGFL prior to allocating space in a nearly
@@ -152,7 +192,6 @@ xfs_alloc_ag_max_usable(
 	return mp->m_sb.sb_agblocks - blocks;
 }
 
-
 static int
 xfs_alloc_lookup(
 	struct xfs_btree_cur	*cur,
@@ -2449,39 +2488,13 @@ xfs_alloc_min_freelist(
 	const unsigned int	bno_level = pag ? pag->pagf_bno_level : 1;
 	const unsigned int	cnt_level = pag ? pag->pagf_cnt_level : 1;
 	const unsigned int	rmap_level = pag ? pag->pagf_rmap_level : 1;
-	unsigned int		min_free;
 
 	ASSERT(mp->m_alloc_maxlevels > 0);
 
-	/*
-	 * For a btree shorter than the maximum height, the worst case is that
-	 * every level gets split and a new level is added, then while inserting
-	 * another entry to refill the AGFL, every level under the old root gets
-	 * split again. This is:
-	 *
-	 *   (full height split reservation) + (AGFL refill split height)
-	 * = (current height + 1) + (current height - 1)
-	 * = (new height) + (new height - 2)
-	 * = 2 * new height - 2
-	 *
-	 * For a btree of maximum height, the worst case is that every level
-	 * under the root gets split, then while inserting another entry to
-	 * refill the AGFL, every level under the root gets split again. This is
-	 * also:
-	 *
-	 *   2 * (current height - 1)
-	 * = 2 * (new height - 1)
-	 * = 2 * new height - 2
-	 */
-
-	/* space needed by-bno freespace btree */
-	min_free = min(bno_level + 1, mp->m_alloc_maxlevels) * 2 - 2;
-	/* space needed by-size freespace btree */
-	min_free += min(cnt_level + 1, mp->m_alloc_maxlevels) * 2 - 2;
-	/* space needed reverse mapping used space btree */
-	if (xfs_has_rmapbt(mp))
-		min_free += min(rmap_level + 1, mp->m_rmap_maxlevels) * 2 - 2;
-	return min_free;
+	return xfs_alloc_min_freelist_calc(
+	    min(bno_level + 1, mp->m_alloc_maxlevels),
+	    min(cnt_level + 1, mp->m_alloc_maxlevels),
+	    xfs_has_rmapbt(mp) ? min(rmap_level + 1, mp->m_rmap_maxlevels) : 0);
 }
 
 /*
-- 
2.25.1

