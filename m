Received: from mx2.suse.de ([195.135.220.15]:54910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932134AbdDFMCe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 6 Apr 2017 08:02:34 -0400
Date: Thu, 6 Apr 2017 14:02:33 +0200
From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] fstests: Remove IRIX os support from template
Message-ID: <20170406140233.20dc6553@suse.de>
In-Reply-To: <20170405032628.22370-1-quwenruo@cn.fujitsu.com>
References: <20170405032628.22370-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, 5 Apr 2017 11:26:28 +0800, Qu Wenruo wrote:

> Since the last release of IRIX is already 10 years ago and support for
> it has ended after 2014, there is no need to support IRIX any way.
> 
> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> ---
>  new | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/new b/new
> index c21d8db..eb7da0f 100755
> --- a/new
> +++ b/new
> @@ -207,7 +207,7 @@ rm -f \$seqres.full
>  
>  # Modify as appropriate.
>  _supported_fs generic
> -_supported_os IRIX Linux
> +_supported_os Linux
>  _require_test
>  
>  # if error

Reviewed-by: David Disseldorp <ddiss@suse.de>

Looking forward to seeing the floodgates open for the rest of the Irix
removal changes.

Cheers, David
