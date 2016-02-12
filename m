Received: from mx1.redhat.com ([209.132.183.28]:41193 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbcBLF3q (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 12 Feb 2016 00:29:46 -0500
Date: Fri, 12 Feb 2016 13:29:37 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 04/13] generic: remove the generic/125 test
Message-ID: <20160212052937.GC11419@eguan.usersys.redhat.com>
References: <1455170182-32587-1-git-send-email-tytso@mit.edu>
 <1455170182-32587-5-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455170182-32587-5-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 11, 2016 at 12:56:13AM -0500, Theodore Ts'o wrote:
> Dave Chinner has pointed out this test is largely pointless:
> 
>    Perhaps one should question whether generic/125 is actually testing
>    anything useful in the first place.
> 
>    i.e. it's writing 16k, then truncating it back to 1000 bytes, then
>    reading it with direct IO for 60s to see if it returns the correct
>    data for that entire time.
> 
>    What, exactly, is going to cause that test to fail?
> 
>    Keep in mind this was ported from a CXFS test, where the metadata
>    server did the truncation operation (including the data zeroing),
>    but the reads are being done from the client.  i.e. it was designed
>    to test whether a remote machine is doing a truncate correctly on a
>    access shared disk.
> 
>    IMO, I think we just remove the test, src/trunc.c and src/ftrunc.c
>    because it's 60s of testing that doesn't actually provide any value
>    to us.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/125   | 68 -----------------------------------------------------
>  tests/generic/group |  1 -
>  2 files changed, 69 deletions(-)
>  delete mode 100755 tests/generic/125

Also remove 125.out ?

Thanks,
Eryu
