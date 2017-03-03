Received: from mx1.redhat.com ([209.132.183.28]:51848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbdCCJFW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Mar 2017 04:05:22 -0500
Date: Fri, 3 Mar 2017 17:03:32 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [RFC PATCH] check: try to fix the test device if it gets
 corrupted
Message-ID: <20170303090332.GP14226@eguan.usersys.redhat.com>
References: <20170302232050.31125-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170302232050.31125-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 02, 2017 at 06:20:50PM -0500, Theodore Ts'o wrote:
> If the test device gets corrupted all subsequent tests will fail.  To
> prevent this from causing all subsequent tests to be useless, try
> repair the file system on TEST_DEV if possible.  We don't need to do
> this with the scratch device since that file system gets recreated
> each time anyway.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> 
> This is a quick hack that I needed while debubgging some research
> code[1].  It turns out that when the grad student is up against a
> paper deadline is an, this becomes amazing evolutionary process which
> creates file system modifications which are optimized for running
> postmark and file bench --- and falls over very easily otherwise.  So
> when TEST_DEV is getting corrupted very frequently, it's nice to be
> able to continue running other tests in the quick or auto group.
> 
> So please consider this a proof-concept-patch; would people consider
> it worthwhile to have this in xfstests upstream?

This idea looks reasonable to me, and TEST_DEV is supposed to be aging,
perhaps being currupted & repaired is kind of aging too :)

Thanks,
Eryu
