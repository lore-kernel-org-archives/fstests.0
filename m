Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDDA44C94
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751072; cv=pass; b=Y0LTTWUCHwOhJTW4umoD0ljXBrIeAQ0zLMuH6DBIVHGwJbW9EnAJtMvrU8Hw0bxZtP56vyYGMZiHsMn3U7gHOdPPd7I1+ae3Lvnf26Hg2f1gm7xYCxgDxtoK5UAicgC6+IYoxUMkfSQvW1gt+5V6uGcfM+VxfUQQxIs9CLinmCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751072; c=relaxed/simple;
	bh=sDi47lle6+ZnZ+Ow0opxwBtu9z0DRPQ3+RQv0j0AVpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+ayrYmNy4agf4jaHQdp0YkIMca1kfmjNIGRs6YD5Vm9Nl4I2cZLZzhUAvgpYCdyoeg2wG5XVg37XkC+ZGzUSpBYIyhudwimWcc6IZ6XhSbCSWBwHS/jFpaNmChsxpjw7ofV5I7VmLN3CraZPHRT1hM19WBdoTHfIvEphQ+bHFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=Jf5jRmzG; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="Jf5jRmzG"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 72D99505FB9
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:36:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 24BEC504965
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 19:36:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1723750612; a=rsa-sha256;
	cv=none;
	b=GCYe0kvzZfyYBjDIN5p6jNAKOzNkxiXbBd3HBVHKoV87mdidElj0lJz3QwlynDeM51675u
	3P/0hS+bOQ5phF9sOWKzi68Iz1LAeOZj3pUqM3+jWDc2ba2k3DkNPH/EsiEJfm+SqCsLTK
	GxSScYC75u7LH2nTtdPdCg9zVFx2aq9rB/cNoL6MFY+Vo28KxFTnzx0+cZKVwl9foumdz5
	I2vYLj+Bp0MXJIJgd0qPu+qJJtwTJWTAIug6KwTAGj9pmAiRvndlbGxvxtU8KMAA4VMfT8
	uX8Wg2ClQKuwqYkJ4hVB7ZLM03XB+nlzZFgQ59OpxEA+l6s/ZdYsTgsFlGHXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1723750612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=d6eEeYvoaLrlXlELqiuQrkY1BKA6OHscTlcfI7Dk5mE=;
	b=OKVAXzggUr8WA7gbwo0QvALcBVLJM5jNlpw665PEeqPHAM0yafww3YI699KIFv1cY1IRsN
	fMBm3Od+zRn2wxIBQChs5tFOi89gK9W3LBcwYMjhH7MeePWix/BlmYSGrSxeJ+/4oY0KIx
	lJRUCnoQqRU/KBcdp1H+yASVZqWa+LRXaDuzZ8XBkkc9xyDc9BvaSOzOfWkp50HeY0MVF9
	+9rgbDs/QPKgp4BYQYtsT25zL0I4+6pT1Pw+/tn3LOsZjKVaZ8APOsBMcmshCXDE+F7n81
	zh69oFqqiecQZygMKcGl5R34LuNEUJbXbZreQDbyj7KZ6Bnhe5h6ErUH6GUEpQ==
ARC-Authentication-Results: i=1;
	rspamd-c4b59d8dc-pk989;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Unite-Tasty: 1ad3eec131a6de84_1723750612355_3108073857
X-MC-Loop-Signature: 1723750612355:564701923
X-MC-Ingress-Time: 1723750612355
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.208.81 (trex/7.0.2);
	Thu, 15 Aug 2024 19:36:52 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4WlFkC3mjnzNs
	for <fstests@vger.kernel.org>; Thu, 15 Aug 2024 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1723750611;
	bh=d6eEeYvoaLrlXlELqiuQrkY1BKA6OHscTlcfI7Dk5mE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Jf5jRmzGmDREJYzKId53hlRi4w8P730a//q692wIDq6S+0e462DeUuusyM6+YZ4YT
	 uSpT4XNi0R0MPzjZC+lO+t5VDGt2tO9U7bBW5et80JjRo9S8uLmjBKETgE9NAbAWXX
	 y+d93UQisBxDNGTcBPpK2zmKMF2duku+m0z1gxTCIfS/41PwLZmlaBqq86zIOQp7bB
	 N+p2heqqLXxx4O/YGvoitVLS+mGx9H/s0R3MCPbznSKlSq+YN0Ykzkza7R88zwspq1
	 Or7fBJZXSgJDD0udX06Oln8QMO9IGxee+2YLV2Lm+dtPs3tOrUSCKQQQv6xZJNBBOX
	 /XCeHkP5mWunw==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0064
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Thu, 15 Aug 2024 12:36:50 -0700
Date: Thu, 15 Aug 2024 12:36:50 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Dave Chinner <dchinner@redhat.com>, Zorro Lang <zlang@kernel.org>,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [RFC PATCH 0/2] xfstests: fstests for agfl reservation
Message-ID: <cover.1723690703.git.kjlx@templeofstupid.com>
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
This set includes a test to trigger the xfs_bmap_extents_to_btree WARN
that tends to the the most observed symptom of the dependent allocation
failures that this author encounters.  The patches to fix the problem
also introduced a failure in xfs/306.  I'm including a fix for that as
well, though if this is an inappropriate resolution of the underlying
problem, I'm happy to take another approach.

This is sent as an RFC since it's my first foray into submitting
xfstests.  The 608 test should be deterministic on kernels that precede
the AG-aware allocator re-write.  On my machines on recent kernels I'm
getting about a 40-50% success rate with triggering the bug with this
test now.

-K

Krister Johansen (2):
  xfs/608: a test case for xfs_bmap_extents_to_btree allocation failure
  xfs/306: update resblks to account for increased per-ag reservation
    size

 tests/xfs/306     |   2 +-
 tests/xfs/608     | 372 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/608.out |   2 +
 3 files changed, 375 insertions(+), 1 deletion(-)
 create mode 100755 tests/xfs/608
 create mode 100644 tests/xfs/608.out


base-commit: f5ada754d5838d29fd270257003d0d123a9d1cd2
-- 
2.25.1

