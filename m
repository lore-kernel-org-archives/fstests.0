Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48354F1E1
	for <fstests@vger.kernel.org>; Thu, 11 Jan 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuMpsgEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704986858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B0mXNYUaAC/Y45a2Jh64GktsoTC4UJyLIMITBVmGcMM=;
	b=JuMpsgEKLyhZa0z17x2G5HDBUNpNAdIPzLnP7VI8pD3MNIqFYA3QQZxZ1+bobBktZwE7rr
	wW150+fPAQxSnciRkvVs+CW6IwLqcCrCNpmPGZVajDqm9JlwbRq7dkIEqCWIJXsLw0Oxic
	1q3FNcwKmx1ct7dvRjFSiVW7hGSR9iE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-0xI181Q7PF6H-PyJpGWDRw-1; Thu,
 11 Jan 2024 10:27:32 -0500
X-MC-Unique: 0xI181Q7PF6H-PyJpGWDRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C526A28EC116
	for <fstests@vger.kernel.org>; Thu, 11 Jan 2024 15:27:31 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 41331C15A0C;
	Thu, 11 Jan 2024 15:27:31 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Recognize block size in _scratch_mkfs_sized
Date: Thu, 11 Jan 2024 16:27:30 +0100
Message-ID: <20240111152730.4339-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Fix the block size recognition logic in _scratch_mkfs_sized() to work
for gfs2 as well.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index cc92fe06..9d947df2 100644
--- a/common/rc
+++ b/common/rc
@@ -931,7 +931,7 @@ _scratch_mkfs_sized()
 	btrfs)
 		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
 		;;
-	ext2|ext3|ext4|ext4dev|reiser4|ocfs2|reiserfs)
+	ext2|ext3|ext4|ext4dev|reiser4|ocfs2|reiserfs|gfs2)
 		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
 		;;
 	udf)
-- 
2.43.0

