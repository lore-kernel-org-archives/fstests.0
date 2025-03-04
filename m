Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D807BA2D
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132125; cv=none; b=qojmImWHOtteGcsusOYwpZjHkPfdu0HrquLsyaHBwAJ9xbD6aacRLSih7JDPqfW/ChvREYl+8Iu06reoI+/G+abf3Bdwc6x4g8qVDHX1umkmO+UJfKQ90OlTktR1eOaSeVgnEpD4ZEUl1RlrEAVsUL0jyVKZC+jihm64ybZi9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132125; c=relaxed/simple;
	bh=4832r1aJNUDx9QnlgrAQhEAsEZHNcRlcX2raD/oMyVI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nxj03hWNssJBJWjSfxL2y6fWcMxMT+q8p9gP3+YN4itEnPnRuvtHGv/RMQGyJzjUjHRnkDW+XvMvu5NU1pQ9ImchawbiDRAqo5BifThxAwvK/IMsz0VCr2dDJwqwiK0WRoBf3NjJ5kUWRyhUMCV4u3N0TBPeganf71wpk7apqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hL0zRKUP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hL0zRKUP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hL0zRKUP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hL0zRKUP"
Received: from localhost.localdomain (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id 061791F393
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 23:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741132119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cJedS+5/jXHAt9h7wZm+hnZI3tlEOPfcNdG6PIUi+R4=;
	b=hL0zRKUPz1k5nGyNrF/6OmY2KUn2tHhHSQTfrnQjzO1P8xwumcPA8u9bn1ToI90EtXNBC3
	sQYCj3DPT5qTZHjb3Q90szSY8+sDV7lRosDAR90W2BS1r3DdBfjURWCEM76XanQJccm6fa
	iqHOQplfTIptOn4aK+I7dadqf6/ibaA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741132119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cJedS+5/jXHAt9h7wZm+hnZI3tlEOPfcNdG6PIUi+R4=;
	b=hL0zRKUPz1k5nGyNrF/6OmY2KUn2tHhHSQTfrnQjzO1P8xwumcPA8u9bn1ToI90EtXNBC3
	sQYCj3DPT5qTZHjb3Q90szSY8+sDV7lRosDAR90W2BS1r3DdBfjURWCEM76XanQJccm6fa
	iqHOQplfTIptOn4aK+I7dadqf6/ibaA=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH] generic/633: add _require_idmapped_mounts check
Date: Wed,  5 Mar 2025 00:48:19 +0100
Message-ID: <20250304234819.783-1-ailiop@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
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
X-Spam-Flag: NO
X-Spam-Level: 

Skip the test on older kernels that don't implement mount_setattr and
open_tree syscalls, instead of failing.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 tests/generic/633 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/633 b/tests/generic/633
index 3bd18df68ba5..f58dbbf5f222 100755
--- a/tests/generic/633
+++ b/tests/generic/633
@@ -12,7 +12,7 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
 # Import common functions.
 . ./common/filter
 
-
+_require_idmapped_mounts
 _require_test
 
 echo "Silence is golden"
-- 
2.44.0

