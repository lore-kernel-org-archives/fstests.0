Return-Path: <SRS0=0vMW=YG=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A34AC4CECE
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Oct 2019 12:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316962082F
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Oct 2019 12:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6OvTDVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfJMMqP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Oct 2019 08:46:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36284 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfJMMqP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Oct 2019 08:46:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23so8487192pgk.3;
        Sun, 13 Oct 2019 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gtVkxFWDnOERz9QtHd7FY1jWNQ++tjo/QQsXGSYHj5s=;
        b=D6OvTDVJz3Yr9ZOgYmbXjSqCUMfb5UovwJ2/QHOKxAJPRZWath3+puIjvDNqs+7m0P
         rq3cOz+QApMO2OGuSHfN7hpciP8NoJGIk23GY//x+b4GGTCE/eneSKBA6WkZ+3EvkWt7
         Zs+CN8uMLuRHh9xQNmu2/juq6zZfidK20pc80uM8IMK6Q1X8mDiuUquq8qL+ikhNWOF/
         Ufmcuki+516XFERthX+Hkj9iKxRwupw0UQeJfZiUfO9rxXyblT8I+endywfMF/OB2ixb
         HQfi68RqDfz5+7Fz0CzJaxfV507IjQbWlG9pNdpobASTPiV2WmRpizhBzuTC+yB2gZ0n
         u5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gtVkxFWDnOERz9QtHd7FY1jWNQ++tjo/QQsXGSYHj5s=;
        b=FoZENk3Ri1/Mem4e0k+UDNKoUR6QfHZreXT/nHEvfQHGEXpNuJT/jgsE4elZvGh5bJ
         YM7ZSRQoK7JefAbc9wnMP61gw2v/O3oyB0E76UHIL2dCuEPdQ0dMRPU82r1vb3RTXj4t
         X93Ki8mrBF/mcHzXrh7HM5zO9vFbJMMeqT4uWxvkg6z453/pNIZxG+a7mzuSxwWZOfnz
         deTJjl7G9tKQbO+JhH9UCm/x7kzwMFFpbQkhbvRnk/2Ht7k2XmdTkIi2Mn0u9juvyvsV
         8Cmor7QyxRIeyOAtLIvV/ilTQT0QlNQCpU7C6IMQF7pryDfBw5KUr7mqS8+IvEB1RXwc
         NJ9Q==
X-Gm-Message-State: APjAAAU4XfkV0/VQ65jWJvVuQwjf1veWwVGLBjiKeigARulRKxPSCWOw
        1MHmW4Gk3Ar/hPT9cCHIf7M=
X-Google-Smtp-Source: APXvYqw1AhGMPQkp8lsOGSfEyvQgVWSbN/O4lW5bxEQxnQFRB70xWClf6MNf2LGBQVFkDN5elL9+LQ==
X-Received: by 2002:a63:1242:: with SMTP id 2mr4970213pgs.288.1570970774706;
        Sun, 13 Oct 2019 05:46:14 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id q15sm14050398pgl.12.2019.10.13.05.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 05:46:13 -0700 (PDT)
Date:   Sun, 13 Oct 2019 20:46:07 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     darrick.wong@oracle.com, ebiggers@google.com, yi.zhang@huawei.com,
        fstests@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH xfstests] generic/192: Move 'cd /' to the place where the
 program exits
Message-ID: <20191013124607.GH2622@desktop>
References: <1570609677-49586-1-git-send-email-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570609677-49586-1-git-send-email-chengzhihao1@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 09, 2019 at 04:27:57PM +0800, Zhihao Cheng wrote:
> Running generic/192 with overlayfs(Let ubifs as base fs) yields the
> following output:
> 
>   generic/192 - output mismatch
>      QA output created by 192
>      sleep for 5 seconds
>      test
>     +./common/rc: line 316: src/t_dir_type: No such file or directory
>      delta1 is in range
>      delta2 is in range
>     ...
> 
> When the use case fails, the call stack in generic/192 is:
> 
>   local unknowns=$(src/t_dir_type $dir u | wc -l)	common/rc:316
>   _supports_filetype					common/rc:299
>   _overlay_mount					common/overlay:52
>   _overlay_test_mount					common/overlay:93
>   _test_mount						common/rc:407
>   _test_cycle_mount					generic/192:50
> 
> Before _test_cycle_mount() being invoked, generic/192 executed 'cd /'
> to change work dir from 'xfstests-dev' to '/', so src/t_dir_type was not
> found.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thanks for the debug! But I think the right fix is to call t_dir_type
via "$here", i.e.

	local unknowns=$($here/src/t_dir_type $dir u | wc -l)

'here', which points to the top level dir of xfstests source code, is
defined in every test in test setup, and is guaranteed not to be empty.

Thanks,
Eryu

> ---
>  tests/generic/192 | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/192 b/tests/generic/192
> index 50b3d6fd..5550f39e 100755
> --- a/tests/generic/192
> +++ b/tests/generic/192
> @@ -15,7 +15,12 @@ echo "QA output created by $seq"
>  here=`pwd`
>  tmp=/tmp/$$
>  status=1	# failure is the default!
> -trap "exit \$status" 0 1 2 3 15
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +}
>  
>  _access_time()
>  {
> @@ -46,7 +51,6 @@ sleep $delay # sleep to allow time to move on for access
>  cat $testfile
>  time2=`_access_time $testfile | tee -a $seqres.full`
>  
> -cd /
>  _test_cycle_mount
>  time3=`_access_time $testfile | tee -a $seqres.full`
>  
> -- 
> 2.13.6
> 
