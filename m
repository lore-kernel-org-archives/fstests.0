Received: from mx1.redhat.com ([209.132.183.28]:43014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751600AbdJLQGx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Oct 2017 12:06:53 -0400
Date: Fri, 13 Oct 2017 00:06:51 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 2/3] common: turn _filter_xfs_dmesg() into
 _filter_aiodio_dmesg()
Message-ID: <20171012160651.GH10593@eguan.usersys.redhat.com>
References: <1507820044-2161-1-git-send-email-idryomov@gmail.com>
 <1507820044-2161-3-git-send-email-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507820044-2161-3-git-send-email-idryomov@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: fstests@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 12, 2017 at 04:54:03PM +0200, Ilya Dryomov wrote:
> With upstream commit 332391a9935d ("fs: Fix page cache inconsistency
> when mixing buffered and AIO DIO"), ext4 (and probably other non-iomap
> based filesystems) need a _check_dmesg() whitelist entry for a new WARN
> in dio_complete() -- generic/095 and 247 trigger a dio_complete() splat
> pretty reliably for me.
> 
> Add dio_complete() entry to _filter_xfs_dmesg(), rename it and use it
> unconditionally in generic/095, 224, 247 and 446.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Thanks for the repost! I added "source ./common/filter" to generic/446
too, which was not sourced originally.

Thanks,
Eryu
