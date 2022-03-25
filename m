Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6134AC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Mar 2022 10:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350920AbiCYKVm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbiCYKVl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Mar 2022 06:21:41 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E826B6929B
        for <fstests@vger.kernel.org>; Fri, 25 Mar 2022 03:20:04 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220325101959euoutp01bf8dff00355b26e24351611a39083305~fmHD-0FmN0938809388euoutp01g
        for <fstests@vger.kernel.org>; Fri, 25 Mar 2022 10:19:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220325101959euoutp01bf8dff00355b26e24351611a39083305~fmHD-0FmN0938809388euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648203599;
        bh=ou0R/4Q5mItbZASn1V3RQNSQA9DIbeoTHZ08kdcCV/4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=dkhEipevyPmtjeW/gt/AfupRF87RHOOBXce7v8Mu/eKn9hjcA3N0Nz4dbL0lhkgQ1
         P8vIcQxt5XMlSw0PmjT7swAOYRTYVPiiv5f31Y/uvIjUJJKJ+PxDm8YRsGTCDXB9F4
         HPmz3oPky8yq85ppdlAStl+0+yQGglR1kRr0NKO0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220325101959eucas1p1a1b27899fdb41dc60ce678706edd32b6~fmHDnue2O3004830048eucas1p1S;
        Fri, 25 Mar 2022 10:19:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 40.3F.10009.F479D326; Fri, 25
        Mar 2022 10:19:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220325101958eucas1p27ba0d39fb5134959ee74728b74a16c20~fmHDKfJtM1264412644eucas1p2F;
        Fri, 25 Mar 2022 10:19:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220325101958eusmtrp190ec97d0085b1603fae5927ee8e72f8e~fmHDJt6SP2163521635eusmtrp1d;
        Fri, 25 Mar 2022 10:19:58 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-0f-623d974fbd2c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DF.B2.09522.E479D326; Fri, 25
        Mar 2022 10:19:58 +0000 (GMT)
Received: from localhost (unknown [106.210.248.55]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220325101958eusmtip2c710543d27f48a95321d4dac630da9d6~fmHC3dYne3135631356eusmtip2W;
        Fri, 25 Mar 2022 10:19:58 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        fstests@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v4] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Date:   Fri, 25 Mar 2022 11:19:08 +0100
Message-Id: <20220325101908.127071-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87r+022TDBoe8VtMP6xo8fvseWaL
        0y172S0e3/nMbvG36x6Txfm3h5ksbkx4ymgx8fhmVovPS1vYLdbcfMriwOWxc9Zddo9NqzrZ
        PHa23mf16NuyitHj8yY5j/YD3UwBbFFcNimpOZllqUX6dglcGafuXGUr+CxV8au7ib2B8Yto
        FyMnh4SAicS/X/NYQGwhgRWMErP2V3UxcgHZXxglWra0MEM4nxklZh7fwtrFyAHWseWrD0R8
        OaNEx5YdLBDOC0aJ7Q9+soMUsQloSTR2soPERUCmbl98HGwFs0AHk8T1F8EgtrBAisT+Z2uZ
        QGwWAVWJQ0s+soLYvAJWEh82LGaHOE9eYual7+wQcUGJkzOfQM2Rl2jeOhvsOgmBIxwS3Y1r
        oRpcJPbcAUmA2MISr45vgYrLSJye3MMC0dDPKDG15Q8ThDODUaLn8GYmiN+sJfrO5ICYzAKa
        Eut36UP0Okpc3vce6ns+iRtvBSFu4JOYtG06M0SYV6KjTQiiWkli588nUFslJC43zWGBKPGQ
        mNwfCQnoWInj5/4zTmBUmIXksVlIHpuFcMICRuZVjOKppcW56anFhnmp5XrFibnFpXnpesn5
        uZsYgcno9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRHe+5etk4R4UxIrq1KL8uOLSnNSiw8xSnOw
        KInzJmduSBQSSE8sSc1OTS1ILYLJMnFwSjUwTbh2K23aqqTTDMxKmxbsOF3KY/tixTuv89Ll
        u760hj8ULD918GLFhMjLx38odG26uEnucc3aQBn9uLYv2zO+tcxa17PeR1XzP0Od/HkGzo7K
        Js8wyT/5H26+326vt+7i+i8cR6TWFips11c9d6pDfcGTC8uETdMYIzYq7mhhjbr+45khf5WT
        mNbmaYGW+4rTv+47/4J/3dGdTX63i+rcth78U6t5k+uni93UWf6f1qYqT9iqUbp65smI9kVC
        lRt5fAq9Ayw5K/cpOVd41fU8XDL3e5dAWbnOtcJlxwvcfpXM4ljacLFUeEH/ec1TiZ/sZzx4
        YpJvy1Kz+LRuinmhal7v2nWaBfPqNnlXT54SrcRSnJFoqMVcVJwIAIdZvTq1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t/xe7p+022TDJp+6FhMP6xo8fvseWaL
        0y172S0e3/nMbvG36x6Txfm3h5ksbkx4ymgx8fhmVovPS1vYLdbcfMriwOWxc9Zddo9NqzrZ
        PHa23mf16NuyitHj8yY5j/YD3UwBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6GafuXGUr+CxV8au7ib2B8YtoFyMHh4SAicSWrz5djFwcQgJL
        GSX2vHjM1sXICRSXkLi9sIkRwhaW+HOtiw2i6BmjxNxDn9lAmtkEtCQaO9lB4iICqxgl1l/6
        wATiMAv0MEm8ebAarFtYIElixs05zCA2i4CqxKElH1lBbF4BK4kPGxazQ2yQl5h56Ts7RFxQ
        4uTMJywgNjNQvHnrbOYJjHyzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERgL
        24793LyDcd6rj3qHGJk4GA8xSnAwK4nw3r9snSTEm5JYWZValB9fVJqTWnyI0RTovonMUqLJ
        +cBozCuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYOIzE8hMfXhd
        cB6r6dxJjYyPjouV7+wUEpcqO5dee3bJLP6reuEBWxb3MK+t+6B0JWzLOV4xpe4FKnrXTqwL
        +XD/1TzdtEqjtYrci07JSKmLNNs0ujyR2tAhxFFVtOHwtralpu8f95VxdW0/JjMpTHjTpS5t
        kXPsavyrDjBxLbj1oO1P19fVziHbe8r/HptqeGqOmZui2QO5Ra8DttgfltzzrSfPc2Jdf2G5
        1r3I+bFna7b8468M6UifGOJxO1b9CX+5gumfHGfbyTt9bzyLW/JpStHP5yvPXG/KPLxq+QX9
        T2q1c6+JiL+8v2G2nci2/Yv0i19Pjd6hLht/e2J+xDkJK551NtVaN5fnBakV/ldiKc5INNRi
        LipOBACVUK4+DgMAAA==
