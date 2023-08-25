Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F6C3DA66
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Aug 2023 13:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjHYNky (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 25 Aug 2023 09:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245287AbjHYNkm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Aug 2023 09:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8994E6F
        for <fstests@vger.kernel.org>; Fri, 25 Aug 2023 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692970795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iw4RA/v2fkfDtCAVUlGJtn1I23uskId0JWbV5XOA/Yo=;
        b=GTubQ/04Wc0j95nvW8zzRulqOgwfIV2NRDu188pu+/j2nrEQqcvJhEX+QfPAPNn5jZgkKA
        beJLa9fgA7YZ4TgQ8rOu0/yFGrBreaT1EU4idDfsI9ITS/47XJMaPhR35DBnS/SHj5J1XO
        Q6rP/o6eZGZXLecs3nfypnVKUo4iGYg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-1BHeXfqNMlibDfP0gyOAGg-1; Fri, 25 Aug 2023 09:39:53 -0400
X-MC-Unique: 1BHeXfqNMlibDfP0gyOAGg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5646e695ec1so829036a12.1
        for <fstests@vger.kernel.org>; Fri, 25 Aug 2023 06:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692970792; x=1693575592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iw4RA/v2fkfDtCAVUlGJtn1I23uskId0JWbV5XOA/Yo=;
        b=MqDn7TNL7Lk0EK/i2MZJhSNSsCtG0hWhvoO9EynbV+1PoxuZ83j6cpv52Oizh5kg/C
         Ikf4/7DmcwylWNc5gooFkS9fxssvfNl0uzkMUVVhKYF95gwkxL3zH7NTvkVZQqws7BQg
         awEs8cbr9GUvGlhuTgWIHuZpTWg9RX9Rp/6ii6C3PiF8YVTk98YKG1uoxnCnmxiC4HBx
         3nofl4pGW6RAyuX/4iBtQCOPqKdPVO5POy7tgJlFcW2YFMNSihE1I57ilcy5i3eFbjd3
         uXxmhzbgaeEVLBSD24BLznM9RHaGE9emflnH1/1462o/O3B/SwyauGdIJvvTw+IIraNr
         0GWg==
X-Gm-Message-State: AOJu0YwogCds1N/rIS1yhEvTkxyfd2QQmtkg9TBTTIMmvPLnDMNwV00t
        JK0HYoGitud865zICgbrDgn8X38HUsczFBgtdcaHZgAYMeOB2V1ycfnLED3lEJhd3C9gl1Ot9mZ
        /XK0RLyJ3R6/xQGjiu08rHZB1PQ==
X-Received: by 2002:a05:6a20:432a:b0:134:4f86:7990 with SMTP id h42-20020a056a20432a00b001344f867990mr21243083pzk.3.1692970792483;
        Fri, 25 Aug 2023 06:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR5jky8U64ioEVICqHQEyyB9CeQOde+hDy+hSbkUnmc7X4L9o8Kqty4xf2cMAHIOo+zDWKRg==
X-Received: by 2002:a05:6a20:432a:b0:134:4f86:7990 with SMTP id h42-20020a056a20432a00b001344f867990mr21243065pzk.3.1692970792159;
        Fri, 25 Aug 2023 06:39:52 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w4-20020a637b04000000b0055fd10306a2sm1563680pgc.75.2023.08.25.06.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:39:51 -0700 (PDT)
Date:   Fri, 25 Aug 2023 21:39:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] common/rc: introduce _random_file() helper
Message-ID: <20230825133948.oubggt74y7cmci2j@zlang-mailbox>
References: <cover.1692600259.git.naohiro.aota@wdc.com>
 <63147107b1aee89c21ef848857e0dc3964134392.1692600259.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63147107b1aee89c21ef848857e0dc3964134392.1692600259.git.naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 21, 2023 at 04:12:11PM +0900, Naohiro Aota wrote:
> Currently, we use "ls ... | sort -R | head -n1" (or tail) to choose a
> random file in a directory.It sorts the files with "ls", sort it randomly
> and pick the first line, which wastes the "ls" sort.
> 
> Also, using "sort -R | head -n1" is inefficient. For example, in a
> directory with 1000000 files, it takes more than 15 seconds to pick a file.
> 
>   $ time bash -c "ls -U | sort -R | head -n 1 >/dev/null"
>   bash -c "ls -U | sort -R | head -n 1 >/dev/null"  15.38s user 0.14s system 99% cpu 15.536 total
> 
>   $ time bash -c "ls -U | shuf -n 1 >/dev/null"
>   bash -c "ls -U | shuf -n 1 >/dev/null"  0.30s user 0.12s system 138% cpu 0.306 total
> 
> So, we should just use "ls -U" and "shuf -n 1" to choose a random file.
> Introduce _random_file() helper to do it properly.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  common/rc | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 5c4429ed0425..4d414955f6d9 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5224,6 +5224,13 @@ _soak_loop_running() {
>  	return 0
>  }
>  
> +# Return a random file in a directory. A directory is *not* followed
> +# recursively.
> +_random_file() {
> +	local basedir=$1
> +	echo "$basedir/$(ls -U $basedir | shuf -n 1)"

I think the "1" can be the second argument, for we might want to get a random
file list sometimes. For example:

  local basedir=$1
  local num=$2
  local opt

  if [ -n "$num" ];then
	  opt="-n $num"
  fi
  echo "$basedir/$(ls -U $basedir | shuf $opt)"

What do you think?

Thanks,
Zorro

> +}
> +
>  init_rc
>  
>  ################################################################################
> -- 
> 2.41.0
> 

