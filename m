Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F819BA5
	for <fstests@vger.kernel.org>; Tue, 31 Oct 2023 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="aa+sGs2Z"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30BBE4
	for <fstests@vger.kernel.org>; Tue, 31 Oct 2023 04:10:51 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SKS9h0Lvxz9sTy;
	Tue, 31 Oct 2023 12:10:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1698750648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xzAuhhvoIh3CZrKyCgRqH8fbsLrgh3q+A/Y6Ecm5I2k=;
	b=aa+sGs2ZQQWPhYZa4PW2fWP62EbzMR2+V2JOjtY9E/NBoLOT+MtshJaNHX7MTjSZm+ea6E
	55ZLZAuYSA3201SbBgrnTvH7roV2iD1CGzVpbL/EaYVYfG+Q7Uf2O9WNBdcgMudTbqBm35
	bcksVRVAEBpZudqJuNeHOrPNC9WnOsxm8HagnRn8mGans6ujmic+VozGWw0C0XtAVWCUNx
	EifAnp6LQtypB0w74KHYsWCPz3jiQT5to2SCXarTvINl2MN1HeQkLLnFuLs3MjrNX/mb42
	9o+cS36Uq9AxhRy+xzgioN662knxGVJrPpXndmPnPDdREX0a66u658H4dpN7mg==
From: Pankaj Raghav <kernel@pankajraghav.com>
To: fstests@vger.kernel.org,
	Zorro Lang <zlang@redhat.com>
Cc: gost.dev@samsung.com,
	mcgrof@kernel.org,
	djwong@kernel.org,
	fdmanana@suse.com,
	p.raghav@samsung.com
Subject: [PATCH] fstests: redirect stderr to stdout in generic/269 and xfs/051
Date: Tue, 31 Oct 2023 12:10:27 +0100
Message-Id: <20231031111027.3367136-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4SKS9h0Lvxz9sTy

From: Pankaj Raghav <p.raghav@samsung.com>

A recent commit redirected the stdout from /dev/null to $seqres.full.
That commit missed redirection of stderr to stdout which was present
before.

This leads to test failures as the stderr is going to the output:

fsstress: check_cwd stat64() returned -1 with errno: 5 (Input/output error)
fsstress: check_cwd stat64() returned -1 with errno: 5 (Input/output error)
fsstress: check_cwd failure
fsstress: check_cwd failure

Redirection of stderr to stdout is still needed because fsstress can
still return errors in generic/269 and xfs/051 as we inject enospc and
shutdown the fs respectively. These tests only care about the fs
consistency at the end.

Add the removed 2>&1 back in these two tests.

Fixes: f55e46d6 ("fstests: redirect fsstress' stdout to $seqres.full instead of /dev/null")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
There could be more tests that might be affected by this regression but
I came across only these two when I ran the test for xfs.

 tests/generic/269 | 2 +-
 tests/xfs/051     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/269 b/tests/generic/269
index b852f6bf..eddca10d 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -23,7 +23,7 @@ _workout()
 	out=$SCRATCH_MNT/fsstress.$$
 	args=`_scale_fsstress_args -p128 -n999999999 -f setattr=1 $FSSTRESS_AVOID -d $out`
 	echo "fsstress $args" >> $seqres.full
-	$FSSTRESS_PROG $args >> $seqres.full &
+	$FSSTRESS_PROG $args >> $seqres.full 2>&1 &
 	pid=$!
 	echo "Run dd writers in parallel"
 	for ((i=0; i < num_iterations; i++))
diff --git a/tests/xfs/051 b/tests/xfs/051
index 1c670964..eca67bb8 100755
--- a/tests/xfs/051
+++ b/tests/xfs/051
@@ -38,7 +38,7 @@ _scratch_mount
 
 # Start a workload and shutdown the fs. The subsequent mount will require log
 # recovery.
-$FSSTRESS_PROG -n 9999 -p 2 -w -d $SCRATCH_MNT >> $seqres.full &
+$FSSTRESS_PROG -n 9999 -p 2 -w -d $SCRATCH_MNT >> $seqres.full 2>&1 &
 sleep 5
 _scratch_shutdown -f
 $KILLALL_PROG -q $FSSTRESS_PROG
-- 
2.40.1

