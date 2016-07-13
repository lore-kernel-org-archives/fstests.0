Received: from mx1.redhat.com ([209.132.183.28]:41017 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbcGMM3e (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 13 Jul 2016 08:29:34 -0400
Date: Wed, 13 Jul 2016 20:28:59 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 4/4] xfstests: filename handling - fix early wildcard
 expansion
Message-ID: <20160713122859.GV2432@eguan.usersys.redhat.com>
References: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
 <1468229169-24045-5-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468229169-24045-5-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 11, 2016 at 11:26:09AM +0200, Jan Tulak wrote:
> Add quotation marks around the wildcarded name.

This makes no difference for me, the original code is working well. Did
I miss anything?

[root@dhcp-66-86-11 xfstests]# bname=999
[root@dhcp-66-86-11 xfstests]# find tests/xfs -name "$bname*"
tests/xfs/999-test-case
tests/xfs/999-test-case.out
[root@dhcp-66-86-11 xfstests]# find tests/xfs -name $bname*
tests/xfs/999-test-case
tests/xfs/999-test-case.out

Thanks,
Eryu

> 
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
>  check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index 58d8869..5ff897b 100755
> --- a/check
> +++ b/check
> @@ -548,7 +548,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  	        # and the test has a name. A bit of hassle to find really
>  	        # the test and not its sample output or helping files.
>  	        bname=$(basename $seq)
> -	        full_seq=$(find $(dirname $seq) -name $bname* -executable |
> +	        full_seq=$(find $(dirname $seq) -name "$bname*" -executable |
>  	            awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
>  	            	END { print shortest }')
>  	        if [ -f $full_seq ] \
> -- 
> 2.5.5
> 
