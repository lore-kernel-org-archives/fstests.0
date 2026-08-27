Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB83749E8;
	Thu, 27 Aug 2026 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874490; cv=none; b=im0vbjsN1HKNkNSM3yYiVOvF/PL8B5j+ieztPF8iowJELQk6NZLu1QhKG6m6CLLhtMVq03748ebBevsShO3BQw54bJYKy4MWv5rSdUPw8YWwcbWydmzzUt9sUPlZu1uy0pDFjJlc6wW/KuIGiZ+LjahkOWbdVXzEuEtN81TJb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874490; c=relaxed/simple;
	bh=uF917bhMGJvIOIlqNFYZ3khhRUIenft4+mCGUqCoBGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqEHKybRMppYHFyCIlkNDDdYhqQ/jtP0P9yvoWLUJbFzYna13JW38lV4XnCkxVv3sInJB2nuHbqihOxnUYD+RD6QA2PU605N4b9p2ypjVfoVWrowjWrmi07G59VgVIsnWciAuMbQClYcB/MGxyPfbCE94KbpD5VPFrN4lfp7DbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=SoGwGdzj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kswkiuj1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="SoGwGdzj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kswkiuj1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22D1A1400132;
	Thu, 27 Aug 2026 19:48:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 27 Aug 2026 19:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1787874487; x=1787960887; bh=e+p7nDiRQi
	Ubj+L3Ep/bgIrhuakpHxcNBRoC2kRwpQA=; b=SoGwGdzjt2JOtZYkLgGM6SSkrC
	3TE6ySKny2nSJsKGo3CKFF7tbnfrsb0p8Z1CL/JJ6BsrnRqcdNmARtnRTLmTo2KP
	K57+qZ5HrNXG/nwNm5c/f/qmDPYpS1JheiZbhsGf8DQZ9bo6Q+fMoEtJizXXGKGX
	im+Ste1Z6a6bgH1ctdrBtGNLk0K3I0laLeuDZ3kBRJuIITYVjc69UgfXZX6dqwjz
	YCnklrGKbnjoESy1pqLRHHQQphCp2/jjKZQBXt4TQ0JogHhleINLPS9WZb5ZctfL
	WXcUQq+01iGrl7ynLvSgFKonOa32krUteQXPVe+99WAJThpD8/Mcd3wT6frg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787874487; x=1787960887; bh=e+p7nDiRQiUbj+L3Ep/bgIrhuakp
	HxcNBRoC2kRwpQA=; b=kswkiuj1iG6ZxhVh9itc82nI0vFtYY8PjjPJS8W969LW
	ncq1fqZWlgKlRwJhLS4roypZboCTXP0cQWlzkLFYmGBbmioTrSpobJAF1jquqn4d
	YTxgquc14tquOfeAKKkvRBF5paOsq9gM8BSj8jJHZ2Uv/bBNjp9/hPxsTmLZBFSa
	JcG6ljOpiKsumvb+QfQCHeMHAafq7Ad0CFdB9IFeuTCcgUvDzko1qGoL1IwUmM/8
	FZYB5oN24sa/tXXKFL1Wb1YZd0TNxvu5p6tf+XyduKGeHpOUjFHkDzB2UdyNEU/l
	qoITQ4r7sEeJXHnIi4ffqBOBjdhOp07RxoC43jgFNA==
X-ME-Sender: <xms:t8yQardN3nbdOjfYfMe4el3yy4kksHTyDsnhvkJfLd_uKTni-9oY0g>
    <xme:t8yQao8E-JW0IE0Gig8yfvGOBGNA77wUUWznDz9bOgYp3kCFyTSioslrLg39jxfG3
    8Z9qdM-YUbkO9JEx8IKFzJeKvkHitd8bWnoIV5lrTKmub7-SGM>
