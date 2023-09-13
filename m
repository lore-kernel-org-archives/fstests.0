Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB57CA553B
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Sep 2023 16:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjIMQev (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Sep 2023 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjIMQev (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Sep 2023 12:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67A31198B
        for <fstests@vger.kernel.org>; Wed, 13 Sep 2023 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694622843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UAYnuk4DQnhCxIfc6YSklz+442IzG/pg0eE22UUf+nk=;
        b=avrcqUnqW66oRZ1/CitwMQDacPXro+0E13Wn3cOH67l6FW94oRN6LC2KFlYmSb4N8noQ8R
        nowoNnut3+GWiY2+FV+kkLgLOxsr8NggZ8aPwN4LlD+sG4xeQWJZ8J5DoNIe/qw5oSub43
        q7+vgh+jAyIpSyYwd7rTLMzsxxXibnE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-fJWRcVnrOY60v40-FtrJFA-1; Wed, 13 Sep 2023 12:34:01 -0400
X-MC-Unique: fJWRcVnrOY60v40-FtrJFA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26d5970cbdbso32894a91.0
        for <fstests@vger.kernel.org>; Wed, 13 Sep 2023 09:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694622840; x=1695227640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAYnuk4DQnhCxIfc6YSklz+442IzG/pg0eE22UUf+nk=;
        b=KbIvyWgsim6264fNOMk21MY9JjJDDzIRxTS/q+2xMUxp5Z1RpmlhjZR2ghsx5PpbVR
         Z79X5RzvRa/2kAbBVxT90kCOTafEiLA36zLWvfDpeLmQrn9VXiXJqgzPJeC2ftY8DaMj
         rR+YhtQ5o0XLmj5Vrk+YNvELJYmIsy+Og5jZ870jtkr0+sS9BgqJ/a//5dPTScDmTk7P
         06OSnRuYQsfm8y+5cPu3JN1FWUk1mYXRr0MUmJvOK7fcKnp9ObHVbMvLamKsTqFqhdOc
         5Jo2J3+fqyaJIHuDhc1Ic3vS1N7GDieDT7PlyMOwtOamysN+bNePCWkuGpNXflNrD+a+
         767A==
X-Gm-Message-State: AOJu0YytbMceElDRIyAxnxn905D8E+HncwPqf78sMfW7T55cb7z7wktA
        8U4aB2/jMVmc5OjXLMxkSeMhtoErERP9HXYBXKlYU/nhBNXZOwe4hdCHebHznZYYwctrTRnVTbB
        w3nHHsxXkKWrbzloO0A==
X-Received: by 2002:a17:90b:3ecd:b0:26d:2162:f596 with SMTP id rm13-20020a17090b3ecd00b0026d2162f596mr2658684pjb.6.1694622840533;
        Wed, 13 Sep 2023 09:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTh1/F12+q80SPMLNPd1KuS70uLHFw8nMq8WnWwSqvTviCKe14/sMYrvIhfqFnl0EUl8f+Hw==
X-Received: by 2002:a17:90b:3ecd:b0:26d:2162:f596 with SMTP id rm13-20020a17090b3ecd00b0026d2162f596mr2658661pjb.6.1694622840205;
        Wed, 13 Sep 2023 09:34:00 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a08ca00b00262e604724dsm1645648pjn.50.2023.09.13.09.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:33:59 -0700 (PDT)
Date:   Thu, 14 Sep 2023 00:33:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs add more tests into the scrub group
Message-ID: <20230913163356.ngsh2ewut7wcevsw@zlang-mailbox>
References: <2fc42b09cdc710cc2ac83e3a1726b5f7b1d0af62.1693312237.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc42b09cdc710cc2ac83e3a1726b5f7b1d0af62.1693312237.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 29, 2023 at 08:32:40PM +0800, Anand Jain wrote:
> I wanted to verify tests using the command "btrfs scrub start" and
> found that there are many more test cases using "btrfs scrub start"
> than what is listed in the group.list file. So, get them to the scrub
> group.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/011 | 2 +-
>  tests/btrfs/027 | 2 +-
>  tests/btrfs/060 | 2 +-
>  tests/btrfs/062 | 2 +-
>  tests/btrfs/063 | 2 +-
>  tests/btrfs/064 | 2 +-
>  tests/btrfs/065 | 2 +-
>  tests/btrfs/067 | 2 +-
>  tests/btrfs/068 | 2 +-
>  tests/btrfs/069 | 2 +-
>  tests/btrfs/070 | 2 +-
>  tests/btrfs/071 | 2 +-
>  tests/btrfs/074 | 2 +-
>  tests/btrfs/148 | 2 +-
>  tests/btrfs/195 | 2 +-
>  tests/btrfs/261 | 2 +-
>  16 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 852742ee8396..ff52ada94a17 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -20,7 +20,7 @@
>  # performed, a btrfsck run, and finally the filesystem is remounted.
>  #
>  . ./common/preamble
> -_begin_fstest auto replace volume
> +_begin_fstest auto replace volume scrub
>  
>  noise_pid=0

[snip]

>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/069 b/tests/btrfs/069
> index 6e798a2e5061..824ca3c3110b 100755
> --- a/tests/btrfs/069
> +++ b/tests/btrfs/069
> @@ -8,7 +8,7 @@
>  # running in background.
>  #
>  . ./common/preamble
> -_begin_fstest auto replace scrub volume
> +_begin_fstest auto replace scrub volume scrub

The btrfs/069 has been in "scrub" group, others looks good to me.

