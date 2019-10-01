Return-Path: <SRS0=ibZJ=X2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858EAECE58A
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Oct 2019 21:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640BF21924
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Oct 2019 21:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfJAVyL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Oct 2019 17:54:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:56720 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfJAVyL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Oct 2019 17:54:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 14:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,572,1559545200"; 
   d="scan'208";a="216225645"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga004.fm.intel.com with ESMTP; 01 Oct 2019 14:54:10 -0700
Date:   Tue, 1 Oct 2019 14:54:10 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc:     john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>,
        Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH V2 00/16] Fix locktest and add lease testing to it
Message-ID: <20191001215410.GA8840@iweiny-DESK2.sc.intel.com>
References: <20190923175336.2287-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923175336.2287-1-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 23, 2019 at 10:53:20AM -0700, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add lease tests[1] to locktest because they share so much code.  Make running
> of lease tests separate as an '-L' option.
> 
> To make things cleaner update the lock test code and test script.  This
> includes fixing a rather serious bug.                                                                                                                 
> 
> Finally update the error output to help identify any steps which fail during
> testing.                                                                                                                                            
>

Was there any further feedback on this series?  Did it get mangled too bad to
apply?

Ira

> 
> Changes from V1:
> 	Create a new option '-L' to run lease testing
> 	Created 568 test script which shared common code with 131
> 	Moved 2 patches earlier in the series
> 		[PATCH V2 09/16] src/locktest: Clean up error output
> 		[PATCH V2 10/16] src/locktest: Audit all debug output
> 	Added 3 patches
> 		[PATCH V2 11/16] src/locktest: Add run() function
> 		[PATCH V2 15/16] common/locktest: Add common locktest functions
> 		[PATCH V2 16/16] generic/568: Add lease testing
> 
> Ira Weiny (16):
>   src/locktest: Remove unnecessary sleep
>   src/locktest: Remove OPEN macro
>   src/locktest: Change command macro names
>   src/locktest: Add get_cmd_str
>   src/locktest.c: Clean up client command passing
>   src/locktest.c: Fix return code if last test fails
>   generic/131: Clean up pid variables
>   generic/131: Save stderr for debugging
>   src/locktest: Clean up error output
>   src/locktest: Audit all debug output
>   src/locktest: Add run() function
>   src/locktest: Add simple lease testing
>   src/locktest: Add lease testing for basic signal reception
>   src/locktest: Add truncate lease tests
>   common/locktest: Add common locktest functions
>   generic/568: Add lease testing
> 
>  common/locktest       |  95 ++++
>  src/locktest.c        | 999 +++++++++++++++++++++++++++---------------
>  tests/generic/131     |  54 +--
>  tests/generic/568     |  32 ++
>  tests/generic/568.out |   2 +
>  tests/generic/group   |   1 +
>  6 files changed, 786 insertions(+), 397 deletions(-)
>  create mode 100644 common/locktest
>  create mode 100755 tests/generic/568
>  create mode 100644 tests/generic/568.out
> 
> -- 
> 2.20.1
> 
