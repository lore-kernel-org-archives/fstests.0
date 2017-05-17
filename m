Received: from mail-pg0-f68.google.com ([74.125.83.68]:34562 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdEQXe5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 19:34:57 -0400
Received: by mail-pg0-f68.google.com with SMTP id u187so3593876pgb.1
        for <fstests@vger.kernel.org>; Wed, 17 May 2017 16:34:57 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 2/5] kernel-configs: remove ext4- prefix from kernel-configs
Date: Wed, 17 May 2017 16:32:30 -0700
Message-Id: <20170517233233.61244-3-ebiggers3@gmail.com>
In-Reply-To: <20170517233233.61244-1-ebiggers3@gmail.com>
References: <20170517233233.61244-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

The kvm-xfstests/gce-xfstests kernel configs already have multiple
filesystems enabled, and I'd like to enable some more filesystems, so
remove the "ext4-" prefix from the config filenames.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kernel-configs/{ext4-i386-config-3.10 => i386-config-3.10}     | 0
 kernel-configs/{ext4-i386-config-3.14 => i386-config-3.14}     | 0
 kernel-configs/{ext4-i386-config-3.3 => i386-config-3.3}       | 0
 kernel-configs/{ext4-i386-config-3.6 => i386-config-3.6}       | 0
 kernel-configs/{ext4-i386-config-3.8 => i386-config-3.8}       | 0
 kernel-configs/{ext4-i386-config-4.1 => i386-config-4.1}       | 0
 kernel-configs/{ext4-i386-config-4.7 => i386-config-4.7}       | 0
 kernel-configs/{ext4-i386-config-4.9 => i386-config-4.9}       | 0
 kernel-configs/{ext4-x86_64-config-3.10 => x86_64-config-3.10} | 0
 kernel-configs/{ext4-x86_64-config-3.14 => x86_64-config-3.14} | 0
 kernel-configs/{ext4-x86_64-config-3.18 => x86_64-config-3.18} | 0
 kernel-configs/{ext4-x86_64-config-3.2 => x86_64-config-3.2}   | 0
 kernel-configs/{ext4-x86_64-config-3.4 => x86_64-config-3.4}   | 0
 kernel-configs/{ext4-x86_64-config-4.1 => x86_64-config-4.1}   | 0
 kernel-configs/{ext4-x86_64-config-4.4 => x86_64-config-4.4}   | 0
 kernel-configs/{ext4-x86_64-config-4.7 => x86_64-config-4.7}   | 0
 kernel-configs/{ext4-x86_64-config-4.9 => x86_64-config-4.9}   | 0
 17 files changed, 0 insertions(+), 0 deletions(-)
 rename kernel-configs/{ext4-i386-config-3.10 => i386-config-3.10} (100%)
 rename kernel-configs/{ext4-i386-config-3.14 => i386-config-3.14} (100%)
 rename kernel-configs/{ext4-i386-config-3.3 => i386-config-3.3} (100%)
 rename kernel-configs/{ext4-i386-config-3.6 => i386-config-3.6} (100%)
 rename kernel-configs/{ext4-i386-config-3.8 => i386-config-3.8} (100%)
 rename kernel-configs/{ext4-i386-config-4.1 => i386-config-4.1} (100%)
 rename kernel-configs/{ext4-i386-config-4.7 => i386-config-4.7} (100%)
 rename kernel-configs/{ext4-i386-config-4.9 => i386-config-4.9} (100%)
 rename kernel-configs/{ext4-x86_64-config-3.10 => x86_64-config-3.10} (100%)
 rename kernel-configs/{ext4-x86_64-config-3.14 => x86_64-config-3.14} (100%)
 rename kernel-configs/{ext4-x86_64-config-3.18 => x86_64-config-3.18} (100%)
 rename kernel-configs/{ext4-x86_64-config-3.2 => x86_64-config-3.2} (100%)
 rename kernel-configs/{ext4-x86_64-config-3.4 => x86_64-config-3.4} (100%)
 rename kernel-configs/{ext4-x86_64-config-4.1 => x86_64-config-4.1} (100%)
 rename kernel-configs/{ext4-x86_64-config-4.4 => x86_64-config-4.4} (100%)
 rename kernel-configs/{ext4-x86_64-config-4.7 => x86_64-config-4.7} (100%)
 rename kernel-configs/{ext4-x86_64-config-4.9 => x86_64-config-4.9} (100%)

