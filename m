Received: from mx1.redhat.com ([209.132.183.28]:43775 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082AbbHNG6L (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 14 Aug 2015 02:58:11 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 3B9A5A103F
	for <fstests@vger.kernel.org>; Fri, 14 Aug 2015 06:58:11 +0000 (UTC)
Date: Fri, 14 Aug 2015 14:58:07 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/084: check inotify limit before tail many files
Message-ID: <20150814065807.GL17933@dhcp-13-216.nay.redhat.com>
References: <1439482592-29611-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1439482592-29611-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 14, 2015 at 12:16:32AM +0800, Zorro Lang wrote:
> generic/084 try to run 'tail' command, tail will use
> inotify, and there're some limit about inotify. I think
> the most important is fs.inotify.max_user_instances, then
> fs.inotify.max_user_watches is importand too.

max_user_watches is much larger (usually 8k?) than max_user_instances
(128), I think we can skip the max_user_watches check here.

> 
> When I test on a machine with 154 cpu cores, this case
> run failed, and hit many warning likes:
> 
>     tail: inotify cannot be used, reverting to polling: Too many
>     open files

No need to wrap lines for quoted logs.

> 
> Because the fs.inotify.max_user_instances is 128, so if
> we try to tail 154 files, it will be failed.
> 
> Of course, open files limit will effect this too. But generally
> max_user_instances is the minimum number, so I don't check open
> file limit.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/generic/084 | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tests/generic/084 b/tests/generic/084
> index 3fec6c2..f34d4b2 100755
> --- a/tests/generic/084
> +++ b/tests/generic/084
> @@ -63,6 +63,15 @@ link_unlink_storm()
>  
>  rm -f $seqres.full
>  nr_cpu=`$here/src/feature -o`
> +user_watches=`sysctl -n fs.inotify.max_user_watches`
> +user_instances=`sysctl -n fs.inotify.max_user_instances`

I think we need some comments in the code too.

> +
> +user_limit=$((user_watches > user_instances ? user_instances : user_watches))

Please use plain if:then

> +if [ $nr_cpu -ge $((user_limit/2)) ]
> +then

if []; then
fi

this is the preferred format in xfstests

> +	nr_cpu=$((user_limit/2))

Need comments to explain why divide by 2.

Thanks,
Eryu
> +fi
> +
>  echo "Silence is golden"
>  
>  _scratch_mkfs >>$seqres.full 2>&1
> -- 
> 1.9.3
> 
