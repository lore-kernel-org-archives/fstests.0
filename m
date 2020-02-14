Return-Path: <SRS0=rSMp=4C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B88C2BA83
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842A32168B
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 15:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgBNPTD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:19:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54689 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbgBNPTD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Feb 2020 10:19:03 -0500
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1j2ck9-00023N-BA
        for fstests@vger.kernel.org; Fri, 14 Feb 2020 15:19:01 +0000
Received: by mail-qt1-f198.google.com with SMTP id k20so6088890qtm.11
        for <fstests@vger.kernel.org>; Fri, 14 Feb 2020 07:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3GiixWLPt3Xsm/w7r5HRS6kYyZ1TZwQaBGsuqSkCksc=;
        b=sLqtiFR49VJYllwb15A9nK0iAmpAv0VW03pVI8zclIh0Lb8SxAXOznTtj7DBETDgil
         rfTC379hvwejOOUpVuU0zUUuzlNUrFl2KdyTCh2Pi5mpWW7xLmXN17egCXCCADmaB5EG
         nl2klOV9Mq13K6SXUVp0fvjrBIpGNMmJVCeviAm/0U5tOVseA0cKO+wTfVWiAwra0bFi
         GQDDIlhW0rDA4f3a1KdOrw++kYJzz00I9dEmSuyK9GB+mChewoR8LtOJkzbohKepiBmn
         1eI7zr+FUTXsZxTUS7+5gdyX3jJtkm/wSErYWcRsMSG2eCblouj4KqjEJlgai52lzfzN
         SeYQ==
X-Gm-Message-State: APjAAAXBz4jeeUhOuwV+cAZV5j91ql5ilIw02p4nB+gPcWAk4l8EVIBw
        xKRlCHw8ycEJiFmB0ZrSsrHR8h9tsEjVB3RMB4ro45S6DWwk+4jyzDuDIY3STQsTSKK3UhR1t71
        O+/F9s1c9xXAEdEhQAiFb7SpZl51cxhVn3zA=
X-Received: by 2002:a05:620a:2119:: with SMTP id l25mr3088414qkl.248.1581693540150;
        Fri, 14 Feb 2020 07:19:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXrSZQbHcIdhkQnJmXTyveNUP2K55D0Dm3Xws0oOOOcoew+XDbhOk/5G8rqYSJdGqL9okHqA==
X-Received: by 2002:a05:620a:2119:: with SMTP id l25mr3088391qkl.248.1581693539900;
        Fri, 14 Feb 2020 07:18:59 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:4e7:1017:a97b:ff5a:85e:d3eb])
        by smtp.gmail.com with ESMTPSA id s22sm3403933qke.19.2020.02.14.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:18:59 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 5/5] common/overlay: silence some mount messages for fuse-overlayfs
Date:   Fri, 14 Feb 2020 12:18:48 -0300
Message-Id: <20200214151848.8328-6-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214151848.8328-1-mfo@canonical.com>
References: <20200214151848.8328-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When mouting fuse-overlayfs there are some messages that make
the tests report failures due to output mismatch; ignore them:

  uid=unchanged
  uid=unchanged
  upperdir=/mnt/test/ovl-upper
  workdir=/mnt/test/ovl-work
  lowerdir=/mnt/test/ovl-lower
  mountpoint=/mnt/test/ovl-mnt

For other filesystem types (e.g., overlay and aufs) make sure to
only print non-null output, to avoid blank lines output mismatch.

And return the status of the mount command, not other commands.

Currently, running './check -overlay' tests (excluding generic/062)
the numbers for fuse-overlayfs on loop devices on v5.4-based Ubuntu
kernel with the fuse-overlayfs package from Ubuntu Eoan/19.10 are:

 - Ran: 530
 - Not run: 395
 - Failures: 29

And hopefully this helps with testing for fuse-overlayfs too.

Steps:

  $ export OVL_FSTYP=fuse.fuse-overlayfs
  $ export FSTYP=ext4
  $ export TEST_DEV=/dev/loop0
  $ export TEST_DIR=/mnt/test
  $ export SCRATCH_DEV=/dev/loop1
  $ export SCRATCH_MNT=/mnt/scratch

  $ sudo mkfs.$FSTYP -F $TEST_DEV
  $ sudo mkfs.$FSTYP -F $SCRATCH_DEV
  $ sudo mkdir $TEST_DIR $SCRATCH_MNT

  $ cat <<EOF >/tmp/exclude-tests
  generic/062
  EOF

  $ sudo -E ./check -overlay -E /tmp/exclude-tests

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 common/overlay | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/common/overlay b/common/overlay
index a1076926c23f..27f3c08252ee 100644
--- a/common/overlay
+++ b/common/overlay
@@ -19,6 +19,8 @@ _overlay_mount_dirs()
 	local upperdir=$2
 	local workdir=$3
 	local options
+	local output
+	local rc
 	shift 3
 
 	options="-o lowerdir=$lowerdir -o upperdir=$upperdir -o workdir=$workdir"
@@ -26,7 +28,23 @@ _overlay_mount_dirs()
 		options="-o br=$upperdir=rw -o br=$lowerdir=ro"
 	fi
 
-	$MOUNT_PROG -t $OVL_FSTYP $options `_common_dev_mount_options $*`
+	options="$options `_common_dev_mount_options $*`"
+	output="`$MOUNT_PROG -t $OVL_FSTYP $options 2>&1`"
+	rc=$?
+
+	if [ "$OVL_FSTYP" = "fuse.fuse-overlayfs" ]; then
+		# Less verbosity to avoid output mismatch.
+		echo "$output" | grep -v \
+			-e "^uid=" \
+			-e "^upperdir=" \
+			-e "^lowerdir=" \
+			-e "^workdir=" \
+			-e "^mountpoint="
+	elif [ -n "$output" ]; then
+		echo "$output"
+	fi
+
+	return $rc
 }
 
 # Mount with same options/mnt/dev of scratch mount, but optionally
-- 
2.20.1

