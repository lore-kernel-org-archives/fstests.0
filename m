Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724D5A7AA
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751383; cv=pass; b=ImdaIpywM1anC2MDB82NHbw6JfiV8lsIEz9jI4WbH7gcaBlvYGWi97dB99r+QUTeKKzd1dQDvjw2zCbnCoLjxKy0Vuj9fat6r6redfuGgiIoGgHDXDdX3prdauYNjs46nKvrOnKLI2pPuugeVvtbUMwMqjYz32TgXYqHfTqq+c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751383; c=relaxed/simple;
	bh=HXs5X2SdPu5IPb39CCTlGl9JDtQi1NSB5c5urGcQwZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7NES62urhG9ok+XMBRDfHifR0E8mcLhNDkulbyz/oFeSN88vxxi+fI3ySlHwe/FWkantXbJLUeYfWpA5SRTzpbLCkadAFTD1wn5LIEv5DhrbVfpjo5w7fSd9/9tuIoOO4HRPFNobX3pUbSyHh68ySkyHTmm+gLzMDFdErL+M48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=RU7PeV/o; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="RU7PeV/o"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 451C1C67B6
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:30:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id F190BC6252
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:30:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1723750249; a=rsa-sha256;
	cv=none;
	b=pshpzGFxN6qjZwenuQQwvYTP9nwuk6xmr1JbsOp1kiCyX+QzZd75nybUxSI5b3HUyZRvxF
	sTuA+KJ7W9PbjWxgeTSJ/zm0FesdUhLSg8vxwkWrlNjVXaJfG6RFdB/iX9V2h6+G7wLyJR
	tpzt4ROhw4QuN2w96G8xCZdAMsBJnZoW1YS7Q8nh/QwmHa+uEbVG/rqXCp77fULKKLX8od
	0lgK1IJAbEl2un5iJY1b7dZE+kBvj4gM/kpw7YTMGDoJwLhel1h9YC1FPHyRlPrsUeZQvS
	qCFASUsYkYJ1AxZ+4d7m2//T2xQ988NpHAFPx7kb6Pu1kBce8YtO1qeUWlfZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1723750249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+yz8QnMgU01wHEONCpX/2eu2lt9HcGc3LQEgdolMzPY=;
	b=Luzjylzf8xAbpYdyXxuSttPGB3sKtJfWLYAPDlyyqZ4ARlIFf8fswkF8cPAo94R2ssHnKQ
	xLUBiXgJs2wU0WUrTfZAkRgZd1cKYs+qWbOT8ME5uQwhYS/JTYD85Lz5KBEfoFE/YF3Rp5
	DNdDx6yjlJCFVLKAAMM7w2vsdjs49YyA8b4Q4IgZPYFMARtJxpPSTpBapyKiR9CcV3FRWJ
	X6D5u6LekwD0wvX4wjs4kJvms8RJ5WUIzNSEV6k/xocWaXzPbc3yAFi3hZYsS7D9AT0wii
	J9cIJTc6ej5Py/ENaQCd5wfCZVsqNkBzRjxHoKJ48oNoCUOcDfyWPAcFv05xtw==
ARC-Authentication-Results: i=1;
	rspamd-587694846-mw6dw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-White-Left: 49c595c12ee126a9_1723750249202_534375929
X-MC-Loop-Signature: 1723750249202:760515900
X-MC-Ingress-Time: 1723750249202
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.72.21 (trex/7.0.2);
	Thu, 15 Aug 2024 19:30:49 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4WlFbD5kK1z9v
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1723750248;
	bh=+yz8QnMgU01wHEONCpX/2eu2lt9HcGc3LQEgdolMzPY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=RU7PeV/oa0y5tTvEnIzPiF51rSegd5lSnO6KqPSCImQhVbND/P07oWgeJanczeOtE
	 ZEK0MPlmAw15PoHisMhevn/SrgvwLbDAjk72yV26irA2KmcjIS8AmZq9k6f/ENAqOn
	 Qoy5srLo7daCTBmpUj6qlR7yOPLU2j6JDwJ6dgRif7MjnOK3RKeUHnPovYln56qg1a
	 fpCm81G6LGTqEaBVtyFZyjUB3K2GgqeQpV61v8H86HY1liRsnszq9Wq2tLJuHXhVfq
	 I1giZXn2mhO6eQm2CMI0MY+zRjp0x2m7iygNJAmPvroLjWOF3XTmS2ovu7KViFxkG7
	 r0sNa9vTNl/RA==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0064
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Thu, 15 Aug 2024 12:30:47 -0700
Date: Thu, 15 Aug 2024 12:30:47 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Dave Chinner <dchinner@redhat.com>, Zorro Lang <zlang@kernel.org>,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 0/5] linux: Modifying per-ag reservation to account for
 dependent allocations
Message-ID: <cover.1723688622.git.kjlx@templeofstupid.com>
References: <cover.1723687224.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723687224.git.kjlx@templeofstupid.com>

Hi,
These patches attempt to address the problem where dependent allocations
fail during a multi allocation transaction, often as a result of
refilling the AGFL.  The failure results in a filesystem shutdown.  In
many cases, it manifests as a warn in xfs_bmap_extents_to_btree, when
the dependent b-tree conversion fails after inadvertently getting an
ENOSPC.

The RFC series was here:

https://lore.kernel.org/linux-xfs/cover.1718232004.git.kjlx@templeofstupid.com/T/#t

This series attempts follows David's guidance around implementing the
reservation using the existing xfs_alloc_ag_max_usable and
XFS_ALLOCBT_AGFL_RESERVE mechanisms.  This mostly worked as advertised
(thanks!), however, a few additional patches were needed in order to
address test failures.

In particular, without the 'xfs: include min freelist in
m_ag_max_usable' patch this series would fail the generic/223 tests
around stripe alignment, because m_ag_max_usable was slightly larger
than the actually usable space.  This turned out to be the result of the
first pre-fill of the AGFL and once corrected the tests pass.

This currently has a failure in xfs/306.  I'm including a patch for
xfstests to address this.  The per-AG reservation size on the filesystem
in that test increased by just enough that the filesystem reservation
that was manually configured to 16 blocks was too small.  Increasing
that test's reservation to 17 allows it to continue.  The failure
manifests as dd failing to make progress and the dmesg filling with
errors about xfs_discard_folio.  Tracing showed that conversion of the
delalloc to a real allocation was getting ENOSPC.

-K

Krister Johansen (5):
  xfs: count the number of blocks in a per-ag reservation
  xfs: move calculation in xfs_alloc_min_freelist to its own function
  xfs: make alloc_set_aside and friends aware of per-AG reservations
  xfs: push the agfl set aside into xfs_alloc_space_available
  xfs: include min freelist in m_ag_max_usable

 fs/xfs/libxfs/xfs_alloc.c | 184 ++++++++++++++++++++++++++++++--------
 fs/xfs/libxfs/xfs_alloc.h |   1 +
 fs/xfs/xfs_fsops.c        |  21 +++++
 fs/xfs/xfs_fsops.h        |   1 +
 fs/xfs/xfs_mount.c        |  24 +++++
 fs/xfs/xfs_mount.h        |  12 +++
 6 files changed, 207 insertions(+), 36 deletions(-)


base-commit: 7bf888fa26e8f22bed4bc3965ab2a2953104ff96
-- 
2.25.1

