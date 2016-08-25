Received: from aserp1040.oracle.com ([141.146.126.69]:47521 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbcHYXar (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Aug 2016 19:30:47 -0400
Subject: [PATCH v8 00/13] xfstests: fixes and new tests for
 rmap/reflink/fsmap
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 25 Aug 2016 16:28:19 -0700
Message-ID: <147216769914.32641.55434969009554013.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Hi all,

This is the eighth revision of a patchset that adds to XFS kernel
support for mapping multiple file logical blocks to the same physical
block (reflink/deduplication), implements the beginnings of online
metadata scrubbing and preening, and implements reverse mapping for
the realtime device.  There shouldn't be any incompatible on-disk
format changes, pending a thorough review of the patches within.

The first several patches in this series fix various minor errors in a
variety of existing tests.  The biggest change fixes xfs_db usage to
work when an external log is specified.

The new tests in this series ensure that xfs_fsr works with files
having a high extent count and reverse mapping enabled.  Next come
more tests for the existing XFS rmap functionality, tests for the
realtime rmap patches against XFS, some quick sanity checks for the
proposed GETFSMAP ioctl, and tests of shared extent reporting via
GETBMAPX.

If you're going to start using this mess, you probably ought to just
pull from my github trees for kernel[1], xfsprogs[2], xfstests[3],
xfs-docs[4], and man-pages[5].  The kernel patches in the git trees
should apply to 4.8-rc3; xfsprogs patches to for-next; and xfstest to
master.

The patches have been xfstested with x64, ppc64, and armhf; all tests
in the clone and rmap groups pass.  AFAICT they don't cause any new
failures for the 'auto' group.

This is an extraordinary way to eat your data.  Enjoy! 
Comments and questions are, as always, welcome.

--D

[1] https://github.com/djwong/linux/tree/djwong-devel
[2] https://github.com/djwong/xfsprogs/tree/djwong-devel
[3] https://github.com/djwong/xfstests/tree/djwong-devel
[4] https://github.com/djwong/xfs-documentation/tree/djwong-devel
[5] https://github.com/djwong/man-pages/tree/djwong-devel
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH v8 00/13] xfstests: fixes and new tests for rmap/reflink/etc

Hi all,

This is the eighth revision of a patchset that adds to xfstests
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
pull from my github trees for kernel[1], xfsprogs[2], xfstests[3], and
documentation[4].  The kernel patches should apply to 4.8-rc3;
xfsprogs patches to for-next; and xfstest to master.

The patches have been xfstested with x64, i386, armv7l, and ppc64.
AFAICT these don't cause any new failures for the 'auto' group.

This is an extraordinary way to eat your data.  Enjoy! 
Comments and questions are, as always, welcome.

--D

[1] https://github.com/djwong/linux/tree/djwong-experimental
[2] https://github.com/djwong/xfsprogs/tree/djwong-experimental
[3] https://github.com/djwong/xfstests/tree/djwong-devel
[4] https://github.com/djwong/xfs-documentation/tree/djwong-devel
