Received: from mail-pg0-f68.google.com ([74.125.83.68]:36073 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752127AbdAGE5e (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Jan 2017 23:57:34 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so7648564pgf.3
        for <fstests@vger.kernel.org>; Fri, 06 Jan 2017 20:57:34 -0800 (PST)
Date: Fri, 6 Jan 2017 20:57:31 -0800
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH] fstests: cleanup tmp files in tests
Message-ID: <20170107045731.GC575@zzz>
References: <20170106034507.5915-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170106034507.5915-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Eryu,

On Fri, Jan 06, 2017 at 11:45:07AM +0800, Eryu Guan wrote:
> $tmp.* files should be removed in _cleanup() even if the test is not
> using any $tmp.* file explicitly, because common helper functions
> may take use of them too.
> 
> So cleanup tmp files properly in tests, and add a _cleanup()
> function and trap it on exit if the test doesn't do so, to make all
> tests consistent on the way they do cleanup.
> 
> Also remove other tmp files used by the tests and the harness so
> that we leave no new tmp files in /tmp dir after a full test run.
> 

Why exactly can't the boilerplate go in a preamble file which is sourced by all
the tests?  For example common/preamble containing something like:

	seq=`basename $0`
	seqres=$RESULT_DIR/$seq
	echo "QA output created by $seq"

	_cleanup()
	{
		cd /
		rm -f $tmp.*
	}

	here=`pwd`
	tmp=/tmp/$$
	status=1        # failure is the default!
	trap "_cleanup; exit \$status" 0 1 2 3 15

	. ./common/rc

Tests that need to do more cleanup could override the default trap.

Eric
