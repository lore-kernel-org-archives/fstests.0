Received: from aserp1050.oracle.com ([141.146.126.70]:42652 "EHLO
        aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755680AbdCGU23 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2017 15:28:29 -0500
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
        by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v27GpYcH028424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <fstests@vger.kernel.org>; Tue, 7 Mar 2017 16:51:34 GMT
Date: Tue, 7 Mar 2017 08:50:27 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: generic/411 clash with TEST_DIR=/mnt
Message-ID: <20170307165027.GA15724@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Zorro,

I noticed that generic/411 creates some sort of directory structure
involving $TEST_DIR/$seq/$$_mpA/mnt1/mnt2, then pipes the findmnt output
through _filter_test_dir.

Unfortunately, on my test system I have TEST_DIR=/mnt, so the filtering
produces this output:

QA output created by 411
------
TEST_DIR/411 SCRATCH_DEV
mpA SCRATCH_DEV
mpATEST_DIR1 SCRATCH_DEV
mpB SCRATCH_DEV
mpBTEST_DIR1 SCRATCH_DEV
mpBTEST_DIR1/TEST_DIR2 SCRATCH_DEV
mpC SCRATCH_DEV
mpCTESTDIR1 SCRATCH_DEV
======
crash test passed

Which means that the golden output comparison fails. :(

I'm not sure what's a proper fix here: changing _filter_test_dir to be
more picky about what gets sed'ed?

e.g. sed -e "s,\([[:space:]]\)$TEST_DIR,\1TEST_DIR,g/"

Or just to change the test to use directory names that are less likely to be
mistaken for TEST_* and SCRATCH_*?

--D
