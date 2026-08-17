Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6AB3C8C5E
	for <fstests@vger.kernel.org>; Mon, 17 Aug 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957910; cv=none; b=WmrTWmxmvFchFdbyMoHAitzkHtdXoE9EzKhLYsIAhuHHZwWQGPjuntkoeia/paLRy854ZUwIAYCMwvMApLw1WwtNdziYWLUJi4N3699HjedfBpP5gbqebXhv2AXFi5oOeGECs50lpNmW4krhVZ5k8qH21xsHRUS4ObA5jYggnsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957910; c=relaxed/simple;
	bh=Mwg4Sl1lxJGBmBZE7JmGK6IBDIJ9/d2p7Uus1UuvL2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QpxpC8YCHIc4I6LY04Gec5mpbRzdzHVzf+3tv9kzdFQzkjMS0cT3THByyw34yN2B90NxFFtOuk05Y2AzO9fvDY9T7FXM3xjKQ4BhcHs5Z3LRwknjAB1l2oLP0Q4a8WwPremtBzeKAC92vQ595xTZMYk42Oz5deC6RA+nrYmTx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyGsDrtd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyGsDrtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1241F000E9;
	Mon, 17 Aug 2026 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786957909;
	bh=6cNv8eSuPVrrI1XugrHa1AwCFxIYfhwh9H2h3hF/0L8=;
	h=From:To:Cc:Subject:Date;
	b=GyGsDrtdu4SHvMv3R2AlBECoqg65HSzMJYIi18nZFqraVATssPH3SecawzMIsspC/
	 Trp6USE4juPI5kZLttMZtsXqTZIokz4fDNkiVywqievdHuW0Mgn1HA+XCP70NO1C1J
	 lT7mS9K1FljENcpx3qpW7kjvV+45EVUwcB1KsMJAKPBFUtw8NyRKkRxgTwbsfbLI90
	 tE1MHW09TvED01YXDTX3PdQGAikuHK2wNwymahTJJ5vX05ZQi27z5JubN2CnvFnlO8
	 yYtVgU09CRPQ9aVc9CuoIjai83Gq+9gvw7rDU1o50VUp2g+YT1igoPU6FBPmax/+Vg
	 JXyERlDy0SBfg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs/009: fix race condition in orphan inode test
Date: Mon, 17 Aug 2026 09:11:37 +0000
Message-ID: <20260817091137.1503208-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs/009     81s ... [failed, exit status 1]- output mismatch (see /share/git/fstests/results//f2fs/009.out.bad)
    --- tests/f2fs/009.out      2026-06-12 08:46:32.819432390 +0800
    +++ /share/git/fstests/results//f2fs/009.out.bad    2026-08-17 13:09:35.000000000 +0800
    @@ -1,2 +1,3 @@
     QA output created by 009
    -Silence is golden
    +can't find corruption
    +(see /share/git/fstests/results//f2fs/009.full for details)
    ...
    (Run 'diff -u /share/git/fstests/tests/f2fs/009.out /share/git/fstests/results//f2fs/009.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing f2fs-tools fix:
      958cd6e fsck.f2fs: support to repair corrupted i_links

f2fs_io write ... atomic_commit ... 5000 runs in the background and has
an initial delay before invoking F2FS_IOC_START_ATOMIC_WRITE. Without a
sleep in the test script, rm and _scratch_shutdown -f run immediately
before f2fs_io enters atomic mode, causing f2fs_io to fail and
preventing the orphan inode from being committed to the on-disk
checkpoint.

Add a 2-second sleep to let f2fs_io enter atomic mode, record its PID,
then shutdown -f to ensure the orphan inode is written to the checkpoint,
and clean up the background process properly.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/009 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/f2fs/009 b/tests/f2fs/009
index afb3bc98f..df8bef96c 100755
--- a/tests/f2fs/009
+++ b/tests/f2fs/009
@@ -106,10 +106,14 @@ check_links 0 0
 touch $filename
 ino=`stat -c '%i' $filename`
 $F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
+pid=$!
+sleep 2
 stat $filename >> $seqres.full
 rm $filename
 _scratch_shutdown -f
-sleep 6
+sleep 4
+kill $pid &> /dev/null
+wait $pid &> /dev/null
 check_links 1 0 $ino
 
 # hardlink
-- 
2.49.0

