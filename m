Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE321C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 08:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346869AbiETIg7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344658AbiETIg6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 04:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3B6556F90
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653035815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PHWQkYf75+dMPt46BWy6ZRmvtYnvMdWtSn089saRThI=;
        b=YULjbmxPXhooPMzEeXqX6fLpOo3mtYQELZleCAGp6+qGwk8eUKsgW9TGe9IdlP9Cf28AXL
        eNigHbXIrOvHlwLJyFG4gzWoLv00zqKx3KsTchmCmZnTzDVfzRJYbtvQy7e0NE4DOUSDMs
        s8iYvHGJmfWreK8i9NsXz9uRd+ffMgI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-YdUkI7lgOzSVYkTGW2b6Ng-1; Fri, 20 May 2022 04:36:54 -0400
X-MC-Unique: YdUkI7lgOzSVYkTGW2b6Ng-1
Received: by mail-qv1-f70.google.com with SMTP id c9-20020a056214146900b00461c7b83672so6189035qvy.7
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 01:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PHWQkYf75+dMPt46BWy6ZRmvtYnvMdWtSn089saRThI=;
        b=f2mcRxTjsjRMo9/SbL7o3EZKLBpeHVYYJmbhFWqOfRnW6f0sh2WhyJNMFi7VP6eZq9
         Qx1Ih1wACui10Fa2mCGqRYnFPz9D+RE4XGAUPEYX2lhy1c7B5vnBmuKg9vOY7m43bJct
         iCsUb2Gez8C9bw5q7QkrpVwUF4/1sXcT8q0EyNf+XKG0hhDpA/Fkkh6d7nJhIkauUuHS
         YFh4eQGUrCWP6fhnvy2gP+tmLSzYlLf2DpuI0zfB6HdFYabAradvjOHboR7UMP7EsAVx
         JVlXkKZRd+QWFO4Ue7KeUGaaNGDn2ZZRgiI+ZaL45FWDzh/SqOBAdsZ3axVJgYHhI+wO
         /Y2Q==
X-Gm-Message-State: AOAM531+3wZ0Sb6eok+2a3b9CxmJXLR2vwt/f03rVt9ZLi78R6R8DNwo
        VYrTkJF/6u5i5abGFMF5a4GF12K1eKhtk6wWH0a5prAZt2dgUar1sPJkqPYvLpii0r6b4QJP0ru
        f71SwQXm73+Abvca85w==
X-Received: by 2002:a05:620a:16d1:b0:6a3:45d7:f83 with SMTP id a17-20020a05620a16d100b006a345d70f83mr2917566qkn.372.1653035813641;
        Fri, 20 May 2022 01:36:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmhK7Gx8VWDLCswx13e74Is73WdHMaPTHidt8JFfbA3NI5O3M39aKwc/dvj+JYBo2ovV6fjA==
X-Received: by 2002:a05:620a:16d1:b0:6a3:45d7:f83 with SMTP id a17-20020a05620a16d100b006a345d70f83mr2917559qkn.372.1653035813343;
        Fri, 20 May 2022 01:36:53 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i18-20020ac860d2000000b002f39b99f6b9sm2036656qtm.83.2022.05.20.01.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 01:36:52 -0700 (PDT)
Date:   Fri, 20 May 2022 16:36:47 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 04/12] fstests: fix group list generation for whacky test
 names
Message-ID: <20220520083647.s22yb2aearmviffi@zlang-mailbox>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517070111.1381936-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517070111.1381936-5-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 17, 2022 at 05:01:03PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Darrick noticed that tests/xfs/191-input-validation didn't get
> generated properly. Fix the regex to handle this.
> 
> $ grep -I -R "^_begin_fstest" tests/xfs | \
>   sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' |grep 191
> tests/xfs/191-input-validation:_begin_fstest auto quick mkfs realtime
> $
> $ grep -I -R "^_begin_fstest" tests/xfs | \
>   sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/ ' |grep 191
> 191 auto quick mkfs realtime
> $
> 
> Use the regexes for matching test names defined in common/test_names
> rather than trying to open code it.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Hi Dave,

After testing, looks like this patch brings in a regression issue, it causes
case number aren't sorted in group.list, then the xfstests/new program can't
get a right new case number which is unused. For example:

# make
# ./new generic
Next test id is 019
Append a name to the ID? Test name will be 019-$name. y,[n]: ^C
# ls tests/generic/019
tests/generic/019

Then comparing the tests/generic/group.list with old generic/group.list, found
lots of difference, due to the number in new group.list isn't sorted from
small to big (I haven't gotten chance to check if there're missing number).

Thanks,
Zorro

>  tools/mkgroupfile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> index 24435898..414cb538 100755
> --- a/tools/mkgroupfile
> +++ b/tools/mkgroupfile
> @@ -19,6 +19,8 @@ if [ ! -x ../../check ]; then
>  	exit 1
>  fi
>  
> +. ../../common/test_names
> +
>  cleanup()
>  {
>  	rm -f $new_groups.check
> @@ -60,7 +62,8 @@ ENDL
>  
>  	# Aggregate the groups each test belongs to for the group file
>  	grep -I -R "^_begin_fstest" $test_dir/ | \
> -		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
> +		sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" \
> +		>> $new_groups
>  
>  	# Create the list of unique groups for existence checking
>  	grep -I -R "^_begin_fstest" $test_dir/ | \
> -- 
> 2.35.1
> 

