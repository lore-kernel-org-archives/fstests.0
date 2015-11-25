Received: from mx1.redhat.com ([209.132.183.28]:53550 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303AbbKYUTw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Nov 2015 15:19:52 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH 0/2] xfstests: xfsprogs logformat tests
Date: Wed, 25 Nov 2015 15:19:48 -0500
Message-Id: <1448482790-44469-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Hi all,

Here are a couple prospective tests that use the recently posted xfs_db
logformat command:

  http://oss.sgi.com/pipermail/xfs/2015-November/045139.html

Note that these should not be merged until xfs_db logformat support is
fully reviewed and merged into xfsprogs. Also note that the test numbers
are arbitrarily high and should be renumbered.

Patch 1 adds a test that uses xfs_logprint to verify that logformat
formats the log correctly with various stripe unit alignments. Patch 2
uses the logformat command to test invalid metadata LSN detection and
recovery. Thoughts, reviews, flames appreciated.

Brian

Brian Foster (2):
  tests/xfs: test xfsprogs log formatting infrastructure
  tests/xfs: verify invalid metadata LSN detection

 common/rc         | 14 +++++++++
 tests/xfs/376     | 71 +++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/376.out |  6 ++++
 tests/xfs/377     | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/377.out |  3 ++
 tests/xfs/group   |  2 ++
 6 files changed, 186 insertions(+)
 create mode 100755 tests/xfs/376
 create mode 100644 tests/xfs/376.out
 create mode 100755 tests/xfs/377
 create mode 100644 tests/xfs/377.out

-- 
2.1.0

