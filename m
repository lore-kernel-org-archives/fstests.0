Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52612 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbbERIxm (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 18 May 2015 04:53:42 -0400
Date: Mon, 18 May 2015 16:53:38 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] _require_command: fixed typo
Message-ID: <20150518085338.GO1140@dhcp-13-216.nay.redhat.com>
References: <1431938861-8149-1-git-send-email-omzg@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431938861-8149-1-git-send-email-omzg@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Omer Zilberberg <omzg@plexistor.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 18, 2015 at 11:47:41AM +0300, Omer Zilberberg wrote:
> fixes 9435b92 common: _require_command needs to handle parameters
> 
> Also quoted $_command because _require_command may be called with an
> empty $1 parameter, e.g.:
> _require_command "$MY_UTIL_PROG" my_util  # but $MY_UTIL_PROG is empty
> 
> [ -x ] returns true.
> [ -x "" ] returns false, as required here.
> 
> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
> Reviewed-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Eryu Guan <eguan@redhat.com>

Thanks!

Eryu
> 
> v2: address Eryu's comment regarding quotation
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 6ea107e..68b07b8 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1299,7 +1299,7 @@ _require_command()
>  	fi
>  
>  	_command=`echo "$1" | awk '{ print $1 }'`
> -	if [ ! -x $command ]; then
> +	if [ ! -x "$_command" ]; then
>  		_notrun "$_name utility required, skipped this test"
>  	fi
>  }
> -- 
> 1.9.3
> 
