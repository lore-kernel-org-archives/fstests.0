Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBCEC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Mar 2022 08:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350240AbiCYIGf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 25 Mar 2022 04:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiCYIGf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Mar 2022 04:06:35 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E88C6ED1
        for <fstests@vger.kernel.org>; Fri, 25 Mar 2022 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1648195500; i=@fujitsu.com;
        bh=oX4n9hlUVt67w6GithLxpNpiNJqh/gtnQUJfXQj3RoI=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=mmAVPLMFlX+ONTMPAd6jO2G5c3zMJMSF2IHpNpCeDgx7aiIe2W7RqhH+a6PmSZ0n4
         BHMvcyPuVZFDKxkphQZbfgIQGHwfob3ROVMWqeHHxgq/P0w2r1oLzrZubpaVb/OE1j
         sizEag+8Rn/YKYWwGVW63E78tmNbu9202WEfA+dQxkYW3QOj1pcO1ESQb0aqD6meRU
         CcNLCfOV3EyuurHrD5UlXkn++Vm3pLm5JOYZcAoTmvW93fGioHFqzwcgH5rUEZq707
         OJQWJ1RJtRZvL/hTYt1nGhmEGQUPzxeGqyOwOk0Du9CvAcQ5m6faKmHXZpbfMS2VKP
         WT0axYMqhQyRw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRWlGSWpSXmKPExsViZ8MxSXd1uW2
  SwZrP5hanW/ayOzB6fN4kF8AYxZqZl5RfkcCaMfHFD9aCtTwVW7dNZG5gPMDVxcjFISRwiVHi
  aXcfG4Szj0ni9ufrrBDOfkaJ692rgTKcHGwCGhLXHrczg9giArIS/2esZgKxmQVkJDqmLGABs
  YUFIiQObJkJZrMIqErsOraTFcTmFXCVOLh7GdgcCQEFiSkP3zNDxAUlTs58wgIxR0Li4IsXzB
  A1ihL7925khLArJGbM2AbVqyZx9dwm5gmM/LOQtM9C0r6AkWkVo11SUWZ6RkluYmaOrqGBga6
  hoamumaWuoaWpXmKVbqJeaqlucmpeSVEiUFovsbxYL7W4WK+4Mjc5J0UvL7VkEyMwOFOKXQ/v
  YNzd91PvEKMkB5OSKK+6j22SEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQneDSVAOcGi1PTUirTMH
  GCkwKQlOHiURHjPlwKleYsLEnOLM9MhUqcYdTl2brm8l1mIJS8/L1VKnPdgGVCRAEhRRmke3A
  hY1F5ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMz7B2QKT2ZeCdymV0BHMAEd8fynJcgRJYk
  IKakGJjv9A/X/Z69gmXvE533Z3iW8nAemirNcEvnH3XlIdLbtpxmzhNyYFyuZSnCvT9jDusBW
  b7I6h4BTbdnS9CyGmk1XW97tXDp52pNFxpv4Mg93MojMLzz2yidpp7DPb5t4yZX80uL3taM/n
  CrNZXz933jDmR+xP0KOiN3ONb/954xtcENdz0vdxJXmG3qXOwU9V1xz+JzV2v73wjdblwhu/e
  xo7/g8deq5+5XSPwQKJpfNsv3/p5jjQcJaF5ZvvPI/Xz7LemT22GRj8j2Ja9f6N+gr2AvsiNJ
  aEpU35dU+Zv3MgNf3ak/dnKW8W7iCO+0m3/9LKjJf0if2sto9re+XLj/9dJaw1B0X09JY8esP
  Y5VYijMSDbWYi4oTAS4xY8pVAwAA
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-18.tower-528.messagelabs.com!1648195499!82937!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.10; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13699 invoked from network); 25 Mar 2022 08:04:59 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-18.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Mar 2022 08:04:59 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 714641000FC
        for <fstests@vger.kernel.org>; Fri, 25 Mar 2022 08:04:59 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 64E9D1000F9
        for <fstests@vger.kernel.org>; Fri, 25 Mar 2022 08:04:59 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 25 Mar 2022 08:04:39 +0000
From:   Dai Shili <daisl.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <daisl.fnst@fujitsu.com>
Subject: [PATCH] generic/631: use trusted.* extended attributes to filter NFS filesystem
Date:   Fri, 25 Mar 2022 16:04:12 -0400
Message-ID: <1648238652-4560-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since commit 2461e8901c(generic/631: Add a check for extended attributes),
check of user.* extended attributes was added to avoid running this
tests for filesystems that are not supported.

But it still fails on NFSv4.2 when mount overlayfs with the following error.
/var/mnt/scratch/merged0: wrong fs type, bad option, bad superblock
on overlay, missing codepage or helper program, or other error.

dmesg log reports the following -
overlayfs: upper fs does not support xattr, falling back to index=off and metacopy=off.

As per the linux patch series(https://lwn.net/Articles/799185/),
the support of user extended attributes were added to NFSv4.2.
So this case passed the check of extended attributes by _require_attrs.

As per the overlayfs documentation -
"The upper filesystem will normally be writable and if it
is it must support the creation of trusted.* and/or user.* extended
attributes, and must provide valid d_type in readdir responses,
so NFS is not suitable."

So we can replace user.* extended attributes check with trusted.* to filter NFS filesystem.

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 tests/generic/631 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/631 b/tests/generic/631
index aae181d..4996bce 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -38,7 +38,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs generic
 _require_scratch
-_require_attrs
+_require_attrs trusted
 test "$FSTYP" = "overlay" && _notrun "Test does not apply to overlayfs."
 _require_extra_fs overlay
 
-- 
1.8.3.1

