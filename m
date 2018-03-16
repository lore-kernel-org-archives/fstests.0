Received: from mail-pg0-f68.google.com ([74.125.83.68]:33749 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeCPEB1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Mar 2018 00:01:27 -0400
Date: Fri, 16 Mar 2018 12:01:19 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH RFC 3/3] fstests: generic: Check the fs after each FUA
 writes
Message-ID: <20180316040119.GN30836@localhost.localdomain>
References: <20180314090230.25055-1-wqu@suse.com>
 <20180314090230.25055-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314090230.25055-3-wqu@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, amir73il@gmail.com
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 14, 2018 at 05:02:30PM +0800, Qu Wenruo wrote:
> Basic test case which triggers fsstress with dm-log-writes, and then
> check the fs after each FUA writes.
> With needed infrastructure and special handlers for journal based fs.

It's not clear to me why the existing infrastructure is not sufficient
for the test. It'd be great if you could provide more information and/or
background in commit log.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> In my test, xfs and btrfs survives while ext4 would report error during fsck.
> 
> My current biggest concern is, we abuse $TEST_DEV and mkfs on it all by
> ourselves. Not sure if it's allowed.

As Amir already replied, that's not allowed, any destructive operations
should be done on $SCRATCH_DEV.

> ---
>  common/dmlogwrites    | 119 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/481     | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/481.out |   2 +
>  tests/generic/group   |   1 +
>  4 files changed, 246 insertions(+)
>  create mode 100755 tests/generic/481
>  create mode 100644 tests/generic/481.out
> 
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index 467b872e..258f5887 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -126,3 +126,122 @@ _log_writes_cleanup()
>  	$UDEV_SETTLE_PROG >/dev/null 2>&1
>  	_log_writes_remove
>  }
> +
> +# Convert log writes mark to entry number
> +# Result entry number is output to stdout, could be empty if not found
> +_log_writes_mark_to_entry_number()
> +{
> +	local _mark=$1

No need to name a local variable with leading underscore.

> +	local ret
> +
> +	[ -z "$_mark" ] && _fatal \
> +		"mark must be given for _log_writes_mark_to_entry_number"

Please use _fail instead of _fatal (and all the other places in this
patch). I think _fatal is only used at the initializing phase of the
test harness (e.g. check required tools, env etc.) and abort the test
run in early stage. _fail is used to indicate a failure in test phase,
it also logs the error messages in $seqres.full.

> +
> +	ret=$($here/src/log-writes/replay-log --find --log $LOGWRITES_DEV \
> +		--end-mark $_mark 2> /dev/null)

Is this output long or short? If it's a short one, e.g. a number or a
simple string, I think it's OK to save it in a variable. But if it's
long/complex enough and/or has multiple lines, I think we'd better to
save it with a tmp file, e.g. $tmp.<suffix>.

> +	[ -z "$ret" ] && return
> +	ret=$(echo "$ret" | cut -f1 -d\@)

Because I want to avoid echoing such a variable to a pipe (even it's
quoted), it used to cause subtle problems if not quoted properly.

Also, it'd be better to give a sample output of the replay-log command
in comment if it's short enough, so people could have an idea what it
looks like and know what you're looking for in the subsequent steps
(cut -f1 -d\@, in this example), and it's easier to review.

Above comments apply to other helper functions too.

Thanks for all the work!

Eryu
