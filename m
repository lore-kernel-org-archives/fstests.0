Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E94C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Oct 2021 23:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE94960E90
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Oct 2021 23:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhJJXJC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Oct 2021 19:09:02 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:46522 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232849AbhJJXJC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Oct 2021 19:09:02 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 05F1F10571FA
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 10:07:01 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mZhuH-004nTJ-22
        for fstests@vger.kernel.org; Mon, 11 Oct 2021 10:07:01 +1100
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1mZhuH-000uFR-15
        for fstests@vger.kernel.org;
        Mon, 11 Oct 2021 10:07:01 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/2] fstests: groupfile generation needs force overwrite
Date:   Mon, 11 Oct 2021 10:06:59 +1100
Message-Id: <20211010230659.216166-3-david@fromorbit.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211010230659.216166-1-david@fromorbit.com>
References: <20211010230659.216166-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61637216
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=8gfv0ekSlNoA:10 a=20KFwNOVAAAA:8 a=cDzX3OqDMS_Mzbm7E6kA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Having built fstests as root as part of a run script, I get failures
then trying to run it as a user because of the group list
generation. The issue occurs because the group list files are owned
by root, and so I get an interactive prompt to overwrite them such
as:

Building btrfs
 [GROUP] /home/dave/src/xfstests-dev/tests/btrfs/group.list
mv: replace 'group.list', overriding mode 0644 (rw-r--r--)? y
Building ceph
 [GROUP] /home/dave/src/xfstests-dev/tests/ceph/group.list
mv: replace 'group.list', overriding mode 0644 (rw-r--r--)? y
Building cifs
 [GROUP] /home/dave/src/xfstests-dev/tests/cifs/group.list
mv: replace 'group.list', overriding mode 0644 (rw-r--r--)? y
Building ext4
 [GROUP] /home/dave/src/xfstests-dev/tests/ext4/group.list
...

Use 'mv -f' to ignore such trivial issues so that the new group
lists are written correctly.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tools/mkgroupfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mkgroupfile b/tools/mkgroupfile
index 634ec92c..3844e57d 100755
--- a/tools/mkgroupfile
+++ b/tools/mkgroupfile
@@ -24,7 +24,7 @@ cleanup() {
 	test -z "$ngroupfile" && return
 
 	if [ $ret -eq 0 ]; then
-		mv "$ngroupfile" "$groupfile"
+		mv -f "$ngroupfile" "$groupfile"
 	else
 		rm -f "$ngroupfile"
 	fi
-- 
2.33.0

