Received: from mx1.redhat.com ([209.132.183.28]:52084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbcJKKmY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Oct 2016 06:42:24 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17DB5E0374
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2016 10:42:24 +0000 (UTC)
Date: Tue, 11 Oct 2016 18:42:22 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/317: fixup grep for qa_user_id
Message-ID: <20161011104222.GS27776@eguan.usersys.redhat.com>
References: <fb1905dab09a7e9d9d8952da56d90aaba2403a57.1476181339.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb1905dab09a7e9d9d8952da56d90aaba2403a57.1476181339.git.bcodding@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Benjamin Coddington <bcodding@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 11, 2016 at 06:26:38AM -0400, Benjamin Coddington wrote:
> The grep for $qa_user_id can return more than one entry.
> 
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  tests/generic/317 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/317 b/tests/generic/317
> index 9d9499ba04dd..ddaa6b59afc5 100755
> --- a/tests/generic/317
> +++ b/tests/generic/317
> @@ -61,7 +61,7 @@ _require_scratch
>  _require_user
>  _require_ugid_map
>  _require_userns
> -qa_user_id=`grep $qa_user /etc/passwd |awk -F: '{print $3}'`
> +qa_user_id=`grep ^${qa_user}: /etc/passwd |awk -F: '{print $3}'`

Hi Ben,

I have a patch[1] to fix this too (in a different way), and it's in my
last pull request[2] to Dave, though he hasn't pushed them to upstream
yet. Does it work for you?

Thanks,
Eryu

[1] http://www.spinics.net/lists/fstests/msg03977.html
[2] http://www.spinics.net/lists/fstests/msg04095.html

>  
>  _filter_output()
>  {
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
