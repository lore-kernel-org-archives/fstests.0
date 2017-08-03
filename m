Received: from mx1.redhat.com ([209.132.183.28]:46040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752366AbdHCLxo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 3 Aug 2017 07:53:44 -0400
Date: Thu, 3 Aug 2017 07:53:43 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] new: validate groups when creating new test
Message-ID: <20170803115342.GC62447@bfoster.bfoster>
References: <20170728062522.16916-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170728062522.16916-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, sandeen@sandeen.net
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 28, 2017 at 02:25:22PM +0800, Eryu Guan wrote:
> Allow only lower case letters, digits, spaces and underscore when
> adding groups, give prompt if there's any not-allowed characters.
> Also remove redundant spaces between groups.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  new | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/new b/new
> index eb7da0ff463b..4eacccd3bf8b 100755
> --- a/new
> +++ b/new
> @@ -239,7 +239,7 @@ then
>  
>      while true
>      do
> -	echo -n "Add to group(s) [other] (? for list): "
> +	echo -n "Add to group(s) [other] (separate by space, ? for list): "
>  	read ans
>  	[ -z "$ans" ] && ans=other
>  	if [ "X$ans" = "X?" ]
> @@ -254,7 +254,17 @@ then
>  	    lst=`for word in $grpl; do echo $word; done | sort| uniq `
>  	    echo $lst
>  	else
> -	    break
> +	    # only allow lower cases, spaces, digits and underscore in group
> +	    inval=`echo $ans | tr -d '[:lower:][:space:][:digit:]_'`
> +	    if [ "$inval" != "" ]; then
> +		echo "Invalid characters in group(s): $inval"
> +		echo "Only lower cases, digits and underscore are allowed in groups, separated by space"
> +		continue
> +	    else
> +		# remove redundant spaces/tabs
> +		ans=`echo "$ans" | sed 's/\s\+/ /g'`
> +		break
> +	    fi
>  	fi
>      done
>  else
> -- 
> 2.13.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
