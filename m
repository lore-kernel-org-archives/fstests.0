Received: from mail-pg0-f67.google.com ([74.125.83.67]:34572 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752968AbdEQXe7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 19:34:59 -0400
Received: by mail-pg0-f67.google.com with SMTP id u187so3593922pgb.1
        for <fstests@vger.kernel.org>; Wed, 17 May 2017 16:34:59 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 3/5] kernel-configs: use CONFIG_LOCALVERSION="-xfstests"
Date: Wed, 17 May 2017 16:32:31 -0700
Message-Id: <20170517233233.61244-4-ebiggers3@gmail.com>
In-Reply-To: <20170517233233.61244-1-ebiggers3@gmail.com>
References: <20170517233233.61244-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kernel-configs/i386-config-3.10   | 1 +
 kernel-configs/i386-config-3.14   | 1 +
 kernel-configs/i386-config-3.3    | 1 +
 kernel-configs/i386-config-3.6    | 1 +
 kernel-configs/i386-config-3.8    | 1 +
 kernel-configs/i386-config-4.1    | 1 +
 kernel-configs/i386-config-4.7    | 1 +
 kernel-configs/i386-config-4.9    | 1 +
 kernel-configs/x86_64-config-3.10 | 1 +
 kernel-configs/x86_64-config-3.14 | 2 +-
 kernel-configs/x86_64-config-3.18 | 1 +
 kernel-configs/x86_64-config-3.2  | 1 +
 kernel-configs/x86_64-config-3.4  | 1 +
 kernel-configs/x86_64-config-4.1  | 1 +
 kernel-configs/x86_64-config-4.4  | 1 +
 kernel-configs/x86_64-config-4.7  | 2 +-
 kernel-configs/x86_64-config-4.9  | 2 +-
 17 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel-configs/i386-config-3.10 b/kernel-configs/i386-config-3.10
index 039c3ae..b919604 100644
--- a/kernel-configs/i386-config-3.10
+++ b/kernel-configs/i386-config-3.10
@@ -1,4 +1,5 @@
 # CONFIG_64BIT is not set
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_FHANDLE=y
diff --git a/kernel-configs/i386-config-3.14 b/kernel-configs/i386-config-3.14
index 12a91d8..30da52b 100644
--- a/kernel-configs/i386-config-3.14
+++ b/kernel-configs/i386-config-3.14
@@ -1,4 +1,5 @@
 # CONFIG_64BIT is not set
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_FHANDLE=y
diff --git a/kernel-configs/i386-config-3.3 b/kernel-configs/i386-config-3.3
index d3ebf66..182038e 100644
--- a/kernel-configs/i386-config-3.3
+++ b/kernel-configs/i386-config-3.3
@@ -1,4 +1,5 @@
 CONFIG_EXPERIMENTAL=y
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
diff --git a/kernel-configs/i386-config-3.6 b/kernel-configs/i386-config-3.6
index fcb89ba..b9c85ef 100644
--- a/kernel-configs/i386-config-3.6
+++ b/kernel-configs/i386-config-3.6
@@ -1,4 +1,5 @@
 CONFIG_EXPERIMENTAL=y
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
diff --git a/kernel-configs/i386-config-3.8 b/kernel-configs/i386-config-3.8
index 5ce7488..d0eed3c 100644
--- a/kernel-configs/i386-config-3.8
+++ b/kernel-configs/i386-config-3.8
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_FHANDLE=y
 CONFIG_AUDIT=y
diff --git a/kernel-configs/i386-config-4.1 b/kernel-configs/i386-config-4.1
index fb1e601..120c4ef 100644
--- a/kernel-configs/i386-config-4.1
+++ b/kernel-configs/i386-config-4.1
@@ -1,4 +1,5 @@
 # CONFIG_64BIT is not set
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_FHANDLE=y
diff --git a/kernel-configs/i386-config-4.7 b/kernel-configs/i386-config-4.7
index 4cd4f12..bf31694 100644
--- a/kernel-configs/i386-config-4.7
+++ b/kernel-configs/i386-config-4.7
@@ -1,4 +1,5 @@
 # CONFIG_64BIT is not set
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
diff --git a/kernel-configs/i386-config-4.9 b/kernel-configs/i386-config-4.9
index eb4761d..78b48f1 100644
--- a/kernel-configs/i386-config-4.9
+++ b/kernel-configs/i386-config-4.9
@@ -1,4 +1,5 @@
 # CONFIG_64BIT is not set
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
diff --git a/kernel-configs/x86_64-config-3.10 b/kernel-configs/x86_64-config-3.10
index ce8b014..441acf3 100644
--- a/kernel-configs/x86_64-config-3.10
+++ b/kernel-configs/x86_64-config-3.10
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_FHANDLE=y
diff --git a/kernel-configs/x86_64-config-3.14 b/kernel-configs/x86_64-config-3.14
index be87d1a..56d0a42 100644
--- a/kernel-configs/x86_64-config-3.14
+++ b/kernel-configs/x86_64-config-3.14
@@ -1,4 +1,4 @@
-CONFIG_LOCALVERSION="-ext4"
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_FHANDLE=y
diff --git a/kernel-configs/x86_64-config-3.18 b/kernel-configs/x86_64-config-3.18
index 94e96f4..746c873 100644
--- a/kernel-configs/x86_64-config-3.18
+++ b/kernel-configs/x86_64-config-3.18
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_FHANDLE=y
diff --git a/kernel-configs/x86_64-config-3.2 b/kernel-configs/x86_64-config-3.2
index 50dc9d8..146af1e 100644
--- a/kernel-configs/x86_64-config-3.2
+++ b/kernel-configs/x86_64-config-3.2
@@ -1,4 +1,5 @@
 CONFIG_EXPERIMENTAL=y
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
diff --git a/kernel-configs/x86_64-config-3.4 b/kernel-configs/x86_64-config-3.4
index 0563e33..6bd8e19 100644
--- a/kernel-configs/x86_64-config-3.4
+++ b/kernel-configs/x86_64-config-3.4
@@ -1,4 +1,5 @@
 CONFIG_EXPERIMENTAL=y
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
diff --git a/kernel-configs/x86_64-config-4.1 b/kernel-configs/x86_64-config-4.1
index d5e0825..ec73222 100644
--- a/kernel-configs/x86_64-config-4.1
+++ b/kernel-configs/x86_64-config-4.1
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_FHANDLE=y
diff --git a/kernel-configs/x86_64-config-4.4 b/kernel-configs/x86_64-config-4.4
index cf09247..bdf4087 100644
--- a/kernel-configs/x86_64-config-4.4
+++ b/kernel-configs/x86_64-config-4.4
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_FHANDLE=y
diff --git a/kernel-configs/x86_64-config-4.7 b/kernel-configs/x86_64-config-4.7
index 40f626a..eb4a51f 100644
--- a/kernel-configs/x86_64-config-4.7
+++ b/kernel-configs/x86_64-config-4.7
@@ -1,4 +1,4 @@
-CONFIG_LOCALVERSION="-ext4"
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
diff --git a/kernel-configs/x86_64-config-4.9 b/kernel-configs/x86_64-config-4.9
index a977f51..0937576 100644
--- a/kernel-configs/x86_64-config-4.9
+++ b/kernel-configs/x86_64-config-4.9
@@ -1,4 +1,4 @@
-CONFIG_LOCALVERSION="-ext4"
+CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
-- 
2.13.0.303.g4ebf302169-goog

