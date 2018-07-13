Received: from mail-pl0-f65.google.com ([209.85.160.65]:46700 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeGMGwl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Jul 2018 02:52:41 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so11755081pld.13
        for <fstests@vger.kernel.org>; Thu, 12 Jul 2018 23:39:30 -0700 (PDT)
Date: Fri, 13 Jul 2018 14:39:25 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/062: filter redundant output by getfattr
Message-ID: <20180713063925.GA2830@desktop>
References: <20180712155926.21722-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712155926.21722-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 12, 2018 at 11:59:26PM +0800, Zorro Lang wrote:
> When getfattr dumps values of all extended attributes (-d option),
> it doesn't print empty extended attributes. e.g: user.name. But
> from attr-2.4.48 this behavior is changed,  new getfattr prints
> user.name="".
> 
> The {=""} will break the golden image, so filter the redundant =""
> at the end if it has.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> This's a bad news. Latest attr package attr-2.4.48 changed his
> behavior as above. And this's different with attr-2.4.47.
> 
> With old attr:
> # setfattr -h -n user.name testfile
> # getfattr -d -n user.name testfile                                                                                                                                     
> # file: testfile                               
> user.name
> 
> With new attr:
> # setfattr -h -n user.name testfile
> # getfattr -d -n user.name testfile                                                                                                                                     
> # file: testfile                               
> user.name=""
> 
> Note: -d option is necessary
> 
> This little difference will break golden image. So this's the problem.
> If you have better idea than this patch, please tell me.
> 
> Thanks,
> Zorro
> 
> 
>  tests/generic/062 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/062 b/tests/generic/062
> index df67960d..4fc2dc46 100755
> --- a/tests/generic/062
> +++ b/tests/generic/062
> @@ -29,9 +29,13 @@ _cleanup()
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
> +# When getfattr dump values of all extended attributes, it print empty attr
> +# as user.name before, but new getfattr print it as user.name="". For match
> +# the golden image, filter the redundant ="" at the end.
>  getfattr()
>  {
> -    $GETFATTR_PROG --absolute-names -dh $@ 2>&1 | _filter_scratch
> +    $GETFATTR_PROG --absolute-names -dh $@ 2>&1 | _filter_scratch | \
> +	sed -e 's/=\"\"//'
>  }

This should really be done by a new helper function that hides all the
details, so future tests could just take use of the helper.

Thanks,
Eryu

>  
>  setfattr()
> -- 
> 2.14.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
