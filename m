Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D1FCE7A94
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Sep 2023 13:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjIYNs2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Sep 2023 09:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjIYNs1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Sep 2023 09:48:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B817BE8
        for <fstests@vger.kernel.org>; Mon, 25 Sep 2023 06:48:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57D0C433C8;
        Mon, 25 Sep 2023 13:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695649701;
        bh=6AlT97iKz4I39zo25jM349u6+1QdU0g41AMlCYTuqpk=;
        h=From:To:Cc:Subject:Date:From;
        b=AJqioi7nHBTzrvs3z/zqH+9IufCZgFcu5OVAKL9JLm0S1aw1x5nA5ZcPabr9n07Lp
         /Bnu3+iWanHGPMCwQkdGSmyAYn9wMXCq6B9Z1o9Qc5mU7itnABYLM2Z+KlrK3TaxN3
         /Zw7zbmU0uWYR0Gh8peL8e7LZw61h2onqYZNW4XAnGwgzjFFmPYL8i7gb6A8uddsHk
         /KUQ7ha5zqa1fpgGob59ZKDJNaoVegk+r4HRoeVUF2r59Rx86wJTdTFiY5ilB8cpi6
         uJUuxakQvkFTnGl7H1+dkyM1RfDi3tjrgHmt1w5pfx5CqMWk61BjRNaDFsrdyX5x4t
         YPM5Zt+8D6klA==
From:   Chandan Babu R <chandanbabu@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Chandan Babu R <chandanbabu@kernel.org>, zlang@redhat.com
Subject: [PATCH] _scratch_mkfs_geom: Fix regex used for matching block size option
Date:   Mon, 25 Sep 2023 19:18:05 +0530
Message-Id: <20230925134805.1559201-1-chandanbabu@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The regular expression used by _scratch_mkfs_geom() to match mkfs.xfs' block
size argument interprets the character 'b' as optional. It should actually
interpret whitespace as optional.

This causes generic/223 to fail when testing an XFS filesystem which uses an
external log device along with the -lsize option. In this case, the original
value of -lsize is replaced with the value of $blocksize.

_scratch_mkfs_sized() also uses the same incorrect regex.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
---
 common/rc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 5c4429ed..991a5731 100644
--- a/common/rc
+++ b/common/rc
@@ -971,7 +971,7 @@ _scratch_mkfs_sized()
 	case $FSTYP in
 	xfs)
 		# don't override MKFS_OPTIONS that set a block size.
-		echo $MKFS_OPTIONS |grep -E -q "b?size="
+		echo $MKFS_OPTIONS |grep -E -q "b\s*size="
 		if [ $? -eq 0 ]; then
 			_scratch_mkfs_xfs -d size=$fssize $rt_ops
 		else
@@ -1063,8 +1063,8 @@ _scratch_mkfs_geom()
 
     case $FSTYP in
     xfs)
-	if echo "$MKFS_OPTIONS" | grep -E -q "b?size="; then
-		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | sed -r "s/(b?size=)[0-9]+k?/\1$blocksize/")
+	if echo "$MKFS_OPTIONS" | grep -E -q "b\s*size="; then
+		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | sed -r "s/(b\s*size=)[0-9]+k?/\1$blocksize/")
 	else
 		MKFS_OPTIONS+=" -b size=$blocksize"
 	fi
-- 
2.39.1

