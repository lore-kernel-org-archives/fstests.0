Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39918C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 13:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiEXNwe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 09:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiEXNwe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 09:52:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1E331378
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 06:52:32 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24ODqQwp016146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 09:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653400348; bh=/VQO02VgxoEjPxYe102qCNE04KjuiEu7Yg9U+Rh1vzE=;
        h=Date:From:To:Cc:Subject;
        b=TdVcPKxSrkS3kOX9bZ54L6q2LBMCSplabiilOfAtlfPTIclQ4J1i7llqMsuTCncl2
         UE6A3BhkgOG41A/ad1OIJzuBUBpNscbU1nKhuR12H5DRg18HeNNCbdSduQTwCInScI
         pBTZoMcQJ0Vzl4Ub1ubztc2XcxlYlhZjjKfwjd8HotIZ1bhL9IdfErUvNrafopWbrO
         1MO5L6n/iYdiY8Hnz8NmdqeqcB5bG1gYYvBJBuXKjD65pZ9W1chsgrBEO24Iy6L7I1
         MXa+0lkGmUcxST3z0Y2a4JwMEmHDu42NfcpjW6Kd62oIIsp+VuYHg7R0+WLZWLZuZj
         nEICEI1XPmywA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 755EC15C3399; Tue, 24 May 2022 09:52:26 -0400 (EDT)
Date:   Tue, 24 May 2022 09:52:26 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     ebiggers@google.com, enwlinux@gmail.com, leah.rumancik@gmail.com,
        harshadshirwadkar@gmail.com
Subject: Directory reorganization in xfstests-bld pushed out
Message-ID: <YozjGjNv9dEW/m0L@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I've justed pushed out a change to the xfstests-bld directory which is
especially disruptive for people who are building test appliances
using xfstests-bld.

The directory structure in xfstests-bld reflects its original design
as a hermetic build system for xfstests.  However, these days, its
primary focus is the an test appliance featuring xfstests (but these
days, we also support blktests the Phoronix test suite, etc.) and
drivers to run the test appliance on a variety of environments ---
e.g., kvm-xfstests, gce-xfstests, and android-xfstests.

To make life easier for new users of xfstests-bld, especially who want
to use kvm-xfstests, I've reorganized the directory structure and
moved around files and directories so they are sorted into four
top-level directories:
    
    fstests-bld		The hermetic build system for xfstests
    test-appliance	The test runner infrastructure for xfstests (and blktests
			and Phoronix Test Suite....)
    run-fstests		The test runner command line utilities, namely kvm-xfstests,
			gce-xfstests, etc.
    build-kernel	Utilities to build and configure the Linux kernel in a
			standard way which is easy for the test runners to run.
    
There is a script in fstests-bld/misc/post-reorg-cleanup which may be
helpful in moving the external repos and other files to the proper
places after this reorganization.  Please take a look at it before
running it, and I recommend that you use the --no-action option first.
Since the most developers will only need to run the script once, it
may be a little rough, and it does delete some files and directories.

       	      	   	       	     	 - Ted
