Received: from mga02.intel.com ([134.134.136.20]:48815 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfIREQD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Sep 2019 00:16:03 -0400
From: ira.weiny@intel.com
Subject: [PATCH 00/13] Fix locktest and add lease testing to it
Date: Tue, 17 Sep 2019 21:15:45 -0700
Message-Id: <20190918041558.2621-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Rather than have a separate lease test, combine the previously proposed lease
tests[1] directly to locktest because they share so much code.

To make things cleaner update the lock test code and test script.  This
includes fixing a rather serious bug.

Finally update the error output to help identify any steps which fail during
testing.

Ira

[1] https://www.spinics.net/lists/fstests/msg12467.html

Ira Weiny (13):
  src/locktest: Remove unnecessary sleep
  src/locktest: Remove OPEN macro
  src/locktest: Change command macro names
  src/locktest: Add get_cmd_str
  src/locktest.c: Clean up client command passing
  src/locktest.c: Fix return code if last test fails
  generic/131: Clean up pid variables
  generic/131: Save stderr for debugging
  src/locktest: Add simple lease testing
  src/locktest: Add lease testing for basic signal reception
  src/locktest: Add truncate lease tests
  src/locktest: Clean up error output
  src/locktest: Audit all debug output

 src/locktest.c    | 957 ++++++++++++++++++++++++++++++----------------
 tests/generic/131 |  72 ++--
 2 files changed, 666 insertions(+), 363 deletions(-)

-- 
2.20.1
