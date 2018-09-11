Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbeIKKZu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Sep 2018 06:25:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D24440241CB
        for <fstests@vger.kernel.org>; Tue, 11 Sep 2018 05:28:18 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-85.bne.redhat.com [10.64.54.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B732B1C733
        for <fstests@vger.kernel.org>; Tue, 11 Sep 2018 05:28:17 +0000 (UTC)
From: Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] cloner: add support for clone_file_range for cifs
Date: Tue, 11 Sep 2018 15:28:06 +1000
Message-Id: <20180911052806.1302-2-lsahlber@redhat.com>
In-Reply-To: <20180911052806.1302-1-lsahlber@redhat.com>
References: <20180911052806.1302-1-lsahlber@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 src/cloner.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/cloner.c b/src/cloner.c
index ffad82f0..9f9156e5 100644
--- a/src/cloner.c
+++ b/src/cloner.c
@@ -120,6 +120,18 @@ clone_file_range_btrfs(int src_fd, int dst_fd, uint64_t src_off,
 }
 
 static int
+clone_file_range_cifs(int fd_in, int fd_out, loff_t off_in,
+		      loff_t off_out, size_t len)
+{
+	int ret;
+
+	ret = copy_file_range(fd_in, &off_in, fd_out, &off_out, len, 0);
+	if (ret < 0)
+		ret = errno;
+	return 0;
+}
+
+static int
 clone_file_range(unsigned int fs_type, int src_fd, int dst_fd, uint64_t src_off,
 		 uint64_t dst_off, uint64_t len)
 {
@@ -128,7 +140,9 @@ clone_file_range(unsigned int fs_type, int src_fd, int dst_fd, uint64_t src_off,
 		return clone_file_range_btrfs(src_fd, dst_fd, src_off, dst_off,
 					      len);
 		break;
-	case CIFS_MAGIC_NUMBER:	/* only supports full file server-side copies */
+	case CIFS_MAGIC_NUMBER:
+		return clone_file_range_cifs(src_fd, dst_fd, src_off, dst_off,
+					     len);
 	default:
 		return ENOTSUP;
 		break;
-- 
2.13.3
