Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E965A0F5
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751682; cv=pass; b=nbFhN7WbNjVwCr932NX4OS/I7EytVOL3wnrvobqPGPjohdM+r1XV+JcTrODzJ2K4M6sRqRXYakAcdoy5rbQQadeYn7vmbfaqlc05feqiH8ItRvmfDsNeBbscKKoW2ONbb8bc3RqWdW4JlBZY90Dn6N/dgyLtZcU5IGJzU4Hg/vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751682; c=relaxed/simple;
	bh=QQK6GS69aXX+74krEAXspDA0eQU5MIwzbpRH8P40iVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeATleFqUbdYkfb1pSUP/HuJ89trnqGs9KJro+kGRm8kxTRV+0TOdeIvnQ2QBFquszmjm1KoHL/oStihrMyomUqtnmmx1pQBC2WW1Ms++O7HUdNUuzMo3b3FtGr0RK7ygSq7jw4woy29jSdudLrDMZCvzmF+kyP8VspLbrrRqGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=n/tGs89i; arc=pass smtp.client-ip=23.83.212.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="n/tGs89i"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 392D8105A62
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:35:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7704610558A
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:35:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1723750550; a=rsa-sha256;
	cv=none;
	b=MTEhkfTmvg5QGF/MH8dSFuPAVfn2Sx9tcaQ0hD4O8eX0gmIQWX5UN/FBIRBILIf6Gt+dmt
	PB4yh2azJDJsmXh9eI9qMutkMymeIK8VmUR32IMxa4iqYHkObm58/pE4A4hdSWdKMQDcrw
	0mImYjxlqevUQiMezOJFepM72J9OXdK4jsPRrpJ1jXX9yXkoUHH48/KwzpHL6eOoZf0P5D
	+IL7QF5Aa3e20Y1OuSHdl1rOuHRi5Y7DXRxHXtSqpXxipGUFpJb4u5NIgm1Jkf5E3FiiIl
	sJ/GLpWAvqDAUw9cpJkAL9wuZLn3/Z8n2lo8o0iOIV4rpYd895DfG1V5W+dQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1723750550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RBN71pbRJTwK1EZaifhgiID77GSAsx/n1jmj9UaAqpI=;
	b=qRBQ2N+nyumBz7SzDR+NsTzf6BFsirbpGPNN/Hz+lmzogSg5wF0SRR+VVIUgeqZqeNoZvf
	NjAvNDTR64NLrk1koso4oUvp1sLZHeub4PnseGWBM83USXyHTwhrkZWM8fE4S+jy7beBDG
	W28FJO2Q83ddnSyqchAjGQPCdi8+THM+Ri3w0kHcPkiqWI5rO0PV34w46DAeTijXyRDcZr
	KYuoP7aW7ARqRk5p0mXM3mfF4GshgQXfv5cwZO0TBtvk5F6Tlm067loU4L/rhuLpADC3I2
	4HrDOeB+usWYhKXWlJZWRoPV8TQ92JRImZW1WVVdkEJgmcTndQdGu0jWxsHdwg==
ARC-Authentication-Results: i=1;
	rspamd-587694846-xgzwp;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Thread-Desert: 222676364f6fcadc_1723750550693_3130685832
X-MC-Loop-Signature: 1723750550693:2708761552
X-MC-Ingress-Time: 1723750550693
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.75.38 (trex/7.0.2);
	Thu, 15 Aug 2024 19:35:50 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4WlFj226FJzDj
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 12:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1723750550;
	bh=RBN71pbRJTwK1EZaifhgiID77GSAsx/n1jmj9UaAqpI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=n/tGs89irVyH72kXnJ4RXETMWFKyLiDZSjN+/IOjdrWNd/3FL8u2P9xAK4GDTgisl
	 jZq28QbZ7cwaHcXBKY4l7pyIk8pDzurGJb1Neeorm59292PcqHsmQ71IYNZVJaYYzf
	 +UHQehM+7vEVft55ASYeycFi64fBVdd9xDQtYyWqzzGAits44wSIqbX2EGPpcYZYdn
	 1rD9rj2uR+/ZVbVpCj0wp4li6T9hakLYpp5UY3Fr/jyrGxaPZFHvILNWxg0ZW4x0eR
	 sZg4dAwjaHeRVIv2yxxYU957NxujMwnQ8FfPgQ/0SJv3jETx5pKKxsT10hWLNGcKj1
	 0h6tE1dCNcFHA==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0064
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Thu, 15 Aug 2024 12:35:49 -0700
Date: Thu, 15 Aug 2024 12:35:49 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Dave Chinner <dchinner@redhat.com>, Zorro Lang <zlang@kernel.org>,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 5/5] xfs: include min freelist in m_ag_max_usable
Message-ID: <4b9b30af3719389701c2dd00f8cb20f12043b3ee.1723688622.git.kjlx@templeofstupid.com>
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

If agfl_reserve blocks are conditionally withheld from consideration in
xfs_alloc_space_available, then m_ag_max_usable overstates the amount of
max available space on an empty filesystem by the amount of blocks that
mkfs placed into the AGFL on our behalf.

While this space _is_ technically free, it's not usable for a maximum
sized allocation on an empty filesystem, because the blocks must remain
in the AGFL in order for an allocation to succeed.  Without this, stripe
aligned allocations on an empty AG pick a size that they can't actually
get which leads to allocations which can't be satisfied and that
consequently come back unaligned.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 4dd401d407c2..26447e6061b3 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -246,7 +246,9 @@ xfs_alloc_set_aside(
  *	- the AG superblock, AGF, AGI and AGFL
  *	- the AGF (bno and cnt) and AGI btree root blocks, and optionally
  *	  the AGI free inode and rmap btree root blocks.
- *	- blocks on the AGFL according to xfs_alloc_set_aside() limits
+ *	- blocks on the AGFL when the filesystem is empty
+ *	- blocks on needed to AGFL while performing dependent allocations close
+ *	  to ENOSPC as given by xfs_allocbt_agfl_reserve()
  *	- the rmapbt root block
  *
  * The AG headers are sector sized, so the amount of space they take up is
@@ -259,6 +261,13 @@ xfs_alloc_ag_max_usable(
 	unsigned int		blocks;
 
 	blocks = XFS_BB_TO_FSB(mp, XFS_FSS_TO_BB(mp, 4)); /* ag headers */
+	/*
+	 * Minimal freelist length when filesystem is completely empty.
+	 * xfs_alloc_min_freelist needs m_alloc_maxlevels so this is computed in
+	 * our second invocation of xfs_alloc_ag_max_usable
+	 */
+	if (mp->m_alloc_maxlevels > 0)
+		blocks += xfs_alloc_min_freelist(mp, NULL);
 	blocks += xfs_allocbt_agfl_reserve(mp);
 	blocks += 3;			/* AGF, AGI btree root blocks */
 	if (xfs_has_finobt(mp))
-- 
2.25.1

