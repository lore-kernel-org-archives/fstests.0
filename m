Return-Path: <SRS0=rSMp=4C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C70C2BA83
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 15:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF222168B
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 15:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgBNPS5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:18:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54676 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbgBNPS5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Feb 2020 10:18:57 -0500
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1j2ck2-00022A-Q1
        for fstests@vger.kernel.org; Fri, 14 Feb 2020 15:18:54 +0000
Received: by mail-qk1-f200.google.com with SMTP id w126so916513qkb.23
        for <fstests@vger.kernel.org>; Fri, 14 Feb 2020 07:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpn1DjbE2auZrikA/d7VQIODPI3wrxIMw6GlG2uZhVI=;
        b=Po2ryi1SNrKYkQpIzB0InT2mrh+S9CC/CIp+oaiQyHxdZdwSsG+ezAbll29V3z1OfG
         YxBOxmqwOsIea+AdRpK14YasDkwWL1wQmCZRa6KFDZQn7xT2QsjrrlRCgU3Q+BAHYuXP
         wJWcHFcUyD8bpHknsOaMXPEiELgLvXl7Qn2drmq6yvG/YPF62gxCtUJ2mvvwgfR+8cKx
         4d1SWclzWwsjAAC2YVD2T80Phv1xH3Bg3BdVR5xrrXQnYgkBoZB/49C5wM/Bo2YGee9g
         t2ss+9kHVrDqyAeQ2zC7rVg+NCLohq9UFgvOXaoNdlNDSZraqdW4R5uie3IK/3bvMGKF
         w12Q==
X-Gm-Message-State: APjAAAXDLjr6thz8PamaYd9EO+ZShoKQhz7GtLspBD+S+fsK5zncYgEg
        bHgrSb9hR4W4b7dQ2dePqMBNIkmUwQncvCcNQcU/zvOCvFkWuAROdEP0E0IU1wGDghzAlBcoCrA
        6H4nLVZ2ZWRPrH30D4x1sxM1lVUqSmXcrKLU=
X-Received: by 2002:ac8:195d:: with SMTP id g29mr2940191qtk.65.1581693533684;
        Fri, 14 Feb 2020 07:18:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwSjpsTgwTbfmXgLXQ6udOZpV8PN8VNKbgXvjshMzyWP6vfINsGpT2YBwSbxGp7zE5faqNHBQ==
X-Received: by 2002:ac8:195d:: with SMTP id g29mr2940172qtk.65.1581693533352;
        Fri, 14 Feb 2020 07:18:53 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:4e7:1017:a97b:ff5a:85e:d3eb])
        by smtp.gmail.com with ESMTPSA id s22sm3403933qke.19.2020.02.14.07.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:18:53 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 1/5] common/overlay,rc,config: introduce OVL_FSTYP variable and aufs
Date:   Fri, 14 Feb 2020 12:18:44 -0300
Message-Id: <20200214151848.8328-2-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214151848.8328-1-mfo@canonical.com>
References: <20200214151848.8328-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Recently I was looking for an aufs test suite, and reached out to
Okajima, but 'There is no public test suite specific to aufs.' [1],
and it looks like 'xfstests/tests/generic' should be enough [1, 2].

Thus, building on top existing xfstests support for overlay just
introduce the OVL_FSTYP variable, and the default value "overlay"
can be changed to "aufs" (uses overlay's upperdir as a rw-branch
and lowerdir as a ro-branch; workdir is not used.)

This is indeed a workaround^W simple change that does the job vs.
creating a new FSTYP "aufs" and mechanically changing the number
of places that check for "overlay" to just handle "aufs" as well.
(so the effort is still small as aufs has no specific tests now.)

This also allows testing fuse-overlayfs with the next patches.

The changes are minimal -- just translate overlay mount options
and use $OVL_FSTYP as filesystem type for checking/mount/umount;
then report it in log headers and document it in README.overlay.

Currently, running './check -overlay' tests (excluding a few [3]
which either hang or keep looping) the numbers for aufs on loop
devices on v5.4-based Ubuntu kernel are:

  - Ran: 645 tests
  - Not run: 483 tests
  - Failures: 22 tests

So, hopefully this may help with a starting point for an public
test suite for aufs.

