Received: from mx1.redhat.com ([209.132.183.28]:42484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757084AbdACEHV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 2 Jan 2017 23:07:21 -0500
Date: Tue, 3 Jan 2017 12:07:19 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] fstests: btrfs/006: Fix false alert due to output
 change
Message-ID: <20170103040719.GI1859@eguan.usersys.redhat.com>
References: <20170103031617.439-1-suy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170103031617.439-1-suy.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Su Yue <suy.fnst@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 02, 2017 at 10:16:17PM -0500, Su Yue wrote:
> Btrfs-progs v4.9 changed "device status" output by adding one more
> space, which differs from golden output.
> Fix it by using filter '_filter_spaces' to convert multi space into one.

You missed your SOB line. I added

Signed-off-by: Su Yue <suy.fnst@cn.fujitsu.com>

and applied the patch.

Thanks,
Eryu
