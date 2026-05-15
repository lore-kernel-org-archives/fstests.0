Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA56937C11B
	for <fstests@vger.kernel.org>; Fri, 15 May 2026 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833572; cv=none; b=Nc2rlqFgX8LoI9nAwWNb2cTm17GDMqns1Y2udWk1CBFHUDIawyJLSjsgYVoeIXWNOUYIKxDXEEv+8MWftwQte642eHgpVEQNUP0cskSMMf/6JbAtRc9KSbY4JelZsbeW4+GvuAjLgdhFURo++i6XpljvAyJ/gQKN7b6v6XLw9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833572; c=relaxed/simple;
	bh=nd8MIbsZrWqEGCq3pOsYxmyxjjh5ALMnXxxMg/7olcw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fi0qIvxlH4Ij3YdJc5bRw5jIWNg7o/rAV974hDO6YdZOej/QCVIhnoApKtiUMQFYt0Ka3v09EMaaoxqsGTuupLSqJfOmQ+Lt2IOKyKXf1Fo5O9sPb2wUIY7UE7z0+tfSPXo2v/Y9y1h2Zkhudw/3Zt/JOxkh0H6jxtB9MuwJRFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9Kdj1ip; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9Kdj1ip"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bcc2320b2deso607578766b.1
        for <fstests@vger.kernel.org>; Fri, 15 May 2026 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778833569; x=1779438369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7MviKwNP+Fy3nkVTooIfs7lmfs9u5oS2cPZjX/OtqFA=;
        b=q9Kdj1ipKVsR0xRe5CFPKU8153K4IJEtEkj3Et4f2Sdz7mm3xF+zbab6IQd4OBY6Nc
         tzk8f+us4uqLFxl1NneywLkZFEAe3zGNbtyGgk7ahAm5i9fq9DaGnpTPHdmwu8aKMkKR
         9U2xFx7UxgIKxwgCZq1Hhtr1fqXSm4A97Am2At8c200wbLi8syh5vBLGl6Q/ePOEyogw
         XfrQjOvtbyRQ1o5TksyXV6J6z+Q/OSEDFYLecloloa+22959v4tfgXbyWWzxcx5nVInz
         MUw9GZItCPjfm6Qp3u+53dJUqWmktMZH7shjBWG7c5Ie0UQ6idaaXUeA4Kja3T0oDmeA
         phEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778833569; x=1779438369;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MviKwNP+Fy3nkVTooIfs7lmfs9u5oS2cPZjX/OtqFA=;
        b=rjqp0LRjZPVO+zzm/vBbrAB9nrtbE09hauXkxKI7jpgawTXEmgABxuewsb5eIMcszv
         ZcRVKZ08o1v4CbNzAPbVpMovXsaAdxJQDLeaBL7USJ9tKvnqPdyhiVchSwwS7gk5b80Z
         OtLrYX9tmR2oNkutAlJjpQnzbln0Z7dckupqKaY9y3jIzymdR8+EmAY9//wrBRkVAuPu
         LRKtY988hAGdr7eOC26vPUXOMS98QZPg2ny13uZvcYi2rCB5oAaYbUXjvF0pK9BjzQKU
         5HWI3UMb+jpQaGIoGrLrg/OBQGNHkh/0A6wodoxzgTECQA09xucn0/Ii3GJqZD06jbru
         pjjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IJglFULxaR3cfRL/1mIdAmW0Bh2AOqVXrFCo0ePPl/hG5RSVXOvhR6PAG3Tlc0ZPeB6GbN6qi@vger.kernel.org
X-Gm-Message-State: AOJu0YyMbJAsbhOp4sRPmXpSJvCubilA2NUIuWt/Azw3jHuPjnhTcF+5
	tq2hft5hkgm+8qNRHtduzUMDniwU+IgCIZSbzwFCfK85Uj08Sq6Ndxf9Pz+zQbB1KR3NwQ0OiaL
	3B9hx+XQqvBDa0ofJ9ZalAC9EO/snbA==
X-Received: from edcm2.prod.google.com ([2002:a05:6402:4302:b0:67c:76a4:f70a])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f59e:b0:bd4:8b86:9026 with SMTP id a640c23a62f3a-bd51795bc15mr193664866b.25.1778833568927;
 Fri, 15 May 2026 01:26:08 -0700 (PDT)
Date: Fri, 15 May 2026 08:26:08 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515082608.449455-1-jprusakowski@google.com>
Subject: [PATCH] generic/563: allow read tolerance for f2fs in scenario 3
From: Jan Prusakowski <jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Qu Wenruo <wqu@suse.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Nirjhar Roy <nirjhar.roy.lists@gmail.com>, 
	Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

F2FS is a log-structured file system that allocates new blocks even for
overwrites. To perform allocation, it may need to read metadata blocks
(such as the Node Address Table (NAT) or Segment Info Table (SIT)) if
they are not already in memory.

In scenario 3 (read -> read/write), unlike scenario 2, there is no prior
write in the same mount session to load these metadata blocks into memory.
Therefore, the write operation in the second cgroup triggers metadata
reads, which are charged to that cgroup.

Relax the read tolerance for f2fs in scenario 3 to accommodate these
expected metadata reads, matching the tolerance already used in scenario 2.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 tests/generic/563 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/generic/563 b/tests/generic/563
index c3705c2f..f95eb073 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -151,7 +151,10 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT
 switch_cg $cgdir
 $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
 check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
-check_cg $cgdir/$seq-cg-2 0 0 0 0
+# F2FS may perform metadata reads during write in this scenario
+read_tol=0
+[ "$FSTYP" = "f2fs" ] && read_tol=33792
+check_cg $cgdir/$seq-cg-2 0 0 $read_tol 0
 
 if [ "$drop_io_cgroup" = 1 ]; then
 	echo "-io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
-- 
2.54.0.563.g4f69b47b94-goog

