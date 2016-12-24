Received: from mx1.redhat.com ([209.132.183.28]:38230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbcLXJp2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 24 Dec 2016 04:45:28 -0500
Date: Sat, 24 Dec 2016 17:45:25 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: btrfs: Test scrub and replace race for RAID56
Message-ID: <20161224094525.GR1859@eguan.usersys.redhat.com>
References: <20161222020251.12272-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161222020251.12272-1-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 22, 2016 at 10:02:51AM +0800, Qu Wenruo wrote:
> Although by design, btrfs scrub and replace share the same code path, so
> they are exclusive to each other.
> 
> But the fact is, there is still some critical region not protected well,
> so we can have the following kernel panic, especially easy to trigger on
> RAID5/6 profiles.

Could btrfs/069 reproduce the panic? It also races scrub and replace,
but with fsstress running in background, raid5/6 profiles are part of
the default test configs.

Also, is there a known fix available in Linus tree or btrfs tree? If
not, I'd push this new test after there's a known fix (if it's worth a
new test).

Thanks,
Eryu
