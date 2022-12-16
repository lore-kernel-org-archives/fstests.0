Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFE5C4332F
	for <linux-fstests@archiver.kernel.org>; Fri, 16 Dec 2022 10:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiLPK6a (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 16 Dec 2022 05:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiLPK63 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Dec 2022 05:58:29 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED52E9F2
        for <fstests@vger.kernel.org>; Fri, 16 Dec 2022 02:58:26 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221216105823euoutp01f5af5cf6e4273e2508e2c9aae583c3fb~xQOhIeNr10860608606euoutp01Y
        for <fstests@vger.kernel.org>; Fri, 16 Dec 2022 10:58:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221216105823euoutp01f5af5cf6e4273e2508e2c9aae583c3fb~xQOhIeNr10860608606euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671188303;
        bh=1cjTUcxB9OqOebKu9+VpdkWJG2BgivKvSp3YDUurmQY=;
        h=From:To:CC:Subject:Date:References:From;
        b=JC6hu3rZRe3Cok5jWmeWRJAmSTQbFNnbHFoPkPVzP5HsBl3ptx87Yr3XD4xgGrvKy
         ChRoxl1QGolIPXaeKx1OvMtdQoQ+vAubN1T6U1jEn9AFYebKcbqLYvKJjHlwudIpGY
         5+KeIoy/NzG7aETWku7ya2Cuvfi+5eLp74pvvC1k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221216105822eucas1p2301cc0909996f8b8fd3dbed6f9797775~xQOg93CUz2880228802eucas1p2Y;
        Fri, 16 Dec 2022 10:58:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 25.0D.09561.E4F4C936; Fri, 16
        Dec 2022 10:58:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0~xQOgo0yZF0649006490eucas1p1B;
        Fri, 16 Dec 2022 10:58:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221216105822eusmtrp22dad96712e9f4e985185aa10dbd4c16a~xQOgoN_0-2275522755eusmtrp2E;
        Fri, 16 Dec 2022 10:58:22 +0000 (GMT)
X-AuditID: cbfec7f2-0c9ff70000002559-77-639c4f4e05e0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 52.10.09026.E4F4C936; Fri, 16
        Dec 2022 10:58:22 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221216105822eusmtip12415b44560f1371885854185a0414af3~xQOgfHZqx1205112051eusmtip1G;
        Fri, 16 Dec 2022 10:58:22 +0000 (GMT)
Received: from localhost (106.110.32.100) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 16 Dec 2022 10:58:21 +0000
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>
CC:     Pankaj Raghav <pankydev8@gmail.com>, <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] btrfs/237: adapt the test to work with the new reclaim
 algorithm
Date:   Fri, 16 Dec 2022 11:57:51 +0100
Message-ID: <20221216105750.28493-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7djP87p+/nOSDT6eNbE43bKX3eJv1z0m
        izU3n7JY7D25k9WBxWPnrLvsHu/3XWXz+LxJzqP9QDdTAEsUl01Kak5mWWqRvl0CV8bbd1dZ
        CiapVBzsbmNsYJwl18XIySEhYCJx4vI59i5GLg4hgRWMEg+7DjNBOF8YJf68nAXlfGaUmLj2
        BjNMy+bbi8BsIYHljBJvOqXhilafXsMGkdjCKHHza2AXIwcHm4CWRGMnO0hYRCBfYk7LdjCb
        WSBdYuu7dlYQW1ggWOL14xesIOUsAqoSr35ag4R5BSwlVmx8yA6xVl5i5qXv7BBxQYmTM5+w
        QIyRl2jeOpsZwpaQOPjiBdSZShIT5t1ng7BrJdYeOwP2pYTAFg6J7z/boIpcJFZPuw+1QFji
        1fEtULaMxP+d85kg7GqJpzd+M0M0tzBK9O9czwZyqISAtUTfmRyIGkeJUxMOsECE+SRuvBWE
        uIdPYtK26cwQYV6JjjYhiGo1iR1NWxknMCrPQvLNLCTfzELyzQJG5lWM4qmlxbnpqcWGeanl
        esWJucWleel6yfm5mxiBCeT0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd6Ap7OShXhTEiurUovy
        44tKc1KLDzFKc7AoifOumNKRLCSQnliSmp2aWpBaBJNl4uCUamDq/vtS1p/TQDVRY7/B5SkO
        33Tm9Zt77k2Q+t21Pdp31f7CQMXDj0zO5AjE5/Z7xOnzT+1TevWss2zl81+PtNJ+rFBT29vz
        MOGZx52wrXqyLafjLiVEXt+lfXNDWO/0R06G2b9ZLobkPGtzXbhbxvOJ2TbfUvv70a+Zdbd/
        VjibnbDOb9r1yfZvJkuLFLHefHyU4fOvwFrlTvE3Jf767p/TboRui+6rPvbkcY3/31kL9N7F
        7DmaWdwn+TlNqUreu/vPaY+KPNUem5peXvGDBZO3qx5tVWyb/GPiplcs+q/sX77VWePpI7Wi
        89v29PaW8+am7qbtH5Ot9VTz92X+dZQKlfjx/V2T06Z2m9WCl5VYijMSDbWYi4oTARGsh1+P
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4XV0//znJBmdWKlicbtnLbvG36x6T
        xZqbT1ks9p7cyerA4rFz1l12j/f7rrJ5fN4k59F+oJspgCVKz6Yov7QkVSEjv7jEVina0MJI
        z9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Ptu6ssBZNUKg52tzE2MM6S62Lk5JAQ
        MJHYfHsRcxcjF4eQwFJGiaU//7BBJGQkPl35yA5hC0v8udbFBlH0kVFi0uy3UB1bGCVm/9jC
        2sXIwcEmoCXR2AnWICKQLzGnZTs7SJhZIF1i/gEfEFNYIFBi3wsbEJNFQFXi1U9rkGJeAUuJ
        FRsfQm2Sl5h56Ts7RFxQ4uTMJywgNjNQvHnrbGYIW0Li4IsXzBD1ShIT5t2HurhW4tX93YwT
        GIVmIWmfhaR9FpL2BYzMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLjZduxn1t2MK589VHv
        ECMTB+MhRgkOZiUR3oCns5KFeFMSK6tSi/Lji0pzUosPMZoCvTORWUo0OR8YsXkl8YZmBqaG
        JmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUzr85JZNf/4HSjYa6/6y6J5+e7o
        2p1CRy575VfasneKMOnJhszafsx107agPvMuBa6VdUda//16cVNuycJfQqsKXUz1I3T2xZt9
        DV1QUXoy6nZMSZT1hGOfFPo2950P3sk29WDucWuxuW7Vdcp2H/cx35vQoMp8MfVbe8GEPmkp
        mxqh2xNf8yl/f5ji2vvg0ImGXoXFF++8DH5WOpH7QmMD03Xj4oNb+i/c0Dt3S/tDw5K/FtcY
        7m5Y37Hr550TB+5cPLXuitTK5Q9rPZUW7Q98L/FF9ZruFZ5ZredufFtz827rlV4vE+n8lJc7
        mg8ff1a3rmLZ/6sx0d++9+w6ubvCc+t64d1R28v9N7eY7E98osRSnJFoqMVcVJwIALtXw7sg
        AwAA
