Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B18C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jan 2022 02:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbiAFCcY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Jan 2022 21:32:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344793AbiAFCcW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Jan 2022 21:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641436342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=72ZM+Bjzlyer4Mk2goDFDUOOU+Q9dWdnBOMKDSFLS+I=;
        b=G/xHPzIxwbKbmCds6XYoJOUa+cpqytqcvGCz2up7NUIEJ0wLiEzAM473pq19W8BAOSJTDh
        GosTtPOT5xlrmEGMLxOMF2kr86I0GbBA81JrGJ0p4+z3D5eLNd/M81SpbpmY86HRPalNxt
        l7ZQUPpQJj39UFBG8vmcrLy8ElKu62U=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-uYfTHB7POteZcjM2HqvUMw-1; Wed, 05 Jan 2022 21:32:20 -0500
X-MC-Unique: uYfTHB7POteZcjM2HqvUMw-1
Received: by mail-pj1-f70.google.com with SMTP id x3-20020a17090a8a8300b001b290d558f0so714043pjn.6
        for <fstests@vger.kernel.org>; Wed, 05 Jan 2022 18:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=72ZM+Bjzlyer4Mk2goDFDUOOU+Q9dWdnBOMKDSFLS+I=;
        b=hsuu8/bUyRiCqXK/Rl0ffJP96il5RFahM5mRlsBDn97cyImZxIfBZOg6DuBJQccfJT
         RJhBzNwo4b970IEpH+MlXJbRah9VGh7STGcpACwzfHYNnzw0PT9MQb0ws7s+LHluSCtm
         yuGociCIjxgsRof80OgrZeSi8fI5eIYCTRUW71+NfQbQFdIrJRgrCnEovzmBxJCx1rVQ
         mkJPHF/YyH9xL79foNqdZDvJVo4uKEOPvFsg5kwvMVeM3SVbDN7ZexwFM86OJb999uN5
         VKiRutxX57xE6t824unzxMKAa4BOJxSQqnF57KWkLKZkrTWluULzwSjrWqfQaLs5HdSv
         u7gQ==
X-Gm-Message-State: AOAM5321q+95p5P2fZPvvAXE5F+MNC/U8hBomsWiaJFcFdrzNaERyGLf
        M2HP572R+AADPgETcbvM5U/KgMUfLI2+ipQOhrkMMdvVtYdPE1oZHuhbbbm2s3ksWqwx4/RVoaG
        0K5EcAU4eeBjj1iIFyQ==
X-Received: by 2002:a05:6a00:21cd:b0:4bc:35e8:eaea with SMTP id t13-20020a056a0021cd00b004bc35e8eaeamr35534795pfj.23.1641436339490;
        Wed, 05 Jan 2022 18:32:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyt3MmHk4xB4qVNsPRY7Ru83m5RVIjyUucDeI/biMwxFhRYA7+0uu7srVAh9ATzaqfdAKHTfg==
X-Received: by 2002:a05:6a00:21cd:b0:4bc:35e8:eaea with SMTP id t13-20020a056a0021cd00b004bc35e8eaeamr35534772pfj.23.1641436339071;
        Wed, 05 Jan 2022 18:32:19 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b6sm386803pfm.170.2022.01.05.18.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 18:32:18 -0800 (PST)
Date:   Thu, 6 Jan 2022 10:32:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH] common: handle ceph's new mount syntax
Message-ID: <20220106023215.ok76dzmnstqeevth@zlang-mailbox>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
        guan@eryu.me
References: <20220105173013.172424-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105173013.172424-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 05, 2022 at 12:30:13PM -0500, Jeff Layton wrote:
> Cephfs is introducing a new mount device syntax. Fix the fstests
> infrastructure to handle the new syntax correctly.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/config |  2 +-
>  common/rc     | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/common/config b/common/config
> index e0a5c5df58ff..be97436b0857 100644
> --- a/common/config
> +++ b/common/config
> @@ -533,7 +533,7 @@ _check_device()
>  	fi
>  
>  	case "$FSTYP" in
> -	9p|tmpfs|virtiofs)
> +	9p|tmpfs|virtiofs|ceph)
>  		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
>  		# tmpfs doesn't use mount source, ignore

Better to add a comment to explain why add *ceph* at here, especially others
all have explanation. But I think you might still want to check
if it's a network url, not only just skip the checking directly. Except it's
similar with virtiofs use plain strings. As there's below checking in
_check_device() function:

        if [ -b "$dev" ] || ( echo $dev | grep -qE ":|//" ); then
                # block device or a network url
                return 0
        fi

Can `grep -qE ":|=|//"` or something else help you through this checking?
I'm not familar with cephfs, so just ask if it's as you wish.

Thanks,
Zorro

>  		;;
> diff --git a/common/rc b/common/rc
> index 7973ceb5fdf8..4fa0b818d840 100644
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
> @@ -1601,6 +1601,21 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> +	ceph)
> +		if [ -z "$SCRATCH_DEV" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_DEV"
> +		fi
> +		echo $SCRATCH_DEV | grep -q "=/" > /dev/null 2>&1
> +		if [ "$?" != "0" ]; then
> +			echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
> +			if [ "$?" != "0" ]; then
> +				_notrun "this test requires a valid \$SCRATCH_DEV"
> +			fi
> +		fi
> +		if [ ! -d "$SCRATCH_MNT" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_MNT"
> +		fi
> +		;;
>  	pvfs2)
>  		echo $SCRATCH_DEV | grep -q "://" > /dev/null 2>&1
>  		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> @@ -1770,7 +1785,7 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> -	nfs*|ceph)
> +	nfs*)
>  		echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
>  		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
>  			_notrun "this test requires a valid \$TEST_DEV"
> @@ -1779,6 +1794,21 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> +	ceph)
> +		if [ -z "$TEST_DEV" ]; then
> +			_notrun "this test requires a valid \$TEST_DEV"
> +		fi
> +		echo $TEST_DEV | grep -q "=/" > /dev/null 2>&1
> +		if [ "$?" != "0" ]; then
> +			echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
> +			if [ "$?" != "0" ]; then
> +				_notrun "this test requires a valid \$TEST_DEV"
> +			fi
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

