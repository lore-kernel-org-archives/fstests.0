Return-Path: <SRS0=5J60=4B=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB28C352A4
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Feb 2020 00:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB66221739
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Feb 2020 00:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgBMAEO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Feb 2020 19:04:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44520 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBMAEO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Feb 2020 19:04:14 -0500
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1j21zH-0006jD-Rf
        for fstests@vger.kernel.org; Thu, 13 Feb 2020 00:04:12 +0000
Received: by mail-qt1-f200.google.com with SMTP id o24so2454130qtr.17
        for <fstests@vger.kernel.org>; Wed, 12 Feb 2020 16:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9n0Le7Ahi8OQG8OShn7ro2Wc6jMub1TyJe+oSxfncxo=;
        b=ALDSdPJLLLvlSaSzasAveSi+bHiwwrWJzXGg2xaIn19BF0Z9sesh42VBg9lKfBCAO5
         Ll3tzfv8F1PV11r1O79PSqrSdV4uBNTUUFLT03mB3vOoBTnbwCulr9I5cEvb6RKHsVEb
         c6Jkpp7rmNG5t7Wg187Q5QZaITfZn2j5RMOlIujtjgrEknQBGPyKN9BVAiVfq/+xIaJ0
         s/nVMbVPb2Kle6qAT8GA5WVxNK2O83eGG11UEIWj/4SbbCXARXACfTJoA9BNPMaR6iT0
         4r45VYRbabZnQF6vaNYtrqhKi2LlF+gTiU2P5ub2k3/9Xy8qSG50XT0yeJJz8i+HAK+x
         Wc1g==
X-Gm-Message-State: APjAAAX4bSpouDqR3gDDh6TXiKi9TLqopuEtOPKp9RmSbzeJcfDQicb0
        K0D2FsuxRNEI/ChsOlosS/kBoTflpJ7tuMuOcun3U+xO3FqsriFiwAnfrpsb0dAf+NrcQNiNf4i
        QGTjfPnmKseXMN51LimHXJwjWl3hVMmtSB5c=
X-Received: by 2002:ac8:750e:: with SMTP id u14mr9141036qtq.320.1581552250890;
        Wed, 12 Feb 2020 16:04:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPvITXZMarPnqfE96u8LylxuOskzaLoO9sLanWYrZ4iHAV2M7htqpASPsjpCbhdWvFYdhKyA==
X-Received: by 2002:ac8:750e:: with SMTP id u14mr9141016qtq.320.1581552250634;
        Wed, 12 Feb 2020 16:04:10 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:4e7:1017:a97b:ff5a:85e:d3eb])
        by smtp.gmail.com with ESMTPSA id g26sm319225qkk.68.2020.02.12.16.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 16:04:10 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/overlay,rc: introduce OVL_ALT_FSTYP for testing aufs
Date:   Wed, 12 Feb 2020 21:04:06 -0300
Message-Id: <20200213000406.4966-1-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Recently looking for an aufs test suite. The author clarified that
'There is no public test suite specific to aufs.' [1] at this time,
and it looks like 'xfstests/tests/generic' should be enough [1, 2],
and is clearly an improvement in terms of publicly available tests.

Thus, building on top of the existing infrastructure for overlay,
just introduce OVL_ALT_FSTYP that can be set to "aufs" to use it.
(using overlay's upperdir as rw-branch and lowerdir as ro-branch).

This is indeed a workaround^W simple change that does the job vs.
creating a new FSTYP "aufs" and mechanically changing the number
of places that check for "overlay" to just handle "aufs" as well.
(so the effort is still small as aufs has no specific tests now.)

Currently, running the generic + overlay (i.e., ./check -overlay)
tests (and excluding a few [3] which either hang or keep looping)
the numbers for aufs on loop devices on v5.4-based Ubuntu kernel
show a relatively good starting base in terms of exercising code:

  - Ran: 645 tests
  - Not run: 483 tests
  - Failures: 21 tests

So, hopefully this may be a starting point as an aufs test suite.

[1] https://sourceforge.net/p/aufs/mailman/message/36918721/
[2] https://sourceforge.net/p/aufs/mailman/message/36918932/
[3] Steps:

  $ export OVL_ALT_FSTYP=aufs
  $ export FSTYP=ext4
  $ export TEST_DEV=/dev/loop0
  $ export TEST_DIR=/mnt/test
  $ export SCRATCH_DEV=/dev/loop1
  $ export SCRATCH_MNT=/mnt/scratch

  $ sudo mkfs.$FSTYP -F $TEST_DEV
  $ sudo mkfs.$FSTYP -F $SCRATCH_DEV
  $ sudo mkdir $TEST_DIR $SCRATCH_MNT

  $ cat <<EOF >/tmp/exclude-tests
  generic/013
  generic/070
  generic/075
  generic/112
  generic/127
  generic/461
  generic/476
  generic/522
  generic/530
  overlay/019
  EOF

  $ sudo -E ./check -overlay -E /tmp/exclude-tests
---
 common/overlay | 6 ++++++
 common/rc      | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/common/overlay b/common/overlay
index 65c639e9c6d8..3b3351ed040e 100644
--- a/common/overlay
+++ b/common/overlay
@@ -20,6 +20,12 @@ _overlay_mount_dirs()
 	local workdir=$3
 	shift 3
 
+	if [ -n "$OVL_ALT_FSTYP" -a "$OVL_ALT_FSTYP" = "aufs" ]; then
+		$MOUNT_PROG -t aufs -o br=$upperdir=rw:$lowerdir=ro \
+			`_common_dev_mount_options $*`
+		return $?
+	fi
+
 	$MOUNT_PROG -t overlay -o lowerdir=$lowerdir -o upperdir=$upperdir \
 		    -o workdir=$workdir `_common_dev_mount_options $*`
 }
diff --git a/common/rc b/common/rc
index b4a77a2187f4..976afb66015d 100644
--- a/common/rc
+++ b/common/rc
@@ -1471,6 +1471,10 @@ _check_mounted_on()
 		return 2 # 2 = mounted on wrong mnt
 	fi
 
+	if [ -n "$type" -a "$type" = "overlay" -a -n "$OVL_ALT_FSTYP" ]; then
+		type="$OVL_ALT_FSTYP"
+	fi
+
 	if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]; then
 		echo "$devname=$dev is mounted but not a type $type filesystem"
 		# raw $DF_PROG cannot handle NFS/CIFS/overlay correctly
-- 
2.20.1

