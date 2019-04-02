Received: from mx2.suse.de ([195.135.220.15]:36156 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbfDBKec (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 2 Apr 2019 06:34:32 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH 0/2] Initial CephFS tests
Date: Tue,  2 Apr 2019 11:34:26 +0100
Message-Id: <20190402103428.21435-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

Hi all,

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

Luis Henriques (2):
  ceph: test basic ceph.quota.max_files quota
  ceph: test basic ceph.quota.max_bytes quota

 tests/ceph/001      | 108 ++++++++++++++++++++++++++++++++
 tests/ceph/001.out  |   1 +
 tests/ceph/002      | 147 ++++++++++++++++++++++++++++++++++++++++++++
 tests/ceph/002.out  |   1 +
 tests/ceph/Makefile |  20 ++++++
 tests/ceph/group    |   2 +
 6 files changed, 279 insertions(+)
 create mode 100755 tests/ceph/001
 create mode 100644 tests/ceph/001.out
 create mode 100755 tests/ceph/002
 create mode 100644 tests/ceph/002.out
 create mode 100644 tests/ceph/Makefile
 create mode 100644 tests/ceph/group
