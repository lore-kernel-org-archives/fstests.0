Return-Path: <SRS0=rSMp=4C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8949C2BA83
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 15:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8D52168B
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 15:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgBNPTB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:19:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54685 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbgBNPTB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Feb 2020 10:19:01 -0500
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1j2ck7-000236-Ki
        for fstests@vger.kernel.org; Fri, 14 Feb 2020 15:18:59 +0000
Received: by mail-qv1-f70.google.com with SMTP id v19so2467799qvk.16
        for <fstests@vger.kernel.org>; Fri, 14 Feb 2020 07:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gxv9naRR94OrFR2E4kqdWVBYbqQzHHgz4FT5saerk8=;
        b=pS+6hmRwNpcUtwEJ6iP8f2/mYvD2bXhaTtKtvQygb52g60/gNyLkP7l0/iCqV9xVYn
         WMXad2GIrPyzmBx2n0AraK+ziCoqBkqIarPfmMPf4opvozyEx1Oa6br1jqH+g+RotzQ7
         T0Iuw3mH0lFOMI+7tkN5P8dasBJa2vArZklWVZpioLx5APrZ4Wp2Bkj9bPnHllavtkO4
         0XnD6NiFMFUltu3pR3YmsiDIdVFFrPokrir0QdylViZ8DBIg/Mbb9Hhk64S9JlA7/jdG
         FHZay2ftYzRV8IsbFiNqeRwinXncObZJhYgREFUJbi76Ys7XGY4oGV2ESyw20I8L7Ah2
         O78g==
X-Gm-Message-State: APjAAAVfBvrgUyWLOl7uNvLaQAvIPi6VeYM5De9+inkqLWuezSVVxPSe
        3XbSBSzvUMmU+2zT5IXUGHS0w2PTlPErwXQRxclsMQyKmcVKOBfbcHrbRArpSbVOfdqzDCOO6Nk
        d9EAQFYfsnbSCui2e1gXHLDDoiTcSivtNhe0=
X-Received: by 2002:a37:678a:: with SMTP id b132mr2714023qkc.4.1581693538560;
        Fri, 14 Feb 2020 07:18:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSs3a5ecC9oWFm9RUxIRwQefN+2hgpiqqvbGMwl4bdR1pwR/cuddVO1Sfr8o3OTlLgvoQaJA==
X-Received: by 2002:a37:678a:: with SMTP id b132mr2714002qkc.4.1581693538291;
        Fri, 14 Feb 2020 07:18:58 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:4e7:1017:a97b:ff5a:85e:d3eb])
        by smtp.gmail.com with ESMTPSA id s22sm3403933qke.19.2020.02.14.07.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:18:57 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 4/5] common/rc: add quirks for fuse-overlayfs device/mount point
Date:   Fri, 14 Feb 2020 12:18:47 -0300
Message-Id: <20200214151848.8328-5-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214151848.8328-1-mfo@canonical.com>
References: <20200214151848.8328-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On fuse-overlayfs the mount device is always reported as
a "fuse-overlayfs" string, instead of the parent directory
of the mount point (the string expected by overlay/scripts).

Unfortunately, it seems that the fuse mount option 'fsname'
doesn't set the filesystem source/device on fuse-overlayfs,
so the easy fix of just adding it to mount options is gone.

So two quirks are used to check for a fuse-overlayfs mount,
that checks the mount point/directory in _check_mounted_on()
and init_rc(); latter with the new helper _fs_type_dev_dir().

With this, fuse-overlayfs can now keep going through tests!

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 README.overlay |  1 +
 common/rc      | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/README.overlay b/README.overlay
index 08a39b8830c9..7ef07ae6bbab 100644
--- a/README.overlay
+++ b/README.overlay
@@ -53,4 +53,5 @@ OVERLAY_FSCK_OPTIONS will be used to check both test and scratch overlay.
 
 To test other filesystem types (experimental) configure the OVL_FSTYP variable:
 
+ OVL_FSTYP=fuse.fuse-overlayfs
  OVL_FSTYP=aufs
diff --git a/common/rc b/common/rc
index 5711eca2a1d2..6a4cb9b6d604 100644
--- a/common/rc
+++ b/common/rc
@@ -1481,6 +1481,14 @@ _check_mounted_on()
 
 	# find $dev as the source, and print result in "$dev $mnt" format
 	local mount_rec=`findmnt -rncv -S $dev -o SOURCE,TARGET`
+
+	# fuse-overlayfs dev is not $dev, check via $mnt.
+	if [ -z "$mount_rec" -a "$FSTYP" = "overlay" -a \
+		"$OVL_FSTYP" = "fuse.fuse-overlayfs" ]; then
+		dev="fuse-overlayfs"
+		mount_rec=`findmnt -rncv -S $dev -T $mnt -o SOURCE,TARGET`
+	fi
+
 	[ -n "$mount_rec" ] || return 1 # 1 = not mounted
 
 	# if it's mounted, make sure its on $mnt
@@ -3788,8 +3796,17 @@ init_rc()
 	fi
 
 	# if $TEST_DEV is not mounted, mount it now as XFS
-	if [ -z "`_fs_type $TEST_DEV`" ]
+	if [ -n "`_fs_type $TEST_DEV`" ]
 	then
+		# $TEST_DEV is mounted
+		true
+	elif [ "$FSTYP" = "overlay" -a "$OVL_FSTYP" = "fuse.fuse-overlayfs" -a \
+		-n "`_fs_type_dev_dir fuse-overlayfs $TEST_DEV/$OVL_MNT`" ]
+	then
+		# (fuse-overlayfs dev is not $TEST_DEV; check via mount point)
+		# $TEST_DEV is mounted
+		true
+	else
 		# $TEST_DEV is not mounted
 		if ! _test_mount
 		then
-- 
2.20.1

