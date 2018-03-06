Received: from mx2.suse.de ([195.135.220.15]:35319 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbeCFLGe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Mar 2018 06:06:34 -0500
Subject: Re: [PATCH 3/3] fstests: btrfs: Add test case to check v1 space cache
 corruption
References: <20180306081555.3242-1-wqu@suse.com>
 <20180306081555.3242-3-wqu@suse.com>
 <CAL3q7H5_1WiGZKEzFGBQRsA9prJ-uMUn2+TKBWHyKOGha4nLDQ@mail.gmail.com>
 <b859c3d8-1eae-98fa-3ae8-7ed017299ce2@gmx.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <b62c7d8b-fd12-9093-6fc2-6f9284880971@suse.com>
Date: Tue, 6 Mar 2018 13:06:32 +0200
MIME-Version: 1.0
In-Reply-To: <b859c3d8-1eae-98fa-3ae8-7ed017299ce2@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests@vger.kernel.org, dsterba@suse.cz, amir73il@gmail.com
List-ID: <fstests@vger.kernel.org>



On  6.03.2018 12:53, Qu Wenruo wrote:
> 
> 
[snip]

> It breaks the rule that we shouldn't have the hole in file extents.
> 
> IIRC Nikolay is trying to use inode_lock_shared() to solve this race.
> 

Unfortunately the inode_lock_shared approach is a no go since Filipe
objected to it quite adamantly. After discussion that happened in that
thread I can say I'm almost convinced that the pair of READDIO_LOCK and
setsize *do* provide necessary consistency for the DIO case. However at
the moment there is a memory barrier missing.

But I think the DIO case is unrelated to the issue you are discussing
here, no ?


[snip]
