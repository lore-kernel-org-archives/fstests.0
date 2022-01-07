Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE07DC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jan 2022 03:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344826AbiAGDPj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jan 2022 22:15:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344803AbiAGDPj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jan 2022 22:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641525338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqzZTa+JQFvA8R9AeQ6h5DuZs//ibMJjBKMuhX77VD4=;
        b=OIgoiGboaZ/1i2NwvjNgEJyrCDx13spWTVrX77mbyLx8HybHiYcxypOfQzwP/j/vLa6+Jp
        h1aeNQzKyl4/nSZbPeGFY5pQU33x411JMbB+OEicXi1AwNY835bJHYHTYAA4NM0dUsX4IO
        3cEG+MHyoS7DZqncifx9QT9FRWG4Hfk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-v6cGJzq0NU--0njzWXDofA-1; Thu, 06 Jan 2022 22:15:37 -0500
X-MC-Unique: v6cGJzq0NU--0njzWXDofA-1
Received: by mail-pg1-f198.google.com with SMTP id c75-20020a63354e000000b003408e4153d1so2972375pga.9
        for <fstests@vger.kernel.org>; Thu, 06 Jan 2022 19:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=aqzZTa+JQFvA8R9AeQ6h5DuZs//ibMJjBKMuhX77VD4=;
        b=g39chIAd3RWXFGILdgOKu+E4Z/KBnqXjEoWN9N/bbogMW3Qhqvuj5jHkAYOps/ukOt
         K0sYs1ATDBN7yZZ014fto8KEh86uJeo8+Tm+8SL3TbfOeo1HIXxkTjGYrDHZpcg0pOLT
         E0HNsJNu4XQYwjk5A8xUJVcCX/Di3DsXpLOlvcAI20QDE2wJX8GpBEtVXbc8IqXJewN3
         IUplgw1ePIWsZr7yKm0TMrHZ4LyXbUGbk+VdpPqBf/iNujY7KojYRFdd+k94+blVQ6UE
         L/XC3sedaBWXefpngzfqc2RZiBZzpM58INZm7T7c/kbtI/eStHF4jqDw3TO9krl4NBW/
         U+OQ==
X-Gm-Message-State: AOAM533lz2At0bxS/2BVyDkVMCYdpygIE1hT5oBtI5W7UXnRYfqnQQ6F
        ZC1TfcGq6q5YUibvv/i9AYc9DKmg/1wogiuWYFPQc7w7vi/Ly1Vjwxpm7nLUkjSFW2fxB94vL56
        GpuXc+dmuUt3lGb+8fw==
X-Received: by 2002:a17:902:830b:b0:149:5f4d:e178 with SMTP id bd11-20020a170902830b00b001495f4de178mr58682461plb.152.1641525336145;
        Thu, 06 Jan 2022 19:15:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvaxDe7qQsz2Unby2MBbYWZvhbegaIe9r5eYUM40Cl4El0h5Y0bJ/Yg0rfKDsFpbjsz+v4ng==
X-Received: by 2002:a17:902:830b:b0:149:5f4d:e178 with SMTP id bd11-20020a170902830b00b001495f4de178mr58682443plb.152.1641525335834;
        Thu, 06 Jan 2022 19:15:35 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h4sm3903562pfi.79.2022.01.06.19.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 19:15:35 -0800 (PST)
Date:   Fri, 7 Jan 2022 11:15:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH v3] common: handle ceph's new mount syntax
Message-ID: <20220107031531.isbacu7kijxojpcg@zlang-mailbox>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
        guan@eryu.me
References: <20220106175426.86522-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106175426.86522-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 06, 2022 at 12:54:26PM -0500, Jeff Layton wrote:
> Cephfs is introducing a new mount device syntax. Fix the fstests
> infrastructure to handle the new syntax correctly.
> 
> Cc: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

It looks good to me now.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/config |  8 ++++++++
>  common/rc     | 22 ++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> v2: more rigorous check for ceph mount device in _check_device
> v3: consolidate multiple grep commands into single regex
> 
> diff --git a/common/config b/common/config
> index e0a5c5df58ff..2b357746476b 100644
> --- a/common/config
> +++ b/common/config
> @@ -537,6 +537,14 @@ _check_device()
>  		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
>  		# tmpfs doesn't use mount source, ignore
>  		;;
> +	ceph)
> +		# ceph has two different possible syntaxes for mount devices. The
> +		# network URL check above catches the legacy syntax. Check for the
> +		# new-style syntax here.
> +		if ( echo $dev | grep -qEv "=/" ); then
> +			_fatal "common/config: $name ($dev) is not a valid ceph mount string"
> +		fi
> +		;;
>  	overlay)
>  		if [ ! -d "$dev" ]; then
>  			_fatal "common/config: $name ($dev) is not a directory for overlay"
> diff --git a/common/rc b/common/rc
> index f8afd93d656c..c087875a4251 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1592,7 +1592,7 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> -	nfs*|ceph)
> +	nfs*)
>  		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
>  		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
>  			_notrun "this test requires a valid \$SCRATCH_DEV"
> @@ -1601,6 +1601,15 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> +	ceph)
> +		echo $SCRATCH_DEV | grep -qE "=/|:/" > /dev/null 2>&1
> +		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_DEV"
> +		fi
> +		if [ ! -d "$SCRATCH_MNT" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_MNT"
> +		fi
> +		;;
>  	pvfs2)
>  		echo $SCRATCH_DEV | grep -q "://" > /dev/null 2>&1
>  		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> @@ -1783,7 +1792,7 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> -	nfs*|ceph)
> +	nfs*)
>  		echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
>  		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
>  			_notrun "this test requires a valid \$TEST_DEV"
> @@ -1792,6 +1801,15 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> +	ceph)
> +		echo $TEST_DEV | grep -qE "=/|:/" > /dev/null 2>&1
> +		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
> +			_notrun "this test requires a valid \$TEST_DEV"
> +		fi
> +		if [ ! -d "$TEST_DIR" ]; then
> +			_notrun "this test requires a valid \$TEST_DIR"
> +		fi
> +		;;
>  	cifs)
>  		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
>  		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
> -- 
> 2.33.1
> 

