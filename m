Received: from mail-pf0-f196.google.com ([209.85.192.196]:35109 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbdEQXet (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 19:34:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so3476284pfd.2
        for <fstests@vger.kernel.org>; Wed, 17 May 2017 16:34:49 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 0/5] xfstests-bld: improvements to recommended kernel configs
Date: Wed, 17 May 2017 16:32:28 -0700
Message-Id: <20170517233233.61244-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

This patch series switches the recommended kernel configs for kvm-xfstests and
gce-xfstests to "defconfig" format so they can be more easily maintained, then
eliminates ext4-specific stuff and enables the f2fs and ubifs filesystems.

Eric Biggers (5):
  kernel-configs: switch to using defconfigs
  kernel-configs: remove ext4- prefix from kernel-configs
  kernel-configs: use CONFIG_LOCALVERSION="-xfstests"
  kernel-configs: enable f2fs support
  kernel-configs: enable ubifs support

 Documentation/kvm-quickstart.md        |    5 +-
 Documentation/kvm-xfstests.md          |   15 +-
 kernel-configs/ext4-i386-config-3.10   | 3791 ------------------------------
 kernel-configs/ext4-i386-config-3.14   | 3961 --------------------------------
 kernel-configs/ext4-i386-config-3.3    | 3404 ---------------------------
 kernel-configs/ext4-i386-config-3.6    | 3686 -----------------------------
 kernel-configs/ext4-i386-config-3.8    | 3763 ------------------------------
 kernel-configs/ext4-i386-config-4.1    | 3572 ----------------------------
 kernel-configs/ext4-i386-config-4.7    | 3834 -------------------------------
 kernel-configs/ext4-i386-config-4.9    | 3617 -----------------------------
 kernel-configs/ext4-x86_64-config-3.10 | 2032 ----------------
 kernel-configs/ext4-x86_64-config-3.14 | 2141 -----------------
 kernel-configs/ext4-x86_64-config-3.18 | 2235 ------------------
 kernel-configs/ext4-x86_64-config-3.2  | 3303 --------------------------
 kernel-configs/ext4-x86_64-config-3.4  | 3409 ---------------------------
 kernel-configs/ext4-x86_64-config-4.1  | 2262 ------------------
 kernel-configs/ext4-x86_64-config-4.4  | 2363 -------------------
 kernel-configs/ext4-x86_64-config-4.7  | 2479 --------------------
 kernel-configs/ext4-x86_64-config-4.9  | 2526 --------------------
 kernel-configs/i386-config-3.10        |  381 +++
 kernel-configs/i386-config-3.14        |  403 ++++
 kernel-configs/i386-config-3.3         |  373 +++
 kernel-configs/i386-config-3.6         |  373 +++
 kernel-configs/i386-config-3.8         |  351 +++
 kernel-configs/i386-config-4.1         |  344 +++
 kernel-configs/i386-config-4.7         |  367 +++
 kernel-configs/i386-config-4.9         |  350 +++
 kernel-configs/x86_64-config-3.10      |  339 +++
 kernel-configs/x86_64-config-3.14      |  351 +++
 kernel-configs/x86_64-config-3.18      |  352 +++
 kernel-configs/x86_64-config-3.2       |  373 +++
 kernel-configs/x86_64-config-3.4       |  374 +++
 kernel-configs/x86_64-config-4.1       |  354 +++
 kernel-configs/x86_64-config-4.4       |  370 +++
 kernel-configs/x86_64-config-4.7       |  371 +++
 kernel-configs/x86_64-config-4.9       |  371 +++
 36 files changed, 6209 insertions(+), 52386 deletions(-)
 delete mode 100644 kernel-configs/ext4-i386-config-3.10
 delete mode 100644 kernel-configs/ext4-i386-config-3.14
 delete mode 100644 kernel-configs/ext4-i386-config-3.3
 delete mode 100644 kernel-configs/ext4-i386-config-3.6
 delete mode 100644 kernel-configs/ext4-i386-config-3.8
 delete mode 100644 kernel-configs/ext4-i386-config-4.1
 delete mode 100644 kernel-configs/ext4-i386-config-4.7
 delete mode 100644 kernel-configs/ext4-i386-config-4.9
 delete mode 100644 kernel-configs/ext4-x86_64-config-3.10
 delete mode 100644 kernel-configs/ext4-x86_64-config-3.14
 delete mode 100644 kernel-configs/ext4-x86_64-config-3.18
 delete mode 100644 kernel-configs/ext4-x86_64-config-3.2
 delete mode 100644 kernel-configs/ext4-x86_64-config-3.4
 delete mode 100644 kernel-configs/ext4-x86_64-config-4.1
 delete mode 100644 kernel-configs/ext4-x86_64-config-4.4
 delete mode 100644 kernel-configs/ext4-x86_64-config-4.7
 delete mode 100644 kernel-configs/ext4-x86_64-config-4.9
 create mode 100644 kernel-configs/i386-config-3.10
 create mode 100644 kernel-configs/i386-config-3.14
 create mode 100644 kernel-configs/i386-config-3.3
 create mode 100644 kernel-configs/i386-config-3.6
 create mode 100644 kernel-configs/i386-config-3.8
 create mode 100644 kernel-configs/i386-config-4.1
 create mode 100644 kernel-configs/i386-config-4.7
 create mode 100644 kernel-configs/i386-config-4.9
 create mode 100644 kernel-configs/x86_64-config-3.10
 create mode 100644 kernel-configs/x86_64-config-3.14
 create mode 100644 kernel-configs/x86_64-config-3.18
 create mode 100644 kernel-configs/x86_64-config-3.2
 create mode 100644 kernel-configs/x86_64-config-3.4
 create mode 100644 kernel-configs/x86_64-config-4.1
 create mode 100644 kernel-configs/x86_64-config-4.4
 create mode 100644 kernel-configs/x86_64-config-4.7
 create mode 100644 kernel-configs/x86_64-config-4.9

-- 
2.13.0.303.g4ebf302169-goog

