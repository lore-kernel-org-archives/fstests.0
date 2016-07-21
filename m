Received: from userp1040.oracle.com ([156.151.31.81]:29439 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbcGUXq1 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 19:46:27 -0400
Subject: [PATCH v7 00/17] xfstests: fixes and new tests for rmap/reflink/etc
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 21 Jul 2016 16:46:15 -0700
Message-ID: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Hi all,

This is the seventh revision of a patchset that adds to xfstests
support for testing reverse-mappings of physical blocks to file and
metadata (rmap); support for testing multiple file logical blocks to
the same physical block (reflink); and implements the beginnings of
online metadata scrubbing.

The first eleven tests fix various bugs in existing reflink and rmap
tests, most of which were a result of not using helpers when I should
have.

After that, there are new tests to make sure that we can't clone_range
across mountpoints; test to make sure that swapext works with many
extents on a rmap filesystem; and tests for realtime reverse-mapping.
There are also revised patches for testing xfs_repair's ability to
rebuild filesystem indices correctly, and to run xfs_scrub during each
test.

If you're going to start using this mess, you probably ought to just
pull from my github trees for kernel[1], xfsprogs[2], and xfstests[3].
There are also updates for xfs-docs[4].  The kernel patches should
apply to dchinner's for-next; xfsprogs patches to for-next; and
xfstest to master.  The kernel git tree already has for-next included.

The patches have been xfstested with x64, i386, armv7l, and ppc64.
AFAICT these don't cause any new failures for the 'auto' group.

This is an extraordinary way to eat your data.  Enjoy! 
Comments and questions are, as always, welcome.

--D

[1] https://github.com/djwong/linux/tree/djwong-experimental
[2] https://github.com/djwong/xfsprogs/tree/djwong-experimental
[3] https://github.com/djwong/xfstests/tree/djwong-devel
[4] https://github.com/djwong/xfs-documentation/tree/djwong-devel
