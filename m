Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45F63FE5
	for <fstests@vger.kernel.org>; Wed, 30 Jul 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896518; cv=none; b=NK44tjh8Fx8QEk0pxxuR0lIrdeWuHMBSAQXo2kpuNioVlbm8EEmTSaMO/xaQ+qDDXgs14sYNjJ+M9VvK+itZf4dzlGXvDza61/WIul+yA7oomU3e/lGgVcmTtv42y6LIrivVfcMYEENAPZxfswKwm1VPLSc5KYK2WsaTsvsHIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896518; c=relaxed/simple;
	bh=U3jpvX8wB2/rlsP/tzRJEgDm8q3r0hjff5LkPTbniqc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CgEbNdT6ypmFoV9aetSkSbVJW+pQKrDREc/r0AgZPVWR1uUwxqMFG8/cq9hh0oRoibNxhVmBx8QDEarbBng2y8qxLYHMZW+bGj2p77qrsTIUsfGWngBfC+7WODqN84ODYuNUjDjAW7m0yrvzFt8RqYjg7N3QsqJztztboAjQGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WTokhfFH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WTokhfFH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WTokhfFH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WTokhfFH"
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id CEAC61F385
	for <fstests@vger.kernel.org>; Wed, 30 Jul 2025 17:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753896513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VYpYBR8nWzJwyfAgr7sxCJmVLPI4iNrXHC7IQ0A0OJE=;
	b=WTokhfFHC1U8vFd1QVQt+vuvMxn1rQ88elYMkFYSnmXqp2yj+9xHrgpIpvcbDRh3aUjRNV
	AZr+6q2Qa7KTIP2DgVGf3Gl76YlnaxyNwCy7E92oLw+JoxTytPITmEu0fcqKC4hh9pwTIR
	ZcpG68D9mRjrGkVrsE7T6dO5xe3zako=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753896513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VYpYBR8nWzJwyfAgr7sxCJmVLPI4iNrXHC7IQ0A0OJE=;
	b=WTokhfFHC1U8vFd1QVQt+vuvMxn1rQ88elYMkFYSnmXqp2yj+9xHrgpIpvcbDRh3aUjRNV
	AZr+6q2Qa7KTIP2DgVGf3Gl76YlnaxyNwCy7E92oLw+JoxTytPITmEu0fcqKC4hh9pwTIR
	ZcpG68D9mRjrGkVrsE7T6dO5xe3zako=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH] xfs/189: fix remount barrier test failure
Date: Wed, 30 Jul 2025 19:28:26 +0200
Message-ID: <20250730172826.122130-1-ailiop@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.985];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.arch.suse.cz:helo,suse.com:email,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

_test_remount_barrier() is skipped on kernels newer than v4.19 where the
barrier options have been removed, and this is detected by matching the
mount command output for a "bad option" error.

Recent util-linux commit 9da5644e414c ("libmount: report kernel message
from new API"), which was introduced in v2.41 release changed that error
message from the old hardcoded one:

  mount: /mnt/scratch: mount point not mounted or bad option.

to the newer, and more specific coming from the kernel:

  mount: /mnt/scratch: fsconfig() failed: xfs: Unknown parameter 'barrier'.

Update the test to account for that change so that the unsupported
options can be properly detected again and for this part of the test to
be skipped successfully.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 tests/xfs/189 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/189 b/tests/xfs/189
index d32adf0840a6..1770023760fd 100755
--- a/tests/xfs/189
+++ b/tests/xfs/189
@@ -180,7 +180,7 @@ _test_remount_barrier()
 
 	# If the kernel doesn't recognize 'barrier' as a mount option then
 	# just fake the output.  The barrier option was removed in 4.19.
-	if grep -q "bad option" $tmp.barriermount; then
+	if grep -E -q "(bad option|Unknown parameter)" $tmp.barriermount; then
 		cat << ENDL
 SCRATCH_DEV on SCRATCH_MNT type xfs (rw)
 SCRATCH_DEV on SCRATCH_MNT type xfs (rw,nobarrier)
-- 
2.50.1

