Received: from mail.kernel.org ([198.145.29.99]:50236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfFRAH4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 17 Jun 2019 20:07:56 -0400
From: Eric Biggers <ebiggers@kernel.org>
Subject: [xfstests-bld PATCH] kernel-configs: add CONFIG_PCI to 4.19 configs
Date: Mon, 17 Jun 2019 17:07:21 -0700
Message-Id: <20190618000721.138057-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Satya Tangirala <satyat@google.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

On v5.0+, CONFIG_PCI is default 'n', so it must be explicitly selected;
otherwise the kvm-xfstests VM doesn't boot.  It's expected that the 4.19
configs work on later kernels too (up until whatever becomes the next
LTS release), so add CONFIG_PCI=y to them.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kernel-configs/i386-config-4.19   | 3 ++-
 kernel-configs/x86_64-config-4.19 | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel-configs/i386-config-4.19 b/kernel-configs/i386-config-4.19
index 1e7e54a..c0ab1b7 100644
--- a/kernel-configs/i386-config-4.19
+++ b/kernel-configs/i386-config-4.19
@@ -25,7 +25,6 @@ CONFIG_KEXEC=y
 # CONFIG_SUSPEND is not set
 # CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
 # CONFIG_ACPI_TABLE_UPGRADE is not set
-CONFIG_PCI_MSI=y
 # CONFIG_DMIID is not set
 CONFIG_JUMP_LABEL=y
 CONFIG_REFCOUNT_FULL=y
@@ -47,6 +46,8 @@ CONFIG_NETLINK_DIAG=y
 # CONFIG_WIRELESS is not set
 CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
 CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK2MTD=y
diff --git a/kernel-configs/x86_64-config-4.19 b/kernel-configs/x86_64-config-4.19
index 4c5d4ce..e0d2159 100644
--- a/kernel-configs/x86_64-config-4.19
+++ b/kernel-configs/x86_64-config-4.19
@@ -31,7 +31,6 @@ CONFIG_KEXEC=y
 # CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
 # CONFIG_ACPI_TABLE_UPGRADE is not set
 # CONFIG_PCI_MMCONFIG is not set
-CONFIG_PCI_MSI=y
 CONFIG_IA32_EMULATION=y
 # CONFIG_DMIID is not set
 CONFIG_JUMP_LABEL=y
@@ -54,6 +53,8 @@ CONFIG_NETLINK_DIAG=y
 # CONFIG_WIRELESS is not set
 CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
 CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK2MTD=y
-- 
2.22.0.410.gd8fdbe21b5-goog
