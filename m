Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02AF1C173F
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015877; cv=none; b=AVqyRINg/PhzM29Nkbj0LHDBYn7fqY/uT35vVnuTM5Ips1t7HpuKVaqh2Mjy4buwJvueC9fUHlLAWyOtOlB+1KtFBra+pvjT17qlK1AliIunfE8LpXFb8GuUIZJiQ8rhMnvj0yaei2vZuhELNAW/hH+Jcfg9988MZF3bHPazlLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015877; c=relaxed/simple;
	bh=SVuKp4RKGTxQmIFVtpAWoH05QYTWyK9E0YvWWjgo5Qw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AnvOJPM8aaLkybUqfePJRKrENFdqGMuPusncx0lkid2BxXeksrqcMwgE1FsZp/3GDzkOgCPXT/zFjJzvFCUeAQ6yJPdFSdXTR8SHroQ2ziyu2s5pATm6AYFAxsJFHxGv7bRoIx1YrFRt/aXnvzakli1OqXHhCb+sUb7iQRrCjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VL2Bz84a; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HhEDbBKE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VL2Bz84a";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HhEDbBKE"
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id DA17F211FD
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 12:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746015874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SzJEYRVRVxqfXutjFSkelEvLUdm6S3Clv1RwZShrXTA=;
	b=VL2Bz84alg1Ov3Sg75RNSKFCHM6Qk+mqNbBZbuUBEC/K7Y6jN1zrO3z9UnKDWWu4F6VadT
	yzoCcwf/qaMPOtOQKK0rCjPufnne6amfslps8eVbznaf6w8JsmBAjnM1v0g9se8ykTMbcg
	ml+ikBRKrfTl6WGOjD6/Uv5DTQy6ENI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746015873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SzJEYRVRVxqfXutjFSkelEvLUdm6S3Clv1RwZShrXTA=;
	b=HhEDbBKEAbmXUQqkCIwgT5LUyRDFu5N5zMEAhw9whmpRMBQZ3kYiUbUvXVq0Yg1dk7F9tZ
	7+AHnLuM/879T7WqMoi4k84oQY9K0ozjvav8IbRouqMIo21K3sWbMMMuQE8GXedcd07BpM
	sojc3P4l2WLQVKW9nP9J1E4QFZM0tUQ=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH] fstests/MAINTAINERS: update ocfs2 mailing list address
Date: Wed, 30 Apr 2025 14:23:42 +0200
Message-ID: <20250430122342.157170-1-ailiop@suse.com>
X-Mailer: git-send-email 2.49.0
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
X-Spam-Flag: NO
X-Spam-Level: 

Bring the ocfs2 mailing list address up to date, following the upstream
change in kernel commit a57b4b7f0557 ("MAINTAINERS: update ocfs2-devel
mailing list address").

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc31572902bf..a0f50f3d98b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -157,7 +157,7 @@ F:	tests/nfs/
 F:	common/nfs
 
 OCFS2
-L:	ocfs2-devel@oss.oracle.com
+L:	ocfs2-devel@lists.linux.dev
 S:	Supported
 F:	tests/ocfs2/
 
-- 
2.49.0

