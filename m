Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:42049 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753027AbcIZWSU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Sep 2016 18:18:20 -0400
Date: Tue, 27 Sep 2016 08:18:14 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: add support for the "local" file system type
Message-ID: <20160926221814.GC2532@dastard>
References: <20160923200526.29674-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160923200526.29674-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 23, 2016 at 04:05:26PM -0400, Theodore Ts'o wrote:
> It is sometimes useful to be able to test the local file system
> provided in a restricted execution environment (such as that which is
> provided by Docker, for example) where it is not possible to mount and
> unmount the file system under test.

Ignoring the code changes for the moment - what's the reason/use
case for running /kernel/ test suites inside a user container with
such restricted access to filesystems and devices? Especially
considering test failures can take the kernel down, which will kill
/everything/ on the machine, not just the container.

This doesn't make a whole lot of sense to me - who is going to use
this and what extra test coverage does it bring to the table
compared to just running inside a guest VM with full privileges?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
