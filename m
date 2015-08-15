Received: from aserp1040.oracle.com ([141.146.126.69]:17683 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbbHOBwF (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 14 Aug 2015 21:52:05 -0400
Subject: [PATCH 0/7] xfstests: fuzz ext4 and xfs
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Fri, 14 Aug 2015 18:52:01 -0700
Message-ID: <20150815015200.4333.9278.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, darrick.wong@oracle.com
Cc: linux-ext4@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Hi all,

This is a pile of fuzzing tests for ext4 and XFS filesystems.
Included are general fuzzers that create, populate, and fuzz a scratch
filesystem; and targeted fuzzers that create specific types of
metadata blocks and test the filesystem's reaction to the corruption.

Each fuzzing test has roughly the same structure: First, the scratch
device is formatted and populated with enough files and directories so
that the targeted metadata is created.  Next, the metadata block is
randomly mutated to some arbitrary degree.  Then, the filesystem is
mounted and exercised to see if the kernel will fling error codes back
to userspace without crashing.  After that, the repair tool is invoked
to fix all the damage.  Finally, the filesystem is remounted and
exercised again to ensure that the errors have gone away.

The first patch provides common code that can populate ext4 and XFS
filesystems containing (hopefully) every possible type of metadata
block, and a few other common code bits.

The second patch implements general fuzzers for ext4 and XFS.  A
scratch FS is created and populated with all types of metadata before
fuzzing begins.

The third and fourth patches implement targeted fuzzing for block
group, bitmap, file, extent, and directory metadata in ext4.

Patches 5-7 implement targeted fuzzing for AGs, btrees, file, extent,
and directory metadata in XFS.

I've tested these xfstests changes against the master branch as of
8/03.  The reflink tests will be dealt with separately.

The xfs fuzzers require xfsprogs with the August 2015 xfsprogs
patchbomb applied.  The ext4 fuzzers do not require patches if your
e2fsprogs are current.

Scary rewound github repo with everything attached:
https://github.com/djwong/xfstests

and for the xfsprogs patches:
https://github.com/djwong/xfsprogs

Comments and questions are, as always, welcome.

--D
