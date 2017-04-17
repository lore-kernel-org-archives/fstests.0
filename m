Received: from mail-pf0-f193.google.com ([209.85.192.193]:35967 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753250AbdDQVeV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Apr 2017 17:34:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id i5so27067022pfc.3
        for <fstests@vger.kernel.org>; Mon, 17 Apr 2017 14:34:21 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 2/3] gce-xfstests: move NR_CPU, MEM, and ROOT_FS into config.gce
Date: Mon, 17 Apr 2017 14:33:26 -0700
Message-Id: <20170417213327.36520-2-ebiggers3@gmail.com>
In-Reply-To: <20170417213327.36520-1-ebiggers3@gmail.com>
References: <20170417213327.36520-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

This allows them to be overridden by ~/.config/gce-xfstests.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/gce-xfstests.md | 12 +++++++-----
 kvm-xfstests/config.gce       | 12 ++++++++++++
 kvm-xfstests/gce-xfstests     |  9 ---------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/gce-xfstests.md b/Documentation/gce-xfstests.md
index 6d053d1..5b1c9a7 100644
--- a/Documentation/gce-xfstests.md
+++ b/Documentation/gce-xfstests.md
@@ -345,8 +345,10 @@ variable is defined:
         GCE_IMAGE_PROJECT="$GCE_PROJECT"
 
 Normally, the most recently created image in the xfstests image family
-will be used by default.  You can however override this by using the
--I option to specify a specific image file.  (For example:
-"gce-xfstests -I xfstests-201608130052 smoke".)  You can also use the
---image-project command line option to override the GCE_IMAGE_PROJECT
-setting in your configuration file.
+will be used by default.  You can however override this and use a
+specific image by setting `ROOT_FS` in your `~/.config/gce-xfstests`
+configuration file, or by using the -I option to gce-xfstests.  (For
+example: `ROOT_FS=xfstests-201608130052`, or "gce-xfstests -I
+xfstests-201608130052 smoke".)  You can also use the --image-project
+command line option to override the GCE_IMAGE_PROJECT setting in your
+configuration file.
diff --git a/kvm-xfstests/config.gce b/kvm-xfstests/config.gce
index 96b64f8..3358ae3 100644
--- a/kvm-xfstests/config.gce
+++ b/kvm-xfstests/config.gce
@@ -13,3 +13,15 @@
 # List of firewall rules to create.  By default the gce-xfstests web interface
 # is made available to everyone over the public Internet.
 GCE_FIREWALL_RULES=("allow-http --allow tcp:80 --target-tags http-server")
+
+# Use different defaults for GCE because the background ruby monitoring
+# program uses extra memory --- the n1-standard-2 machine type has 7.5 GB,
+# so use that.
+NR_CPU=2
+MEM=7680
+
+# Name of the GCE image from which the test instances will be created.
+# This can also be set by the -I option.
+# If "xfstests" (the default), this is actually treated as an image family, and
+# the latest image from the xfstests family will be used.
+ROOT_FS="xfstests"
diff --git a/kvm-xfstests/gce-xfstests b/kvm-xfstests/gce-xfstests
index 7b678bc..240467e 100755
--- a/kvm-xfstests/gce-xfstests
+++ b/kvm-xfstests/gce-xfstests
@@ -9,15 +9,6 @@ fi
 
 . "$DIR/util/get-config"
 
-# Use different defaults for GCE because the background ruby monitoring
-# program uses extra memory --- the n1-standard-2 machine type has 7.5 GB,
-# so use that.
-NR_CPU=2
-MEM=7680
-
-# We use ROOT_FS for the GCE image; this can be set by the -I option
-ROOT_FS="xfstests"
-
 if test -r "$DIR/test-appliance/config.custom" ; then
    . "$DIR/test-appliance/config.custom"
 fi
-- 
2.12.2.762.g0e3151a226-goog

