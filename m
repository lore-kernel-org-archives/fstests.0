Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B98CDB465
	for <linux-fstests@archiver.kernel.org>; Mon, 16 Oct 2023 13:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjJPNL4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 Oct 2023 09:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjJPNLj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Oct 2023 09:11:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC510E6
        for <fstests@vger.kernel.org>; Mon, 16 Oct 2023 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description;
        bh=9WZXm/yfAxtPeq7QFeFdbmfLMCmkQFi0vQUK9jpW9PQ=; b=B64GteZDeLF1Z901SCreH6kpmw
        YBqIVyGcshsBAApPyda9Tp7jHFexxHyDeHADZb8wzGKat9FY/sQKYTYxJJpZmG9CZyzuw3/tGI8gq
        2ZMdYq+A7+TGv0HagA3M8rzAHSz0YhJp5sMQq8NeA/QhjSeiPq3r2azqQc1Aw5RllY6OIHvSNDbJr
        51EOaKaXadX0syZEKhd57SnVuuCYJbQcgn84HL3F3sHQ6ROoJS3L5n4OhUcpZkQbXoq2w4mvcQvjI
        mrPp68UEpJjpibYTnC+Zj4DFDMeCR1ZKoFJZvub9n2aNPIN30nvSroVhngOXjJMUglnfL1mu5t8t2
        Z509kvog==;
Received: from 213-147-167-190.nat.highway.webapn.at ([213.147.167.190] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsNNH-009hCU-3A
        for fstests@vger.kernel.org;
        Mon, 16 Oct 2023 13:11:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/2] xfs: add missing _require_scratch calls
Date:   Mon, 16 Oct 2023 15:11:03 +0200
Message-Id: <20231016131103.966920-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016131103.966920-1-hch@lst.de>
References: <20231016131103.966920-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add _require_scratch to a bunch of test that were using $SCRATCH_DEV
without that check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/xfs/184 | 1 +
 tests/xfs/192 | 1 +
 tests/xfs/200 | 1 +
 tests/xfs/204 | 1 +
 tests/xfs/232 | 1 +
 5 files changed, 5 insertions(+)

diff --git a/tests/xfs/184 b/tests/xfs/184
index 3bdd86ad..97f529f6 100755
--- a/tests/xfs/184
+++ b/tests/xfs/184
@@ -19,6 +19,7 @@ _begin_fstest auto quick clone fiemap unshare
 
 # real QA test starts here
 _supported_fs xfs
+_require_scratch
 _require_scratch_delalloc
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/xfs/192 b/tests/xfs/192
index eb577f15..ef7da55b 100755
--- a/tests/xfs/192
+++ b/tests/xfs/192
@@ -19,6 +19,7 @@ _begin_fstest auto quick clone fiemap unshare
 
 # real QA test starts here
 _supported_fs xfs
+_require_scratch
 _require_scratch_delalloc
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/xfs/200 b/tests/xfs/200
index b51b9a54..a9d6ce1b 100755
--- a/tests/xfs/200
+++ b/tests/xfs/200
@@ -21,6 +21,7 @@ _begin_fstest auto quick clone fiemap unshare
 
 # real QA test starts here
 _supported_fs xfs
+_require_scratch
 _require_scratch_delalloc
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/xfs/204 b/tests/xfs/204
index 7d6b79a8..7dacfa2d 100755
--- a/tests/xfs/204
+++ b/tests/xfs/204
@@ -21,6 +21,7 @@ _begin_fstest auto quick clone fiemap unshare
 
 # real QA test starts here
 _supported_fs xfs
+_require_scratch
 _require_scratch_delalloc
 _require_scratch_reflink
 _require_cp_reflink
diff --git a/tests/xfs/232 b/tests/xfs/232
index 59bbc436..0cb26fa1 100755
--- a/tests/xfs/232
+++ b/tests/xfs/232
@@ -30,6 +30,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs xfs
+_require_scratch
 _require_scratch_delalloc
 _require_xfs_io_command "cowextsize"
 _require_scratch_reflink
-- 
2.39.2

