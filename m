Received: from imap.thunk.org ([74.207.234.97]:34152 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997AbcBVE0U (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 21 Feb 2016 23:26:20 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/4] Remaining patches to fix up tmpfs testing
Date: Sun, 21 Feb 2016 23:26:07 -0500
Message-Id: <1456115171-13191-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

These commits had some outstanding review comments, which have been
addressed in this patch series.

Hugh Dickins (1):
  xfstests: remove dependency on /proc/partitions for generic/312

Theodore Ts'o (3):
  generic: add _require_odirect for generic/125
  defrag: require extents support for ext4 defrag
  common: filter warning messages from mkfs.ext4

 common/defrag       | 4 +++-
 common/rc           | 2 +-
 tests/generic/125   | 1 +
 tests/generic/312   | 5 -----
 tests/generic/group | 2 +-
 5 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.5.0