X-CMS-MailID: 20220325101958eucas1p27ba0d39fb5134959ee74728b74a16c20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220325101958eucas1p27ba0d39fb5134959ee74728b74a16c20
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220325101958eucas1p27ba0d39fb5134959ee74728b74a16c20
References: <CGME20220325101958eucas1p27ba0d39fb5134959ee74728b74a16c20@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test will break when zone capacity != zone size because the
calculation of the size to be filled is done using zone_size instead of
the actual capacity available per zone. Fix it by using zone capacity.

As a zoned device can have variable capacity, use the btrfs utility to
get the zone capacity from the first data block group that the test will
be performed on.

The support to extract zone capacity was added to blkzone only from
version 2.37. So zcap will be used only when the blkzone version is
greater or equal to 2.37.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
Changes since v1:
- Add a filter that can append a 'cap' column for blkzone version <2.37
  (Naohiro)
- Extract the capacity from the zone on which the test is performed as a
  zoned device can have variable zone capacity(Naohiro)

Changes since v2:
- Use btrfs inspect-internal utility to find the first data zone address
instead of hardcoding. (Naohiro)

Changes since v3:
- Change 0x(\d)+ to 0x[[xdigit]]+ (Naohiro)

 common/filter   | 13 +++++++++++++
 tests/btrfs/237 | 21 +++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/common/filter b/common/filter
index 257227c2..5fe86756 100644
--- a/common/filter
+++ b/common/filter
@@ -634,5 +634,18 @@ _filter_bash()
 	sed -e "s/^bash: line 1: /bash: /"
 }
 
+#
+# blkzone report added zone capacity to be printed from v2.37.
+# This filter will add an extra column 'cap' with the same value of
+# 'len'(zone size) for blkzone version < 2.37
+#
+# Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
+# After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 ..
+_filter_blkzone_report()
+{
+	$AWK_PROG -F "," 'BEGIN{OFS=",";} $3 !~ /cap/ {$2=$2","$2;} {print;}' |\
+	sed -e 's/len/cap/2'
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 96940549..f96031d5 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -35,8 +35,13 @@ get_data_bg()
 		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
 }
 
-zonesize=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_sectors)
-zonesize=$((zonesize << 9))
+get_data_bg_physical()
+{
+	# Assumes SINGLE data profile
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
+		grep -A 4 CHUNK_ITEM | grep -A 3 'type DATA\|SINGLE' |\
+	        grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2
+}
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount -o commit=1 # 1s commit time to speed up test
@@ -49,12 +54,20 @@ if [[ "$uuid" == "" ]]; then
 	exit 1
 fi
 
+start_data_bg_phy=$(get_data_bg_physical)
+start_data_bg_phy=$((start_data_bg_phy >> 9))
+
+size=$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
+	_filter_blkzone_report |\
+	grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
+size=$((size << 9))
+
 reclaim_threshold=75
 echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
 fill_percent=$((reclaim_threshold + 2))
 rest_percent=$((90 - fill_percent)) # make sure we're not creating a new BG
-fill_size=$((zonesize * fill_percent / 100))
-rest=$((zonesize * rest_percent / 100))
+fill_size=$((size * fill_percent / 100))
+rest=$((size * rest_percent / 100))
 
 # step 1, fill FS over $fillsize
 $XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqres.full
-- 
2.25.1

