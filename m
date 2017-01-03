Received: from mx1.redhat.com ([209.132.183.28]:35480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753671AbdACFGK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 3 Jan 2017 00:06:10 -0500
Date: Tue, 3 Jan 2017 13:06:07 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] check: support include/exclude of sub groups
Message-ID: <20170103050607.GJ1859@eguan.usersys.redhat.com>
References: <1483363379-10210-1-git-send-email-amir73il@gmail.com>
 <1483363379-10210-2-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483363379-10210-2-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 02, 2017 at 03:22:59PM +0200, Amir Goldstein wrote:
> Allow including and/or excluding tests by test dir and group.
> -g and -x command line arguments can take the form of
> <subdir>/<group>.
> 
> For example:
> 
> ./check -n -g xfs/quick
> ./check -n -g stress -x xfs/stress
> ./check -n -g xfs/punch -x dangerous_fuzzers
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

This looks handy to me! Mention this usage in usage() function too?

Thanks,
Eryu

> ---
>  check | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/check b/check
> index faf6281..8d1ec71 100755
> --- a/check
> +++ b/check
> @@ -105,6 +105,14 @@ get_group_list()
>  {
>  	local grp=$1
>  	local grpl=""
> +	local sub=$(dirname $grp)
> +
> +	if [ -n "$sub" -a "$sub" != "." -a -d "$SRC_DIR/$sub" ]; then
> +		# group is given as <subdir>/<group> (e.g. xfs/quick)
> +		grp=$(basename $grp)
> +		get_sub_group_list $sub $grp
> +		return
> +	fi
>  
>  	for d in $SRC_GROUPS $FSTYP; do
>  		if ! test -d "$SRC_DIR/$d" ; then
> -- 
> 2.7.4
> 
