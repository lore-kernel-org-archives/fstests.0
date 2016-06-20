Received: from mx1.redhat.com ([209.132.183.28]:54661 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205AbcFTJZo (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 20 Jun 2016 05:25:44 -0400
Date: Mon, 20 Jun 2016 17:25:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] ext4/271: Fix test failure with data=<foo> mount option
Message-ID: <20160620092541.GO5140@eguan.usersys.redhat.com>
References: <1466071511-30069-1-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466071511-30069-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Jan,

On Thu, Jun 16, 2016 at 12:05:11PM +0200, Jan Kara wrote:
> The test is failing when MOUNT_OPTIONS contain 'data=<foo>' mount option
> as it does not combine with 'noload' mount option the test uses. Fix it
> by removing the data=<foo> mount option. Arguably we could also fix the
> problem by just skipping the test when such option is set but e.g. using
> 'data=writeback' is common to excercise somewhat different behavior and

When MOUNT_OPTIONS contains 'data=writeback' ext4/271 also fails

[275528.681541] EXT4-fs (sda6): can't mount with data=, fs mounted w/o journal

Seems kernel commit 1e381f60dad9 ("ext4: do not allow journal_opts for
fs w/o journal") refuses all mounts with "data=" mount option.

> it is undesirable to skip the test just because of this.

So skipping ext4/271 in this case makes more sense to me.

> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  tests/ext4/271 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/ext4/271 b/tests/ext4/271
> index d68c2719024e..417a796ffac9 100755
> --- a/tests/ext4/271
> +++ b/tests/ext4/271
> @@ -45,6 +45,10 @@ _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
>  
>  # -onoload and EXT4_SYNC_FL on file is important becase result in
>  # metadata sync writes inside ext4_handle_dirty_metadata()
> +#
> +# We have to be careful and remove data=<foo> mount options as they don't
> +# combine with 'noload'.
> +MOUNT_OPTIONS=$(echo $MOUNT_OPTIONS | sed -e 's/\([ ,]\)data=[a-zA-Z]*[,$]/\1/')

This doesn't remove 'data=<foo>' mount option for me

  $ MKFS_OPTIONS="-o data=journal"
  $ echo $MKFS_OPTIONS | sed -e 's/\([ ,]\)data=[a-zA-Z]*[,$]/\1/'
  -o data=journal

Even with that works, the 'sed' filter only removes the 'data=<foo>'
part and leaves the '-o' part, which results in MOUNT_OPTIONS="-o" and
still causes mount to fail.

And perhaps other journal related mount options should be removed too?
e.g. journal_checksum, journal_async_commit, commit=<n>

I sent two patches back in Jan. to fix ext4/271 (skip ext4/271 when
MOUNT_OPTIONS contain journal related options), what do you think?

https://patchwork.kernel.org/patch/8052251/
https://patchwork.kernel.org/patch/8052261/

Thanks,
Eryu
