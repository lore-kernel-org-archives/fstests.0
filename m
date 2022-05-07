Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EB5C433F5
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 13:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387268AbiEGNhe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 09:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385152AbiEGNhe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 09:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94BC5369C9
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 06:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651930426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XyotHlnPBZMTbWwbWZV56jLBQCGIO3aie4DIO5CGBeM=;
        b=WYxLIUdqUJpS7NF7wIQnjK0CueZb/nirxb88dY2YiYhONVkxVNfA6lPmElVadkYJPaW7Fc
        8+kZqWBIpXdQt5RYLtJ9QDkkXjHlUEsX2emwnqgo4zZ1s1g8WkuqgsIbDtkM7C/sffpIzl
        DCHbXNMqMtkufhxxRi9y/JMSWSg4m9s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-En1QveDcOmapqc-eHjdiCw-1; Sat, 07 May 2022 09:33:37 -0400
X-MC-Unique: En1QveDcOmapqc-eHjdiCw-1
Received: by mail-qt1-f200.google.com with SMTP id u11-20020a05622a198b00b002f3be513f83so5666282qtc.4
        for <fstests@vger.kernel.org>; Sat, 07 May 2022 06:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XyotHlnPBZMTbWwbWZV56jLBQCGIO3aie4DIO5CGBeM=;
        b=1UhH5DNDVEcu7xKrJgHXg1s8C7aaOR57zPo+9749JswuklF5M8LwFn/RHhV8EVtn3E
         eJH56E2XRla9QXlBloSnnGZxnrNxEWYgNsaw+s61JI66N2faYNB1GnHuv13xUj9PsmJ8
         M4eOy3U2YSfkyrqzDQoLBR5JR+w6Lh5NcrLMHlKeGO38k4sdBWr0XdE290p4q4Jpj8NA
         iDk1+XIxOwYLjxsR1ACipo8RdmXWpBgI90wTEn/WAsT8pBjDeOQoY1HEJ8jVLbz63fcD
         vHxr9vxPohHgXJkatZHCoX/OyPdpYn3stZTP5Ze6K4hZWQwhtMGGf3iq1UkqJBablz5f
         PZSw==
X-Gm-Message-State: AOAM5314ys3OBAQqmcQu/oAz073tPwaHUVZ27Tv+OBmJjjtMgIcsyFx/
        IV1AxRaIUxywCfu1vBRjXDxZPNuTxO6IXpzuikk2vyD7jC+gUwOSbugoSTesLWLjPH8pLYv6Lek
        WizF8EX35023Z2B31aA==
X-Received: by 2002:ac8:5f0d:0:b0:2f3:b0d6:fb6f with SMTP id x13-20020ac85f0d000000b002f3b0d6fb6fmr7300804qta.663.1651930417015;
        Sat, 07 May 2022 06:33:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxygjzsutNY00Piq+Q/Su60QU41qUNYOoCdOYhiBDj+IBvdTk7ZkR014dUPH0Ys1ohMGBtobQ==
X-Received: by 2002:ac8:5f0d:0:b0:2f3:b0d6:fb6f with SMTP id x13-20020ac85f0d000000b002f3b0d6fb6fmr7300787qta.663.1651930416789;
        Sat, 07 May 2022 06:33:36 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l6-20020a37f906000000b0069fc13ce23dsm4137451qkj.110.2022.05.07.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 06:33:36 -0700 (PDT)
Date:   Sat, 7 May 2022 21:33:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v4 1/3] idmapped-mounts: Reset errno to zero before
 run_test
Message-ID: <20220507133330.xxuw2x7buluhpnlu@zlang-mailbox>
Mail-Followup-To: Yang Xu <xuyang2018.jy@fujitsu.com>,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
References: <1651928726-2263-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651928726-2263-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, May 07, 2022 at 09:05:24PM +0800, Yang Xu wrote:
> If we run case on old kernel that doesn't support mount_setattr and
> then fail on our own function before call is_setgid/is_setuid function
> to reset errno, run_test will print "Function not implement" error.
> 
> We also check whether system support user namespace, so reset errno to
> zero after userns check.
> 
> Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

This patchset bring in a new failure [1] on kernel 5.18.0-0.rc4+. Before I push,
just confirm that is it as your expected, not a regression ?

Thanks,
Zorro

[1]
# ./check generic/633
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 hp-xxxxxxx-xx 5.18.0-0.rc4.20220427git46cf2c613f4b10e.35.fc37.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Apr 27 13:03:32 UTC 2022
MKFS_OPTIONS  -- -f /dev/sda3
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda3 /mnt/scratch

generic/633 14s ... [failed, exit status 1]- output mismatch (see /root/git/xfstests/results//generic/633.out.bad)
    --- tests/generic/633.out   2022-04-29 23:07:23.547501513 +0800
    +++ /root/git/xfstests/results//generic/633.out.bad 2022-05-07 21:20:40.205852662 +0800
    @@ -1,2 +1,4 @@
     QA output created by 633
     Silence is golden
    +idmapped-mounts.c: 8244: setgid_create_idmapped - No such file or directory - failure: linkat
    +idmapped-mounts.c: 14437: run_test - Success - failure: create operations in directories with setgid bit set on idmapped mounts
    ...
    (Run 'diff -u /root/git/xfstests/tests/generic/633.out /root/git/xfstests/results//generic/633.out.bad'  to see the entire diff)
Ran: generic/633
Failures: generic/633
Failed 1 of 1 tests

> v3->v4: move this reset step after sys_has_usersn()
>  src/idmapped-mounts/idmapped-mounts.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index ce3f73be..2e94bf71 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -14232,6 +14232,8 @@ int main(int argc, char *argv[])
>  		exit(EXIT_SUCCESS);
>  	}
>  	t_has_userns = sys_has_userns();
> +	/* don't copy ENOSYS errno to child process on older kernel */
> +	errno = 0;
>  
>  	stash_overflowuid();
>  	stash_overflowgid();
> -- 
> 2.31.1
> 

