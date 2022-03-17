Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3E8C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Mar 2022 12:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiCQMaI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Mar 2022 08:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiCQMaH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Mar 2022 08:30:07 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D235D3AF0
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 05:28:50 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220317122844euoutp01a9d54087b854f9336f64c45353e0f961~dKtMKd-4q0328603286euoutp01T
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 12:28:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220317122844euoutp01a9d54087b854f9336f64c45353e0f961~dKtMKd-4q0328603286euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647520124;
        bh=JlqLJs4LlaB+KRi9rUa/r/6pHZFZg0438y9KmWjhM80=;
        h=From:To:Cc:Subject:Date:References:From;
        b=m3g7CXM0UJk22PqIdV5gn2A8OkJfJxkuNIA2vPyKRHNRhK2AmiBm03T55Lz5RlGRH
         1yIXfegINHjR1P7Rxz1T1aNcZmNBJwvLAu6UQbAd1fD/gbVqnKY22hxLFDGhZXC43S
         99SVfFi9tIiYv7MzqWEOCMS6r+XUzH40piXwNsGE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220317122843eucas1p256184e721594a2fb27db881e11f15eff~dKtLWZ6z20378703787eucas1p2d;
        Thu, 17 Mar 2022 12:28:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FB.34.10009.B7923326; Thu, 17
        Mar 2022 12:28:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220317122843eucas1p1d01a061e25bd7bfaaf912780c011ffdd~dKtK2c4210445904459eucas1p1Z;
        Thu, 17 Mar 2022 12:28:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220317122843eusmtrp1c7001784988016264b14b59c3f84bf15~dKtK1p8hW0717407174eusmtrp1I;
        Thu, 17 Mar 2022 12:28:43 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-53-6233297b08bb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C7.76.09404.B7923326; Thu, 17
        Mar 2022 12:28:43 +0000 (GMT)
