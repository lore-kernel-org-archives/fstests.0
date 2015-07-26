Received: from imap.thunk.org ([74.207.234.97]:37890 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbbGZMVI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 26 Jul 2015 08:21:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/6] Add cross-compilation support for android
Date: Sun, 26 Jul 2015 08:20:49 -0400
Message-Id: <1437913255-7524-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: xfs@oss.sgi.com
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

As part of my efforts to port xfstests so it can be used in an Android
runtime environment (where running fsstress by hand seems to be the
state-of-the-art in file system QA), I needed to make the following
changes to xfsprogs so it can be built using cross compilation using
Android's bionic C library.  Fortunately given XFS's Irix roots, the
number of glibc'isms that have kept in was relatively small.


Theodore Ts'o (6):
  xfsprogs: define NBBY if not defined by the system header files
  xfsprogs: pull in libgen.h to get prototype for basename()
  xfsprogs: define and use BUILD_CC in configure.ac for cross
    compilation
  xfsprogs: avoid use of si_tid in struct xlog_split_item
  xfsprogs: use "unsigned short" instead of ushort
  xfsprogs: add missing include of <stat.h>

 configure.ac               | 8 ++++++++
 include/builddefs.in       | 1 +
 include/platform_defs.h.in | 5 +++++
 include/xfs_inode_buf.h    | 4 ++--
 include/xfs_log_format.h   | 4 ++--
 include/xfs_log_recover.h  | 2 +-
 libdisk/evms.c             | 1 +
 libxfs/Makefile            | 4 ++--
 libxfs/logitem.c           | 2 +-
 libxfs/xfs_ialloc.c        | 4 ++--
 logprint/log_misc.c        | 8 ++++----
 11 files changed, 29 insertions(+), 14 deletions(-)

-- 
2.3.0

