Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C54CDB47E
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Oct 2023 14:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjJROJE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjJROJD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Oct 2023 10:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03AC10D
        for <fstests@vger.kernel.org>; Wed, 18 Oct 2023 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697638095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gxjr3FRAWUXmlL4dYt3wy5Ctb+m7y7/6eNZRQEsyw5s=;
        b=CpW3CaExn6V7vlJs2V47as21d7Gl314NVwherTdgndBRZP658DH1jecqgtZ+TW+egdT8qG
        dndO0EEwr6/5qP4sEkQ019WeeynElovuQcK3r22Yc0hml1cyaAMFjG6vsNTSrOBdVteV9j
        E4ZzQd4eb1ydxxI9LjjQuR6k2KvPmyQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-d0o6ZysPM9SCSXlWsKia0A-1; Wed, 18 Oct 2023 10:08:12 -0400
X-MC-Unique: d0o6ZysPM9SCSXlWsKia0A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-27d3345f079so3874005a91.0
        for <fstests@vger.kernel.org>; Wed, 18 Oct 2023 07:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697638091; x=1698242891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxjr3FRAWUXmlL4dYt3wy5Ctb+m7y7/6eNZRQEsyw5s=;
        b=XFf9YRcIjsTVch3phoOrWGU6S3h3DMgSUsHMK0Ze+p+DNN93uqMLVOaIAiMJhfOlpa
         I+sB+t1P9cxw7D4FVrUpRel4RkhFQ+9pFGfBdsHWeZdELI0WxJjhDFksfkWrnAOzGyS1
         b6jdUH3lvnOPkTf6zMholT2xjRlhSCEtpT7cRaThZWNpLefDoYMjn+GQU2gyEhJNNZrP
         sOYXKlRbDLWp5ZNFR88ISP2kxe+z/uYhXBq+OPsAHmfOGjC0Arfl2tcyYanHhpV/J33k
         hrIWtWyl9vpgTYgnVt2iY15H9bMru9jwgz3tFCz0n40WLZJDBAqpCSUJmELMXLbDHSWr
         T+NA==
X-Gm-Message-State: AOJu0YwKIB4QQDyq3O9tsWmSZDrp2j/ZMD9ftziBqwYKZl/2SX1AohBM
        6elZ0a6cr/yiOJfCc7F/LyKIOcm/iypHUyg2YjApNrAhhMUt9VmuDAogxVhPSBe9IMz0RYk59uH
        J6uS1tH+h2shLD9JYx+Lpm+tuuWhqMw0=
X-Received: by 2002:a17:90b:1082:b0:27c:ef06:38c3 with SMTP id gj2-20020a17090b108200b0027cef0638c3mr5159205pjb.21.1697638090717;
        Wed, 18 Oct 2023 07:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlqavad+q4lNO1MmJa5z5s6d7enM+7etCIaBd7y0nWFKrXX3zVzppW+/EpQq1dvRDNneRzDg==
X-Received: by 2002:a17:90b:1082:b0:27c:ef06:38c3 with SMTP id gj2-20020a17090b108200b0027cef0638c3mr5159175pjb.21.1697638090319;
        Wed, 18 Oct 2023 07:08:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a34c200b0027732eb24bbsm1493658pjf.4.2023.10.18.07.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 07:08:09 -0700 (PDT)
Date:   Wed, 18 Oct 2023 22:08:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Su Yue <glass.su@suse.com>
Cc:     fstests@vger.kernel.org, l@damenly.org
Subject: Re: [PATCH] generic/245: Filter mv error message
Message-ID: <20231018140806.zyb45abbwzdvxtlu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231005034255.2031-1-glass.su@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005034255.2031-1-glass.su@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 05, 2023 at 11:42:55AM +0800, Su Yue wrote:
> Coreutils commit 3cb862ce5f10 ( mv: better diagnostic for 'mv dir x' failure)
> was released in v9.4, changed the error message from
> 'mv: cannot move 'b/t' to 'a/t': Directory not empty' to
> 'mv: cannot overwrite 'a/t': Directory not empty' in case of
> EDQUOT/EEXIST/EISDIR/EMLINK/ENOSPC/ENOTEMPTY/ETXTBSY.
> 
> The change breaks generic/245 due to the mismatched output:
> 
> generic/245 1s ... - output mismatch (see /root/xfstests-dev/results//generic/245.out.bad)
>     --- tests/generic/245.out   2023-10-05 11:15:21.124295738 +0800
>     +++ /root/xfstests-dev/results//generic/245.out.bad 2023-10-05 11:15:23.456315468 +0800
>     @@ -1,2 +1,2 @@
>     QA output created by 245
>     -mv: cannot move 'TEST_DIR/test-mv/ab/aa/' to 'TEST_DIR/test-mv/aa': File exists
>     +mv: cannot overwrite 'TEST_DIR/test-mv/aa': File exists

Thanks for fixing this issue, I hit it too.

>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/245.out /root/xfstests-dev/results//generic/245.out.bad'  to see the entire diff)
> 
> Filter out the common part of mv error messages to fix the test.
> 
> Signed-off-by: Su Yue <glass.su@suse.com>
> ---
>  tests/generic/245     | 4 +++-
>  tests/generic/245.out | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/245 b/tests/generic/245
> index e2d5c926e906..31f9dd1873b6 100755
> --- a/tests/generic/245
> +++ b/tests/generic/245
> @@ -29,9 +29,11 @@ _cleanup()
>  # According to the rename(2) manpage you can get either EEXIST or ENOTEMPTY as an
>  # error for trying to rename a non-empty directory, so just catch the error for
>  # ENOTMEMPTY and replace it with the EEXIST output so that either result passes
> +# Also, mv v9.4+ modified error message when a nonempty destination directory fails
> +# to be overwriteen
>  _filter_directory_not_empty()
>  {
> -	sed -e "s,Directory not empty,File exists,g"
> +	sed -e "s,Directory not empty,File exists,g" -e "s/.* '\(.*\)':\(.*\)/mv: '\1':\2/"

As the first line uses "," to be the separator, so better to follow it.
And the ".* '\(.*\)':\(.*\)" is too "imprecise", better to give it more
specific strings to match, to avoid it replace something we don't want
to change. So how about:

	sed -e "s,Directory not empty,File exists,g" \
	    -e "s,cannot move .* to \(.*\):\(.*\),cannot overwrite \1:\2,g"

Thanks,
Zorro


>  }
>   
>  
> diff --git a/tests/generic/245.out b/tests/generic/245.out
> index f5b5f182619d..fb7f0f7908e7 100644
> --- a/tests/generic/245.out
> +++ b/tests/generic/245.out
> @@ -1,2 +1,2 @@
>  QA output created by 245
> -mv: cannot move 'TEST_DIR/test-mv/ab/aa/' to 'TEST_DIR/test-mv/aa': File exists
> +mv: 'TEST_DIR/test-mv/aa': File exists
> -- 
> 2.42.0
> 

