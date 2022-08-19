Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15864C32773
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Aug 2022 11:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348696AbiHSLxr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 19 Aug 2022 07:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348061AbiHSLxq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Aug 2022 07:53:46 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD772E694
        for <fstests@vger.kernel.org>; Fri, 19 Aug 2022 04:53:44 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220819115341euoutp011b49c00cba999383383eb8771037f38a~MvN1KpE6-2603826038euoutp01i
        for <fstests@vger.kernel.org>; Fri, 19 Aug 2022 11:53:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220819115341euoutp011b49c00cba999383383eb8771037f38a~MvN1KpE6-2603826038euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660910021;
        bh=14LibsWewtKNwrqtvIOuuU85qhj5cQSfXn9WL14KrM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XEvT9Cpks/ww0X7XK7U8/pxay/3E4IwM7FkOQHLTXlnjgS6tubTdcEj76bUMuK05R
         H5XM4wFTJJJqBRs2RIKn1UjaGiUFIipQHOHd1qRpsh8WEqe0R8rc1U2K56o8Nh54k9
         WdX49ItRkVG2ZUTu8+fXpmL0BicBAOa8k8Utz6mY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220819115340eucas1p1cf7897a13cfcec801d4af84eec85fcb9~MvN0Ip4bv0078100781eucas1p1D;
        Fri, 19 Aug 2022 11:53:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 29.9A.10067.4C97FF26; Fri, 19
        Aug 2022 12:53:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220819115339eucas1p1896638f0a9a3d0c71c7fcba3b754b8ad~MvNziTYNx1419114191eucas1p12;
        Fri, 19 Aug 2022 11:53:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220819115339eusmtrp1bb0ba3f6d5bd8ebeeabd2ecdee961c92~MvNzhkU6G0147601476eusmtrp1U;
        Fri, 19 Aug 2022 11:53:39 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-6f-62ff79c4a03d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C4.73.09038.3C97FF26; Fri, 19
        Aug 2022 12:53:39 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220819115339eusmtip1ee6f9a48832b0bc7c3fb813245b30a6e~MvNzOVflA1915719157eusmtip1n;
        Fri, 19 Aug 2022 11:53:39 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     fstests@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, naohiro.aota@wdc.com, gost.dev@samsung.com,
        mcgrof@kernel.org, dsterba@suse.cz,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 1/1] btrfs/237: adapt the test to work with the new reclaim
 algorithm
