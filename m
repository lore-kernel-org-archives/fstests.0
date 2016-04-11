Received: from mx1.redhat.com ([209.132.183.28]:47568 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753763AbcDKLj6 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 11 Apr 2016 07:39:58 -0400
Date: Mon, 11 Apr 2016 19:39:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] gitignore: add src/holetest
Message-ID: <20160411113956.GI10345@eguan.usersys.redhat.com>
References: <1460361906-7054-1-git-send-email-omzg@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460361906-7054-1-git-send-email-omzg@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Omer Zilberberg <omzg@plexistor.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 11, 2016 at 11:05:06AM +0300, Omer Zilberberg wrote:
> Recently added 450d833 (generic/338: Add mmap race test) added a new
> binary, it should be added to .gitignore as well.
> 
> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index f9ea1fa..552d2a8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -60,6 +60,7 @@
>  /src/getpagesize
>  /src/godown
>  /src/holes
> +/src/holetest
>  /src/itrash
>  /src/locktest
>  /src/loggen
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
