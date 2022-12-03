Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AFDC4332F
	for <linux-fstests@archiver.kernel.org>; Sat,  3 Dec 2022 06:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiLCGex (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 3 Dec 2022 01:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiLCGex (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Dec 2022 01:34:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0B4DBF47
        for <fstests@vger.kernel.org>; Fri,  2 Dec 2022 22:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670049238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yrtln5NZdrWRBK9yiWunXxGiuf0vN4HqWDkAHYGvgSw=;
        b=B2k+/cIhvOCvDhM6DX47CR+kc+TSrIbe8Cli0loLm49/cgZI5MKZInbYzY6wusi4G5r4Kt
        y6FlbWWjqX9fF8ST5z1PF2NvXM8TDxgl0ZQrO1ufZoeojygwa8XwZv7fMgViKIwtdQGC9y
        DfbgpPTr+wDzLkwDr0C34kkaFr9Yvno=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-463-_Wk4gvrMOg2QBNEUenQaiQ-1; Sat, 03 Dec 2022 01:33:51 -0500
X-MC-Unique: _Wk4gvrMOg2QBNEUenQaiQ-1
Received: by mail-pl1-f197.google.com with SMTP id j18-20020a170902da9200b00189b3b16addso8427704plx.23
        for <fstests@vger.kernel.org>; Fri, 02 Dec 2022 22:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrtln5NZdrWRBK9yiWunXxGiuf0vN4HqWDkAHYGvgSw=;
        b=1zCRAT1iNcMJQp6KPpGVwr/sqfzq31vx79oj2Z5zEw1suSG194G83Z1nsXhzSNuFtF
         byN8qQStVPHRZPORDPA9mrUSDf0cGc1TJVuHAJyKcgqWpMyR42A/OU2xt43ZJtPgx8Lu
         vufbSUW2cX3onAMIobxWnT06bVYy88/T2TjG70Kb6McT2iGVWFLfRZb1wUwlU1hO0/1v
         W/YvhqvDArtj0PA5Ld48hbfCwREb5OGhFV1rPEBgIhggj9Yb1+JdrLL3yJeSJqa/jzcH
         UfWkuYPn70CNTq4rCGLlVUi6G/S4WNVjyVfEYxNuJZze1hBBa+J19L23XU96xqZHqGoA
         C5ug==
X-Gm-Message-State: ANoB5pkTnO9jPObYjA9MfIHys1Gzs0ODq2vwCIby+1R3MUUOX04giZcV
        4Wg+HqXF09uzRWyHtxde3pmnXI918v0m467J0cE5y8PK30e1uH69G0W1dr9OiOXreg1NMDaN9Oq
        HbAXAQTCkINufMzwIcQ==
X-Received: by 2002:a17:903:d1:b0:189:c4b4:b374 with SMTP id x17-20020a17090300d100b00189c4b4b374mr2935662plc.72.1670049230260;
        Fri, 02 Dec 2022 22:33:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7hzqDRQsmAoLM1g0TpGXHKpvGN+wTMSb7wN9RDb0jgAYsfFITRT4djkMDylkUw5wdTqUzjCg==
X-Received: by 2002:a17:903:d1:b0:189:c4b4:b374 with SMTP id x17-20020a17090300d100b00189c4b4b374mr2935652plc.72.1670049229919;
        Fri, 02 Dec 2022 22:33:49 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y10-20020aa793ca000000b0056afd55722asm6041751pff.153.2022.12.02.22.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 22:33:49 -0800 (PST)
Date:   Sat, 3 Dec 2022 14:33:45 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/273: Limit number of files by available inodes
Message-ID: <20221203063345.i4zzm546s7ohxiou@zlang-mailbox>
References: <20221130170153.31924-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130170153.31924-1-jack@suse.cz>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 30, 2022 at 06:01:53PM +0100, Jan Kara wrote:
> Test generic/273 is failing for ext4 with 1k blocksize because it is
> creating more files than we have available inodes. Just limit the number
> of files created to the number of inodes.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/273 | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> Changes since v1:
> * Handle btrfs which reports 0 free inodes
> 
> diff --git a/tests/generic/273 b/tests/generic/273
> index f86dae9b8095..54c199962421 100755
> --- a/tests/generic/273
> +++ b/tests/generic/273
> @@ -50,9 +50,21 @@ _file_create()
>  
>  	cd $SCRATCH_MNT/origin
>  
> -	_disksize=`$DF_PROG -B 1 $SCRATCH_MNT | tail -1 | $AWK_PROG '{ print $5 }'`
> +	_disksize=$(_get_available_space $SCRATCH_MNT)
> +	_free_inodes=$(_get_free_inode $SCRATCH_MNT)
> +	# Some filesystems do not limit number of inodes and return 0
> +	if [ $_free_inodes -eq 0 ]; then
> +		# Guess one block per inode
> +		_free_inodes=$(($_disksize / $block_size))
> +	fi
> +	# Leave some slack for directories etc.
> +	_free_inodes=$(($_free_inodes - $_free_inodes/8))
>  	_disksize=$(($_disksize / 3))
> -	_num=$(($_disksize / $count / $threads / $block_size))
> +	_num=$(($_disksize / $count / $block_size))
> +	if [ $_num -gt $_free_inodes ]; then
> +		_num=$_free_inodes
> +	fi
> +	_num=$(($_num/$threads))
>  	_count=$count
>  	while [ $_i -lt $_num ]
>  	do
> -- 
> 2.35.3
> 