Date:   Fri, 19 Aug 2022 13:53:37 +0200
Message-Id: <20220819115337.35681-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819115337.35681-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djP87pHKv8nGfxoYbb4ffY8s8Xi399Z
        LE637GW3uHlgJ5PF3657TBY3JjxltJh4fDOrxeelLewWa24+ZXHg9Ng56y67x6ZVnWweO1vv
        s3r0bVnF6HFmwRF2j8+b5DzaD3QzBbBHcdmkpOZklqUW6dslcGVcmjaDseCHasX+z4dZGhh/
        y3cxcnJICJhIfOyfytjFyMUhJLCCUWLemm0sEM4XRomG82ehnM+MEnu//WLuYuQAa3m/QxYi
        vpxRou/dFmYI5wWjxNL1S8CK2AS0JBo72UFWiAhIS3zqv8cGUsMscJ5RYsfR68wgCWGBUIkl
        F3+C2SwCqhI33/9iAbF5BSwl2g53sUHcJy8x89J3dpCZnAJWEhMmWUGUCEqcnPkErJwZqKR5
        62ywGyQE7nBITD02G+pQF4lTE0UgxghLvDq+hR3ClpE4PbmHBcKulnh64zdUbwujRP/O9WwQ
        vdYSfWdyQExmAU2J9bv0IaKOEo1zFCBMPokbbwUhDuCTmLRtOtROXomONiGI2UoSO38+gdop
        IXG5aQ7UTg+JF90H2CYwKs5C8sosJK/MQli7gJF5FaN4amlxbnpqsVFearlecWJucWleul5y
        fu4mRmAqOv3v+JcdjMtffdQ7xMjEwXiIUYKDWUmE98adP0lCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamDZwLEnVu8WRxah67kIWd5W5bM+L6UxLqu34
        ZDpfdV3Jcefe+3tuzp6fmSkPLi/9LFkkvk6hy//N6d3Zm36bVC/jLq9feH/ZvWAp+Y41s7o0
        fga/yvx5ipNzrtZRtdf/cp/qr1ftc9Y01Fl/5TxTlHyj9PFuNfbHDtPPN9UeEMr4dIuTgeHF
        o9n7I19lauh8y0hlNFD3OcK5xFP3otetUn7LhJqEv1oMDyc6SPPFNgpoO0aIteff5+HcsGTT
        pWKj9z4Fi5INY29FzBX5kXbhnPqhm8bzFlX6/M69VGqkwrTq1kr7NmUNeY5Cye8chn4dl6P+
        +FnLPN460Vx18lwG+cXp8bbcZRvOn9408c4pJZbijERDLeai4kQAGlfiArQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xu7qHK/8nGWy8Jm7x++x5ZovFv7+z
        WJxu2ctucfPATiaLv133mCxuTHjKaDHx+GZWi89LW9gt1tx8yuLA6bFz1l12j02rOtk8drbe
        Z/Xo27KK0ePMgiPsHp83yXm0H+hmCmCP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
        j7UyMlXSt7NJSc3JLEst0rdL0Mu4NG0GY8EP1Yr9nw+zNDD+lu9i5OCQEDCReL9DtouRi0NI
        YCmjxPbVj1m7GDmB4hIStxc2MULYwhJ/rnWxQRQ9Y5TYPPc5I0gzm4CWRGMnO0iNiIC0xKf+
        e2A1zAI3GSUWHp8DlhAWCJb4d/Iv2FAWAVWJm+9/sYDYvAKWEm2HQYaCLJCXmHnpOzvITE4B
        K4kJk6xAwkJAJS+Xb2SDKBeUODnzCVgrM1B589bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfY
        SK84Mbe4NC9dLzk/dxMjMHK2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuG9cedPkhBvSmJlVWpR
        fnxRaU5q8SFGU6CzJzJLiSbnA2M3ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUg
        tQimj4mDU6qBae+JY3MnMkebWqb/yKo+vEqlaLO9sujX1X7Rzxpq4icdmWZQktgdxdnR7rxM
        Jle74chfA4fVL99KTP789l7S5A96f2Zdv9x7yf9OxFLt70nihnyXgtaoFlvpT3pnmpkZYyP5
        fWHgXRaXoC0crIYyV0q/Cvv4Gfw8zlmbMZnxTJ4Fx9F5c+dNub0gp5hrT+zLotxDwX/mt81r
        Kd8YsPnk6lTfs2vyLK59Tmc/dPnkq2ur8pcv5vsQfFKJV3JVSV+M6CGthwsWm1VPCly/0Dd2
        Ybv9//c/9H5/erDxiiHrv+L1go88j72Pv5pz59PL7UXndL8lqllq82aH/ZgS7PQxMvgBe2yR
        183tR7y6Xs4IOKbEUpyRaKjFXFScCACC2TdTJQMAAA==
X-CMS-MailID: 20220819115339eucas1p1896638f0a9a3d0c71c7fcba3b754b8ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220819115339eucas1p1896638f0a9a3d0c71c7fcba3b754b8ad
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220819115339eucas1p1896638f0a9a3d0c71c7fcba3b754b8ad
References: <20220819115337.35681-1-p.raghav@samsung.com>
        <CGME20220819115339eucas1p1896638f0a9a3d0c71c7fcba3b754b8ad@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")
commit, reclaim algorithm has been changed to trigger auto-reclaim once
the fs used size is more than certain threshold. This change breaks this
test.

The test has been adapted so that the new auto-reclaim algorithm can be
tested along with relocation.
---
 tests/btrfs/237 | 80 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 23 deletions(-)

diff --git a/tests/btrfs/237 b/tests/btrfs/237
index f96031d5..18945e78 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -54,46 +54,80 @@ if [[ "$uuid" == "" ]]; then
 	exit 1
 fi
 
+fssize=$($BTRFS_UTIL_PROG fi usage -b $SCRATCH_MNT |grep "Device size" |\
+	grep -Eo "[0-9]+")
+
+allocated_fssize=$($BTRFS_UTIL_PROG fi usage -b $SCRATCH_MNT |grep "Device allocated" |\
+	grep -Eo "[0-9]+")
+
+
 start_data_bg_phy=$(get_data_bg_physical)
 start_data_bg_phy=$((start_data_bg_phy >> 9))
 
