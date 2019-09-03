Received: from mga07.intel.com ([134.134.136.100]:39854 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfICVFr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 3 Sep 2019 17:05:47 -0400
From: ira.weiny@intel.com
Subject: [RFC PATCH 0/2] Add lease testing
Date: Tue,  3 Sep 2019 14:05:35 -0700
Message-Id: <20190903210537.29142-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

To get to a point of developing and testing the new Lease semantics for long
term file pins[1], add a simple lease test.

Currently the following tests are performed based on the fcntl() man page.

    /*  1 */"Take Read Lease",
    /*  2 */"Take Write Lease",
    /*  3 */"Fail Write Lease if file is open somewhere else",
    /*  4 */"Fail Read Lease if opened with write permissions",
    /*  5 */"Read lease gets SIGIO on write open",
    /*  6 */"Write lease gets SIGIO on read open",

[1] https://lkml.org/lkml/2019/8/14/435

Ira Weiny (2):
  src/leasetest: Add lease test executable
  generic: Add Lease testing

 src/Makefile          |   2 +-
 src/leasetest.c       | 837 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/567     | 100 +++++
 tests/generic/567.out |   2 +
 tests/generic/group   |   1 +
 5 files changed, 941 insertions(+), 1 deletion(-)
 create mode 100644 src/leasetest.c
 create mode 100755 tests/generic/567
 create mode 100644 tests/generic/567.out

-- 
2.20.1
