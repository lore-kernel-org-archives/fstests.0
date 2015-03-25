Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37563 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbbCYXI6 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Mar 2015 19:08:58 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2PN8wWo017678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 25 Mar 2015 19:08:58 -0400
Date: Wed, 25 Mar 2015 19:08:56 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 9/9] generic/077: add missing _require_scratch
Message-ID: <20150325230856.GD13510@bfoster.bfoster>
References: <1426846618-23413-1-git-send-email-eguan@redhat.com>
 <1426846618-23413-10-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426846618-23413-10-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 20, 2015 at 06:16:58PM +0800, Eryu Guan wrote:
> generic/077 uses $SCRATCH_DEV without _require_scratch. Add it back.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---

Looks good...

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/generic/077 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/077 b/tests/generic/077
> index 0d6aec7..8405b02 100755
> --- a/tests/generic/077
> +++ b/tests/generic/077
> @@ -54,6 +54,7 @@ _supported_os Linux
>  
>  [ ! -d $filler ] && _notrun "No directory to source files from"
>  
> +_require_scratch
>  _require_attrs
>  _require_acls
>  _require_user
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
