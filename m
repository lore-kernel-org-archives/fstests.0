Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2620C3DA78
	for <linux-fstests@archiver.kernel.org>; Fri, 13 Jan 2023 18:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAMSlr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjAMSli (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Jan 2023 13:41:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3FB209
        for <fstests@vger.kernel.org>; Fri, 13 Jan 2023 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673635252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kG2DvsTsR9fanFrFZN99LQxWJl2RuPKBCl5toiClfpA=;
        b=e0fmyfwqrMHPwyEL7pu5Vm3JxfoTxczdCUzb35KXzSKzb6KYnlC8F7smNmiO0C5CCiCXTn
        qimb9m2+1EGMzVPykyThiA2/t7Ll0UJ8DidtXLJ0h4GDHK2RhW4WjknGZaLXX0rcF1FkaX
        YiVsZ+cX9xpSZYvMU0UPyM8gTz9wBsk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-YMkYMWqON2Wfj6VK149GJw-1; Fri, 13 Jan 2023 13:40:50 -0500
X-MC-Unique: YMkYMWqON2Wfj6VK149GJw-1
Received: by mail-pl1-f198.google.com with SMTP id n1-20020a170902e54100b00192cc6850ffso15335364plf.18
        for <fstests@vger.kernel.org>; Fri, 13 Jan 2023 10:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG2DvsTsR9fanFrFZN99LQxWJl2RuPKBCl5toiClfpA=;
        b=fMw/G5PmaIF7dVSIDUFPvNk/e4FkW6NRYpCceaM0kjA0sBsjklVoZXQlhOnrYSiapq
         TtXYpYRgaSTdEvl0CcP2z5p3H20dVMfOi/2g9MSyelKZOnM7JmEZr8W+aVDfZr7N7dxn
         D/x+cApy1P8tXrCO7pjRTPQhFmBauqO7/X22qjKVRYmDaZIfODeXEOHQyzRYWQ0mc1pl
         QDmvdIESo50AdvHUfg74UJpfXkv6+WN5MQd+0QygidDjPK3gxnAnLIlWqjunoDkQz1SQ
         R6MxOdUaYqKBUrftMd0t3HtFz+tNbjr6eLpqPEefENryN71rDZV0LBDo6UceJiF1fIV1
         pvSw==
X-Gm-Message-State: AFqh2kr+bZQoPojvLlZHIgKSldLlLQVQ3lV9QnhxLGBzZ6DW3Ocyon26
        y7pREK7BMUzOsX/UC84Tml1qIB9cyPsd86YeoPkdwJd4SU5Ib+BInQusctaweOjaJVSo8duU+BT
        eGlEUboPgsf59mTfq5A==
X-Received: by 2002:a17:902:ba12:b0:194:4016:11ac with SMTP id j18-20020a170902ba1200b00194401611acmr15569330pls.30.1673635248901;
        Fri, 13 Jan 2023 10:40:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtBwaqx50lWMvBBnVbYhugmzzggi5UYhJssZunnA58DW/0r8XrDvfwyIWxzCCt7w1atb60JTA==
X-Received: by 2002:a17:902:ba12:b0:194:4016:11ac with SMTP id j18-20020a170902ba1200b00194401611acmr15569310pls.30.1673635248539;
        Fri, 13 Jan 2023 10:40:48 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902d2cf00b0018963b8e131sm14377142plc.290.2023.01.13.10.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:40:48 -0800 (PST)
Date:   Sat, 14 Jan 2023 02:40:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     An Long <lan@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/011: use $_btrfs_profile_configs to limit the
 tests
Message-ID: <20230113184044.3os5l5xuaie6vs33@zlang-mailbox>
References: <20230111131833.471ada43@echidna.fritz.box>
 <20230113163547.18036-1-lan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113163547.18036-1-lan@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jan 14, 2023 at 12:35:47AM +0800, An Long wrote:
> Generally the tester need BTRFS_PROFILE_CONFIGS to test certain
> profiles. For example, skip raid56 as it's not supported.
> 
> Signed-off-by: An Long <lan@suse.com>
> ---
>  tests/btrfs/011 | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 6c3d037f..6dfa1fd6 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -22,6 +22,8 @@
>  . ./common/preamble
>  _begin_fstest auto replace volume
>  
> +_btrfs_get_profile_configs
> +

Do you need to call it such early? I think this helper should be called after
"_supported_fs btrfs" at least. Or maybe even after those _require_scratch_*
things?

>  noise_pid=0
>  
>  # Override the default cleanup function.
> @@ -237,18 +239,27 @@ btrfs_replace_test()
>  	fi
>  }
>  
> -workout "-m single -d single" 1 no 64
> +if [[ "${_btrfs_profile_configs[@]}" =~ "-m single -d single"( |$) ]]; then
> +	workout "-m single -d single" 1 no 64
> +fi
> +
>  # Mixed BG & RAID/DUP profiles are not supported on zoned btrfs
>  if ! _scratch_btrfs_is_zoned; then
> -	workout "-m dup -d single" 1 no 64
> -	workout "-m dup -d single" 1 cancel 1024
> -	workout "-m raid0 -d raid0" 2 no 64
> -	workout "-m raid1 -d raid1" 2 no 2048
> -	workout "-m raid10 -d raid10" 4 no 64
> -	workout "-m single -d single -M" 1 no 64
> -	workout "-m dup -d dup -M" 1 no 64
> -	workout "-m raid5 -d raid5" 2 no 64
> -	workout "-m raid6 -d raid6" 3 no 64
> +	for t in "-m dup -d single:1 no 64" \
> +		"-m dup -d single:1 cancel 1024" \
> +		"-m raid0 -d raid0:2 no 64" \
> +		"-m raid1 -d raid1:2 no 2048" \
> +		"-m raid10 -d raid10:4 no 64" \
> +		"-m single -d single -M:1 no 64" \
> +		"-m dup -d dup -M:1 no 64" \
> +		"-m raid5 -d raid5:2 no 64" \
> +		"-m raid6 -d raid6:3 no 64"; do
> +		mkfs_option=${t%:*}
> +		workout_option=${t#*:}
> +		if [[ "${_btrfs_profile_configs[@]}" =~ "${mkfs_option/ -M}"( |$) ]]; then
> +			workout "$mkfs_option" $workout_option
> +		fi
> +	done
>  fi
>  
>  echo "*** done"
> -- 
> 2.35.3
> 

