Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48974C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 18:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357452AbiELSWW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 14:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357581AbiELSWO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 14:22:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A175C764
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 11:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D89460C6B
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 18:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95E2C34118;
        Thu, 12 May 2022 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652379728;
        bh=Aah6CErgBBjVH6lWrUSxNw1khtLNURi1m40LiaOJ0sU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8rjYfYraMnqhSmoogLgik4iFhE3VkM5igFk03N9yp85igD+tfHRajFxLaXHrhbk0
         AcdQhRFNvIz2REjcSn4OaE8WQmMORhSqPZKRDPoQPDjmGWVbodUVC3xDHMorsbGApr
         2NN5RishQAjBPkGt4qxG79kg1nMwP12X6aQur2yBzjUztSA3JtLojDs62lS7iC5zMK
         Z27u8ILULBune67BA6LoJNBLRfGgi71lJm0HW1W9oh18dUUJtU2T+EXjU0tDkERoMK
         wMnqsfIIDm0h433vQnqqofWNdBA8x8xcIrjDLwYXH8XlWwUlJdfjSI5J/gif8nkj3r
         sN6o75q4A4r0A==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     djwong@kernel.org
Subject: [PATCH v3 2/2] generic/603: use project quota create and restore common helpers
Date:   Fri, 13 May 2022 02:22:03 +0800
Message-Id: <20220512182203.2839593-2-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220512182203.2839593-1-zlang@kernel.org>
References: <20220512182203.2839593-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

As common/quota has _create_project_quota and _restore_project_quota
helpers now, so replace local similar functions with them.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 tests/generic/603 | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/tests/generic/603 b/tests/generic/603
index b362a3d0..08ddcbf2 100755
--- a/tests/generic/603
+++ b/tests/generic/603
@@ -13,7 +13,7 @@ _begin_fstest auto quick quota
 # Override the default cleanup function.
 _cleanup()
 {
-	restore_project
+	_restore_project_quota
 	cd /
 	rm -f $tmp.*
 }
@@ -22,38 +22,6 @@ _cleanup()
 . ./common/filter
 . ./common/quota
 
-require_project()
-{
-	rm -f $tmp.projects $tmp.projid
-	if [ -f /etc/projects ];then
-		cat /etc/projects > $tmp.projects
-	fi
-	if [ -f /etc/projid ];then
-		cat /etc/projid > $tmp.projid
-	fi
-
-	cat >/etc/projects <<EOF
-100:$SCRATCH_MNT/t
-EOF
-	cat >/etc/projid <<EOF
-$qa_user:100
-EOF
-	PROJECT_CHANGED=1
-}
-
-restore_project()
-{
-	if [ "$PROJECT_CHANGED" = "1" ];then
-		rm -f /etc/projects /etc/projid
-		if [ -f $tmp.projects ];then
-			cat $tmp.projects > /etc/projects
-		fi
-		if [ -f $tmp.projid ];then
-			cat $tmp.projid > /etc/projid
-		fi
-	fi
-}
-
 init_files()
 {
 	local dir=$1
@@ -157,7 +125,7 @@ BLOCK_SIZE=$(_get_file_block_size $SCRATCH_MNT)
 rm -rf $SCRATCH_MNT/t
 mkdir $SCRATCH_MNT/t
 $XFS_IO_PROG -r -c "chproj 100" -c "chattr +P" $SCRATCH_MNT/t
-require_project
+_create_project_quota $SCRATCH_MNT/t 100 $qa_user
 
 echo "### Set up different grace timers to each type of quota"
 UBGRACE=12
-- 
2.31.1

