Received: from mga14.intel.com ([192.55.52.115]:54757 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751696AbdF3DtT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 29 Jun 2017 23:49:19 -0400
Date: Fri, 30 Jun 2017 11:49:16 +0800
From: Dai Xiang <xiangx.dai@intel.com>
Subject: [QUESTION] xfstest f2fs generic/240 run fail
Message-ID: <20170630034916.GB11974@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: philip.li@intel.com, zhijianx.li@intel.com, xiangx.dai@intel.com
List-ID: <fstests@vger.kernel.org>

The issue as below:

root@test ~/xfstests./check generic/240
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 test 4.12.0-rc6
MKFS_OPTIONS  -- /dev/sda8
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda8 /fs/scratch

generic/240	 [failed, exit status 10] - output mismatch (see ~/xfstests/results//generic/240.out.bad)
    --- tests/generic/240.out	2017-05-31 18:15:23.000000000 +0800
    +++ ~/xfstests/results//generic/240.out.bad	2017-06-29 11:25:03.457701432 +0800
    @@ -1,2 +1,7 @@
     QA output created by 240
     Silence is golden.
    +AIO write offset 512 expected 4096 got -22
    +AIO write offset 4608 expected 4096 got -22
    +non one buffer at buf[0] => 0x00,00,00,00
    +non-one read at offset 512
    +*** WARNING *** /fs/sda5/aiodio_sparse has not been unlinked; if you don't rm it manually first, it may influence the next run
    ...
    (Run 'diff -u tests/generic/240.out ~/xfstests/results//generic/240.out.bad'  to see the entire diff)
Ran: generic/240
Failures: generic/240
Failed 1 of 1 tests

I want to know its failure is just my HW is not work well or i lack some config or test itself can not run well with f2fs?

Thanks
Dai Xiang