X-CMS-MailID: 20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0
X-Msg-Generator: CA
X-RootMTR: 20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0
References: <CGME20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")
commit and cc4804bfd639 ("btrfs: skip reclaim if block_group is empty"),
reclaim algorithm has been changed to be less aggressive, which breaks this
test.

The test has been adapted so that the new auto-reclaim algorithm can be
tested with the following flow:
- Write a small file
- Write a big file that crosses the reclaim limit
- Delete the big file
- Check that only the block group that contained the small file is reclaimed,
  and the small file is relocated to a new block group.
---
 tests/btrfs/237 | 67 ++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 3c660edb..ce7eb35d 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -54,51 +54,60 @@ if [[ "$uuid" == "" ]]; then
 	exit 1
 fi
 
+fssize=$($BTRFS_UTIL_PROG fi usage -b $SCRATCH_MNT |grep "Device size" |\
+	grep -Eo "[0-9]+")
+
 start_data_bg_phy=$(get_data_bg_physical)
 start_data_bg_phy=$((start_data_bg_phy >> 9))
-size=$(_zone_capacity $start_data_bg_phy)
 
-reclaim_threshold=75
-echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
-fill_percent=$((reclaim_threshold + 2))
-rest_percent=$((90 - fill_percent)) # make sure we're not creating a new BG
-fill_size=$((size * fill_percent / 100))
-rest=$((size * rest_percent / 100))
+zone_cap=$(_zone_capacity $start_data_bg_phy)
 
-# step 1, fill FS over $fillsize
-$XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqres.full
-$XFS_IO_PROG -fc "pwrite 0 $rest" $SCRATCH_MNT/$seq.test2 >> $seqres.full
+# Set it to a lower value to speed up the test
+fs_reclaim_threshold=51
+echo $fs_reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
+
+fs_fill_percent=$((fs_reclaim_threshold + 2))
+fill_size=$((fssize * fs_fill_percent / 100))
+
+# This small file that fits within a zone will be used to verify the relocation
+relocate_file_size=$((zone_cap * 2 / 100))
+
+# step 1, fill FS over $relocate_file_size and $fill_size
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
 
-# check that we don't have more zones open than before
-zones_after=$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw | wc -l)
-echo "After reclaim: $zones_after zones open" >> $seqres.full
+open_zones_before_reclaim=$($BLKZONE_PROG report --offset $start_data_bg_phy $SCRATCH_DEV |\
+	grep -v -e em -e nw | wc -l)
 
-# Check that old data zone was reset
-old_wptr=$($BLKZONE_PROG report -o $old_data_zone -c 1 $SCRATCH_DEV |\
-	grep -Eo "wptr 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
-if [ "$old_wptr" != "0x000000" ]; then
-	_fail "Old wptr still at $old_wptr"
+# sanity check
+if [ $open_zones_before_reclaim -eq 0 ]; then
+	echo "Error writing to the device"
 fi
 
-new_data_zone=$(get_data_bg)
-new_data_zone=$((new_data_zone >> 9))
-printf "New data zone 0x%x\n" $new_data_zone >> $seqres.full
+echo "Before reclaim: $open_zones_before_reclaim zones open" >> $seqres.full
 
-# Check that data was really relocated to a different zone
-if [ $old_data_zone -eq $new_data_zone ]; then
-	echo "New zone same as old zone"
+# step 2, delete the $fill_size sized file to trigger reclaim
+rm $SCRATCH_MNT/$seq.test2
+$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+sleep 5 # sleep for transaction commit for 'rm' and for balance
+
+open_zones_after_reclaim=$($BLKZONE_PROG report --offset $start_data_bg_phy $SCRATCH_DEV |\
+	grep -v -e em -e nw | wc -l)
+echo "After reclaim: $open_zones_after_reclaim zones open" >> $seqres.full
+
+reclaimed_bg_zone_empty=$($BLKZONE_PROG report --offset $start_data_bg_phy\
+	-c 1 $SCRATCH_DEV | grep -e em | wc -l)
+
+# Check that data from test1 file was really relocated to a different zone
+if [ $reclaimed_bg_zone_empty -eq 0 ]; then
+	echo "Error reclaiming the zone"
 fi
 
 # success, all done
-- 
2.25.1

