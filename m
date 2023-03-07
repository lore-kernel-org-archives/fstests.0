Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AD3C678D4
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 12:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjCGMF2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 07:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCGMF2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 07:05:28 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBA532530
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 04:05:25 -0800 (PST)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 07 Mar 2023 11:45:42 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 11/11] vfs: Use tabs to indent, not spaces
Date:   Tue,  7 Mar 2023 12:45:07 +0100
Message-Id: <20230307114507.332309-12-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 src/vfs/vfstest.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git src/vfs/vfstest.c src/vfs/vfstest.c
index 3d75b1e3..dea344cc 100644
--- src/vfs/vfstest.c
+++ src/vfs/vfstest.c
@@ -107,7 +107,7 @@ static int hardlink_crossing_mounts(const struct vfstest_info *info)
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
 
-        if (chown_r(info->t_mnt_fd, T_DIR1, 10000, 10000)) {
+	if (chown_r(info->t_mnt_fd, T_DIR1, 10000, 10000)) {
 		log_stderr("failure: chown_r");
 		goto out;
 	}
@@ -2307,22 +2307,22 @@ static void usage(void)
 	fprintf(stderr, "    Run idmapped mount tests\n\n");
 
 	fprintf(stderr, "Arguments:\n");
-	fprintf(stderr, "--device                            Device used in the tests\n");
-	fprintf(stderr, "--fstype                            Filesystem type used in the tests\n");
-	fprintf(stderr, "--help                              Print help\n");
-	fprintf(stderr, "--mountpoint                        Mountpoint of device\n");
-	fprintf(stderr, "--idmapped-mounts-supported         Test whether idmapped mounts are supported on this filesystem\n");
-	fprintf(stderr, "--scratch-mountpoint                Mountpoint of scratch device used in the tests\n");
-	fprintf(stderr, "--scratch-device                    Scratch device used in the tests\n");
-	fprintf(stderr, "--test-core                         Run core idmapped mount testsuite\n");
-	fprintf(stderr, "--test-fscaps-regression            Run fscap regression tests\n");
-	fprintf(stderr, "--test-nested-userns                Run nested userns idmapped mount testsuite\n");
-	fprintf(stderr, "--test-btrfs                        Run btrfs specific idmapped mount testsuite\n");
-	fprintf(stderr, "--test-tmpfs                        Run tmpfs specific idmapped mount testsuite\n");
+	fprintf(stderr, "--device			     Device used in the tests\n");
+	fprintf(stderr, "--fstype			     Filesystem type used in the tests\n");
+	fprintf(stderr, "--help				     Print help\n");
+	fprintf(stderr, "--mountpoint			     Mountpoint of device\n");
+	fprintf(stderr, "--idmapped-mounts-supported	     Test whether idmapped mounts are supported on this filesystem\n");
+	fprintf(stderr, "--scratch-mountpoint		     Mountpoint of scratch device used in the tests\n");
+	fprintf(stderr, "--scratch-device		     Scratch device used in the tests\n");
+	fprintf(stderr, "--test-core			     Run core idmapped mount testsuite\n");
+	fprintf(stderr, "--test-fscaps-regression	     Run fscap regression tests\n");
+	fprintf(stderr, "--test-nested-userns		     Run nested userns idmapped mount testsuite\n");
+	fprintf(stderr, "--test-btrfs			     Run btrfs specific idmapped mount testsuite\n");
+	fprintf(stderr, "--test-tmpfs			     Run tmpfs specific idmapped mount testsuite\n");
 	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
 	fprintf(stderr, "--test-setxattr-fix-705191b03d50    Run setxattr regression tests\n");
-	fprintf(stderr, "--test-setgid-create-umask          Run setgid with umask tests\n");
-	fprintf(stderr, "--test-setgid-create-acl            Run setgid with acl tests\n");
+	fprintf(stderr, "--test-setgid-create-umask	     Run setgid with umask tests\n");
+	fprintf(stderr, "--test-setgid-create-acl	     Run setgid with acl tests\n");
 
 	_exit(EXIT_SUCCESS);
 }
-- 
2.39.2

