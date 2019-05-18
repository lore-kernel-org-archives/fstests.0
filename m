Received: from mx1.redhat.com ([209.132.183.28]:54636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfERDzh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 May 2019 23:55:37 -0400
Date: Sat, 18 May 2019 11:55:34 +0800
From: Murphy Zhou <xzhou@redhat.com>
Subject: Re: [PATCH 2/2] overlay/023: use numeric user and group IDs in
 getfacl
Message-ID: <20190518035534.7dtcygww65hneuby@XZHOUW.usersys.redhat.com>
References: <20190517112422.20671-1-lhenriques@suse.com>
 <20190517112422.20671-3-lhenriques@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517112422.20671-3-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: fstests@vger.kernel.org, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, May 17, 2019 at 12:24:22PM +0100, Luis Henriques wrote:
> This prevents test failures if cases where, e.g., /etc/group doesn't
> include the 'root' group ID.

Ack for this patch(I don't see that other 1/2 one). Thanks!

Xiong

> 
> Cc: Xiong Zhou <xzhou@redhat.com>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  tests/overlay/023     | 2 +-
>  tests/overlay/023.out | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/overlay/023 b/tests/overlay/023
> index 7e48349d1a12..edd034c3a9e3 100755
> --- a/tests/overlay/023
> +++ b/tests/overlay/023
> @@ -55,7 +55,7 @@ setfacl -d -m o::rwx $wkdir
>  _scratch_mount
>  
>  # getting acls, ACL set on workdir should be cleaned
> -getfacl -p $wkdir/work 2>&1 | _filter_scratch | _filter_ovl_dirs
> +getfacl -n -p $wkdir/work 2>&1 | _filter_scratch | _filter_ovl_dirs
>  
>  # success, all done
>  status=0
> diff --git a/tests/overlay/023.out b/tests/overlay/023.out
> index 4a243c5b44ce..911d272d2241 100644
> --- a/tests/overlay/023.out
> +++ b/tests/overlay/023.out
> @@ -1,7 +1,7 @@
>  QA output created by 023
>  # file: SCRATCH_DEV/OVL_WORK/work
> -# owner: root
> -# group: root
> +# owner: 0
> +# group: 0
>  user::---
>  group::---
>  other::---
