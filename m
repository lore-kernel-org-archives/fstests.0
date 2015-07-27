Received: from imap.thunk.org ([74.207.234.97]:46584 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754330AbbG0OWv (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 27 Jul 2015 10:22:51 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/4] xfstests portability fixes for Android
Date: Mon, 27 Jul 2015 10:22:43 -0400
Message-Id: <1438006967-18815-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

As part of my efforts to port xfstests so it can be cross-compiled for
Android (where running fsstress by hand seems to be the
state-of-the-art in file system QA), I had to make the following
portability fixes.

Modulo working around some missing functions in the Bionic libc, I was
pleasantly surprised how few changes were required!

Theodore Ts'o (4):
  xfstests: if DEV_BSIZE is not defined, assume it to be 512
  xfstests: Support C libraries that define SIGCHLD instead of SIGCLD
  xfstests: use the Posix st_mode defines instead of the obsolete SysV
    ones
  xfstests: remove manual declaration of errno

 lib/str_to_bytes.c |  4 ++++
 lib/write_log.c    |  4 ++++
 ltp/doio.c         |  4 ++++
 ltp/growfiles.c    |  6 +++++-
 src/locktest.c     |  1 -
 src/lstat64.c      | 18 +++++++++---------
 6 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.3.0

