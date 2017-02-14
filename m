Received: from imap.thunk.org ([74.207.234.97]:36760 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbdBNAzx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 13 Feb 2017 19:55:53 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/4] test multi-level bind and shared subtree mounts
Date: Mon, 13 Feb 2017 19:55:41 -0500
Message-Id: <20170214005545.29373-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

This is a respon if of Zorro Lang's patch set from May 20, 2016.  I've
reviewed them, and tested them against a recent development kernel.

The two main changes which I made to Zorro's patches:

  * I changed the numbers to the most recent unallocated test numbers
  * I added code to delete the test files in the end_test function

Zorro Lang (4):
  common/rc: new functions for multi-level mount/umount operations
  generic: new case for test mount bind operation
  generic: new case for test mount shared subtrees state transition
  generic: new case test two vfsmount no peers

 common/rc             |  31 ++
 tests/generic/409     | 182 +++++++++++
 tests/generic/409.out | 365 ++++++++++++++++++++++
 tests/generic/410     | 215 +++++++++++++
 tests/generic/410.out | 813 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/411     | 147 +++++++++
 tests/generic/411.out |  12 +
 tests/generic/group   |   3 +
 8 files changed, 1768 insertions(+)
 create mode 100644 tests/generic/409
 create mode 100644 tests/generic/409.out
 create mode 100644 tests/generic/410
 create mode 100644 tests/generic/410.out
 create mode 100644 tests/generic/411
 create mode 100644 tests/generic/411.out

-- 
2.11.0.rc0.7.gbe5a750