Thanks to Amir Goldstein for feedback/improvements and pointers
to support fuse-overlayfs as well [v2].

[1] https://sourceforge.net/p/aufs/mailman/message/36918721/
[2] https://sourceforge.net/p/aufs/mailman/message/36918932/
[3] Steps:

  $ export OVL_FSTYP=aufs
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

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 README.overlay |  4 ++++
 common/config  |  2 ++
 common/overlay | 11 ++++++++---
 common/rc      |  6 ++++++
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/README.overlay b/README.overlay
index 30b5ddb2d1c3..08a39b8830c9 100644
--- a/README.overlay
+++ b/README.overlay
@@ -50,3 +50,7 @@ In the example above, MOUNT_OPTIONS will be used to mount the base scratch fs,
 TEST_FS_MOUNT_OPTS will be used to mount the base test fs,
 OVERLAY_MOUNT_OPTIONS will be used to mount both test and scratch overlay and
 OVERLAY_FSCK_OPTIONS will be used to check both test and scratch overlay.
+
+To test other filesystem types (experimental) configure the OVL_FSTYP variable:
+
+ OVL_FSTYP=aufs
diff --git a/common/config b/common/config
index 9a9c77602b54..d92a78003295 100644
--- a/common/config
+++ b/common/config
@@ -71,6 +71,8 @@ export OVL_LOWER="ovl-lower"
 export OVL_WORK="ovl-work"
 # overlay mount point parent must be the base fs root
 export OVL_MNT="ovl-mnt"
+# overlay mount filesystem type (for testing other fs)
+export OVL_FSTYP=${OVL_FSTYP:-overlay}
 
 # From e2fsprogs/e2fsck/e2fsck.h:
 # Exit code used by fsck-type programs
diff --git a/common/overlay b/common/overlay
index 65c639e9c6d8..a1076926c23f 100644
--- a/common/overlay
+++ b/common/overlay
@@ -18,10 +18,15 @@ _overlay_mount_dirs()
 	local lowerdir=$1
 	local upperdir=$2
 	local workdir=$3
+	local options
 	shift 3
 
-	$MOUNT_PROG -t overlay -o lowerdir=$lowerdir -o upperdir=$upperdir \
-		    -o workdir=$workdir `_common_dev_mount_options $*`
+	options="-o lowerdir=$lowerdir -o upperdir=$upperdir -o workdir=$workdir"
+	if [ "$OVL_FSTYP" = "aufs" ]; then
+		options="-o br=$upperdir=rw -o br=$lowerdir=ro"
+	fi
+
+	$MOUNT_PROG -t $OVL_FSTYP $options `_common_dev_mount_options $*`
 }
 
 # Mount with same options/mnt/dev of scratch mount, but optionally
@@ -302,7 +307,7 @@ _overlay_check_fs()
 		_overlay_base_mount $*
 	else
 		# Check and umount overlay for dir check
-		ovl_mounted=`_is_dir_mountpoint $ovl_mnt`
+		ovl_mounted=`_is_dir_mountpoint $ovl_mnt $OVL_FSTYP`
 		[ -z "$ovl_mounted" ] || $UMOUNT_PROG $ovl_mnt
 	fi
 
diff --git a/common/rc b/common/rc
index b4a77a2187f4..1feae1a94f9e 100644
--- a/common/rc
+++ b/common/rc
@@ -1471,6 +1471,10 @@ _check_mounted_on()
 		return 2 # 2 = mounted on wrong mnt
 	fi
 
+	if [ -n "$type" -a "$type" = "overlay" ]; then
+		type="$OVL_FSTYP"
+	fi
+
 	if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]; then
 		echo "$devname=$dev is mounted but not a type $type filesystem"
 		# raw $DF_PROG cannot handle NFS/CIFS/overlay correctly
@@ -2841,6 +2845,8 @@ _full_fstyp_details()
 		FSTYP="$FSTYP (non-debug)"
 	    fi
 	fi
+     elif [ $FSTYP = "overlay" -a "$OVL_FSTYP" != "overlay" ]; then
+	FSTYP="$FSTYP ($OVL_FSTYP)"
      fi
      echo $FSTYP
 }
-- 
2.20.1

