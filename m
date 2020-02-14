Return-Path: <SRS0=rSMp=4C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427E1C3B19F
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A9624670
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgBNPS7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:18:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54682 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbgBNPS7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Feb 2020 10:18:59 -0500
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1j2ck5-00022s-VR
        for fstests@vger.kernel.org; Fri, 14 Feb 2020 15:18:58 +0000
Received: by mail-qk1-f198.google.com with SMTP id a132so6375908qkg.5
        for <fstests@vger.kernel.org>; Fri, 14 Feb 2020 07:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83C2lNWz8o4Om2q4nHCqNIAoV15NBW+uboT5K2kj8rU=;
        b=WV5Eojzk+KVLonCH9sgdzFUMfpNDCPiu4Gi8CgfLXrO3g31uVl3LCV/seLSS2ZR9ig
         zEVSKB4wLq84OHIirPhjFkNdYciPCPRvghzRzx92qKoyz1nqC0LMEFgQq+0C70XrUkU7
         5Gu1PaB22SIvC5pLSSBRQJCSap8APp6SIKJ3Hr6HKHXWqAj8xdIGE02deSI7a1yvtsim
         PpdJdSJUSGwdBLhOYyUdmMKEg8M+lN+roc7fsUqQpTuB9Hpqbt8gM6cS0/w8P2Y6Tuii
         54UrOZ9m8mGC+d2ZT9XsRes8IjBmp+QImzHZtQFgVpY84QEEffiFlgAzrbcNa9tF3N6c
         Jgjw==
X-Gm-Message-State: APjAAAVh7i3ht9bqCUQtvWaFcuCYZM67VMtm5JpXsirzTIlhLwZYiAGJ
        gqSfgoytF0tEeR3scn00+T1qqllStFE8fccF0RZyEEqLIEsa0gFGUkfqyqZOoucdzHMJ3/fsc3/
        lq7j36bY20Q4ZHMND21TlhOQ+1fRO+wJSytc=
X-Received: by 2002:a37:4e97:: with SMTP id c145mr2976556qkb.253.1581693536956;
        Fri, 14 Feb 2020 07:18:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqx98yYRfFgrmnoTK7yOcT8vEYzHYdeLFs9Ej1KFbEv1l6A+9C0pufzZcLHUFobNLA5YXrl16w==
X-Received: by 2002:a37:4e97:: with SMTP id c145mr2976531qkb.253.1581693536653;
        Fri, 14 Feb 2020 07:18:56 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:4e7:1017:a97b:ff5a:85e:d3eb])
        by smtp.gmail.com with ESMTPSA id s22sm3403933qke.19.2020.02.14.07.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:18:56 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 3/5] common/rc: introduce new helper function _fs_type_dev_dir()
Date:   Fri, 14 Feb 2020 12:18:46 -0300
Message-Id: <20200214151848.8328-4-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214151848.8328-1-mfo@canonical.com>
References: <20200214151848.8328-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

In order to determine the fs type on fuse-overlayfs (coming)
we need to search for the mount point/directory; the device
is not enough. (details in the next patch.)

Thus the _fs_type() function is insufficient to determine
the filesystem type, as it only searches for mount device.

So, introduce the _fs_type_dev_dir() function, which also
searches for the mountpoint/dir in addition to the device.

The fs type fix-up sed script goes into a common function.

P.S.: there might be other sites that need similar changes,
since the mount device is also checked elsewhere, but just
with this bit tests can run, so it is good enough for now.)

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 common/rc | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/common/rc b/common/rc
index 1feae1a94f9e..5711eca2a1d2 100644
--- a/common/rc
+++ b/common/rc
@@ -1262,6 +1262,19 @@ _used()
     _df_device $1 | $AWK_PROG '{ sub("%", "") ; print $6 }'
 }
 
+# fix filesystem type up
+#
+_fix_fs_type()
+{
+    #
+    # The Linux kernel shows NFSv4 filesystems in df output as
+    # filesystem type nfs4, although we mounted it as nfs earlier.
+    # Fix the filesystem type up here so that the callers don't
+    # have to bother with this quirk.
+    #
+    sed -e 's/nfs4/nfs/' -e 's/fuse.glusterfs/glusterfs/'
+}
+
 # return the FS type of a mounted device
 #
 _fs_type()
@@ -1272,14 +1285,21 @@ _fs_type()
 	exit 1
     fi
 
-    #
-    # The Linux kernel shows NFSv4 filesystems in df output as
-    # filesystem type nfs4, although we mounted it as nfs earlier.
-    # Fix the filesystem type up here so that the callers don't
-    # have to bother with this quirk.
-    #
-    _df_device $1 | $AWK_PROG '{ print $2 }' | \
-        sed -e 's/nfs4/nfs/' -e 's/fuse.glusterfs/glusterfs/'
+    _df_device $1 | $AWK_PROG '{ print $2 }' | _fix_fs_type
+}
+
+# return the FS type of a mounted device
+# on a mount point directory (check both)
+#
+_fs_type_dev_dir()
+{
+    if [ $# -ne 2 ]
+    then
+	echo "Usage: _fs_type_dev_dir device directory" 1>&2
+	exit 1
+    fi
+
+    _df_dir $2 | $AWK_PROG -v what=$1 '($1==what) { print $2 }' | _fix_fs_type
 }
 
 # return the FS mount options of a mounted device
-- 
2.20.1

