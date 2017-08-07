Received: from mail-pf0-f193.google.com ([209.85.192.193]:37878 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdHGTzd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Aug 2017 15:55:33 -0400
Received: by mail-pf0-f193.google.com with SMTP id p13so1282629pfd.4
        for <fstests@vger.kernel.org>; Mon, 07 Aug 2017 12:55:33 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 4/4] xfstests-bld: build dynamically linked binaries by default
Date: Mon,  7 Aug 2017 12:52:57 -0700
Message-Id: <20170807195257.61176-5-ebiggers3@gmail.com>
In-Reply-To: <20170807195257.61176-1-ebiggers3@gmail.com>
References: <20170807195257.61176-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

It seems the default of static linking was set several years ago, before
it was recommended to use a chroot to build the test appliances.  But
now it is pretty straightforward to set up a build chroot, and in that
case using static linking only bloats the binary sizes.  And although
static linking does make it a bit more plausible to build the
kvm-xfstests and gce-xfstests binaries outside a chroot, when actually
trying it I've ran into a number of problems, including:

    - distros shipping shared libraries but not static ones for some
      packages, causing the build to fail
    - the gen-image script making Debian-specific assumptions, such as
      assuming it can call apt-cache and dpkg, and running commands in
      the chroot without resetting the $PATH

Some of the problems can be solved, but not all can be, and dynamic
linking is preferable anyway.  So change the default to dynamic linking.
It's still possible to request static linking by setting EXEC_LDFLAGS
and EXEC_LLDFLAGS.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 config | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/config b/config
index e69530f..207ac06 100644
--- a/config
+++ b/config
@@ -20,8 +20,11 @@ XFSPROGS_COMMIT=v4.11.0-rc1
 # TOOLCHAIN_DIR=/u1/arm64-toolchain
 # CROSS_COMPILE=aarch64-linux-android
 
-EXEC_LDFLAGS=-static
-EXEC_LLDFLAGS=-all-static
+EXEC_LDFLAGS=
+EXEC_LLDFLAGS=
+# Uncomment these to statically link the binaries to the system libraries
+#EXEC_LDFLAGS=-static
+#EXEC_LLDFLAGS=-all-static
 
 BUILD_ENV=
 SUDO_ENV=sudo
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