-size=$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
+zone_cap=$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
 	_filter_blkzone_report |\
 	grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
-size=$((size << 9))
+zone_cap=$((zone_cap << 9))
 
-reclaim_threshold=75
-echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
-fill_percent=$((reclaim_threshold + 2))
-rest_percent=$((90 - fill_percent)) # make sure we're not creating a new BG
-fill_size=$((size * fill_percent / 100))
-rest=$((size * rest_percent / 100))
+fs_reclaim_threshold=60
+bg_reclaim_threshold=75
+echo $fs_reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
+echo $bg_reclaim_threshold > /sys/fs/btrfs/"$uuid"/allocation/data/bg_reclaim_threshold
 
-# step 1, fill FS over $fillsize
-$XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqres.full
-$XFS_IO_PROG -fc "pwrite 0 $rest" $SCRATCH_MNT/$seq.test2 >> $seqres.full
+fs_fill_percent=$((fs_reclaim_threshold + 2))
+fill_size=$((fssize * fs_fill_percent / 100))
+
+# Remove the allocated size from the $fill_size
+fill_size=$((fill_size - allocated_fssize))
+
+bg_fill_percent=$((bg_reclaim_threshold + 2))
+zone_fill_size=$((zone_cap * bg_fill_percent / 100))
+
+# $fill_size might not cover the last zone block group with threshold
+# for reclaim. Add the remaining bytes so that it can also be reclaimed
+last_zone_offset=$((fill_size % zone_cap))
+
+if [ $last_zone_offset -lt $zone_fill_size ]; then
+	fill_size=$((fill_size + zone_fill_size - last_zone_offset))
+fi
+
+# This small file will be used to verify the relocation
+relocate_file_size=$((zone_cap * 2 / 100))
+
+# step 1, fill FS over $relocated_file_size and $fill_size
+$XFS_IO_PROG -fc "pwrite 0 $relocate_file_size" $SCRATCH_MNT/$seq.test1 >> $seqres.full
 $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
 
-zones_before=$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw | wc -l)
-echo "Before reclaim: $zones_before zones open" >> $seqres.full
 old_data_zone=$(get_data_bg)
 old_data_zone=$((old_data_zone >> 9))
 printf "Old data zone 0x%x\n" $old_data_zone >> $seqres.full
 
-# step 2, delete the 1st $fill_size sized file to trigger reclaim
-rm $SCRATCH_MNT/$seq.test1
+$XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test2 >> $seqres.full
 $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
-sleep 2 # 1 transaction commit for 'rm' and 1 for balance
+
+open_zones_before_reclaim=$($BLKZONE_PROG report --offset $start_data_bg_phy $SCRATCH_DEV |\
+	grep -v -e em -e nw | wc -l)
+
+# sanity check
+if [ $open_zones_before_reclaim -eq 0 ]; then
+	echo "Error writing to the device"
+fi
+
+echo "Before reclaim: $open_zones_before_reclaim zones open" >> $seqres.full
+
+# step 2, delete the $fill_size sized file to trigger reclaim
+rm $SCRATCH_MNT/$seq.test2
+$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+sleep 5 # sleep for transaction commit for 'rm' and for balance
 
 # check that we don't have more zones open than before
-zones_after=$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw | wc -l)
-echo "After reclaim: $zones_after zones open" >> $seqres.full
+open_zones_after_reclaim=$($BLKZONE_PROG report --offset $start_data_bg_phy $SCRATCH_DEV |\
+	grep -v -e em -e nw | wc -l)
+echo "After reclaim: $open_zones_after_reclaim zones open" >> $seqres.full
 
-# Check that old data zone was reset
-old_wptr=$($BLKZONE_PROG report -o $old_data_zone -c 1 $SCRATCH_DEV |\
-	grep -Eo "wptr 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
-if [ "$old_wptr" != "0x000000" ]; then
-	_fail "Old wptr still at $old_wptr"
+# Check that data was really relocated to a different zone
+if [ $open_zones_after_reclaim != 1 ]; then
+	echo "Error relocating the data"
 fi
 
 new_data_zone=$(get_data_bg)
-- 
2.25.1

