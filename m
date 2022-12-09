Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099DDC04FDE
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Dec 2022 09:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLIJ3P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 9 Dec 2022 04:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLIJ3O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Dec 2022 04:29:14 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FCD45EC8
        for <fstests@vger.kernel.org>; Fri,  9 Dec 2022 01:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1670578152; i=@fujitsu.com;
        bh=80R6F4t7611fAF/kZwnqidwrcxVyUZQgfPBWuDiNO/s=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=nQZn9VHMd4zBvP3wf6uq/98eVY8G1WqNvj0MO6H8SNhJ1IddxvLQgr69T8MmKW8zM
         u5Gw74zMRHg8aVX7lvT9WZU1qmqCZ+G7EX+Ey4/voY4VlT64ixTncbad7KnDpFae7C
         PAFzGdE3Hjg/W1HQcw+Fhn9QOMW0FoLohJWvE3JvSqnztPYV9IPRUiuqwlZ+g4k1ld
         e3oYvg5iK2nBA2J85he30VFbYxBViMLrjSjJu2+3dsFqPfVvZc3inb/0oshATsDwMM
         ru1XnGz9EjVEnm8ihsZ1Zm9MJAx8gdVmSc79CzJX6t4gOMwdetFtyKJqMSSA89Yc85
         s1OF2kiNg7Cpg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRWlGSWpSXmKPExsViZ8ORpPvi/6R
  kg+VfWCxOt+xld2D0+LxJLoAxijUzLym/IoE1Y8L3s4wF3cwVG3tnMjUwnmbqYuTiEBI4zyjx
  eeIeRgjnEJPEzwdToJw9jBJ7d+9n6WLk5GAT0JG4sOAvK4gtIiAr8X/GaiYQmxnI3vV8ARuIL
  SxgLTHhx1SwGhYBFYm7Jy+D2bwCLhLTTpwBsyUEFCSmPHzPDGJzCrhK3FjzB6xXCKjm2q9D7B
  D1ghInZz5hgZgvIXHwxQugeg6gXiWJmd3xEGMqJGbNamOCsNUkrp7bxDyBUXAWku5ZSLoXMDK
  tYjQrTi0qSy3SNTTXSyrKTM8oyU3MzNFLrNJN1Est1S1PLS7RNdRLLC/WSy0u1iuuzE3OSdHL
  Sy3ZxAgM3ZRidoEdjEeW/dE7xCjJwaQkyhv4YlKyEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQneg
  z+BcoJFqempFWmZOcA4gklLcPAoifA+/QKU5i0uSMwtzkyHSJ1iVJQS513zByghAJLIKM2Da4
  PF7iVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrw8v4Gm8GTmlcBNfwW0mAlo8covE0EWlyQ
  ipKQamGRUV70VDuKo/dF58cDG5Vmd5kdEG869d5izXNayoG7DysO6xz7cz/ecs4jti8MGrpfv
  I3uU5lVdb/Z+rtb6daHGwb+3BC7Gfv177r55WELooxnRu+vYdpX4GKVdlb6wVudw9iuucAs1s
  XeBsybVRwu2Njxmrzp4oztt0qt1OVPKbVZ9i7aU2rVR8Yz+86Rjr0+5HBHsrOm9JCL3sOxf6G
  ad52qst/P8bl9ZsPOP+c0Nfs5XeqZ8f2YSk+6dHSr5Nc+X0S8ytk4gy+debuJ+8bdSn64bLTJ
  xPiTnO+3+wyiTn7s5Fjp+yxaMVbn3vrI0j7dUY0P5qZ/MTPzrZ6xpKxb5dm+vLX8I68IJWXpX
  ViqxFGckGmoxFxUnAgCZvQoYWAMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-16.tower-587.messagelabs.com!1670578151!108653!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22780 invoked from network); 9 Dec 2022 09:29:12 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-16.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 9 Dec 2022 09:29:12 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id AC4FB1AC
        for <fstests@vger.kernel.org>; Fri,  9 Dec 2022 09:29:11 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 9F3021B1
        for <fstests@vger.kernel.org>; Fri,  9 Dec 2022 09:29:11 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 9 Dec 2022 09:29:09 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH 2/2] generic/692: chmod the testcase to 755
Date:   Fri, 9 Dec 2022 09:28:50 +0000
Message-ID: <1670578130-13-2-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1670578130-13-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1670578130-13-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This case was created with 644.  It should be 755 otherwise its mode
will be changed and dirty the git tree after test.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/692 | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/generic/692

diff --git a/tests/generic/692 b/tests/generic/692
old mode 100644
new mode 100755
-- 
2.38.1

