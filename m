Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33995C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 05:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhKYFS6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 00:18:58 -0500
Received: from mail1.bemta32.messagelabs.com ([195.245.230.66]:29940 "EHLO
        mail1.bemta32.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231580AbhKYFQ5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 00:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1637817226; i=@fujitsu.com;
        bh=huh5ElQOAgUgRNm+HwInIZ1ibKay9qrpgDS+sDV4iLw=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=BDK0raia9hUjsvz3rOuEFtsc8VlS8LvhmhdoiYejxckWn/TZLm3WIVWZckAkBmW8e
         AjRp7d3eyCI3+hFy/V3VUOSKKiVoY+iiw0TZbrKuk/VREG+uz2lrl+PG2qpFfXVI4D
         nu5Dvwf5WbVswnFv7SZNUM+3YJhmOAGUj0lNj0AGkQJqxe1Ynec361s9ONBDD3bySE
         9kOEYO8MwxT3YLI6SUZmSKadDL5zCnF5sDUVTN0RiBg1FthZhguQC816KBeb+ntYwm
         koZUuFJOndYFVroS9tyfvE07v7Zr5ifPrAlKmyIrKtOj2tdugy2Kek5/7g9L9J+XZZ
         tbP8gxUNydDgg==
Received: from [100.115.1.54] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.ess.symcld.net id D0/EF-06911-98B1F916; Thu, 25 Nov 2021 05:13:45 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRWlGSWpSXmKPExsViZ8MxSbdTen6
  iwcLZihanW/ayOzB6fN4kF8AYxZqZl5RfkcCacezefvaCZq6KT92vWBsYj3B0MXJxCAlcYpR4
  O20TM4Szj0li9dezTBDOHkaJd4cvsXYxcnKwCWhKPOtcwAxiiwjISvyfsZoJxGYWUJdYPukXm
  C0s4C1xsA8iziKgKvFpWj+YzSvgIbHmwxFGEFtCQEFiysP3zBBxQYmTM5+wQMyRkDj44gUzRI
  2ixKWOb1D1FRKzZrUxQdhqElfPbWKewMg/C0n7LCTtCxiZVjFaJRVlpmeU5CZm5ugaGhjoGhq
  a6hrrGlpa6iVW6SbqpZbqlqcWl+ga6iWWF+ulFhfrFVfmJuek6OWllmxiBAZlSjHz8R2MU/p+
  6h1ilORgUhLlDf4zL1GILyk/pTIjsTgjvqg0J7X4EKMMB4eSBO9lyfmJQoJFqempFWmZOcAIg
  UlLcPAoifDaSAGleYsLEnOLM9MhUqcYjTkuX5+3iJnjdcvPHcxCLHn5ealS4ryBIKUCIKUZpX
  lwg2CRe4lRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMK8MyBSezLwSuH2vgE5hAjqld89skFN
  KEhFSUg1Mxk9/KnumiymbXvSoe2m22tRp1kchLaObZ72jr+7WNPnx7Onplc+W3/k/V+Bk0vXd
  FywtJxmtSrpxqS/r78amVHbmih4T6Tu560WZeD6f/cHifKDJlXdZ07r+adWxjc7Ty1/1hta+u
  b5bN2qxlNW5z5Xs2zZPPL+3Y9u7F83zjU5bBm3dZS8bNHNJVYPmV185vRdafJYO8Zkcmxe9nM
  3KeWZe92xBr8QVpc93TdZsvVLz0mCHBEPYw/DL+q+dIju2u916d+TzBbUfPmWN3AcyHqod/dZ
  k/DWMTT616U/YRvFnjXtevk/oynDe/CVwXpyBYPmemuS+e+cXXY5zDjWsfZK4oI9/9r/c87uZ
  M1/UKLEUZyQaajEXFScCAD6wh71XAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-591.messagelabs.com!1637817225!15584!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31985 invoked from network); 25 Nov 2021 05:13:45 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-11.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Nov 2021 05:13:45 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 1D14710046F
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 05:13:45 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 10141100463
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 05:13:45 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 25 Nov 2021 05:13:29 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2] xfs/126: Add a getxattr opeartion after corrupted xattr
Date:   Thu, 25 Nov 2021 13:13:27 +0800
Message-ID: <1637817207-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

It is design to reproduce a deadlock on upstream kernel. It is introduced by kernel
commit 07120f1abdff ("xfs: Add xfs_has_attr and subroutines") and fixed by kernel
commit a1de97fe296c ("xfs: Fix the free logic of state in xfs_attr_node_hasname")[1].

[1]https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=a1de97fe296c

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/126 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/126 b/tests/xfs/126
index c3a74b1c..5496f3d7 100755
--- a/tests/xfs/126
+++ b/tests/xfs/126
@@ -7,6 +7,10 @@
 # Create and populate an XFS filesystem, corrupt a leaf xattr's data extent,
 # then see how the kernel and xfs_repair deal with it.
 #
+# It is also a regression test for kernel commit:
+# a1de97fe296c ("xfs: Fix the free logic of state in xfs_attr_node_hasname")
+#
+
 . ./common/preamble
 _begin_fstest fuzzers
 
@@ -69,7 +73,7 @@ done
 
 echo "+ mount image && modify xattr"
 if _try_scratch_mount >> $seqres.full 2>&1; then
-
+	getfattr "${SCRATCH_MNT}/attrfile" -n "user.x00000000" 2> /dev/null && _fail "got corrupt xattr"
 	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2> /dev/null && _fail "modified corrupt xattr"
 	umount "${SCRATCH_MNT}"
 fi
-- 
2.23.0

