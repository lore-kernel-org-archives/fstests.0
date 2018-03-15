Received: from mx2.suse.de ([195.135.220.15]:54961 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbeCOVzB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 15 Mar 2018 17:55:01 -0400
From: jeffm@suse.com
Subject: [PATCH 0/4] fstests: GDBM detection cleanup
Date: Thu, 15 Mar 2018 17:54:51 -0400
Message-Id: <20180315215455.8245-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: xfstests list <fstests@vger.kernel.org>
Cc: Luis Rodriguez <mcgrof@suse.com>, Eryu Guan <eguan@redhat.com>, Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

Commit 2353022 (build: update AC_PACKAGE_WANT_GDBM() and src/dbtest.c
to build) fixed building on newer SUSE systems but broke older ones.  Where
we used to skip building src/dbtest on SLES systems, now we'd fail
to build on SLES11.  The reason was that we were now detecting
ndbm.h but also including gdbm.h, which doesn't work on older systems due
to both defining the datum type.  It turns out that no system needs
gdbm.h at all.

This series cleans up the macros and fixes detection for all systems that
only have /usr/include/ndbm.h.

-Jeff

---

Jeff Mahoney (4):
  build: remove dead AC_PACKAGE_WANT_NDBM macro
  build: AC_PACKAGE_WANT_GDBM, fall back to compat if libgdbm detection
    fails
  build: clean up AC_PACKAGE_WANT_GDBM
  build: fix <ndbm.h> detection in AC_PACKAGE_WANT_GDBM

 m4/package_gdbmdev.m4 | 104 ++++++++++++++++++++++----------------------------
 src/dbtest.c          |   3 --
 2 files changed, 46 insertions(+), 61 deletions(-)

-- 
2.15.1

