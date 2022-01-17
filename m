Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7593CC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Jan 2022 08:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbiAQIV6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:21:58 -0500
Received: from mail1.bemta36.messagelabs.com ([85.158.142.1]:53376 "EHLO
        mail1.bemta36.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231253AbiAQIV5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Jan 2022 03:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1642407716; i=@fujitsu.com;
        bh=xoMZK60oaftejFTiKcQu4z84XimKYAPkGTlMi+BeMxo=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=uq7MnHZfdw5XftsByDwdsGUAq0WjRfwLe34jy/aB6LjpjRNmXSbxKjrH5DEnKcdS8
         kF1fBtBVsBpC6EHqXPBYWBy2TmKY4UC8dPmeuhi6AUsDefWqrb8RpzrjU7QoInpM9v
         +ho27Psvw9HYrLaTs7BRjOechAokjKj/kg5fChxYQPTcRcPFv2pa2GLpFGm1dZBzMd
         4PlYpRpICmQF4YiC5SrndEl/hEHe4JL+xu77LkW2V5fOABOe9AVWKDfIILwsgKQ81w
         Gf1bDlMK8R4MbkFYiW29kch4AE7VG8BMuq9vCDzWUNbHCARZgLWZuyNF58fqWTMots
         Qd+VA8WucxEWA==
Received: from [100.115.65.13] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.ess.symcld.net id A0/27-31213-42725E16; Mon, 17 Jan 2022 08:21:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRWlGSWpSXmKPExsViZ8MxSVdZ/Wm
  iwfWXfBaXn/BZnG7Zy+7A5LFpVSebx+dNcgFMUayZeUn5FQmsGT1TbQteCFZ0HPdpYJzG38XI
  xSEksIVRYs+J2+wQzgImiXUbmlkgnD2MEj+PrWLuYuTkYBPQlHjWuQDMFhEQl3i86BYTiM0s4
  CQxZ90pMFtYwFdixrxeVhCbRUBVYu3VHWA2r4CHxPsda8F6JQQUJKY8fA9mcwroSxxbfosNxB
  YS0JM4ubyVBaJeUOLkzCcsEPMlJA6+eAHVqyhxqeMbI4RdITFrVhsThK0mcfXcJuYJjIKzkLT
  PQtK+gJFpFaNdUlFmekZJbmJmjq6hgYGuoaGprpmprqGFkV5ilW6iXmqpbnJqXklRIlBaL7G8
  WC+1uFivuDI3OSdFLy+1ZBMjMLRTih237WA81fdT7xCjJAeTkiivr9LTRCG+pPyUyozE4oz4o
  tKc1OJDjDIcHEoSvOuVgXKCRanpqRVpmTnAOINJS3DwKInwCqgBpXmLCxJzizPTIVKnGHU5Ll
  +ft4hZiCUvPy9VSpzXCKRIAKQoozQPbgQs5i8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuY
  1BpnCk5lXArfpFdARTEBHrPr4COSIkkSElFQDE/uuEiWti6LcDGcu/LjfuO6AYbQFS5Ux52bF
  YKe/obdrEww2zflo2dZ8W6eg4+jdPO3bF1gv3c7003HgaO3JPLvCTYPt3KVXf5kDMxtKT/rP5
  OBe7SA6J+a/5EnloHWbHux88T2vNenEvPtXbuf6pxj82LA276B8zPNJ2jYnBI9V6nUdEXGpO6
  aXw5mUEDvH//Mltp5fx3aln3hvPLni8eNrGav3vdz07vPr8GMzuAyv/ro/aXO0hPmbBH6z/hV
  P+1b/EvK6u66kTyTRyLcj4t2NLVKLm7zaNgc/YtLJ6ZN4+9rk7DMptvl/RXY2HZ7W8iP42ryN
  1iIxu7d5sG9SLvMpEXe791eUr+xQoNShDCWW4oxEQy3mouJEAHYrhp10AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-545.messagelabs.com!1642407714!67995!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30305 invoked from network); 17 Jan 2022 08:21:55 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-21.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Jan 2022 08:21:55 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 9E4F1100464;
        Mon, 17 Jan 2022 08:21:54 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 90571100353;
        Mon, 17 Jan 2022 08:21:54 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 17 Jan 2022 08:21:40 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <djwong@kernel.org>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3] xfs/12[4-6]: Add getfattr operation after xattr corrupted
Date:   Mon, 17 Jan 2022 16:22:16 +0800
Message-ID: <1642407736-3898-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20211126232817.GA266000@magnolia>
References: <20211126232817.GA266000@magnolia>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add getfattr operation in these three cases, we can also use xfs/126(corrupt a leaf
xattr's data extent) to reproduce a deadlock. This deadlock is introduced by kernel
commit 07120f1abdff ("xfs: Add xfs_has_attr and subroutines") and fixed by kernel
commit a1de97fe296c ("xfs: Fix the free logic of state in xfs_attr_node_hasname").

Also making getfattr operation after xattr corrupted is a common part, so we can
test whether the similar deadlock occurs in the future in xfs/124(corrupt a block xattr)
and xfs/125(corrupt a leaf xattr's index extent).

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/124 | 2 +-
 tests/xfs/125 | 2 +-
 tests/xfs/126 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/xfs/124 b/tests/xfs/124
index 39307218..c3cccfd5 100755
--- a/tests/xfs/124
+++ b/tests/xfs/124
@@ -64,7 +64,7 @@ _scratch_xfs_db -x -c "inode ${inode}" -c 'ablock 0' -c "stack" -c "blocktrash -
 
 echo "+ mount image && modify xattr"
 if _try_scratch_mount >> $seqres.full 2>&1; then
-
+	getfattr "${SCRATCH_MNT}/attrfile" -n "user.x00000000" 2> /dev/null && _fail "got corrupt xattr"
 	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2> /dev/null && _fail "modified corrupt xattr"
 	umount "${SCRATCH_MNT}"
 fi
diff --git a/tests/xfs/125 b/tests/xfs/125
index fb5f5695..a7eb51fb 100755
--- a/tests/xfs/125
+++ b/tests/xfs/125
@@ -64,7 +64,7 @@ _scratch_xfs_db -x -c "inode ${inode}" -c 'ablock 0' -c "stack" -c "blocktrash -
 
 echo "+ mount image && modify xattr"
 if _try_scratch_mount >> $seqres.full 2>&1; then
-
+	getfattr "${SCRATCH_MNT}/attrfile" -n "user.x00000000" 2> /dev/null && _fail "got corrupt xattr"
 	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2> /dev/null && _fail "modified corrupt xattr"
 	umount "${SCRATCH_MNT}"
 fi
diff --git a/tests/xfs/126 b/tests/xfs/126
index c3a74b1c..519d377e 100755
--- a/tests/xfs/126
+++ b/tests/xfs/126
@@ -69,7 +69,7 @@ done
 
 echo "+ mount image && modify xattr"
 if _try_scratch_mount >> $seqres.full 2>&1; then
-
+	getfattr "${SCRATCH_MNT}/attrfile" -n "user.x00000000" 2> /dev/null && _fail "got corrupt xattr"
 	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2> /dev/null && _fail "modified corrupt xattr"
 	umount "${SCRATCH_MNT}"
 fi
-- 
2.23.0

