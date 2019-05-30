Received: from mx2.suse.de ([195.135.220.15]:53882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbfE3Ljq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 30 May 2019 07:39:46 -0400
Date: Thu, 30 May 2019 13:39:43 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: regression test for online resizing maximum blocks
Message-ID: <20190530113943.GE29237@quack2.suse.cz>
References: <1559208438-2767-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559208438-2767-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc: guaneryu@gmail.com, jack@suse.cz, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu 30-05-19 17:27:18, Yang Xu wrote:
> This adds a regression test for online resizing maximum blocks
> which can trigger a BUG_ON with non-zero s_first_data_block
> filesystem.
> 
> The bug was fixed by patch:
> "ext4: fix crash during online resizing"
> 
> The bug was introduced by patch:
> "ext4: convert file system to meta_bg if needed..."
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just one nit below:

> +# success, all done
> +echo "Silence is golden"

The "Silence is golden" message doesn't really make sense when the test
actually outputs something ;)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
