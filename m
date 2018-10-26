Received: from mx1.redhat.com ([209.132.183.28]:43578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbeJZXSM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 26 Oct 2018 19:18:12 -0400
Date: Fri, 26 Oct 2018 09:40:51 -0500
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: Re: [PATCH] generic: update group file to indicate generic/456 uses
 {collapse,zero}_range
Message-ID: <20181026144051.GA31432@redhat.com>
References: <20181026115349.4241-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026115349.4241-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Oct 26, 2018 at 07:53:49AM -0400, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

Reviewed-by: Bill O'Donnell <billodo@redhat.com>

>  tests/generic/group | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/group b/tests/generic/group
> index 28452732..8a21970e 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -458,7 +458,7 @@
>  453 auto quick dir
>  454 auto quick attr
>  455 auto log replay
> -456 auto quick metadata
> +456 auto quick metadata collapse zero
>  457 auto log replay clone
>  458 auto quick clone collapse zero
>  459 auto thin
> -- 
> 2.18.0.rc0
> 
