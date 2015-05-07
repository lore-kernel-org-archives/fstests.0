Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:60480 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbbEGQJg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 7 May 2015 12:09:36 -0400
Message-ID: <554B8E3F.6030608@sandeen.net>
Date: Thu, 07 May 2015 11:09:35 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH] _require_command: fixed typo
References: <1431014916-1951-1-git-send-email-omzg@plexistor.com>
In-Reply-To: <1431014916-1951-1-git-send-email-omzg@plexistor.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Omer Zilberberg <omzg@plexistor.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 5/7/15 11:08 AM, Omer Zilberberg wrote:
> fixes 9435b92 common: _require_command needs to handle parameters
> 
> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>

Yep, thanks!

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

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
>  		_notrun "$_name utility required, skipped this test"
>  	fi
>  }
> 

