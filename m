Received: from mx1.redhat.com ([209.132.183.28]:37920 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbcHONw7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Aug 2016 09:52:59 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 509227F0B4
	for <fstests@vger.kernel.org>; Mon, 15 Aug 2016 13:52:59 +0000 (UTC)
Date: Mon, 15 Aug 2016 08:52:56 -0500
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: Re: [PATCH] add prjquota to _qmount_option() filter
Message-ID: <20160815135256.GA26458@redhat.com>
References: <b8fc0176-e023-42d0-717c-925999aa2ed0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8fc0176-e023-42d0-717c-925999aa2ed0@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 12, 2016 at 05:46:54PM -0500, Eric Sandeen wrote:
> _qmount_option() did not properly filter the
> "prjquota" mount option along with the "pquota"
> variant, as it does for the other types.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Bill O'Donnell <billodo@redhat.com>

> ---
> 
> diff --git a/common/quota b/common/quota
> index 32777a9..d91062a 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -190,6 +190,7 @@ _qmount_option()
>  		-e 's/gquota/QUOTA/g'      \
>  		-e 's/grpquota/QUOTA/g'    \
>  		-e 's/pquota/QUOTA/g'      \
> +		-e 's/prjquota/QUOTA/g'      \
>  		-e 's/quota/QUOTA/g'       \
>  		-e 's/uqnoenforce/QUOTA/g' \
>  		-e 's/gqnoenforce/QUOTA/g' \
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
