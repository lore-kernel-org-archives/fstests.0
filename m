Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4409AC636D4
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Feb 2023 17:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBGRAR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Feb 2023 12:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBGRAQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Feb 2023 12:00:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64BD3B66A
        for <fstests@vger.kernel.org>; Tue,  7 Feb 2023 09:00:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9ED7BB81A22
        for <fstests@vger.kernel.org>; Tue,  7 Feb 2023 17:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B15C433EF;
        Tue,  7 Feb 2023 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675789213;
        bh=8QFLhyByXCuIQWlTQPtuZse7xsx6vrOwicu6QNxc3sk=;
        h=Date:From:To:Cc:Subject:From;
        b=pqirie1HP7cbnpNPqpzKUSlAd2N6mNUjyi4Q0VTYmUmDVQJTSYHGr1fAjYQVJ4/Jt
         NPmA+gsk0PhnKrkF+lxYMNaSOfGQ3RWh4u6kxulFkF3VieqH0YgPUUiWcK0yL95Erg
         SHDNGT6VLtqtZctjxVuBLdQvci0Dbw5amCJxWWxkL9HEs84nYmjDkeG2MTtN1GSCKC
         c3ZckjJYXSKT6agSaF7aHiAZUqsJEurmfklk6miDzYLMJCZcQvnOtk6G4c6XEhYKI5
         5p84KMuR2pUrkf0XnjLG+vNPXXoAZJd4r/b/8G2jkNF8d5e/k3nzCnhIegMYizS8MJ
         lm3ED8ajZkGuw==
Date:   Tue, 7 Feb 2023 09:00:12 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, shiina.hironori@gmail.com
Subject: [PATCH] common/xfs: use whole-word matching for
 _require_xfsrestore_xflag
Message-ID: <Y+KDnDHVCKK07yzI@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

On my system, the path to the xfsrestore binary is:

/code/xfsdump/build-x86_64/restore/xfsrestore

The grep command in _require_xfsrestore_xflag matches on the "build-x86"
part, even though my version of xfsrestore does not actually have a -x
flag.  Fix the string parsing to match entire words so that we only look
for -x in the help output.

(Maybe someone should patch xfsrestore -h to report basename(argv[0])
instead of argv[0]...)

Fixes: 1ffa16c573 ("xfs: test for fixing wrong root inode number in dump")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 common/xfs |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/xfs b/common/xfs
index ba59889c3b..97c049e2ca 100644
--- a/common/xfs
+++ b/common/xfs
@@ -1529,7 +1529,7 @@ _xfs_filter_mkfs()
 
 _require_xfsrestore_xflag()
 {
-	$XFSRESTORE_PROG -h 2>&1 | grep -q -e '-x' || \
+	$XFSRESTORE_PROG -h 2>&1 | grep -q -w -e '-x' || \
 			_notrun 'xfsrestore does not support -x flag.'
 }
 
