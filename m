Received: from mx1.redhat.com ([209.132.183.28]:45900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbdBNC2t (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 13 Feb 2017 21:28:49 -0500
Date: Tue, 14 Feb 2017 10:28:48 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH 0/4] test multi-level bind and shared subtree mounts
Message-ID: <20170214022848.GG14570@dhcp12-143.nay.redhat.com>
References: <20170214005545.29373-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214005545.29373-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 13, 2017 at 07:55:41PM -0500, Theodore Ts'o wrote:
> This is a respon if of Zorro Lang's patch set from May 20, 2016.  I've
> reviewed them, and tested them against a recent development kernel.
> 
> The two main changes which I made to Zorro's patches:
> 
>   * I changed the numbers to the most recent unallocated test numbers
>   * I added code to delete the test files in the end_test function

Hi Theodore,

Thanks for your review, too long time passed, I need to read these
code again to recollect something :)

> 
> Zorro Lang (4):
>   common/rc: new functions for multi-level mount/umount operations

Actually, this patch is what I want to improve. I don't know if it's
a good way, I can't find a better way to implement this common/rc
patch, I really need a stack to store mountpoints. Do you have some
better ideas than store them in a simple bash variable?

Thanks,
Zorro

>   generic: new case for test mount bind operation
>   generic: new case for test mount shared subtrees state transition
>   generic: new case test two vfsmount no peers
> 
>  common/rc             |  31 ++
>  tests/generic/409     | 182 +++++++++++
>  tests/generic/409.out | 365 ++++++++++++++++++++++
>  tests/generic/410     | 215 +++++++++++++
>  tests/generic/410.out | 813 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/411     | 147 +++++++++
>  tests/generic/411.out |  12 +
>  tests/generic/group   |   3 +
>  8 files changed, 1768 insertions(+)
>  create mode 100644 tests/generic/409
>  create mode 100644 tests/generic/409.out
>  create mode 100644 tests/generic/410
>  create mode 100644 tests/generic/410.out
>  create mode 100644 tests/generic/411
>  create mode 100644 tests/generic/411.out
> 
> -- 
> 2.11.0.rc0.7.gbe5a750
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
