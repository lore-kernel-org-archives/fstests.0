Received: from mail-pf0-f194.google.com ([209.85.192.194]:34136 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033442AbdEYT0p (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 May 2017 15:26:45 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so41050315pfk.1
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 12:26:45 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 0/7] xfstests-bld: get-all improvements and adding keyctl
Date: Thu, 25 May 2017 12:25:42 -0700
Message-Id: <20170525192549.138518-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Patches 1-6 make some improvements to how the xfstests-bld system
handles external git repositories --- especially, making sure the build
system recognizes changes made to the config file.

Patch 7 adds support for optionally including keyctl (used by the
filesystem encryption tests) in the xfstests tarball built by
xfstests-bld.  As noted, this usually isn't needed, but it can be useful
if the tarball is used "on its own", without being contained in a
dedicated test appliance.

Eric Biggers (7):
  get-all: use helper function to clone repositories
  get-all: check out correct commits in already-cloned repositories
  get-all: fail if optional repositories have been deconfigured
  Makefile: always run get-all
  do-all, get-all: run with 'set -e'
  Makefile: check whether xfsprogs-dev exists before cleaning it
  xfstests-bld: optionally build keyctl

 .gitignore                         |   1 +
 Documentation/building-xfstests.md |  36 ++++----
 Makefile                           |  24 ++---
 build-all                          |  28 +++++-
 config                             |   5 ++
 do-all                             |   2 +
 get-all                            | 173 +++++++++++++++++++++----------------
 7 files changed, 164 insertions(+), 105 deletions(-)

-- 
2.13.0.219.gdb65acc882-goog

