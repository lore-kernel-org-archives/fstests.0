Received: from mx1.redhat.com ([209.132.183.28]:57845 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752156AbbHQOYM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 17 Aug 2015 10:24:12 -0400
Date: Mon, 17 Aug 2015 22:24:09 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] generic/084: use src/multi_open_unlink to replace
 tail command
Message-ID: <20150817142409.GY17933@dhcp-13-216.nay.redhat.com>
References: <1439819393-7713-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1439819393-7713-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 17, 2015 at 09:49:53PM +0800, Zorro Lang wrote:
> generic/084 try to run 'tail' command, tail will use inotify.
> There're some limit about the number of inotify. For example
> fs.inotify.max_user_instances specifies an upper limit on
> the number of inotify instances that can be created per real
> user ID.
> 
> When I test on a machine with 154 cpu cores, this case run
> failed, and hit many warning likes:
> 
>     +tail: inotify cannot be used, reverting to polling: Too many open files
> 
> Because the fs.inotify.max_user_instances is 128, so if we
> try to tail 154 files, it will be failed.
> 
> So use src/multi_open_unlink to instead of tail will avoid
> this problem.

Looks good to me overall, just some nitpicks :)

> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> Reviewed-by: Eryu Guan <eguan@redhat.com>
> Reviewed-by: Dave Chinner <david@fromorbit.com>

You shouldn't add "Reviewed-by" tags until reviewer said so.

> ---
>  tests/generic/084 | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/generic/084 b/tests/generic/084
> index 3fec6c2..d5061a7 100755
> --- a/tests/generic/084
> +++ b/tests/generic/084
> @@ -69,15 +69,8 @@ _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
>  
>  # create, open & unlinked files so unlinked inode list is not empty
> -for i in `seq 1 $nr_cpu`; do
> -	testfile=$SCRATCH_MNT/$seq.unlinked.$i
> -	touch $testfile
> -	tail -f $testfile &
> -	tail_pids="$tail_pids $!"
> -done
> -# give tail some time to open the file before the file is removed
> -sleep 1
> -rm -f $SCRATCH_MNT/$seq.unlinked.*
> +src/multi_open_unlink -f $SCRATCH_MNT/$seq.unlinked -n $nr_cpu -s 1000 &

I think the "-s 1000" is not necessary, the default sleep time is 60s
and that's enough for this test (sleep 5 below).

Thanks for fixing this case, and thanks Dave for the pointer to
multi_open_unlink. Now you can add

Reviewed-by: Eryu Guan <eguan@redhat.com>

in your v4 patch :)

Eryu
