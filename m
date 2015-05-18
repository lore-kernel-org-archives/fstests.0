Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53949 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbbERIQz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 18 May 2015 04:16:55 -0400
Date: Mon, 18 May 2015 16:16:51 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] _require_command: fixed typo
Message-ID: <20150518081651.GN1140@dhcp-13-216.nay.redhat.com>
References: <1431014916-1951-1-git-send-email-omzg@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431014916-1951-1-git-send-email-omzg@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Omer Zilberberg <omzg@plexistor.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 07, 2015 at 07:08:36PM +0300, Omer Zilberberg wrote:
> fixes 9435b92 common: _require_command needs to handle parameters
> 
> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 6ea107e..cd0f3e6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1299,7 +1299,7 @@ _require_command()
>  	fi
>  
>  	_command=`echo "$1" | awk '{ print $1 }'`
> -	if [ ! -x $command ]; then
> +	if [ ! -x $_command ]; then

Can you please send v2 with $_command quoted? I found that if $_command
is empty -x still treats it as executable, but not empty quoted string.

# prints ok
if [ -x ]; then echo ok; fi

# prints nothing
if [ -x "" ]; then echo ok; fi

Thanks,
Eryu
