Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FD0C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 14:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiGUOEU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiGUOEU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 10:04:20 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E175C4B4A6
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 07:04:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26LE3j2g024589
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 10:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658412227; bh=uMmUgra8WLeMLmpjopdjolODosinUcUJ8tJZoEfKN0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CWbvGQfur22W6jbvwyMRo9r/8MOsNIVQud3GtyJDewdmhD7/qXHos7RmtQpZ0Q0Y2
         GzoXgRSs5XmCIJhpGoeCGOMYmY7FzraM0b97XEXC6hlwPzckvO2toM6BX6mqbvvwaQ
         tgze+/Z9HrwzYFHZ28UBNClRXwpgrp3k1sdTBpPAhS/jlPpySD3WSCQxjBo25VG9ri
         TXcalRs/X3W522fv3JSlXFmFClnV9KZw2jJxP49Ev3oe/QTjCvtAj1M7waykC+hydP
         b/izLbtjD7vbtpHY2o2grcFGCMz9/myGOsazU6TXybEdPFVMU75zlajjYpXuDJTadF
         lS20X1TO4H8EQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CDAFD15C3EBF; Thu, 21 Jul 2022 10:03:45 -0400 (EDT)
Date:   Thu, 21 Jul 2022 10:03:45 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Boyang Xue <bxue@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
Message-ID: <YtlcwZ/66pJhpdiS@mit.edu>
References: <20220721022959.4189726-1-bxue@redhat.com>
 <YtjYxyhVmSPzzFoH@magnolia>
 <CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com>
 <Ytk7t0am8H4x2BbS@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytk7t0am8H4x2BbS@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Following up, using NFS loopback with a 5GB scratch device on a Google
Compute Engine VM, generic/476 passes using a 4.14 LTS, 4.19 LTS, and
5.4 LTS kernel.  So this looks like it's a regression which is in 5.10
LTS and newer kernels, and so instead of patching it out of the test,
I think the right thing to do is to add it to a kernel
version-specific exclude file and then filing a bug with the NFS
folks.

KERNEL:    kernel 4.14.284-xfstests #8 SMP Tue Jul 5 08:21:37 EDT 2022 x86_64
CMDLINE:   -c nfs/default generic/476
CPUS:      2
MEM:       7680

nfs/loopback: 1 tests, 597 seconds
  generic/476  Pass     595s
Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 595s

---
KERNEL:    kernel 4.19.248-xfstests #4 SMP Sat Jun 25 10:43:45 EDT 2022 x86_64
CMDLINE:   -c nfs/default generic/476
CPUS:      2
MEM:       7680

nfs/loopback: 1 tests, 407 seconds
  generic/476  Pass     407s
Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 407s

----
KERNEL:    kernel 5.4.199-xfstests #21 SMP Sun Jul 3 12:15:15 EDT 2022 x86_64
CMDLINE:   -c nfs/default generic/476
CPUS:      2
MEM:       7680

nfs/loopback: 1 tests, 404 seconds
  generic/476  Pass     404s
Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 404s


See below for what I'm checking into xfstests-bld for
{kvm,gce}-xfstests.  I don't believe we should be changing xfstests's
generic/476, since it *does* pass with a smaller scratch device on
older kernels, and presumably, RHEL customers would be cranky if this
issue resulted in their production systems to lock up, and so it
should be considered a kernel bug as opposed to a test bug.

						- Ted


commit 4a33b6721d5db9c07f295a10a8ad65d2a0021406
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Jul 21 09:54:50 2022 -0400

    test-appliance: add an nfs test exclusions for kernels newer than 5.4
    
    This is apparently an NFS bug which is visible in 5.10 LTS and newer
    kernels, and likely appeared sometime after 5.4.  Since it causes the
    test VM to spin forever (or at least for days), let's exclude it for
    now.
    
    Link: https://lore.kernel.org/all/CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com/
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/test-appliance/files/root/fs/nfs/exclude b/test-appliance/files/root/fs/nfs/exclude
index 184750fb..ef4b19bc 100644
--- a/test-appliance/files/root/fs/nfs/exclude
+++ b/test-appliance/files/root/fs/nfs/exclude
@@ -10,3 +10,14 @@ generic/477
 // failing in the expected output of the linux-nfs Wiki page.  So we'll
 // suppress this failure for now.
 generic/294
+
+#if LINUX_VERSION_CODE > KERNEL_VERSION(5,4,0)
+// There appears to be a regression that shows up sometime after 5.4.
+// LTS kernels for 4.14, 4.19, and 5.4 will terminate successfully,
+// but newer kernels will spin forever in some kind of deadlock or livelock
+// This apparently does not happen if the scratch device is > 27GB, so it
+// may be some kind of ENOSPC-related bug.
+// For more information see the e-mail thread starting at:
+// https://lore.kernel.org/r/CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com/
+generic/476
+#endif
