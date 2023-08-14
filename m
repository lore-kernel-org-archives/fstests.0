Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E749DC001B0
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Aug 2023 15:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjHNPB7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Aug 2023 11:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjHNPBb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Aug 2023 11:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDA71B5
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692025244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gUIcTGKgmv6U3oBn1AoJg5Y0JtooqOi2HzPrts+u9fU=;
        b=HPvYjgJJ98FiJQcDyxIm2pjIIVNeQi/1hvLiua4JS7ToJ/xR4xlScjHnAAvYkhULbtHbXs
        JkkcS3Yic1aw/NGRgZowpzC6ydBrXhKg7DUVaBTJcbCbNzqfrM74EPD+6YsV5g2JbUfXnS
        ypMP7/OZKWHQToS5YnR+80OfF7bDO6Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-TEW31s0-PzmT7IATkq9Idg-1; Mon, 14 Aug 2023 11:00:42 -0400
X-MC-Unique: TEW31s0-PzmT7IATkq9Idg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bdca574b7fso34753375ad.1
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 08:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025241; x=1692630041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUIcTGKgmv6U3oBn1AoJg5Y0JtooqOi2HzPrts+u9fU=;
        b=ZLDSaFi6XwTKpN+3xsbRb/Q3+DUrAo45/wKOW+sOmNCeMqnFAWkN3KgU+7FVvl9eDB
         yMIyNBsZP+z5W+y7uwdSKqe72WrKUwNDZy5uzkljSmmEFTflCZcWhpEq1Pdqvq/h25qW
         Jbgvi7XAs5C7tQYOyljyxZfOVoesiO1R0q74UBQsR1ndZ1hdqaaJ0cMa2Xyuw42LuDpy
         l/h3mObui+mwgupdSRU4cNQ37mG3uni6x6MnHaOyK8HmdL3I4vjRAjJTk3y6LHv9VtU4
         ClUcxRW51+TU8cSiOrOcHd9SIunGgEoh/xq0bhwurjpTJtkItDdcXcKNDCYpo4mh0Iwg
         PqHg==
X-Gm-Message-State: AOJu0YzTJ9MALw4obsEA9jK3erglNMyau17ohnt/amBMq4OE289mlwYO
        HocJfKMSYSoSftFpENJEMIsnJPkKWsMV/hE+/5lyqKEj/F0hbhcC6izL8jeRVpyrkhqhb8B21rk
        M4RlRjn995gQEFc6hmW/Ju1b+vWTk5kg=
X-Received: by 2002:a17:903:234c:b0:1b7:e355:d1ea with SMTP id c12-20020a170903234c00b001b7e355d1eamr13740348plh.24.1692025240825;
        Mon, 14 Aug 2023 08:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn3wT/M1zRb6sEDUTnnaEwMglEZfX1p5XFlrpjFAtuPOKVhoc2RPEdx8jw0IP9m0vgV6HBOg==
X-Received: by 2002:a17:903:234c:b0:1b7:e355:d1ea with SMTP id c12-20020a170903234c00b001b7e355d1eamr13740162plh.24.1692025240029;
        Mon, 14 Aug 2023 08:00:40 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b001bdf046ed71sm998882plg.120.2023.08.14.08.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:00:39 -0700 (PDT)
Date:   Mon, 14 Aug 2023 23:00:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/213: fix failure due to misspelled function name
Message-ID: <20230814150036.e6zyasqydeq5krsa@zlang-mailbox>
References: <71413edbeb1ee5b945f0b82faccaf4a75e8ba56b.1691924176.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71413edbeb1ee5b945f0b82faccaf4a75e8ba56b.1691924176.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Aug 13, 2023 at 12:01:22PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test is calling _not_run but it should be _notrun, so fix that.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/213 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/213 b/tests/btrfs/213
> index 5666d9b9..6def4f6e 100755
> --- a/tests/btrfs/213
> +++ b/tests/btrfs/213
> @@ -55,7 +55,7 @@ sleep $(($runtime / 4))
>  # any error about no balance currently running.
>  $BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT" 2>&1 | grep -iq 'not in progress'
>  if [ $? -eq 0 ]; then
> -	_not_run "balance finished before we could cancel it"
> +	_notrun "balance finished before we could cancel it"
>  fi
>  
>  # Now check if we can finish relocating metadata, which should finish very
> -- 
> 2.34.1
> 

