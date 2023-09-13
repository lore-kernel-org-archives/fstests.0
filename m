Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94FBEE01E0
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Sep 2023 17:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjIMRHU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Sep 2023 13:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIMRHT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Sep 2023 13:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77636198B
        for <fstests@vger.kernel.org>; Wed, 13 Sep 2023 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9qmOEQJ/EqSZpL9rLSn0CaAejK2ncItiFgUoKh0UJKk=;
        b=VL4L48bqLnDxgq0ouO9M1bkBItYQmsz5oLzw9lPVe5S0jm0LpFILlUQ3iwrUKQl7m1Eb9C
        y3kTz5/vQZI5JCxJr99p/pIiznKUExM7E6hO9i/aa42N9E6qo7vCE5Pc3aUcGLLW5JsJeN
        Tt/sQ32OclxgfDpbHE0+q78BfkkEh68=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-fIP7I2IXNnSltznkO_7LNw-1; Wed, 13 Sep 2023 13:06:28 -0400
X-MC-Unique: fIP7I2IXNnSltznkO_7LNw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-57774ddb68dso3808250a12.1
        for <fstests@vger.kernel.org>; Wed, 13 Sep 2023 10:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624787; x=1695229587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qmOEQJ/EqSZpL9rLSn0CaAejK2ncItiFgUoKh0UJKk=;
        b=TS2ycLxSx/HF5icOEgw7+5t9DWdanK9V10Rin9tl8z6I3dl4aAtYeMZ5dTFNVKriRs
         1EjF2OzgV/SaNrxsxFqOQJQUtKUt1WPs+Q6bBQbdsmMdElTDnJOJm56ia2hV5+J4+/6H
         6Jaor4EcVP84xmqx9fPd4PJnYZTZadfRZyp8K7XEz6HOO/2xdxfgg3fwvffTCvz5gqIR
         ha/V2FLDQwWR3qMt8tVBrJ66v9wql2kbOUOZrbBPcrl/fxhu6vQsF4L0eyplIkyrGJOe
         KI39/edZEff49jKPQ3FOdu6lomeMnf9/KFiQBG64oiM9GiXVz1LMp17L/S9KRQiFaoGu
         q6zA==
X-Gm-Message-State: AOJu0YwtFD9mnE4qTnDJXZwFGCcxKqiJ1+TK/hJX10EnIqmZe9hU0bX7
        x0kFe8MOq4axaWSeh6qf8CH19Hg054/2soGwhBlPnQ32AS/svZ9RAnfp2EUQk7hbbshcISNgduo
        reiO4qG7hcHxZcKyHr/ziiZVxSjgdikw=
X-Received: by 2002:a05:6a20:2446:b0:134:8d7f:f4d9 with SMTP id t6-20020a056a20244600b001348d7ff4d9mr3596029pzc.52.1694624786831;
        Wed, 13 Sep 2023 10:06:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFjeJZP9KtyDBJGchBcOEX092Vvd/OM3Ram7Wz42jDbjJ4yBL+FQtW8boF3aSDV/yrXTBoZw==
X-Received: by 2002:a05:6a20:2446:b0:134:8d7f:f4d9 with SMTP id t6-20020a056a20244600b001348d7ff4d9mr3596004pzc.52.1694624786478;
        Wed, 13 Sep 2023 10:06:26 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z24-20020a63ac58000000b005658d3a46d7sm9115850pgn.84.2023.09.13.10.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:06:26 -0700 (PDT)
Date:   Thu, 14 Sep 2023 01:06:21 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fstests: use btrfs check repair for repairing btrfs
 filesystems
Message-ID: <20230913170621.f6paqto5vvibrkl6@zlang-mailbox>
References: <2c89e68e7a34f1d0545f19e9e178e258f777c027.1692286458.git.anand.jain@oracle.com>
 <28de98f456031353d34be71fe7b71937d3ef3e4b.1692600778.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28de98f456031353d34be71fe7b71937d3ef3e4b.1692600778.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 21, 2023 at 05:05:09PM +0800, Anand Jain wrote:
> There are two repair functions: _repair_scratch_fs() and
> _repair_test_fs(). As the names suggest, these functions are designed to
> repair the filesystems SCRATCH_DEV and TEST_DEV, respectively. However,
> these functions never called proper comamnd for the filesystem type btrfs.
> This patch fixes it. Thx.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

This patch looks good to me. It's been several weeks past, there's not more
review points or better idea from others either. So I'd like to merge it, to
support btrfs specific repair.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> v2:
> 
> When I reran the tests, they hung because 'btrfs check --repair' was
> waiting for confirmation to fix the tree, despite using the '--force'
> option. This is a bug. However, we still need to support the older
> btrfs-progs. So, pass in a 'yes' response.
> 
> Uses BTRFS_UTIL_PROG instead of btrfs.
> 
>  common/rc | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 5002369b9b34..45cb56816c05 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1187,6 +1187,15 @@ _repair_scratch_fs()
>  	fi
>  	return $res
>          ;;
> +    btrfs)
> +	echo "yes|$BTRFS_UTIL_PROG check --repair --force $SCRATCH_DEV"
> +	yes | $BTRFS_UTIL_PROG check --repair --force $SCRATCH_DEV 2>&1
> +	local res=$?
> +	if [ $res -ne 0 ]; then
> +		_dump_err2 "btrfs repair failed, err=$res"
> +	fi
> +	return $res
> +	;;
>      bcachefs)
>  	# With bcachefs, if fsck detects any errors we consider it a bug and we
>  	# want the test to fail:
> @@ -1239,6 +1248,13 @@ _repair_test_fs()
>  			res=$?
>  		fi
>  		;;
> +	btrfs)
> +	echo 'yes|$BTRFS_UTIL_PROG check --repair --force "$TEST_DEV"' > \
> +								/tmp.repair 2>&1
> +	yes | $BTRFS_UTIL_PROG check --repair --force "$TEST_DEV" >> \
> +								/tmp.repair 2>&1
> +		res=$?
> +		;;
>  	*)
>  		# Let's hope fsck -y suffices...
>  		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
> -- 
> 2.38.1
> 

