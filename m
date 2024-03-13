Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5C5E066
	for <fstests@vger.kernel.org>; Wed, 13 Mar 2024 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373619; cv=none; b=tL7oWJSr6XCfY0aa8LRNu5rT+xnQ5xZKFssnF2NKEg5V8ztHYT1sSyYVgQfH2wEzvRoIS89pNZEKMZoZ+DQXxLQpKJ8b+7wH+fHwmhZYQDCo75Rq9U1DXc0FMQgFgJUP1yt34V/jznRHzmw6oD9S1qY47lnhgvqn3B8RVAQuRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373619; c=relaxed/simple;
	bh=sfuHMsjcDWTcvKyqIuBcCKVXerqATN2ObSYpO9zvKD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ew9PzHSCW/54T6f0RjpueAwK7TWoKDKJI20Rik/TdYEoEBixf7kG+an8SDgnlM5RaKZ6OeIi9ntrzqH2K0OEtYZvfZvRMQfWmWmeO7YGZ0E1XYILLU6aHTVuoW4+ySHoJTW84vImZH7JwD5R1c6fwz1Y8ZpKUKVydEdiBvJfNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ZYEjq3pa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNS0NPOh; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ZYEjq3pa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNS0NPOh"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id D5CF732009FD;
	Wed, 13 Mar 2024 19:46:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 13 Mar 2024 19:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1710373616; x=1710460016; bh=rJ2JXLR/hcZWo0bDWIcPL
	RNVWRH5442XsgL3VHN/iFs=; b=ZYEjq3pae32RGCARyzfBnv8+5AvNoobki+Mq4
	NEHVwKPaM3LIvRIPlmvwESW4uUs5aO9wsiff1HiG2WCbjEDcXfUHZvrj4wMMXw1o
	9H9rkG/MPjcWhNxcpSPjhmkmIDsA4t+/UGprP7frZuG7WQLVS/VB7EPE1xcu0gR+
	un82rTnPWhdrQmKddRTWiz4qSZOrxYePCLPJ/S9K6sMOxcdRjulZBjdzZBlBUdgR
	WabMu1UFQJduaB9cPO8BhUeIpugbK9czn3TGbpz8dTJQTS2jgwT2dYb/rgk4PODQ
	E7FvwtAe3BO7krgslbtLE9yAl/p6q0XRfrY/MhIG9Fg2VMCLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710373616; x=1710460016; bh=rJ2JXLR/hcZWo0bDWIcPLRNVWRH5
	442XsgL3VHN/iFs=; b=lNS0NPOhm5SMON3rusv8Qi80+ZQU2liLMiOfFFeeuN5h
	i77bRjCd0HQ0su2IZGU2RM9Ol9YBDDXKXXTXgs/V3FJOIHoAQVAqixQ88kE+qHFh
	uwjPE2npp1g7kLdUgBnlFkc+UY76UPwALeMFwr4tFbDF/pVVL10ZTCo0rx7Omx/u
	4c6UJNgsMdjjrlzv0VzdCU0O5wABxoI8a2/5DTGcrOJl7YP6sJDFiujpfEkPr1Xt
	N7Ccz1wxBKR8YmaZWy31dKSMSC1MgzlW99MD+FKNkATCcPINt3x5hEJr6F2OdGhI
	TBLMRDriK9X79n2gNkeNv7chzHqnXVedmBz4Exl1qQ==
X-ME-Sender: <xms:8DryZarlOQ5cb0yCBVSRAmSk-KPo2NdtqkfUwUhVmjuD6dBlKkkx1g>
    <xme:8DryZYqhq38oDiMTNwe5QA6WNeeDFYI-KOoF6ZmAHo3CLzjVxfjFVbwisK1F6ZOOe
    qdN_5l8Py20-83jI-w>
X-ME-Received: <xmr:8DryZfMbzh0NiuHo37cxHTpy6XEBsR7DgFkS0pCPhS7h9dOBXRYZc7QmJC4D7VjFLNEZumRK41z_GND_hpjgX1UUO78>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepieegle
    ehjeelfeeifeeiuefhfefgvefgkedtjefhiedvveetgfduleejheeifffgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:8DryZZ6kxaCgJt3OdLNCld9Fn3cPaj7CQYtpsH-m7pJYQQDJ8_LqBw>
    <xmx:8DryZZ7P-AeFf5MhhJyF1RExUWXbdOajqFV_8r5_YHf7uDhvAdpdsw>
    <xmx:8DryZZj2Bto3lRBedBxQ1bgz6vvX-vOOSgkqQszTfgoptn3W0RHrag>
    <xmx:8DryZT4gQa3KL3BX8FiDzkrURG99xS74C7GkOotUR6gzLqBtMPIYuA>
    <xmx:8DryZZHypnDREWRCHPLINYhfXn64GQeNJxtl37kgMrLy3pf-M_9xMg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 19:46:55 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: kernel-team@fb.com,
	fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH RFC] generic/730: ensure EIO after device delete
Date: Wed, 13 Mar 2024 16:47:47 -0700
Message-ID: <6165b0018426e58e7427a26eebea3d63e66fed15.1710373423.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test removes a SCSI debug device out from under a mounted
filesystem with a (probably) dirty file. This assumes that page cache
cannot save us from EIO, for a reason that I can't quite explain. In
fact, this test fails for exactly that reason, at least on btrfs.

The original patches:

      https://lore.kernel.org/fstests/20230807112100.GB15405@lst.de/

refer to this passing on xfs and not btrfs, so I suspect I am missing
something. With that said, on my machine this actually fails on xfs with
and without my patch, so this is clearly not enough.

High level, I am trying to understand what is really the expected
behavior from a filesystem under this condition and what this test is
getting at. Of btrfs, ext4, and xfs, only ext4 passes it, while btrfs
does pass with this additional syncing/cache dropping to nudge it to an
error.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/generic/730 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/730 b/tests/generic/730
index 11308cdaa..ca5037c57 100755
--- a/tests/generic/730
+++ b/tests/generic/730
@@ -47,6 +47,9 @@ exec 3< $SCSI_DEBUG_MNT/testfile
 # delete the scsi debug device while it still has dirty data
 echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
 
+sync
+echo 3 > /proc/sys/vm/drop_caches
+
 # try to read from the file, which should give us -EIO
 cat <&3 > /dev/null
 
-- 
2.43.0

