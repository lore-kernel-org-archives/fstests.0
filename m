Received: from mail-pg0-f68.google.com ([74.125.83.68]:33082 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdBFVo3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Feb 2017 16:44:29 -0500
Received: by mail-pg0-f68.google.com with SMTP id 194so10092386pgd.0
        for <fstests@vger.kernel.org>; Mon, 06 Feb 2017 13:44:29 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: enable crypto self-tests in kernel configs
Date: Mon,  6 Feb 2017 13:42:37 -0800
Message-Id: <20170206214237.8838-5-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

It can be useful to enable crypto self-tests by setting
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n.  This makes the crypto API test
each algorithm against its test vectors before it is used.  Otherwise,
there could be undetected bugs or incompatibilities in the algorithms
--- which would be especially problematic for filesystem encryption.
Note that the crypto self-tests are quite fast and only happen for a
given algorithm when someone first requests that algorithm.

I updated all configs for kernels 3.18 and later, excluding 4.2 which
I've proposed removing, and regenerated the configs for the latest
upstream stable version of each.  I didn't bother with pre-3.18 kernels.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kernel-configs/ext4-i386-config-4.1    |  6 +++---
 kernel-configs/ext4-i386-config-4.7    |  7 ++++---
 kernel-configs/ext4-i386-config-4.9    |  6 ++----
 kernel-configs/ext4-x86_64-config-3.18 |  4 ++--
 kernel-configs/ext4-x86_64-config-4.1  |  4 ++--
 kernel-configs/ext4-x86_64-config-4.4  |  4 ++--
 kernel-configs/ext4-x86_64-config-4.7  | 10 +++++++---
 kernel-configs/ext4-x86_64-config-4.9  |  5 ++---
 8 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/kernel-configs/ext4-i386-config-4.1 b/kernel-configs/ext4-i386-config-4.1
index ab95abd..c5e078e 100644
--- a/kernel-configs/ext4-i386-config-4.1
+++ b/kernel-configs/ext4-i386-config-4.1
@@ -1,6 +1,6 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux/i386 4.1.0-rc4 Kernel Configuration
+# Linux/x86 4.1.38 Kernel Configuration
 #
 # CONFIG_64BIT is not set
 CONFIG_X86_32=y
@@ -650,6 +650,7 @@ CONFIG_PCIEASPM_DEFAULT=y
 # CONFIG_PCIEASPM_POWERSAVE is not set
 # CONFIG_PCIEASPM_PERFORMANCE is not set
 CONFIG_PCIE_PME=y
+CONFIG_PCI_BUS_ADDR_T_64BIT=y
 CONFIG_PCI_MSI=y
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
@@ -3364,7 +3365,7 @@ CONFIG_CRYPTO_PCOMP2=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_MANAGER2=y
 # CONFIG_CRYPTO_USER is not set
-CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
 CONFIG_CRYPTO_GF128MUL=y
 CONFIG_CRYPTO_NULL=y
 # CONFIG_CRYPTO_PCRYPT is not set
@@ -3470,7 +3471,6 @@ CONFIG_CRYPTO_DRBG=y
 # CONFIG_CRYPTO_USER_API_HASH is not set
 # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
 # CONFIG_CRYPTO_USER_API_RNG is not set
-# CONFIG_CRYPTO_USER_API_AEAD is not set
 CONFIG_CRYPTO_HW=y
 CONFIG_CRYPTO_DEV_PADLOCK=y
 # CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
diff --git a/kernel-configs/ext4-i386-config-4.7 b/kernel-configs/ext4-i386-config-4.7
index 7bb998e..3cec444 100644
--- a/kernel-configs/ext4-i386-config-4.7
+++ b/kernel-configs/ext4-i386-config-4.7
@@ -1,6 +1,6 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux/i386 4.7.0-rc1 Kernel Configuration
+# Linux/x86 4.7.10 Kernel Configuration
 #
 # CONFIG_64BIT is not set
 CONFIG_X86_32=y
@@ -282,6 +282,7 @@ CONFIG_HAVE_EXIT_THREAD=y
 CONFIG_ARCH_MMAP_RND_BITS=8
 CONFIG_HAVE_COPY_THREAD_TLS=y
 # CONFIG_HAVE_ARCH_HASH is not set
+CONFIG_ISA_BUS_API=y
 CONFIG_CLONE_BACKWARDS=y
 CONFIG_OLD_SIGSUSPEND3=y
 CONFIG_OLD_SIGACTION=y
@@ -1943,7 +1944,6 @@ CONFIG_VT_CONSOLE_SLEEP=y
 CONFIG_HW_CONSOLE=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_UNIX98_PTYS=y
-# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 CONFIG_SERIAL_NONSTANDARD=y
@@ -3503,6 +3503,7 @@ CONFIG_TRACING_EVENTS_GPIO=y
 # CONFIG_TEST_KSTRTOX is not set
 # CONFIG_TEST_PRINTF is not set
 # CONFIG_TEST_BITMAP is not set
+# CONFIG_TEST_UUID is not set
 # CONFIG_TEST_RHASHTABLE is not set
 # CONFIG_TEST_HASH is not set
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
@@ -3603,7 +3604,7 @@ CONFIG_CRYPTO_AKCIPHER2=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_MANAGER2=y
 # CONFIG_CRYPTO_USER is not set
-CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
 CONFIG_CRYPTO_GF128MUL=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_NULL2=y
diff --git a/kernel-configs/ext4-i386-config-4.9 b/kernel-configs/ext4-i386-config-4.9
index 9ddedf6..d3065fb 100644
--- a/kernel-configs/ext4-i386-config-4.9
+++ b/kernel-configs/ext4-i386-config-4.9
@@ -1,6 +1,6 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux/i386 4.9.0-rc1 Kernel Configuration
+# Linux/x86 4.9.8 Kernel Configuration
 #
 # CONFIG_64BIT is not set
 CONFIG_X86_32=y
@@ -1066,7 +1066,6 @@ CONFIG_DMA_SHARED_BUFFER=y
 #
 # Bus devices
 #
-# CONFIG_QCOM_EBI2 is not set
 # CONFIG_CONNECTOR is not set
 # CONFIG_MTD is not set
 # CONFIG_OF is not set
@@ -1952,7 +1951,6 @@ CONFIG_PTP_1588_CLOCK=y
 #
 # CONFIG_PTP_1588_CLOCK_PCH is not set
 CONFIG_GPIOLIB=y
-CONFIG_GPIO_DEVRES=y
 CONFIG_GPIO_ACPI=y
 # CONFIG_DEBUG_GPIO is not set
 # CONFIG_GPIO_SYSFS is not set
@@ -3389,7 +3387,7 @@ CONFIG_CRYPTO_KPP2=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_MANAGER2=y
 # CONFIG_CRYPTO_USER is not set
-CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
 CONFIG_CRYPTO_GF128MUL=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_NULL2=y
diff --git a/kernel-configs/ext4-x86_64-config-3.18 b/kernel-configs/ext4-x86_64-config-3.18
index 715e3c1..ddf7778 100644
--- a/kernel-configs/ext4-x86_64-config-3.18
+++ b/kernel-configs/ext4-x86_64-config-3.18
@@ -1,6 +1,6 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux/x86_64 3.18.36 Kernel Configuration
+# Linux/x86 3.18.47 Kernel Configuration
 #
 CONFIG_64BIT=y
 CONFIG_X86_64=y
@@ -2028,7 +2028,7 @@ CONFIG_CRYPTO_PCOMP2=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_MANAGER2=y
 CONFIG_CRYPTO_USER=y
-CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
 CONFIG_CRYPTO_GF128MUL=y
 CONFIG_CRYPTO_NULL=y
 # CONFIG_CRYPTO_PCRYPT is not set
diff --git a/kernel-configs/ext4-x86_64-config-4.1 b/kernel-configs/ext4-x86_64-config-4.1
index 46ebb30..04666ed 100644
--- a/kernel-configs/ext4-x86_64-config-4.1
+++ b/kernel-configs/ext4-x86_64-config-4.1
@@ -1,6 +1,6 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux/x86_64 4.1.27 Kernel Configuration
+# Linux/x86 4.1.38 Kernel Configuration
 #
 CONFIG_64BIT=y
 CONFIG_X86_64=y
@@ -2051,7 +2051,7 @@ CONFIG_CRYPTO_PCOMP2=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_MANAGER2=y
 CONFIG_CRYPTO_USER=y
-CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
 CONFIG_CRYPTO_GF128MUL=y
 CONFIG_CRYPTO_NULL=y
 # CONFIG_CRYPTO_PCRYPT is not set
diff --git a/kernel-configs/ext4-x86_64-config-4.4 b/kernel-configs/ext4-x86_64-config-4.4
index a8fe011..00c64d3 100644
--- a/kernel-configs/ext4-x86_64-config-4.4
+++ b/kernel-configs/ext4-x86_64-config-4.4
@@ -1,6 +1,6 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux/x86_64 4.4.14 Kernel Configuration
+# Linux/x86 4.4.47 Kernel Configuration
 #
 CONFIG_64BIT=y
 CONFIG_X86_64=y
@@ -2133,7 +2133,7 @@ CONFIG_CRYPTO_AKCIPHER=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_MANAGER2=y
 CONFIG_CRYPTO_USER=y
-CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
 CONFIG_CRYPTO_GF128MUL=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_NULL2=y
diff --git a/kernel-configs/ext4-x86_64-config-4.7 b/kernel-configs/ext4-x86_64-config-4.7
index 2e26ae6..89994ad 100644
--- a/kernel-configs/ext4-x86_64-config-4.7
+++ b/kernel-configs/ext4-x86_64-config-4.7
@@ -1,6 +1,6 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux/x86_64 4.7.0-rc1 Kernel Configuration
+# Linux/x86 4.7.10 Kernel Configuration
 #
 CONFIG_64BIT=y
 CONFIG_X86_64=y
@@ -292,6 +292,7 @@ CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
 CONFIG_HAVE_COPY_THREAD_TLS=y
 CONFIG_HAVE_STACK_VALIDATION=y
 # CONFIG_HAVE_ARCH_HASH is not set
+# CONFIG_ISA_BUS_API is not set
 CONFIG_OLD_SIGSUSPEND3=y
 CONFIG_COMPAT_OLD_SIGACTION=y
 # CONFIG_CPU_NO_EFFICIENT_FFS is not set
@@ -756,6 +757,8 @@ CONFIG_IPV6_SIT=y
 CONFIG_IPV6_NDISC_NODETYPE=y
 CONFIG_IPV6_TUNNEL=y
 # CONFIG_IPV6_GRE is not set
+CONFIG_IPV6_FOU=y
+# CONFIG_IPV6_FOU_TUNNEL is not set
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
 # CONFIG_IPV6_MROUTE is not set
@@ -1347,7 +1350,6 @@ CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_UNIX98_PTYS=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_SERIAL_NONSTANDARD is not set
@@ -2144,6 +2146,7 @@ CONFIG_FTRACE_MCOUNT_RECORD=y
 # CONFIG_TEST_KSTRTOX is not set
 # CONFIG_TEST_PRINTF is not set
 # CONFIG_TEST_BITMAP is not set
+# CONFIG_TEST_UUID is not set
 # CONFIG_TEST_RHASHTABLE is not set
 # CONFIG_TEST_HASH is not set
 # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
@@ -2237,11 +2240,12 @@ CONFIG_CRYPTO_RNG=y
 CONFIG_CRYPTO_RNG2=y
 CONFIG_CRYPTO_RNG_DEFAULT=y
 CONFIG_CRYPTO_AKCIPHER2=y
+CONFIG_CRYPTO_AKCIPHER=y
 # CONFIG_CRYPTO_RSA is not set
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_MANAGER2=y
 CONFIG_CRYPTO_USER=y
-CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
 CONFIG_CRYPTO_GF128MUL=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_NULL2=y
diff --git a/kernel-configs/ext4-x86_64-config-4.9 b/kernel-configs/ext4-x86_64-config-4.9
index 02f99bf..a6e3710 100644
--- a/kernel-configs/ext4-x86_64-config-4.9
+++ b/kernel-configs/ext4-x86_64-config-4.9
@@ -1,6 +1,6 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux/x86_64 4.9.0-rc1 Kernel Configuration
+# Linux/x86 4.9.8 Kernel Configuration
 #
 CONFIG_64BIT=y
 CONFIG_X86_64=y
@@ -884,7 +884,6 @@ CONFIG_GENERIC_CPU_AUTOPROBE=y
 #
 # Bus devices
 #
-# CONFIG_QCOM_EBI2 is not set
 CONFIG_CONNECTOR=y
 CONFIG_PROC_EVENTS=y
 # CONFIG_MTD is not set
@@ -2288,7 +2287,7 @@ CONFIG_CRYPTO_KPP2=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_MANAGER2=y
 CONFIG_CRYPTO_USER=y
-CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
 CONFIG_CRYPTO_GF128MUL=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_NULL2=y
-- 
2.11.0.483.g087da7b7c-goog

