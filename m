Received: from mx2.suse.de ([195.135.220.15]:53840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbfDHQIq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 8 Apr 2019 12:08:46 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v3 0/2] Initial CephFS tests
Date: Mon,  8 Apr 2019 17:08:40 +0100
Message-Id: <20190408160842.23649-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Dave Chinner <david@fromorbit.com>, Eryu Guan <guaneryu@gmail.com>, ceph-devel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

This is the first attempt to (finally!) add CephFS specific tests to
fstests.  Hopefully, more will follow once an initial set is accepted -- I
do have a few more that could easily be added, and I'm sure that in the
future more CephFS-specific tests can continue to be developed.  This test
suite has already proved to be quite useful in finding bugs in this
filesystem; adding specific tests for it is just the next logic step.

For now, just two simple tests to do some basic checks on quotas features.

Cheers,
--
Luis

Changes since v2:

- Use 'local' variables in functions
- Use $seqres.full for logging output (and rm -f $seqres.full before test)
- Use _getfattr wrapper and filter TEST_DIR

Changes since v1 (RFC):

 Both tests refactored:
 - use 'workdir' instead of 'testdir' and initialize it to $seq
 - don't remove $workdir on cleanup()
 - use output to validate test results instead of _fail

Luis Henriques (2):
  ceph: test basic ceph.quota.max_files quota
  ceph: test basic ceph.quota.max_bytes quota

 tests/ceph/001      |  88 ++++++++++++++++++++++++++++++
 tests/ceph/001.out  |   9 ++++
 tests/ceph/002      | 127 ++++++++++++++++++++++++++++++++++++++++++++
 tests/ceph/002.out  |  64 ++++++++++++++++++++++
 tests/ceph/Makefile |  20 +++++++
 tests/ceph/group    |   2 +
 6 files changed, 310 insertions(+)
 create mode 100755 tests/ceph/001
 create mode 100644 tests/ceph/001.out
 create mode 100755 tests/ceph/002
 create mode 100644 tests/ceph/002.out
 create mode 100644 tests/ceph/Makefile
 create mode 100644 tests/ceph/group
