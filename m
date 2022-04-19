Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3246C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Apr 2022 12:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350524AbiDSM72 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Apr 2022 08:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350512AbiDSM70 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Apr 2022 08:59:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929FC326F4
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 05:56:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bv16so5180047wrb.9
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqpkEkCFkcQo7DeoBimHeKYrUbUlYkGXJzSr73MZHmo=;
        b=Vn22/DjMYwTzUVUFKjQSYBreeTA06ifUoeRQNyCQ0fftg0ypXZKKp5VTws8GqAKpJ3
         x5vk/akdqyWJM8BroZ6Tcp9MZWBBssdKUoGmzButQQ/RHJnztGdap38Oc0My7928jubV
         R6RcUObaYyMgpz3Q0F+iivhKgKEsaQLbowYRs0Ki3sFMeUKM+QXrNus5MQl/UJei+QqM
         r6Vjf2+jwhzQNSg6SvES7KKg5HSstlCtEzK/UMRoQZEVQPItoABtdlhrLMi9nv51dpme
         skZU/ekR1eQlhOgbHbEI4qBeaOH+nJ75vBEYZ/w2m3hLmPSdUkyd1qhts8N9szv/HuWP
         GXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqpkEkCFkcQo7DeoBimHeKYrUbUlYkGXJzSr73MZHmo=;
        b=jtflOQ7ZPgQ6WRj3mFAvzeKbPDgG/5TTYsqNJ5ntA0X31sb5ANwxBCIQ51cJDkiz3v
         u7OVh+Bho8mlkct2BtxEdEOF2F4tlRkje1jAWADmqcwdnorU6l2XRxzyzAp+6r3U8RDw
         HDrG+I7iwXIKrgL3IkqEEjViTeCgRIEs1NWz+lxPRBOZp7LQuQVFpS3ZEz9+exvpkNmt
         DkOuYYXfCFxewmQ6hqBpZfBQZrbOgpt6ShOQccgHPZqFX9ZDWS+QrB6p3BZMGKo3+spi
         AAQ7hyRj9qhkRn7/cu5YV6MPdhWrzHYkZRorzJ8y7w2T1O4UEEdU4eaoRNQxkkO3SSm9
         V7QQ==
X-Gm-Message-State: AOAM532Mya/SSOxmn3o2/8wQBF4UlfA8wxizUkShk4k8NZOCtufy4TI0
        EgpuNAaQ2kqpVf3At0h9cIaxKSIvF6E=
X-Google-Smtp-Source: ABdhPJx0p3deqoobsU7I0v5oIXhGH3EnClxYIZaosqff8wxA1K4Q2m0DEedNg0fFymzhfuXQlebzOw==
X-Received: by 2002:a05:6000:784:b0:207:a570:b5b3 with SMTP id bu4-20020a056000078400b00207a570b5b3mr11711790wrb.304.1650373002118;
        Tue, 19 Apr 2022 05:56:42 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b00207aac5d595sm12499142wrx.38.2022.04.19.05.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:56:41 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>, Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: [PATCH v2 1/2] common: support black listing fs in _supported_fs()
Date:   Tue, 19 Apr 2022 15:56:36 +0300
Message-Id: <20220419125637.2502181-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419125637.2502181-1-amir73il@gmail.com>
References: <20220419125637.2502181-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

For example:
_supported_fs ^xfs

There is no need to specify "generic" when using a block list
"all other fs are supported" is implied.

Converted some generic tests that open code this condition without
emitting a meaningful reason.

More generic test like generic/186,187 could use a block list, but
were not converted because they emit some meaningful reason:
  _notrun "Can't fragment free space on btrfs."

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc         | 30 ++++++++++++++++++++----------
 tests/generic/500 |  3 +--
 tests/generic/631 |  3 +--
 tests/generic/679 |  3 +--
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/common/rc b/common/rc
index 553ae350..ae201f87 100644
--- a/common/rc
+++ b/common/rc
@@ -1580,19 +1580,29 @@ _fail()
 
 # tests whether $FSTYP is one of the supported filesystems for a test
 #
-_supported_fs()
+_check_supported_fs()
 {
-    local f
+	local res=1
+	local f
 
-    for f
-    do
-	if [ "$f" = "$FSTYP" -o "$f" = "generic" ]
-	then
-	    return
-	fi
-    done
+	for f; do
+		# ^FS means black listed fs
+		if [ "$f" = "^$FSTYP" ]; then
+			return 1
+		elif [ "$f" = "generic" ] || [[ "$f" == "^"* ]]; then
+			# ^FS implies "generic ^FS"
+			res=0
+		elif [ "$f" = "$FSTYP" ]; then
+			return 0
+		fi
+	done
+	return $res
+}
 
-    _notrun "not suitable for this filesystem type: $FSTYP"
+_supported_fs()
+{
+	_check_supported_fs $* || \
+		_notrun "not suitable for this filesystem type: $FSTYP"
 }
 
 # check if a FS on a device is mounted
diff --git a/tests/generic/500 b/tests/generic/500
index 0be59934..bc84d219 100755
--- a/tests/generic/500
+++ b/tests/generic/500
@@ -35,7 +35,6 @@ _cleanup()
 . ./common/dmthin
 
 # real QA test starts here
-_supported_fs generic
 _require_scratch_nocheck
 _require_dm_target thin-pool
 
@@ -43,7 +42,7 @@ _require_dm_target thin-pool
 # and since we've filled the thinp device it'll return EIO, which will make
 # btrfs flip read only, making it fail this test when it just won't work right
 # for us in the first place.
-test $FSTYP == "btrfs"  && _notrun "btrfs doesn't work that way lol"
+_supported_fs ^btrfs
 
 # Require underlying device support discard
 _scratch_mkfs >>$seqres.full 2>&1
diff --git a/tests/generic/631 b/tests/generic/631
index 4996bce7..219f7a05 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -36,10 +36,9 @@ _cleanup()
 . ./common/attr
 
 # real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_attrs trusted
-test "$FSTYP" = "overlay" && _notrun "Test does not apply to overlayfs."
+_supported_fs ^overlay
 _require_extra_fs overlay
 
 _scratch_mkfs >> $seqres.full
diff --git a/tests/generic/679 b/tests/generic/679
index 440f0c08..c32d42b9 100755
--- a/tests/generic/679
+++ b/tests/generic/679
@@ -17,7 +17,6 @@ _begin_fstest auto quick prealloc
 
 # real QA test starts here
 
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fiemap"
@@ -26,7 +25,7 @@ _require_xfs_io_command "fiemap"
 #
 #   https://lore.kernel.org/linux-btrfs/20220315164011.GF8241@magnolia/
 #
-[ $FSTYP == "xfs" ] && _notrun "test not valid for xfs"
+_supported_fs ^xfs
 
 rm -f $seqres.full
 
-- 
2.25.1

