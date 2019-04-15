Received: from mail-pg1-f196.google.com ([209.85.215.196]:44194 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfDOEDQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Apr 2019 00:03:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id i2so7890419pgj.11
        for <fstests@vger.kernel.org>; Sun, 14 Apr 2019 21:03:16 -0700 (PDT)
Date: Mon, 15 Apr 2019 12:03:09 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/294: skip on NFS
Message-ID: <20190415040309.GN2824@desktop>
References: <20190304025008.11986-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304025008.11986-1-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Murphy Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, bcodding@redhat.com, yieli@redhat.com, bxue@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 04, 2019 at 10:50:08AM +0800, Xiong Zhou wrote:
> Because NFS handles this differently, returning different values.
> Details:
> http://people.redhat.com/bcodding/nfs/2016/10/07/nfs_xfstest_generic/#generic294
> 
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>

Sorry for the so long delay.. 

> ---
>  tests/generic/294 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/294 b/tests/generic/294
> index b74579ac..f7e763a3 100755
> --- a/tests/generic/294
> +++ b/tests/generic/294
> @@ -27,6 +27,7 @@ _cleanup()
>  . ./common/filter
>  
>  # real QA test starts here
> +[ $FSTYP == "nfs" ] && _notrun "NFS behaves differently, breaks golden output"

I think it's better to filter the output of NFS to follow the golden
output, so when NFS changes behavior, filter fails and we could know
that from test failure.

Thanks,
Eryu

>  
>  # Modify as appropriate.
>  _supported_fs generic
> -- 
> 2.21.0
> 
