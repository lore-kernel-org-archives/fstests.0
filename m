Received: from mail-pf1-f196.google.com ([209.85.210.196]:41208 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389425AbfEXJCM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 May 2019 05:02:12 -0400
Date: Fri, 24 May 2019 17:02:05 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: Validate that balance and qgroups
 work correctly when balance needs to be resumed on mount
Message-ID: <20190524090205.GN15846@desktop>
References: <20190523011101.4594-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523011101.4594-1-wqu@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 23, 2019 at 09:11:01AM +0800, Qu Wenruo wrote:
> There are two regressions related to balance resume:
> - Kernel NULL pointer dereference at mount time
>   Introduced in v5.0
> - Kernel BUG_ON() just after mount
>   Introduced in v5.1
> 
> The kernel fixes are:
> "btrfs: qgroup: Check if @bg is NULL to avoid NULL pointer
>  dereference"
> "btrfs: reloc: Also queue orphan reloc tree for cleanup to
>  avoid BUG_ON()"
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

The summary seems a bit long, does this look like a proper summary to
describe the test?

"btrfs: resume balance on mount with qgroup"

If so, I'll use this summary on commit.

Thanks,
Eryu