X-ME-Received: <xmr:t8yQannm506XBF8IzKBoX47h7ZSKr8wak354lxQXi8Iab3jXcxr5twLxXL4E6nlGYnI-GbHT7cepFOF-dRFvc0UVgz3dsrI>
X-ME-Proxy-Cause: dmFkZTG1EIgqdMDgIMbDUd5cdHDc6pRiI5hwcEXVV7kyXcmJO9z4jArlP+ei/R3KCgtOAc
    pqTIyTyVrCLtkPOW8fGEdckErr0fhc2iWEkVDHEzJrZdlGSWTZ9rRRT/wmwcowt6J0MR7W
    zqSHcME15RWAMDQPNP11qSLCHpZJ2OvQbn6VK2ADQEbVgdcQbBpxrgi7+QY99TJsALGd8N
    163elRUSBoUHhbyA0EzUmqW6bNmQ0C8/+WQKINAjQGoYvJVZLsslkjaIgLW0y9nTS9Jd5v
    skM9SkKHqdMVrxiEsHQjesOiv6b0ofJdCkRstUz5OTqwRlEBDy82l9E+ZpwgyHlwt5McmX
    bYJerHyu28y3vAM35Bs8k8CckRDvrOKvE0lt9lQQOhBfYmpEO8+O11iL+FWHLrTtPhfOwk
    b9L+lFBD9Iy5efP7ndGjY61C9cmN6dekom2lwtMl1DoPGLA6PiVw8izFhQ2pkyysn362pU
    I7vPa115X7NnzBaUtovw5avw5XeMDU4gQtd+3XVnkImlFoWs5i2I8B54RbD2wPtnxpXmpY
    wumRQAw4fs1in2+tYQmC1e3yxhHqfe9bDWv40L7Dq/WKkm+qYWXPLKRhIgE3kHRu0MSmsf
    Oo8HWPkIK946oLRbL6azti39iYhaGsAo4xSN0W0n6qbzwBPvtavVtoTHcK5A
X-ME-Proxy: <xmx:t8yQaq9Y62EU6cdBn3zUCB98m88QyhJ51d-8zAcMr3pauY5_f22fQA>
    <xmx:t8yQalkGCRQ5hNFameMeY1qNjXl7EL9SZqSR9x6Qm3sdleYGtom6LQ>
    <xmx:t8yQan1qxg4PX5hmUF0kfXe6Dp5OqsHvShfC1IY2ZEnEcg9YLgi1Rw>
    <xmx:t8yQagqzTY0u3jkWGADyMsXqSa0WmgOKzE58ZwnCD82pivTx_HJ1gA>
    <xmx:t8yQapOD6qMD6a2XyhJo2hyBElYTishb8dQI1cxw6BVEmr5ZcWQZaRmW>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 19:48:05 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Chuck Lever <cel@kernel.org>
Subject: fstests: Verify behaviour of "seek" in a directory
Date: Fri, 28 Aug 2026 09:36:09 +1000
Message-ID: <20260827234743.2389778-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

 I would like to propose the following test to be added to fstests.  It
 checks the behaviour of a directory with respect to seek.  As described
 in the patch and the code, it expects names which are not removed or
 moved to have a stable position in the result of getdents64 with
 respect to each other and with respect to any seek offset (d_off)
 reported of any entry.  This means that if we stop and any point while
 scanning a directory, remember the most recent d_off, close the
 directory, then later open and seek to that offset and keep reading,
 then we will find all the names that existed for the whole time and see
 those only once.

 Names that are added or removed are not tests as we expect them
 possibly appear not at all or even multiple times.

 My particular motivation is to confirm that the current tmpfs doesn't
 behave correctly, and to test an alternate implementation that I will
 propose which does pass this test.

 I discovered that while xfs and ext4 pass the test, btrfs doesn't.
 It appears that with btrfs the target of a rename does not keep its
 position in the directory listing order.

Thanks,
NeilBrown

 [PATCH] fstests: generic: Add test of seek in directories