Received: from localhost (unknown [106.210.248.227]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220317122842eusmtip1151f5dd898d45fb5b3b298ce9250f230~dKtKgfJ9W2394923949eusmtip1t;
        Thu, 17 Mar 2022 12:28:42 +0000 (GMT)
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
Subject: [PATCH v2] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Date:   Thu, 17 Mar 2022 13:28:39 +0100
Message-Id: <20220317122839.44404-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87rVmsZJBpvXqltMP6xo8fvseWaL
        0y172S0e3/nMbvG36x6Txfm3h5ksbkx4ymgx8fhmVovPS1vYLdbcfMriwOWxc9Zddo9NqzrZ
        PHa23mf16NuyitHj8yY5j/YD3UwBbFFcNimpOZllqUX6dglcGVOmb2IuWCRWsafzFGMD42Sh
        LkYODgkBE4nGS85djFwcQgIrGCVe/jnMBuF8YZR4sv0GI4TzmVGitec1cxcjJ1jHosNnWUBs
        IYHljBItzcwQ9ktGidPfPEGmsgloSTR2soP0ioBM3b74OFg9s0AHk8T1F8EgtrBAisSPo82s
        IDaLgKpES08bO4jNK2ApcejVLkaIXfISMy99h4oLSpyc+QRqjrxE89bZzCALJAT2cEgcOP+O
        DaLBReLeyWXsELawxKvjW6BsGYnTk3tYIBr6GSWmtvxhgnBmMEr0HN7MBAkMa4m+MzkgJrOA
        psT6XfoQvY4SPw98Z4Go4JO48VYQ4gY+iUnbpjNDhHklOtqEIKqVJHb+fAK1VULictMcFgjb
        Q+LM4oVskKCKldiyeyPzBEaFWUg+m4Xks1kINyxgZF7FKJ5aWpybnlpsmJdarlecmFtcmpeu
        l5yfu4kRmIxO/zv+aQfj3Fcf9Q4xMnEwHmKU4GBWEuE980I/SYg3JbGyKrUoP76oNCe1+BCj
        NAeLkjhvcuaGRCGB9MSS1OzU1ILUIpgsEwenVAOTU/CWcuZ2w08Nyb4z/ZfOPbLm1doz0XeD
        k29srzOKyFVvVFglp2bkVF1l4qdTJ7Dld9sC8abjX336fLfmfPnNeJbT37nek0Wvl+GJjV8z
        +1UrHo7TNX+i4oVist6fn3jfMtPs5y6Zz32xvQscDl/NPWRrHNKm51x4Oy075IxJtZzzgU07
        7Qy/iS5l0z6/IOJHjMvsi3FZFumCcoePWLyKOuTULhgVySAxc/6zbXNfvNeQm6K/+eY+Ttl9
        vRHmyzhs02rNZv9a88bFp9Z7xol5LSs8wi28Mt9ujM2pe93x4aQAwz3d3t+en2pmCLx/PVF2
        8Wbjo0Zd/79bci1Ldbn5s22e7+yU2ZtkQyI3vVBiKc5INNRiLipOBAA2qZqvtQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsVy+t/xu7rVmsZJBqvesFpMP6xo8fvseWaL
        0y172S0e3/nMbvG36x6Txfm3h5ksbkx4ymgx8fhmVovPS1vYLdbcfMriwOWxc9Zddo9NqzrZ
        PHa23mf16NuyitHj8yY5j/YD3UwBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6GVOmb2IuWCRWsafzFGMD42ShLkZODgkBE4lFh8+ydDFycQgJ
        LGWUmHH4DyNEQkLi9sImKFtY4s+1LjaIoueMEk1L97B2MXJwsAloSTR2soPERQRWMUqsv/SB
        CcRhFuhhknjzYDVYt7BAksT7vT+ZQWwWAVWJlp42dhCbV8BS4tCrXVAb5CVmXvoOFReUODnz
        CQuIzQwUb946m3kCI98sJKlZSFILGJlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbDtmM/
        t+xgXPnqo94hRiYOxkOMEhzMSiK8Z17oJwnxpiRWVqUW5ccXleakFh9iNAW6byKzlGhyPjAe
        80riDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamMQ0pa5nXS/mWuRq
        6/X859kW9kxmF5XNa62PdPTy3Jk+SeBbTtbBc3PnWPd4pf8/cjtqr9GXXKaqhJnZ/h5vVrCU
        fWjfVNlt09THoDYl4kj0ojVbXmxfJBLtmKrb8FtBRrrNirksnuPtqYlL7q6aGv1l5TT5Re4F
        b35uEN1+3/WguGJc/MnHQeYz+P92vFcJiTPYWsX0fqK7GLu9Y3Twlwfvjj1RC5e1XLMl9wO7
        hob4+cf+5+6xO/RNWm28YZH8+w/HK+4FR686Ok8opPuoJ1+mhdveqT/kXv2bk6tze8bBLVvv
        Pz60al2B+QE96yJ/uXCX6tAQNc4fLeVTu+fyGyydFli0XfRNoFsb95v6ECWW4oxEQy3mouJE
        ACyOx8YPAwAA
X-CMS-MailID: 20220317122843eucas1p1d01a061e25bd7bfaaf912780c011ffdd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220317122843eucas1p1d01a061e25bd7bfaaf912780c011ffdd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220317122843eucas1p1d01a061e25bd7bfaaf912780c011ffdd
References: <CGME20220317122843eucas1p1d01a061e25bd7bfaaf912780c011ffdd@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test will break when zone capacity != zone size because the
calculation of the size to be filled is done using zone_size instead of
the actual capacity available per zone. Fix it by using zone capacity.

As a zoned device can have variable capacity, use the capacity from zone 5
as it is the first data block group.

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

 common/filter   | 12 ++++++++++++
 tests/btrfs/237 | 13 ++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/common/filter b/common/filter
index 257227c2..5acd57dd 100644
--- a/common/filter
+++ b/common/filter
@@ -634,5 +634,17 @@ _filter_bash()
 	sed -e "s/^bash: line 1: /bash: /"
 }
 
+#
+#blkzone report added zone capacity to be printed from v2.37.
+#This filter will add an extra column 'cap' with the same value of
+#'len'(zone size) for blkzone version < 2.37
+#
+#Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
+#After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 ..
+_filter_blkzone_report()
+{
+	$AWK_PROG -F "," 'BEGIN{OFS=",";} $3 !~ /cap/ {$2=$2","$2;} {print;}' | sed -e 's/len/cap/2'
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 96940549..33a0d81d 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -35,9 +35,6 @@ get_data_bg()
 		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
 }
 
-zonesize=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_sectors)
-zonesize=$((zonesize << 9))
-
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount -o commit=1 # 1s commit time to speed up test
 
@@ -49,12 +46,18 @@ if [[ "$uuid" == "" ]]; then
 	exit 1
 fi
 
+data_bg_zone_idx=5
+size=$($BLKZONE_PROG report -c $data_bg_zone_idx $SCRATCH_DEV | tail -1 |\
+	_filter_blkzone_report |\
+	grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)
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

