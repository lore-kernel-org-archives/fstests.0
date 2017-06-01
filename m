Received: from mail-pf0-f195.google.com ([209.85.192.195]:35044 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdFAXgv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Jun 2017 19:36:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so9597620pfd.2
        for <fstests@vger.kernel.org>; Thu, 01 Jun 2017 16:36:50 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v3 0/3] xfstests-bld: update recommended kernel configs
Date: Thu,  1 Jun 2017 16:36:28 -0700
Message-Id: <20170601233631.131510-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

This patchset halves the length of the recommended configs for
kvm-xfstests and gce-xfstests by trimming unnecessary features, while
also enabling some extra debugging options.  It also makes the configs
be more consistent with each other and match LTS kernel versions.

Changed since v2:
	- update all the configs, not just latest x86_64 one
	- leave CONFIG_HW_RANDOM_VIRTIO enabled

Eric Biggers (3):
  kernel-configs: remove configs for non-LTS versions
  kernel-configs: improve recommended x86_64 configs
  kernel-configs: sync i386 configs with x86_64 ones

 kernel-configs/i386-config-3.10   | 392 ++++++++-----------------------------
 kernel-configs/i386-config-3.14   | 400 ++++++++------------------------------
 kernel-configs/i386-config-3.18   | 162 +++++++++++++++
 kernel-configs/i386-config-3.2    | 145 ++++++++++++++
 kernel-configs/i386-config-3.3    | 373 -----------------------------------
 kernel-configs/i386-config-3.4    | 149 ++++++++++++++
 kernel-configs/i386-config-3.6    | 373 -----------------------------------
 kernel-configs/i386-config-3.8    | 351 ---------------------------------
 kernel-configs/i386-config-4.1    | 310 +++++++----------------------
 kernel-configs/i386-config-4.4    | 171 ++++++++++++++++
 kernel-configs/i386-config-4.7    | 367 ----------------------------------
 kernel-configs/i386-config-4.9    | 294 ++++++----------------------
 kernel-configs/x86_64-config-3.10 | 233 +++-------------------
 kernel-configs/x86_64-config-3.14 | 245 +++--------------------
 kernel-configs/x86_64-config-3.18 | 243 +++--------------------
 kernel-configs/x86_64-config-3.2  | 378 ++++++++---------------------------
 kernel-configs/x86_64-config-3.4  | 385 ++++++++----------------------------
 kernel-configs/x86_64-config-4.1  | 245 +++--------------------
 kernel-configs/x86_64-config-4.4  | 249 +++---------------------
 kernel-configs/x86_64-config-4.7  | 371 -----------------------------------
 kernel-configs/x86_64-config-4.9  | 239 +++--------------------
 21 files changed, 1240 insertions(+), 4835 deletions(-)
 create mode 100644 kernel-configs/i386-config-3.18
 create mode 100644 kernel-configs/i386-config-3.2
 delete mode 100644 kernel-configs/i386-config-3.3
 create mode 100644 kernel-configs/i386-config-3.4
 delete mode 100644 kernel-configs/i386-config-3.6
 delete mode 100644 kernel-configs/i386-config-3.8
 create mode 100644 kernel-configs/i386-config-4.4
 delete mode 100644 kernel-configs/i386-config-4.7
 delete mode 100644 kernel-configs/x86_64-config-4.7

-- 
2.13.0.506.g27d5fe0cd-goog

