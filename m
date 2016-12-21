Received: from mx1.redhat.com ([209.132.183.28]:52956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbcLUCd7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 20 Dec 2016 21:33:59 -0500
Date: Wed, 21 Dec 2016 10:33:55 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: btrfs: Remove btrfs/047 since upstream don't
 accept stream-version
Message-ID: <20161221023355.GM1859@eguan.usersys.redhat.com>
References: <20161220012456.19363-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161220012456.19363-1-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 20, 2016 at 09:24:56AM +0800, Qu Wenruo wrote:
> Btrfs upstream doesn't accept stream-version, so the test is never ran
> on upstream kernel nor btrfs-progs.
> 
> Just remove it.
> 
> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>

Looks fine to me, but I'd like to see an ack or review from btrfs
developers.

Thanks,
Eryu
