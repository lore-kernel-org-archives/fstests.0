Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBDBC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Mar 2022 11:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346947AbiCUMA1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347063AbiCUMAZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Mar 2022 08:00:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68FC22B1D
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 04:58:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qa43so29222700ejc.12
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 04:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VmHf0QYRmq+Qkt9Ipmh9N0MoSEC6Cp8rTr4XXOtjSGg=;
        b=L6FjLjrAhoqQgwwUEd8ISrEWy/4pMMGbnay8ERCSJXI2T3uHPucXRxLH9RdyX9tynk
         c2aAv4DpVYEXTDNnVFcrJuKCk0D8D/yB3lKrcSvcuQUog5JA+li4LvqNgWWdmOuWJ7bM
         UQxHv3cmj/BN1m7C+RbpgINt49l7HUvopJYTovLWS26wcCyEDYkVgED1/mGGMGA3VIyS
         +9nlh6xoGYJr/ZjzhT1n3nFa7mGDo0WftOlEL3DWy2YdAcF64wMbnLi4+9rX4B1tUIPA
         5/dv/Nr5BDIOnFKR4icIKKyTTVMaJgy9naoqwXIhhDjXCrBKxft4RC/EvJnzmGDli2nl
         iMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VmHf0QYRmq+Qkt9Ipmh9N0MoSEC6Cp8rTr4XXOtjSGg=;
        b=4IDzozJVylLKrI3FmxrzJHLFJy0smKrScPCXc98Zcc8dXRprEw0wcY3TRSZ8Vdqdgo
         NU+5r3ureb7oS9NhBlaER5rC+j35giwSpzvtqDbyFhxFFhxHBnSWm8kW25XaLuR7qd41
         8xWJ+tAxnfPIUcrdVfOL9VtRkra9cPdcoTaVpHH5DatGcvk48UZ0uRo+3a3vFnLTEbYg
         6toroU7SWXhH7m3NkxWlL1119j9HiTDeFakA5zIpkDC+Me+OrKEBVRVBaYas7kFsOjBx
         YVq8r9ItuI/3B9j9Btd7f4MjJvR5ZMwqXWKpw92nMh/lW/51tNdxzPiwIpt/OWZBVINk
         gifA==
X-Gm-Message-State: AOAM5310JBBv5H55Z6ndd47oBC787hq5OLrYFzmuXUdGQ1TOpRSeYZRL
        kyqNXfobR1wzzAGaELJIYbC2l16Vdgc=
X-Google-Smtp-Source: ABdhPJwVkDSfwzGO8+S8cy+x81y9/SW4mqc4yc5rykBVYA/ZiS/3QeDZadnvtjXZwV8CcNJpKsa5vQ==
X-Received: by 2002:a17:906:3a83:b0:6d6:e54d:3264 with SMTP id y3-20020a1709063a8300b006d6e54d3264mr20881503ejd.96.1647863937349;
        Mon, 21 Mar 2022 04:58:57 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090672d100b006df98bb199dsm5191296ejl.129.2022.03.21.04.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 04:58:56 -0700 (PDT)
From:   Pankaj Raghav <pankydev8@gmail.com>
X-Google-Original-From: Pankaj Raghav <p.raghav@samsung.com>
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
Subject: [PATCH v3] btrfs/237: Use zone cap instead of zone size in fill_size and rest calculation
Date:   Mon, 21 Mar 2022 12:58:48 +0100
Message-Id: <20220321115848.30397-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 96940549..cb897416 100755
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
+start_data_bg_phy=$((data_bg_zone >> 9))
+
+size=$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
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

