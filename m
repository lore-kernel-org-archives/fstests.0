Received: from mx1.redhat.com ([209.132.183.28]:37684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbdBOJq5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 15 Feb 2017 04:46:57 -0500
Date: Wed, 15 Feb 2017 17:46:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 0/4] test multi-level bind and shared subtree mounts
Message-ID: <20170215094656.GQ24562@eguan.usersys.redhat.com>
References: <20170214005545.29373-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214005545.29373-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 13, 2017 at 07:55:41PM -0500, Theodore Ts'o wrote:
> This is a respon if of Zorro Lang's patch set from May 20, 2016.  I've
> reviewed them, and tested them against a recent development kernel.
> 
> The two main changes which I made to Zorro's patches:
> 
>   * I changed the numbers to the most recent unallocated test numbers
>   * I added code to delete the test files in the end_test function

Thanks a lot!

I have some minor comments and I can fix all of them at commit time.

Thanks,
Eryu

> 
> Zorro Lang (4):
>   common/rc: new functions for multi-level mount/umount operations
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
