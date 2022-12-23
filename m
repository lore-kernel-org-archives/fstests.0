Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D17C4332F
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Dec 2022 10:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiLWKW0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Dec 2022 05:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiLWKWS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Dec 2022 05:22:18 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8C5F6C
        for <fstests@vger.kernel.org>; Fri, 23 Dec 2022 02:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1671790933; i=@fujitsu.com;
        bh=cc8amIZPUWqINeUetP2R5Sh2+1uuKIwX5A3E8F/8w2g=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=uBnU0so5YtBG7JvEsXCycXg+WH7Dv/IgE3yH4o6WJ3iWlrqg94cJfQKrAKCdJVMKF
         kxA3SBxXlXRAGca3RCpTtmpRi110EL6l6qCX/KFOAkPway7r0jJZ4cmR9/5QOOuBP9
         0Ar1dX6lhG2WbFB0xpMDZAC7hWVhAIrwEI5ymXLSocNxAu3u0ylGoq1ldahQjbXfDh
         tLT9K/f9gKWj+vFfxearzxC5KlKf0iQ3cHFLs4mAzjMa+/hbnG6TrwRs+asJkTbmnO
         Uuv9YU2cKgWLJwjgibsXig9dOh0ocPGhhk85QcVVfev2c4x+kYrQqBk9TsZXAHzGDf
         QJigCaqQchfAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRWlGSWpSXmKPExsViZ8MxSTe0cWm
  ywakdkhaXn/BZnG7Zy26x/+gjFgdmj02rOtk8Pm+SC2CKYs3MS8qvSGDN+DmzlbGgk61i3oZJ
  LA2Mz1m6GLk4hAS2MEpc2XqVGcJZziTRNfkoVGY/o8T6/veMXYycHGwCahI7p79kAbFFBIwkv
  pxcwg5iMwtYSHzoOsUEYgsLuEn8OHYPLM4ioCpx+E8nUJyDg1fAUeLxrgSQsISAgsSUh++ZQW
  xeAUGJkzOfsECMkZA4+OIFM0SNokTbkn/sEHaFxKxZbUwQtprE1XObmCcw8s9C0j4LSfsCRqZ
  VjGbFqUVlqUW6hpZ6SUWZ6RkluYmZOXqJVbqJeqmluuWpxSW6RnqJ5cV6qcXFesWVuck5KXp5
  qSWbGIFhmlKsuG4H4/Rlf/QOMUpyMCmJ8q6SXposxJeUn1KZkVicEV9UmpNafIhRhoNDSYKXr
  Q4oJ1iUmp5akZaZA4wZmLQEB4+SCO9kkDRvcUFibnFmOkTqFKMux9qGA3uZhVjy8vNSpcR5eR
  uAigRAijJK8+BGwOL3EqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3hyQVTyZeSVwm14BHcE
  EdMS0mwtBjihJREhJNTDNurL8sOt0kbNpebfSu1fOMGSK9eR4tIQxyNtcP5eH9YC5VZrXHIMt
  L2Rszf6xhv7SWDKjbseMaMWbda5mh5MmsD0/JnS/3GOl0481hcF7e/fNuf4k4me1z0olLZG7f
  v96bn4pvvyyt8ljZoUDZ15bSzrvjUns6ioX133qmNl3ZGHQlikRfznmzN7qcFxWfJlRzAatuh
  +aRvP8F2yYwFc859O+lFoO81t7j69RSzvC7CV9YF7QcoeTr25Isjb21zMGP062YvgSIbGk5OZ
  h3V813l9tcg8wxiUl2f/v9YnVXHezzcb/z8W1+VKiVxOOPfh6M+SE8PYNhjoMOo9i+qdkncr7
  H3t0HXfjt5J3V88qsRRnJBpqMRcVJwIANgXE0loDAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-20.tower-548.messagelabs.com!1671790933!3655!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20957 invoked from network); 23 Dec 2022 10:22:13 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-20.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 23 Dec 2022 10:22:13 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 16FC51000D5;
        Fri, 23 Dec 2022 10:22:13 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 09E9E1000C1;
        Fri, 23 Dec 2022 10:22:13 +0000 (GMT)
Received: from 60d65d211147.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 23 Dec 2022 10:22:10 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <djwong@kernel.org>, <fstests@vger.kernel.org>
CC:     <zlang@kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] xfs/440: skip test if the dax mount option is enabled
Date:   Fri, 23 Dec 2022 10:21:56 +0000
Message-ID: <1671790916-13-1-git-send-email-yangx.jy@fujitsu.com>
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

With the enabled dax mount option, this test doesn't
work well because unwritten extents will not be allocated
according to the CoW extent size hint.

Try to fix the following error by the patch:
$./check xfs/440
    ...
     fsgqa 64 0 0
     Reflink and CoW
     root 0 0 0
    -fsgqa 1152 0 0
    +fsgqa 128 0 0
     Sync
     root 0 0 0
    ...

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 tests/xfs/440 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/440 b/tests/xfs/440
index 496ee04e..eb9fbd73 100755
--- a/tests/xfs/440
+++ b/tests/xfs/440
@@ -23,6 +23,7 @@ _require_quota
 _require_scratch_reflink
 _require_cp_reflink
 _require_user
+_exclude_scratch_mount_option dax
 
 echo "Format and mount"
 _scratch_mkfs > "$seqres.full" 2>&1
-- 
2.25.1

