Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43192EE4997
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Aug 2023 19:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242217AbjHRTg6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Aug 2023 15:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379635AbjHRTgb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Aug 2023 15:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5321FCE
        for <fstests@vger.kernel.org>; Fri, 18 Aug 2023 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692387341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BrQdf0GkcvOQID6YKUNm9kecc+hMz7+NpVKlR9WNpyY=;
        b=eWhHmMGyRtrlt7dh3yxs2wgyl/Y6xKA6oFBBWK6+mAj5sO+yx3Psp7LKoS2xrT51XH0P3e
        do2tO0f8vdBlfUAD0FQqw2Toac81+h08vsiydpIyfAwL3YrsMv9bTMNjYsbcqBtBstYx2+
        La0G3lt7gewMW35e5U2WxWrfhSb9Yzs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-gIuPcsE4OX28oLrupGf_hQ-1; Fri, 18 Aug 2023 15:35:38 -0400
X-MC-Unique: gIuPcsE4OX28oLrupGf_hQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bddb67390dso17484325ad.2
        for <fstests@vger.kernel.org>; Fri, 18 Aug 2023 12:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692387337; x=1692992137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrQdf0GkcvOQID6YKUNm9kecc+hMz7+NpVKlR9WNpyY=;
        b=LHHvzD2vEEJ6N9fXn1D5JxUkHOVFNx1TNx9WyqH5WVIhf9Ng/YR8Wn01AykbVAgznF
         2VCjOlvMMwv3isj5ttTdlCP137WGmZYcoTjJ9mov4+vWwIwMDXbrG6TzA4ziCCCgr+Pa
         rKpJFGwkeT/ezZWnA+xyLUDmvySwrubcsli3UtA9+vcKiXbKpAWUM2yqwWxQOWTNUXkz
         k8fV6RDH1ARhZ4KiJy7ohFy+1i2hVCghGTtndMCSl6b+2So6M3BQ4pgmEIPHzPE/824e
         4HwfbrHxcjGcSHmAkKRTGMOnoLtD4RtfTtjCPE8x3OXi2FdUVrLKpV1L5amrcpMgkXhv
         7mjA==
X-Gm-Message-State: AOJu0YzSmIWUWCa/844kNAR59Nm6QEkWC0P+JmkT+AaeTbXZMfUsYdzB
        FdS2djKMSa07HEgpwsIoFT17zrSNJuLlhc+fLl+pnaFzOz/O/FI6Z/PIn2+gg8RGCLcp9QM+fx0
        HTEu664HnL9Z5vCIC4+M6WzbitfWX3R4=
X-Received: by 2002:a17:903:18e:b0:1bb:891b:8bd with SMTP id z14-20020a170903018e00b001bb891b08bdmr172613plg.34.1692387337452;
        Fri, 18 Aug 2023 12:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA36BB1TWknTxgkbMpIEzudrc5rf5DN8F7lY/3KPMSD1q5dqE5Pp+DkZHRKhI3BDEAXQDokQ==
X-Received: by 2002:a17:903:18e:b0:1bb:891b:8bd with SMTP id z14-20020a170903018e00b001bb891b08bdmr172596plg.34.1692387337134;
        Fri, 18 Aug 2023 12:35:37 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001b567bbe82dsm2126412plb.150.2023.08.18.12.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 12:35:36 -0700 (PDT)
Date:   Sat, 19 Aug 2023 03:35:33 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/179: optimize remove file selection
Message-ID: <20230818193533.kuonbvwzvuw7eflw@zlang-mailbox>
References: <20230817051317.3825299-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817051317.3825299-1-naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 17, 2023 at 02:13:17PM +0900, Naohiro Aota wrote:
> Currently, we use "ls ... | sort -R | head -n1" to choose a removing
> victim. It sorts the files with "ls", sort it randomly and pick the first
> line, which wastes the "ls" sort.
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
> So, just use "ls -U" and "shuf -n 1" to choose a victim.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  tests/btrfs/179 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/179 b/tests/btrfs/179
> index 2f17c9f9fb4a..0fbd875cf01b 100755
> --- a/tests/btrfs/179
> +++ b/tests/btrfs/179
> @@ -45,7 +45,7 @@ fill_workload()
>  
>  		# Randomly remove some files for every 5 loop
>  		if [ $(( $i % 5 )) -eq 0 ]; then
> -			victim=$(ls "$SCRATCH_MNT/src" | sort -R | head -n1)
> +			victim=$(ls -U "$SCRATCH_MNT/src" | shuf -n 1)

Thanks for this improvement. This case has two lines have this similar logic,
Why not change them both?

And btrfs/192 has a similar line too:

$ grep -rsn -- "sort -R" tests
tests/btrfs/179:48:                     victim=$(ls "$SCRATCH_MNT/src" | sort -R | head -n1)
tests/btrfs/179:72:             victim=$(ls "$SCRATCH_MNT/snapshots" | sort -R | head -n1)
tests/btrfs/192:75:     echo "$basedir/$(ls $basedir | sort -R | tail -1)"
tests/btrfs/004:204:    for file in `find $dir -name f\* -size +0 | sort -R`; do

Do we need to change that too? And a common helper might help, if more cases
would like to have this helper?

Thanks,
Zorro

>  			rm "$SCRATCH_MNT/src/$victim"
>  		fi
>  		i=$((i + 1))
> -- 
> 2.41.0
> 

