Received: from mail-pf0-f193.google.com ([209.85.192.193]:35753 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdHGTz1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Aug 2017 15:55:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id j68so1294959pfc.2
        for <fstests@vger.kernel.org>; Mon, 07 Aug 2017 12:55:27 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 0/4] xfstests-bld: improvements to building test appliances
Date: Mon,  7 Aug 2017 12:52:53 -0700
Message-Id: <20170807195257.61176-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Hi Ted,

This patch series adds a 'setup-buildchroot' script to xfstests-bld to
make it easy to set up a (possibly foreign) build chroot for building
the test appliances for kvm-xfstests and android-xfstests.  It also
changes the default from static linking to dynamic linking, adds a
 --chroot option to the do-all script, and brings the documentation for
building the xfstests.tar.gz and the test appliances up to date.

Eric Biggers (4):
  xfstests-bld: allow overriding chroot for do-all
  xfstests-bld: add a 'setup-buildchroot' script
  xfstests-bld: update documentation for building xfstests and
    appliances
  xfstests-bld: build dynamically linked binaries by default

 Documentation/android-xfstests.md  |   6 +-
 Documentation/building-rootfs.md   |  72 ++++-
 Documentation/building-xfstests.md | 227 ++++++---------
 Documentation/kvm-xfstests.md      |   7 +-
 config                             |  21 +-
 do-all                             | 113 ++++++--
 do-update                          |  11 +-
 setup-buildchroot                  | 545 +++++++++++++++++++++++++++++++++++++
 8 files changed, 804 insertions(+), 198 deletions(-)
 create mode 100755 setup-buildchroot

-- 
2.14.0.rc1.383.gd1ce394fe2-goog

