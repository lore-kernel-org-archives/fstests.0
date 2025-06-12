Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19B2737E7
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749755127; cv=none; b=neYckL6FcvXt31KgHQSGCnPyzt/DuYqkXc72Duqg0wOSlusZAvQE80VZzsSLgxEirswXlnA4zeV+CiNOQyPpRnMWPO4Sp1PGqLM2XTCfSZyrOEvfmszEgYF1d6Y9WtItLFJ7/V4pJLUmNPmCPf2cAGTotSXSV+fHXp2C85T+5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749755127; c=relaxed/simple;
	bh=9DTYqjGgPk4xaq7d7L+b/dNHyIg8P6aqV5M9ubUY2/k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=raKuORxdKVobnQ8C2z6th7ZjdWe3I1TJ2qie/COAxCfH1ELmJhUCBlsgYimg3QT6LoPZAZG/OBop9xyiX+kkMsvnpsPo4VEUbu4wcBLIMGA/wQM0YsSwd3Q/EiE+ZZfFhMM+sk53F6zbdf3q1md1hSLGEd4N82lAmitfIN4AGVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FIUsbv25; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FIUsbv25; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FIUsbv25";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FIUsbv25"
Received: from localhost.localdomain (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id 9641C21188
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 19:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749755122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ptAEXJ8AZ/qBuYov0kiw0KQVNkroF/oqNaT1qDScAus=;
	b=FIUsbv25a/XPkxxnBrgicAjoBLQ3ePmtYi9T0b4AUxvXJaM/PriwRIMlhZYnmzFEcWWsol
	L7ilVWJAAyeaXuNKcfQP/HT9MZus3nqegWrCBW99J71PBBq6W6ttpzVkXnsPa+wZFHhkj/
	odwZJhxQfWSRjdrH78hZXF5CqNsCPZ0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749755122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ptAEXJ8AZ/qBuYov0kiw0KQVNkroF/oqNaT1qDScAus=;
	b=FIUsbv25a/XPkxxnBrgicAjoBLQ3ePmtYi9T0b4AUxvXJaM/PriwRIMlhZYnmzFEcWWsol
	L7ilVWJAAyeaXuNKcfQP/HT9MZus3nqegWrCBW99J71PBBq6W6ttpzVkXnsPa+wZFHhkj/
	odwZJhxQfWSRjdrH78hZXF5CqNsCPZ0=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH] src/fill2: fix segfault during fopen error cleanup
Date: Thu, 12 Jun 2025 21:05:13 +0200
Message-ID: <20250612190513.8669-1-ailiop@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,localhost.localdomain:helo]
X-Spam-Level: 

When fill2 fails to open the output file (e.g. due to ENOSPC), it jumps
into the cleanup code where it attempts to call fclose, and this causes
a segfault within the glibc fclose code as it attempts to deref a null
pointer.

Fix it by conditionally calling fclose on the file pointer only when
non-null.

This is consistently reproducible with xfs/041.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 src/fill2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/fill2.c b/src/fill2.c
index 4cc1c3d79a98..37ed00b1d9b1 100644
--- a/src/fill2.c
+++ b/src/fill2.c
@@ -307,7 +307,7 @@ main(int argc, char **argv)
  cleanup:
 
     /* close file and flush buffers - check if this fails */
-    if (fclose(f) != 0) {
+    if (f && fclose(f) != 0) {
 	fprintf(stderr, "fill2: fclose() on \"%s\" failed: %s\n",
 		dfile, strerror(errno));
 	status = 1;
-- 
2.44.0

