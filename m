Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4DCC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 15 Oct 2021 18:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6E960BD3
	for <linux-fstests@archiver.kernel.org>; Fri, 15 Oct 2021 18:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhJOSjR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 15 Oct 2021 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbhJOSjQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 15 Oct 2021 14:39:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDC8C061570
        for <fstests@vger.kernel.org>; Fri, 15 Oct 2021 11:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=NrspZEHYkiRmCXEyIfYSB3rb5fYYoHMgE/53/70YqiM=; b=BrnsfKjSwk9HE4rHQ9eAWs45FP
        gBFCPsLvBAVRwdM9ZV3z0cKJ/Dbrtmke19Rdva/7xE3wiguMRjcZRWrsRMRcLltfZ4vGTSSNbM/Yq
        zRH1RTwf0ok1qqg6Bnzumt1FSub/U2o3OupPgrdYgqRrs0NhygFTevRfUqSeTljl2Qj2EjIE2EzPB
        v70b0IPmyHqNdaXNaC2GT6rEKJ8S06JsgtWp+aE5kZnZKX61VEZ590UiIg5WwGWESmwfku8HRGcrT
        nWmUKbjwQFCkRlyqT8IS1JFqAbK62tI2dPsoA+uSNAdwEoLr9IhzYXjVMCWPjexsu1MYV8U2XLACe
        1j96UKNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbS3Q-009CqI-DT; Fri, 15 Oct 2021 18:35:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     fstests@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] common/rc: Include swap in memory size calculation
Date:   Fri, 15 Oct 2021 19:35:34 +0100
Message-Id: <20211015183534.2193978-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_free_memory_bytes() is used to determine whether it's reasonable to
create a tmpfs of a particular size.  Since tmpfs can swap (and some of
these tests are good for evaluating swapping), it makes sense to include
the free swap as well as the free memory in the calculation.

Use perl instead of awk because at least mawk will saturate at 2^31-1.
gawk doesn't, but that kind of dependency is a bad thing to require.
At least this eliminates a use of grep.

With this fixed, generic/273 generic/274 generic/275 generic/312
generic/320 generic/466 all now pass on tmpfs instead of being skipped.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 7f693d39..f84d3873 100644
--- a/common/rc
+++ b/common/rc
@@ -966,7 +966,7 @@ _scratch_pool_mkfs()
 # Return the amount of free memory available on the system
 _free_memory_bytes()
 {
-    free -b | grep ^Mem | awk '{print $4}'
+    free -b | perl -lane '$F[0] =~ /^[A-Z]/ and $total += $F[3]; END { print $total }'
 }
 
 _available_memory_bytes()
-- 
2.32.0

