Received: from mx1.redhat.com ([209.132.183.28]:46408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbcIXLzu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 24 Sep 2016 07:55:50 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A3D8C04B30A
        for <fstests@vger.kernel.org>; Sat, 24 Sep 2016 11:55:50 +0000 (UTC)
Received: from localhost (dhcp-12-196.nay.redhat.com [10.66.12.196])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8OBtmoJ031744
        for <fstests@vger.kernel.org>; Sat, 24 Sep 2016 07:55:49 -0400
Date: Sat, 24 Sep 2016 19:55:48 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/317: use id to get user id
Message-ID: <20160924115548.GC12847@dhcp12-143.nay.redhat.com>
References: <1474649676-31602-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474649676-31602-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Sep 24, 2016 at 12:54:36AM +0800, Eryu Guan wrote:
> Greping username "fsgqa" in passwd file to get user id doesn't
> always work, because the given username could match multiple
> entries, e.g. when we have user "123456-fsgqa" (used by other tests)
> in passwd file.
> 
> Fix it by using "id -u $qa_user" to get the user id directly.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/generic/317 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/317 b/tests/generic/317
> index 9d9499b..7e40b1f 100755
> --- a/tests/generic/317
> +++ b/tests/generic/317
> @@ -61,7 +61,7 @@ _require_scratch
>  _require_user
>  _require_ugid_map
>  _require_userns
> -qa_user_id=`grep $qa_user /etc/passwd |awk -F: '{print $3}'`
> +qa_user_id=`id -u $qa_user`

Looks good to me.
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  _filter_output()
>  {
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
