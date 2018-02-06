Received: from mx1.redhat.com ([209.132.183.28]:56324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752074AbeBFDyo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 5 Feb 2018 22:54:44 -0500
Date: Tue, 6 Feb 2018 11:54:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: xfstests failures
Message-ID: <20180206035443.GN18267@eguan.usersys.redhat.com>
References: <94286394-157a-421b-7f73-52f10529f23f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94286394-157a-421b-7f73-52f10529f23f@intel.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Jiang <dave.jiang@intel.com>
Cc: fstests@vger.kernel.org, "Zwisler, Ross" <ross.zwisler@intel.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 05, 2018 at 02:40:40PM -0700, Dave Jiang wrote:
> Eryu,
> I've noticed that these tests fails under what I think is a normal
> config (BRD of 48G). We have an expectation that for simple configs all
> tests in the 'auto' group should pass, and these ones don't. Are these

No, 'auto' group doesn't mean the test should pass, we do add tests
that're known to fail to auto group, but with the expectation that the
failures will be fixed in the near future.

> false positive failures?  If so, what do we need to do to remove these
> false positives?  a) fix the tests to handle these cases b) remove the

And some tests do fail on unusual configs/setups, e.g. 2M extent setting
in your case, and some tests may not work well with 4k-sector disks.
We'd want to fix the tests but sometimes it's hard to make test work
with all configs, perhahs it's just not worth it if the config is
strange enough and no one cares about it.. But I do like to see the easy
ones get fixed.

> tests from the 'auto' group?  Something else? Attached file with test
> outputs. I think some if not all of these failures have lasted many
> kernel versions.
> 
> # xfs
> generic/009
> generic/012
> generic/016
> generic/021
> generic/022
> generic/058
> generic/060
> generic/061
> generic/063
> generic/092
> generic/255
> xfs/167
> xfs/191-input-validation

This tests mkfs.xfs behavior and AFAIK it fails after Dave's mkfs
refactor patchset, the test itself requires some fixes.

> xfs/242
> xfs/252
> xfs/432
> 
> # ext4
> generic/388

This is a known issue on ext4, there's a discussion thread on ext4 list.
https://marc.info/?l=linux-ext4&m=151629719004002&w=2

Thanks,
Eryu
