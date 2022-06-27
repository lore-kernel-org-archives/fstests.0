Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521EAC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Jun 2022 13:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiF0N3j (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Jun 2022 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiF0N3i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Jun 2022 09:29:38 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC46449
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1656336571; i=@fujitsu.com;
        bh=ZHZ96kQXwbYX1SoVA4bTmeWbe6kV/Z2GLNZE3RpuUuc=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=DtgaW3uAZVJI8Mn9cWID67E0OvDSXTKx7uGfjXY/RHx5Un6shF1iyuZ2RM1jZy5pR
         nlkV+oG5XdKafN0TuMEu83fBdSnQBVYV+kiiVRPYJIP27dJlKWu9RngVX4pqpMZd8O
         h6LhltIEysbuA1XEtx1f3zrmxuzM0RFlx+VBydkJX0sfeaieNzu70MyyXipk0qDZNP
         su87zMT+ZnQ+Z2/ZfxsrsgUpGgty27Lh57isvdEKJUMlrHX/RJXDXGltOquAPgO2FW
         6HpvCBV2EhMRxO+mQoxGB0GgaY04yf6d73AGzIydDcOiNjbBL9xP1wISp6LtMD6mn/
         PsGjcwhvz2gzg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRWlGSWpSXmKPExsViZ8ORpLt7w84
  kg9XT+SxOt+xld2D0+LxJLoAxijUzLym/IoE149LPM2wFF4Qq1lyYy9TAeI+/i5GLQ0jgPKNE
  67nFTF2MnEDOISaJT0uUIBJ7GCW+HPnFDJJgE9CUeNa5AMwWEZCV+D9jNVgDs4C6xPJJv8BsY
  YFkiQNX37GD2CwCqhK/rvaAxXkFPCTOvO9gBLElBBQkpjx8zwwRF5Q4OfMJC8QcCYmDL14wQ9
  QoSlzq+AZVXyHx+vAlqLiaxNVzm5gnMPLPQtI+C0n7AkamVYzWSUWZ6RkluYmZObqGBga6hoa
  mupbmupYmeolVuol6qaW6eflFJRm6hnqJ5cV6qcXFesWVuck5KXp5qSWbGIFBmVKcGLeD8eG+
  X3qHGCU5mJREeVdX70wS4kvKT6nMSCzOiC8qzUktPsQow8GhJMErsBQoJ1iUmp5akZaZA4wQm
  LQEB4+SCG/iOqA0b3FBYm5xZjpE6hSjLsfahgN7mYVY8vLzUqXEecvXAxUJgBRllObBjYBF6y
  VGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrxmIKt4MvNK4Da9AjqCCegIv4k7QI4oSURISTU
  wFS90Llz3W3ietDXLJ3nDH9tOvs7/NfHPVWnnpkedFcc7S8WZOtuSvK5mPOFIDWU8vo8jR0xt
  6iWVR0r/pn2bOZ3/adW/HMGnb3ZfVssQ/bxdOOCNVNL1jz+PfH85IX3TFYXaNKOGzrXBqz79W
  hm7nO3nHa1JlXElK2WfVC+fJvs/dWPyWr3S1xp6RmvTzjZH9PDc/JXxoihnuf2PEh6XuGNLGF
  NNfrrp7VgYYSnNJvwlPSOHw/jzoTORDz1YPBzTHsxNuHnN9vwH0XtHHukfmMsUuXJvfX5b+6c
  NU7cKfJXmX+h6UWe6y/LWk6qe/wMfb/66Ns1LMv2hd9uuSOOiVb8sVk++lXB1LkcR49sd4kos
  xRmJhlrMRcWJANnUNe9RAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-732.messagelabs.com!1656336570!3573!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30750 invoked from network); 27 Jun 2022 13:29:31 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-6.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Jun 2022 13:29:31 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id A61251B2
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 14:29:30 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 9AA2A1AE
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 14:29:30 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 27 Jun 2022 14:29:28 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH 1/2] xfs/270: only check new_ro_compat value when mkfs.xfs supports nrext64 feature
Date:   Mon, 27 Jun 2022 22:30:02 +0800
Message-ID: <1656340203-2322-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently, this case fails on old xfsprogs as below:
+/var/lib/xfstests/tests/xfs/270: line 51: [: !=: unary operator expected

Getting ro_compat value will report the following error after setting new ro_compat
value:
+cache_purge: shake on cache 0x56033fde4920 left 1 nodes!?
+cache_purge: shake on cache 0x56033fde4920 left 1 nodes!?
+cache_zero_check: refcount is 1, not zero (node=0x56033fdf9110

Old xfsprogs miss a bugfix
f4afdcb0ad ("xfs_db: clean up the salvage read callsites in set_cur()").

Here we skip the get step of new ro_comap value when nrext64 feature is supported.
Also will add a new test to cover this xfsprog bug.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/270 | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tests/xfs/270 b/tests/xfs/270
index b740c379..5ff83ead 100755
--- a/tests/xfs/270
+++ b/tests/xfs/270
@@ -22,6 +22,10 @@ _require_scratch_nocheck
 # Only V5 XFS disallow rw mount/remount with unknown ro-compat features
 _require_scratch_xfs_crc
 
+nrext64_supported=0
+_scratch_mkfs_xfs_supported -m crc=1 -i nrext64 > /dev/null 2>&1 && \
+	nrext64_supported=1
+
 _scratch_mkfs_xfs >>$seqres.full 2>&1
 
 # set the highest bit of features_ro_compat, use it as an unknown
@@ -43,13 +47,18 @@ ro_compat=$(echo $ro_compat | \
 _scratch_xfs_set_metadata_field "features_ro_compat" "$ro_compat" "sb 0" \
 				> $seqres.full 2>&1
 
-# read the newly set ro compat filed for verification
-new_ro_compat=$(_scratch_xfs_get_metadata_field "features_ro_compat" "sb 0" \
-						2>/dev/null)
-
-# verify the new ro_compat field is correct.
-if [ $new_ro_compat != $ro_compat ]; then
-	echo "Unable to set new features_ro_compat. Wanted $ro_compat, got $new_ro_compat"
+# Indeed, xfsprogs has a bug here and fixed by commit f4afdcb
+# ("xfs_db: clean up the salvage read callsites in set_cur()")
+# Here, we use nrext64 feature as a proxy.
+if [ $nrext64_supported -eq 1 ]; then
+	# read the newly set ro compat filed for verification
+	new_ro_compat=$(_scratch_xfs_get_metadata_field "features_ro_compat" \
+					"sb 0" 2>/dev/null)
+	# verify the new ro_compat field is correct.
+	if [ $new_ro_compat != $ro_compat ]; then
+		echo "Unable to set new features_ro_compat. Wanted $ro_compat, \
+			got $new_ro_compat"
+	fi
 fi
 
 # rw mount with unknown ro-compat feature should fail
-- 
2.27.0

