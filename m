Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE2AC433F5
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Dec 2021 16:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhLGQIL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Dec 2021 11:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhLGQIL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Dec 2021 11:08:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5973AC061574
        for <fstests@vger.kernel.org>; Tue,  7 Dec 2021 08:04:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 240BFB817FC
        for <fstests@vger.kernel.org>; Tue,  7 Dec 2021 16:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9701DC341C1;
        Tue,  7 Dec 2021 16:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638893078;
        bh=sm/YeaJUFS74a8iDN2GkzR93Hl56Ptp0kqz5tCt9OYk=;
        h=From:To:Cc:Subject:Date:From;
        b=EE+rrsjULiBQqjHCJGxPZVFHU4WZvKtzt8eG6/qDnjcJ0Fy3mHPuCsALj1ROyFVTO
         CHzCwXJVsTvIxjVZBhhlDZnSWEXisKVTXY+aspnJFxnIE0RmnO/dli0xZcRoaCjpHF
         9SYeY7uryhfMxNWTWmZW8598TEIOErwwPmtCgxqZP/O+Xao86ZZbDvc2uDrx3IJsCP
         fETz615qIjzggUT+k5owO2pI1O5T/xcGVUNTJfU5AeC92qxKySOsy2EIa7B/NUH2N/
         e65gu+rFqj9m7MVc7vxXFXem5Z3UFii29FOpT/18au9Ve5n8dnTOPjRpMzhOJv4PpI
         quV7JKUocPkiA==
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Luis Henriques <lhenriques@suse.de>
Subject: [fstests PATCH] ceph: don't run tests if we can't set a custom layout
Date:   Tue,  7 Dec 2021 11:04:37 -0500
Message-Id: <20211207160437.184145-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some of the coming fscrypt patches prohibit non-default layout changes.
Skip running the tests that set custom layouts if setting the layout fails.

Cc: Luis Henriques <lhenriques@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/ceph | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/ceph b/common/ceph
index ca756dda8dd3..31b169af51b8 100644
--- a/common/ceph
+++ b/common/ceph
@@ -19,7 +19,7 @@ _ceph_create_file_layout()
 	touch $fname
 	$SETFATTR_PROG -n ceph.file.layout \
 		-v "stripe_unit=$objsz stripe_count=1 object_size=$objsz" \
-		$fname
+		$fname || _notrun "setting ceph.file.layout failed"
 }
 
 # this test requires to access file capabilities through vxattr 'ceph.caps'.
-- 
2.33.1

