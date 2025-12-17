Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2299B342500
	for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969714; cv=none; b=ePuwZSvkj1zdiiO83MwxfV4qS/U/hLiaB9Ykjzd+u5lFo/EyID+CjxxwIZp5UAAaLzzeucPNQ502SCBTJeU1pRsLZyLkZh9PKo0vmPK9i/pOqCRkJIvD1rtOVRQZFadKtIgXqMZE7YM0hDX/rgXccFpHlBsPVVKA0XUqB23sMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969714; c=relaxed/simple;
	bh=fEd1bXfjY41i3QAn6xzWzZwUTDvoedhrz0/P0TijLEE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qSMNumCyaQolFQgyNeqPGoBYbstmau5NJcGKWzEGts9tfA+SKqswbSKdHIDOfZVXNgibCIDyZ/4uZ/iPaAmlIzElg2lt17YJ6iZxStJxgMECOyLQZ+8qVK6kMTmn+Jxecx3SFx8dnjw3Nw5br7NhhDkYGaqNx70APTta9k6+wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jxvqbHVA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gA71/5Nn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jxvqbHVA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gA71/5Nn"
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id 14753336A2
	for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 11:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765969710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4oOs1Sni0Vu1xEcSj6w1l+T3lRA/AXXAkrvWUWR42uw=;
	b=jxvqbHVA/w4bZ2COegFbtpsHkpmUz7/yMSfiNIaSPuNiBJNd+zZVFKee7oVlI51+UnnI0N
	ecXDu2y5P2q5iepSzBfk1Ke63h7ne8Q7VG/gLNHIHb6gpF4/eW5jsz+rRjFE0rBBwseYyc
	40TkIT+/ddemuu1ACgA9i7kKGjTq20g=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765969709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4oOs1Sni0Vu1xEcSj6w1l+T3lRA/AXXAkrvWUWR42uw=;
	b=gA71/5Nn+7F6KQ8N0J53Dr9mXIED7/5qslQQEn9WIQrwOZiDXFGwRJbRKSJJdWhFh6HxAI
	Hm+inc03xHCud2DfbeHuOpP83fF4KBcFNfKGYXwaUUDtRceyWWIZjKAM41ASpWnzwg+uvx
	ecUDxRB1MixfFeaxmbPMivQcmjghGfg=
From: Anthony Iliopoulos <ailiop@suse.com>
To: <fstests@vger.kernel.org>
Subject: [PATCH] xfs/490: fix failure due to deprecated ikeep mount option
Date: Wed, 17 Dec 2025 12:08:19 +0100
Message-ID: <20251217110819.150741-1-ailiop@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.70
X-Spam-Level: 
X-Spamd-Result: default: False [-2.70 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.10)[-0.523];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,kunlun.arch.suse.cz:helo]

The ikeep mount option has been deprecated as of kernel commit
b9a176e54162 ("xfs: remove deprecated mount options"), and after commit
3e7ec343f066 ("xfs: loudly complain about defunct mount options") there
is a warning emitted when testing v5 filesystems.

Fix it by explicitly requiring and formatting scratch to nocrc/v4, as
the test cannot otherwise be triggered on v5 without the ikeep option.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 tests/xfs/490 | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tests/xfs/490 b/tests/xfs/490
index a3b0747580ea..366acbfa3ef9 100755
--- a/tests/xfs/490
+++ b/tests/xfs/490
@@ -20,6 +20,7 @@ _begin_fstest auto quick
 # Modify as appropriate.
 _require_scratch_nocheck
 _require_xfs_mkfs_finobt
+_require_xfs_nocrc
 
 # Skip the verifier "xfs_check_agi_freecount()" which verify the number of free
 # inodes in the AGI is correct, when XFS_DEBUG is enabled
@@ -35,16 +36,7 @@ filter_dmesg()
 # If enable free inode B+tree, this case will fail on xfs_dialloc_ag_update_inobt,
 # that's not what we want to test. Due to finobt feature is not necessary for this
 # test, so disable it directly.
-_scratch_mkfs_xfs -m finobt=0 | _filter_mkfs 2>$tmp.mkfs >> $seqres.full
-
-# On V5 filesystem, this case can't trigger bug because it doesn't read inodes
-# we are allocating from disk - it simply overwrites them with new inode
-# information. So use ikeep mount option to stop that.
-source $tmp.mkfs
-mount_opt=""
-if [ $_fs_has_crcs -eq 1 ]; then
-	mount_opt="-o ikeep"
-fi
+_scratch_mkfs_xfs -m crc=0,finobt=0 | _filter_mkfs 2>$tmp.mkfs >> $seqres.full
 
 blksz=$(_scratch_xfs_get_sb_field blocksize)
 agcount=$(_scratch_xfs_get_sb_field agcount)
-- 
2.52.0

