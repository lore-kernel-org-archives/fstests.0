Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933145AbeGJNic (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Jul 2018 09:38:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0825840AC6DF
        for <fstests@vger.kernel.org>; Tue, 10 Jul 2018 13:38:32 +0000 (UTC)
Date: Tue, 10 Jul 2018 15:38:29 +0200
From: Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH v2] generic/499: filter fsx stderr output
Message-ID: <20180710133829.tjpwdjvdyk7osqvz@localhost.localdomain>
References: <20180710125243.4956-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710125243.4956-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 10, 2018 at 08:52:43PM +0800, Zorro Lang wrote:
> On some old kernel which supports COLLAPSE_RANGE and ZERO_RANGE,
> but doesn't support INSERT_RANGE, this case alway fails as:
> 
>    QA output created by 499
>   +main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, disabling!
>    Silence is golden
> 
> fsx print one more line to break the golden image.
> 
> To fix this issue, redirect both fsx stdout and stderr to a file,
> then check the return value.

Looks good, thanks.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> V1 as below (thanks Lukas):
> https://marc.info/?l=fstests&m=153122545923371&w=2
> 
> V2 use "2>&1" to instead of "-I".
> 
> Thanks,
> Zorro
> 
>  tests/generic/499 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/499 b/tests/generic/499
> index 99d6d308..773eab2e 100755
> --- a/tests/generic/499
> +++ b/tests/generic/499
> @@ -50,7 +50,7 @@ ENDL
>  
>  victim=$SCRATCH_MNT/a
>  touch $victim
> -$here/ltp/fsx --replay-ops $tmp.fsxops $victim > $tmp.output || cat $tmp.output
> +$here/ltp/fsx --replay-ops $tmp.fsxops $victim > $tmp.output 2>&1 || cat $tmp.output
>  
>  echo "Silence is golden"
>  status=0
> -- 
> 2.14.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
