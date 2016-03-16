Received: from mx1.redhat.com ([209.132.183.28]:40231 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934141AbcCPL0I (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 16 Mar 2016 07:26:08 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id A1E5880508
	for <fstests@vger.kernel.org>; Wed, 16 Mar 2016 11:26:07 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v5 0/3] Richacl tests
Date: Wed, 16 Mar 2016 12:26:02 +0100
Message-Id: <1458127565-24149-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Here we go with the richacl tests converted into "golden output matching"
tests.  The tests no longer consistently check the exit statuses of commands
and it is more difficult to figure out which piece of output belongs to which
command and to trace back from a failure to the command that has failed.  Still
better than nothing, though.

Andreas Gruenbacher (3):
  Rename output file templates to match TEST.out*
  xfs/191: Remove obsolete nfs4acl tests
  generic/338-346: Add richacl tests

 .gitignore                   |  19 +++
 common/rc                    |  39 ++++++
 nfs4acl/Makefile             |  29 ----
 nfs4acl/apply-mask.test      | 143 -------------------
 nfs4acl/basic.test           |  70 ----------
 nfs4acl/chmod.test           |  31 -----
 nfs4acl/chown.test           |  63 ---------
 nfs4acl/computed-mode.test   |  62 ---------
 nfs4acl/create.test          |  35 -----
 nfs4acl/ctime.test           |  36 -----
 nfs4acl/delete.test          |  77 ----------
 nfs4acl/run                  | 298 ---------------------------------------
 nfs4acl/unrepresentable.test |  20 ---
 nfs4acl/write-vs-append.test |  46 ------
 tests/generic/338            | 117 ++++++++++++++++
 tests/generic/338.out        |  94 +++++++++++++
 tests/generic/339            | 109 +++++++++++++++
 tests/generic/339.out        | 140 +++++++++++++++++++
 tests/generic/340            |  90 ++++++++++++
 tests/generic/340.out        |  39 ++++++
 tests/generic/341            |  77 ++++++++++
 tests/generic/341.out        |   9 ++
 tests/generic/342            |  76 ++++++++++
 tests/generic/342.out        |  11 ++
 tests/generic/343            |  75 ++++++++++
 tests/generic/343.out        |  11 ++
 tests/generic/344            |  75 ++++++++++
 tests/generic/344.out        |   7 +
 tests/generic/345            | 116 ++++++++++++++++
 tests/generic/345.out        |  24 ++++
 tests/generic/346            |  80 +++++++++++
 tests/generic/346.out        |  19 +++
 tests/generic/group          |   9 ++
 tests/xfs/096                |   4 +-
 tests/xfs/096.external       |  50 -------
 tests/xfs/096.internal       |  51 -------
 tests/xfs/096.out.external   |  50 +++++++
 tests/xfs/096.out.internal   |  51 +++++++
 tests/xfs/191                |  75 ----------
 tests/xfs/191.out            | 324 -------------------------------------------
 tests/xfs/group              |   1 -
 41 files changed, 1339 insertions(+), 1413 deletions(-)
 delete mode 100644 nfs4acl/Makefile
 delete mode 100644 nfs4acl/apply-mask.test
 delete mode 100644 nfs4acl/basic.test
 delete mode 100644 nfs4acl/chmod.test
 delete mode 100644 nfs4acl/chown.test
 delete mode 100644 nfs4acl/computed-mode.test
 delete mode 100644 nfs4acl/create.test
 delete mode 100644 nfs4acl/ctime.test
 delete mode 100644 nfs4acl/delete.test
 delete mode 100755 nfs4acl/run
 delete mode 100644 nfs4acl/unrepresentable.test
 delete mode 100644 nfs4acl/write-vs-append.test
 create mode 100755 tests/generic/338
 create mode 100644 tests/generic/338.out
 create mode 100755 tests/generic/339
 create mode 100644 tests/generic/339.out
 create mode 100755 tests/generic/340
 create mode 100644 tests/generic/340.out
 create mode 100755 tests/generic/341
 create mode 100644 tests/generic/341.out
 create mode 100755 tests/generic/342
 create mode 100644 tests/generic/342.out
 create mode 100755 tests/generic/343
 create mode 100644 tests/generic/343.out
 create mode 100755 tests/generic/344
 create mode 100644 tests/generic/344.out
 create mode 100755 tests/generic/345
 create mode 100644 tests/generic/345.out
 create mode 100755 tests/generic/346
 create mode 100644 tests/generic/346.out
 delete mode 100644 tests/xfs/096.external
 delete mode 100644 tests/xfs/096.internal
 create mode 100644 tests/xfs/096.out.external
 create mode 100644 tests/xfs/096.out.internal
 delete mode 100755 tests/xfs/191
 delete mode 100644 tests/xfs/191.out

-- 
2.5.0

