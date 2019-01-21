Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:42154 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbfAUWtW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Jan 2019 17:49:22 -0500
Date: Tue, 22 Jan 2019 09:49:19 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/1] squashfs: introduce squashfs support
Message-ID: <20190121224919.GF4205@dastard>
References: <20190118093725.103172-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118093725.103172-1-zhengbin13@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: zhengbin <zhengbin13@huawei.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org, houtao1@huawei.com, zhaohongjiang@huawei.com
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 18, 2019 at 05:37:24PM +0800, zhengbin wrote:
> This patch add squashfs support in xfstests-dev. Add two directories
> in tests directory, readonly can also be used for other readonly
> filesystem, squashfs is just used for squashfs filesystem.
> tests/readonly/001        mount test
> tests/readonly/002--010   metadata test
> tests/readonly/011--018   data test
> tests/readonly/019--021   xattr test
> tests/squashfs/001--005   mksquashfs options test
> 
> zhengbin (1):
>   squashfs: add squashfs tests

This needs to be broken up into multiple patches.

At least:
	- one that adds squashfs support
	- one for each of the different infrastructure changes
	  that are needed (e.g. to common/config, to common/rc, etc)
	- one that adds squashfs specific tests
	- the "read-only" tests need to be separated out - 20 tests
	  in a single patch is way too many to review in a single
	  file.

>  .gitignore                                  |   1 +
>  README.squashfs                             |  12 ++
>  check                                       |  19 ++-
>  common/attr                                 |   5 +
>  common/config                               |   6 +
>  common/rc                                   |  63 ++++++++-
>  src/aio-dio-regress/aio-subblock-eof-read.c |  84 ++++++++++++

Why is there a new AIO test hidden in all this? That needs to be in
it's own patch (along with the test that uses it).

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