diff --git a/kernel-configs/ext4-i386-config-3.10 b/kernel-configs/i386-config-3.10
similarity index 100%
rename from kernel-configs/ext4-i386-config-3.10
rename to kernel-configs/i386-config-3.10
diff --git a/kernel-configs/ext4-i386-config-3.14 b/kernel-configs/i386-config-3.14
similarity index 100%
rename from kernel-configs/ext4-i386-config-3.14
rename to kernel-configs/i386-config-3.14
diff --git a/kernel-configs/ext4-i386-config-3.3 b/kernel-configs/i386-config-3.3
similarity index 100%
rename from kernel-configs/ext4-i386-config-3.3
rename to kernel-configs/i386-config-3.3
diff --git a/kernel-configs/ext4-i386-config-3.6 b/kernel-configs/i386-config-3.6
similarity index 100%
rename from kernel-configs/ext4-i386-config-3.6
rename to kernel-configs/i386-config-3.6
diff --git a/kernel-configs/ext4-i386-config-3.8 b/kernel-configs/i386-config-3.8
similarity index 100%
rename from kernel-configs/ext4-i386-config-3.8
rename to kernel-configs/i386-config-3.8
diff --git a/kernel-configs/ext4-i386-config-4.1 b/kernel-configs/i386-config-4.1
similarity index 100%
rename from kernel-configs/ext4-i386-config-4.1
rename to kernel-configs/i386-config-4.1
diff --git a/kernel-configs/ext4-i386-config-4.7 b/kernel-configs/i386-config-4.7
similarity index 100%
rename from kernel-configs/ext4-i386-config-4.7
rename to kernel-configs/i386-config-4.7
diff --git a/kernel-configs/ext4-i386-config-4.9 b/kernel-configs/i386-config-4.9
similarity index 100%
rename from kernel-configs/ext4-i386-config-4.9
rename to kernel-configs/i386-config-4.9
diff --git a/kernel-configs/ext4-x86_64-config-3.10 b/kernel-configs/x86_64-config-3.10
similarity index 100%
rename from kernel-configs/ext4-x86_64-config-3.10
rename to kernel-configs/x86_64-config-3.10
diff --git a/kernel-configs/ext4-x86_64-config-3.14 b/kernel-configs/x86_64-config-3.14
similarity index 100%
rename from kernel-configs/ext4-x86_64-config-3.14
rename to kernel-configs/x86_64-config-3.14
diff --git a/kernel-configs/ext4-x86_64-config-3.18 b/kernel-configs/x86_64-config-3.18
similarity index 100%
rename from kernel-configs/ext4-x86_64-config-3.18
rename to kernel-configs/x86_64-config-3.18
diff --git a/kernel-configs/ext4-x86_64-config-3.2 b/kernel-configs/x86_64-config-3.2
similarity index 100%
rename from kernel-configs/ext4-x86_64-config-3.2
rename to kernel-configs/x86_64-config-3.2
diff --git a/kernel-configs/ext4-x86_64-config-3.4 b/kernel-configs/x86_64-config-3.4
similarity index 100%
rename from kernel-configs/ext4-x86_64-config-3.4
rename to kernel-configs/x86_64-config-3.4
diff --git a/kernel-configs/ext4-x86_64-config-4.1 b/kernel-configs/x86_64-config-4.1
similarity index 100%
rename from kernel-configs/ext4-x86_64-config-4.1
rename to kernel-configs/x86_64-config-4.1
diff --git a/kernel-configs/ext4-x86_64-config-4.4 b/kernel-configs/x86_64-config-4.4
similarity index 100%
rename from kernel-configs/ext4-x86_64-config-4.4
rename to kernel-configs/x86_64-config-4.4
diff --git a/kernel-configs/ext4-x86_64-config-4.7 b/kernel-configs/x86_64-config-4.7
similarity index 100%
rename from kernel-configs/ext4-x86_64-config-4.7
rename to kernel-configs/x86_64-config-4.7
diff --git a/kernel-configs/ext4-x86_64-config-4.9 b/kernel-configs/x86_64-config-4.9
similarity index 100%
rename from kernel-configs/ext4-x86_64-config-4.9
rename to kernel-configs/x86_64-config-4.9
-- 
2.13.0.303.g4ebf302169-goog

