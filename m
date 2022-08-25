Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D43EC64991
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Aug 2022 14:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbiHYOn6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Aug 2022 10:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiHYOnh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Aug 2022 10:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5DAA61EC
        for <fstests@vger.kernel.org>; Thu, 25 Aug 2022 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661438570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+7PCv0HIxK9/L/mSvEX7Y0Dk2lvLA0vuhPLisj0hIU=;
        b=ZEbtp9sdnhfIrvQ69BYyMswumJbpSlICKiQtsX+Rx4CIh7kRGwbaFj9P6Zzf2cvmMnOsn5
        TiSVa9AsYft/akHbxZEwjCDQ80UoNBDchWdkEGIylDg/D+tThC1A2qHxvMgV7Svkjtxf27
        TtJZZIsuujE0Obs/BNKW2ur0G3y5klk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-aNIdsJigMEmvlTP-WZgVRw-1; Thu, 25 Aug 2022 10:42:49 -0400
X-MC-Unique: aNIdsJigMEmvlTP-WZgVRw-1
Received: by mail-qv1-f70.google.com with SMTP id dc16-20020a056214175000b0049717d038b5so2730812qvb.11
        for <fstests@vger.kernel.org>; Thu, 25 Aug 2022 07:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/+7PCv0HIxK9/L/mSvEX7Y0Dk2lvLA0vuhPLisj0hIU=;
        b=x/evxc/aBYobn9ME+/eobHq1xkyw7XvwBBmNzK/9Db7hhPYQ9SH1+TznQ6IYtinUwz
         QkWxmUdtvIN7zU7aICArWeKA8UsgnizRGgROZoMggPfI+X6A/9JMgkwX0y5I0GoLiRDS
         /LqSy7T/3IedS7ApvYSrR3/lWNo0il0t0WbQ5RY0DvLm/XWO2wHpDZYVBTxwDWtNHlDN
         hIFDZdCySw6woIAa8zfSu3Bk8pEnaqnP/NNp1/ACMccS6og7GW0ER30Q1xGJ7V0UU4AU
         JIpUMiC5e6yPtrGuOEyjng4TiJPHFKT9QVqiRnjinxyQzEhe8n+XJC9tITWv5UwkCUL3
         lJsA==
X-Gm-Message-State: ACgBeo1Lhl9ZjCgjR+TY3YCM5iqYZibvOCrGLd6EP9Rv3LC0dCqnlV+H
        RoSxhuZsF7mdPk/o0bZ7/mJkZiTF/b3RAziByZrdKirot2IAVlWYAI1/0IT0gD7L0F+A5zUOJCk
        bkJiZSQQU9v8STAGq4Q==
X-Received: by 2002:a05:620a:16d4:b0:6bc:4df0:2118 with SMTP id a20-20020a05620a16d400b006bc4df02118mr3107804qkn.574.1661438568396;
        Thu, 25 Aug 2022 07:42:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6myzjnCoiwHSiqk4WpiY6qnqJEMjW02AqywL4lqUQFq6uJNZnCiDHFjm/Kzx9paJd+AUaEcQ==
X-Received: by 2002:a05:620a:16d4:b0:6bc:4df0:2118 with SMTP id a20-20020a05620a16d400b006bc4df02118mr3107790qkn.574.1661438568128;
        Thu, 25 Aug 2022 07:42:48 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b006bb9125363fsm18144433qki.121.2022.08.25.07.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 07:42:47 -0700 (PDT)
Date:   Thu, 25 Aug 2022 22:42:42 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: get section config after RUN_SECTION checks
Message-ID: <20220825144242.25zstpvox5dcrvmg@zlang-mailbox>
References: <f214d554b294bd3d2515742ad3bd7eeeab4d361f.1661369519.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f214d554b294bd3d2515742ad3bd7eeeab4d361f.1661369519.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 24, 2022 at 03:32:10PM -0400, Josef Bacik wrote:
> While trying to do
> 
> ./check -s <some section>
> 
> I was failing because I had a section defined higher than <some section>
> that had TEST_DEV=/some/nonexistent/device, since I was using the other
> section to test an experimental drive.  This appears to be because we
> run through all of the sections, and when getting the section config we
> check to see if it's valid, and in this case the section wasn't valid.
> 
> The section I was actually trying to use was valid however.  Fix check
> to see if the section we're trying to run is in our list of sections to
> run first, and then if it is get the config at that point.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

May you provide any specific config examples to clarify what kind of issue
you feel wrong, and what kind of usage you hope to support :)

Thanks,
Zorro

>  check | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index 0b2f10ed..ad0ab3cf 100755
> --- a/check
> +++ b/check
> @@ -678,7 +678,6 @@ function run_section()
>  
>  	OLD_FSTYP=$FSTYP
>  	OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
> -	get_next_config $section
>  
>  	# Do we need to run only some sections ?
>  	if [ ! -z "$RUN_SECTION" ]; then
> @@ -708,6 +707,8 @@ function run_section()
>  		fi
>  	fi
>  
> +	get_next_config $section
> +
>  	mkdir -p $RESULT_BASE
>  	if [ ! -d $RESULT_BASE ]; then
>  		echo "failed to create results directory $RESULT_BASE"
> -- 
> 2.26.3
> 

