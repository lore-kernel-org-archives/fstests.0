Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0853F195FE8
	for <fstests@vger.kernel.org>; Thu,  8 May 2025 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746690069; cv=none; b=uRhJ2ypna8l5NSgvzpupcfPxtG989lVbvGOyiXnkAnba3+Kdzanj9eLohF715WGVvw3uYIVyBspkDJnfLRXwmolLN/hdLYEhvnq/Q8bDB/Ubvnm5l3sPIqs7/xp8jLnLbSc9xPa0jhDrFL4/0DYTxrZ/yOJzqLTpaJXgjNlWcMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746690069; c=relaxed/simple;
	bh=VmRyIkZhsENLcG9rhJFQee56cwAJ2WMmDLChNr6gTDk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L4Hio64D/CSWdJOkKhCGtLq7vmi0sUBwqUBYyDMPA/pE1UDIAPiO9I5JlIttBfrmn5mDxG+UmNyuFkiXKVyADwzleQv+7Vr56qsfJUrp3P/NDsH55T1ewHGgEslpjdBcUOre2czpJeqASYrpCFDmzPqfrpFEBiYzG8g6+H9gzdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bEW53Ayt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hEUL+JxH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bEW53Ayt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hEUL+JxH"
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id EE4D61F385
	for <fstests@vger.kernel.org>; Thu,  8 May 2025 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746690065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O8YIKxXec31C2zdGbHed9842BJBZJ+A0LHuhkcNeoK4=;
	b=bEW53AytVj0N/TCnq2OjV5ltYXOcogDucT2TfRRH4ZnuqZrfioCrxcnVvf8hYnA8qwkvet
	/Dn9JCtdqjMiisbm/CY70EMMu3lDRN/SjjAIHxMhoYFZgdTh0dyZzJqZqUEWcoamRBrX9R
	IbBN4XosXWlZkNGpwyH/DjHIETzfLic=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746690064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O8YIKxXec31C2zdGbHed9842BJBZJ+A0LHuhkcNeoK4=;
	b=hEUL+JxHts85TTKZgzqO3CXNaKPZGVxPGhJLjqHkfjHDbJ9MhXMivYYV+vSIQlqW4M3vdF
	n7AhYh166NW/6Yc8OYlztGT6HbXzMRYfTZSmFq3tJit1NG8L3k8Ybbh2WFm9nYIl7g6glI
	yfnbOxYgu5h9VkUIQKjIEgrFl8IWOmM=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH] xfs/008: fix golden output for 512 fsblock size
Date: Thu,  8 May 2025 09:41:02 +0200
Message-ID: <20250508074102.125013-1-ailiop@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Spam-Score: -2.80

commit 97989c9839dd ("xfs/008: use block size instead of the pagesize")
changed the test filter, which causes nocrc/512b fsblock configurations
to fail due to mismatch of the golden output. Update it to match the
expected output.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 tests/xfs/008.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/008.out b/tests/xfs/008.out
index 0941e218c7d0..dc999156dab5 100644
--- a/tests/xfs/008.out
+++ b/tests/xfs/008.out
@@ -8,7 +8,7 @@ randholes.2 : -l FSIZE -c 100 -b BLKSIZE
 ------------------------------------------
 holes is in range
 
-randholes.3 : -l FSIZE -c 100 -b 512
+randholes.3 : -l FSIZE -c 100 -b BLKSIZE
 ------------------------------------------
 holes is in range
 
-- 
2.49.0

