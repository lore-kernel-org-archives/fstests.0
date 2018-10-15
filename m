Received: from mail-wr1-f47.google.com ([209.85.221.47]:46710 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeJPEpR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Oct 2018 00:45:17 -0400
Received: by mail-wr1-f47.google.com with SMTP id n11-v6so22841057wru.13
        for <fstests@vger.kernel.org>; Mon, 15 Oct 2018 13:58:20 -0700 (PDT)
MIME-Version: 1.0
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Mon, 15 Oct 2018 15:58:06 -0500
Message-ID: <CA+EzBbDZ5QZPqbgicY6Ar=uroM9a0-7b8PyUBdwYGMwXgBEanw@mail.gmail.com>
Subject: Submitting patches to xfstests based on OSDI '18 paper (CrashMonkey)
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>
Cc: Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-ID: <fstests@vger.kernel.org>

Hi Ted,

Thanks for encouraging and helping us in the course of building
CrashMonkey for file-system crash consistency testing. Our work is
published in OSDI '18
(https://www.usenix.org/conference/osdi18/presentation/mohan). While
our goal is to enable the integration of a tool like CrashMonkey in
the file-system development cycle, we think it would be beneficial to
add the test suite of about 300 workloads (consisting of 1 core
file-system operation) that we systematically generated, to xfstest.
The complete list of these workloads is in the CrashMonkey repository
(https://github.com/utsaslab/crashmonkey/tree/master/code/tests/seq1).
Given that developers currently use the xfstest, this addition would
ensure that simple crash-consistency bugs are eliminated from any
future kernel versions.

If this idea sounds good to you, we can write a patch for including
our workloads into xfstest, using dm_flakey. If there's some specific
format you want us to follow while writing patches for these
crash-consistency tests, we are happy to adopt it.

Thanks,
Jayashree Mohan
