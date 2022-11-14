Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9EEC433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Nov 2022 08:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiKNIf2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Nov 2022 03:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiKNIfY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Nov 2022 03:35:24 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B5B1BEAE
        for <fstests@vger.kernel.org>; Mon, 14 Nov 2022 00:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668414920; i=@fujitsu.com;
        bh=gBTrd7pt2suZ6FEcoKCUZEI3wq3y5fKHJl49fdYVhpQ=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=NQVmwrT8D9uNV6A64D0d1zLfiAK6csM7U/3E0enlo0ibtRwVf0M1RgMv0ROeSuF3f
         s8EVBUPgFMD6mjthjyEC2eW+OqvsshHY4nE2IdbyVrGtbMuQpDJgwLHTkC5gRRXmSp
         +4ww8x0M1JKkNkwdi23bVVxorB9QYbpfgDJtnZL55C6R/yyRlacZpy6tu7mrm6CdJV
         0uXmPnyiSM1eC0VTcVdHqYMCXTY4RbiaUVlV5cqyGN5emERVMdp7I/U2VolH0FhDDY
         XEYRu+N+dVJQ6FSbRttuQW9yvI3ZnBmU2Mh1cA7i7x454IT7TY9k+O7KnPrWPiFx+9
         9T1jgqQ1mk/JQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRWlGSWpSXmKPExsViZ8MxSff438J
  kg2+L9Czefa6yuPyEz+J0y152i70nd7I6sHhsWtXJ5vF+31U2j8+b5AKYo1gz85LyKxJYM3qm
  t7EXnOOseLriBGMD42SOLkYuDiGBLYwSz68sYupi5ARyljNJdJ42h0jsZ5RovriZFSTBJqAms
  XP6SxYQW0RAW2Lt1idgcWaBHIm3hxeyg9jCAikSvx70AtVwcLAIqEoc+REGEuYVcJTY03sDrE
  RCQEFiysP3zBBxQYmTM5+wQIyRkDj44gUzRI2iRNuSf1D1FRKzZrUxQdhqElfPbWKewMg/C0n
  7LCTtCxiZVjGaFacWlaUW6ZrqJRVlpmeU5CZm5uglVukm6qWW6ublF5Vk6BrqJZYX66UWF+sV
  V+Ym56To5aWWbGIEhm1KcYLTDsYpy/7oHWKU5GBSEuW9/KcwWYgvKT+lMiOxOCO+qDQntfgQo
  wwHh5IErxdITrAoNT21Ii0zBxhDMGkJDh4lEV7ln0Bp3uKCxNzizHSI1ClGXY6Pfy7uZRZiyc
  vPS5US52UGRqSQAEhRRmke3AhYPF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMxb/xtoCk9
  mXgncpldARzABHfE9Mg/kiJJEhJRUA9NhUX+NNKbKdVuivbWXvVmy7/07l8D3Ptwisnc1FitX
  N0Rbq5nN2GAfuCmzM29jXmH9ubsfZ02STozbbvLplGlvxqRDOcfZ5+S3e5bzR/y3Tlhx2cb0N
  H9j3zGeA+WO0uXpc25+2M1yQODglMtpgv+nO3UpRj48/SZszhqbLx+y+b9KbjF/lJAgcyZwSm
  6Mz5NJZn63vpXnBOkv3mG9hC/vedfN0i8hxo8q9Y+1XQjbl7dA9o0nQ9mTkPa1T00Tvyv8t9U
  9vWDpz+1vDapSnrwSkFBb+Ci/qsLWyYCxYOqzWU3151M3OTtLvHn1MvNVpKP7+piIl6xd+fPb
  2prca87ft5H/93jVvdR7y302H1ZiKc5INNRiLipOBABz4oPlYgMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-3.tower-732.messagelabs.com!1668414919!855621!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32016 invoked from network); 14 Nov 2022 08:35:19 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-3.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Nov 2022 08:35:19 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 3A0441000EE;
        Mon, 14 Nov 2022 08:35:19 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 2C9251000E7;
        Mon, 14 Nov 2022 08:35:19 +0000 (GMT)
Received: from 66819b64675f.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 14 Nov 2022 08:35:16 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <djwong@kernel.org>, <zlang@redhat.com>
CC:     <fstests@vger.kernel.org>, <bfoster@redhat.com>,
        <y-goto@fujitsu.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v2 1/2] common/dmlogwrites: Extend _log_writes_init() to accept the specified length
Date:   Mon, 14 Nov 2022 08:35:02 +0000
Message-ID: <1668414903-13-1-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

It is unnecssary to always create a dm-log-writes device
based on the entire size of the target/underlying device.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 common/dmlogwrites | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/common/dmlogwrites b/common/dmlogwrites
index 9fa1c977..c1c85de9 100644
--- a/common/dmlogwrites
+++ b/common/dmlogwrites
@@ -59,14 +59,28 @@ _require_log_writes_dax_mountopt()
 	fi
 }
 
+# Set up a dm-log-writes device
+#
+# blkdev: the specified target device
+# length(optional): the mapped length in bytes
+# Note that the entire size of the target device will be used
+# if length is not specified.
 _log_writes_init()
 {
-	blkdev=$1
+	local blkdev=$1
+	local length=$2
+	local BLK_DEV_SIZE
 
 	[ -z "$blkdev" ] && _fail \
 	"block dev must be specified for _log_writes_init"
 
-	local BLK_DEV_SIZE=`blockdev --getsz $blkdev`
+	if [ -z "$length" ]; then
+		BLK_DEV_SIZE=`blockdev --getsz $blkdev`
+	else
+		local blksz=`blockdev --getss $blkdev`
+		BLK_DEV_SIZE=$((length / blksz))
+	fi
+
 	LOGWRITES_NAME=logwrites-test
 	LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
 	LOGWRITES_TABLE="0 $BLK_DEV_SIZE log-writes $blkdev $LOGWRITES_DEV"
-- 
2.34.1

