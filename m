Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2CAC433B4
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Apr 2021 17:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD1661073
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Apr 2021 17:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242385AbhD1Rse (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Apr 2021 13:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242718AbhD1Rse (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Apr 2021 13:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619632068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Np/0h7yK8mlO72O746vGN1gLf2I7R6Y5y97q0vaR2XE=;
        b=M2hMgccmY8C9VgxP6upJmON8RugwcThW8J48u7C5qNOdDle0rUo4Faj+/I1SnBjSgSJwp7
        DwH7BlvctjwPXVf8uH8IXnqGGTjNemqBWaj6lZ9vTpo6V95f3USAGqPY/X1AoRXMHR9yQV
        FpnVBKqjKbVQ4DrkfatuOcK9N17PDmA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-iCYmmcirMJiia_wVIGqHlw-1; Wed, 28 Apr 2021 13:47:46 -0400
X-MC-Unique: iCYmmcirMJiia_wVIGqHlw-1
Received: by mail-qv1-f69.google.com with SMTP id el4-20020ad459c40000b029019a47ec7a9dso25018922qvb.21
        for <fstests@vger.kernel.org>; Wed, 28 Apr 2021 10:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Np/0h7yK8mlO72O746vGN1gLf2I7R6Y5y97q0vaR2XE=;
        b=UScLQcP5lrMv3ZVAs0oXFb4DvLyknquio7LdyFVuvKrQOsYuqqI+1fLTCSkFToFqD+
         LW6VuYMF9PMDxkv7ME519UbXpFFu045S+CRZdBXdSi7rio522/YKxtUdMQLdf6DDQZHC
         7ndZApNZ+o6Eyn2VsBAk5KknYqBDPQ2Zt11EPQ+/KlSWF+vObLaJfAeKydm5Q0AUgz4/
         Q5Ds9eQapT4QOyrZAJ1fxqRsJkS2s210z+eMK1ss8L+xR/PbkaNX2xX4ERlCZeUpfTWV
         ZAg9rrD54SjerUGAS0yfFaDqDKuZhaHScwZSYpClQdpiUm/GLd7slbox41RiTUO/uz39
         NmLQ==
X-Gm-Message-State: AOAM531qEK/5Jd9ZenSqfcHn44gKqLOpvc1z6P9LdPpASgmWR7Z9z+DT
        HL0lYr5PaCjjRIO/EW2zo5eLEzKlMygA5ui1m6zei+8WlT6uqW9otacOWSK1kMBOI3OpgisrXkG
        Q1pnJH8jS8HCapVC4KQ==
X-Received: by 2002:a05:620a:8dd:: with SMTP id z29mr22118700qkz.492.1619632065025;
        Wed, 28 Apr 2021 10:47:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+ROJMweWfnnaFHRM9hDW1zD8OrcysSIba1ln92bv5vcltrV6g044e9q/k56OIHBEzUjPjTA==
X-Received: by 2002:a05:620a:8dd:: with SMTP id z29mr22118691qkz.492.1619632064877;
        Wed, 28 Apr 2021 10:47:44 -0700 (PDT)
Received: from bfoster ([98.216.211.229])
        by smtp.gmail.com with ESMTPSA id e13sm534274qtm.35.2021.04.28.10.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:47:44 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:47:42 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     guaneryu@gmail.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 4/5] xfs/004: don't fail test due to realtime files
Message-ID: <YImfvpWFzufkVUvR@bfoster>
References: <161958293466.3452351.14394620932744162301.stgit@magnolia>
 <161958295873.3452351.8562454394626118217.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161958295873.3452351.8562454394626118217.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 27, 2021 at 09:09:18PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test exercises xfs_db functionality that relates to the free space
> btrees on the data device.  Therefore, make sure that the files we
> create are not realtime files.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/xfs/004 |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> 
> diff --git a/tests/xfs/004 b/tests/xfs/004
> index 141cf03a..7633071c 100755
> --- a/tests/xfs/004
> +++ b/tests/xfs/004
> @@ -28,6 +28,10 @@ _populate_scratch()
>  	_scratch_mkfs_xfs | tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs
>  	. $tmp.mkfs
>  	_scratch_mount
> +	# This test looks at specific behaviors of the xfs_db freesp command,
> +	# which reports on the contents of the free space btrees for the data
> +	# device.  Don't let anything get created on the realtime volume.
> +	$XFS_IO_PROG -c 'chattr -t' $SCRATCH_MNT
>  	dd if=/dev/zero of=$SCRATCH_MNT/foo count=200 bs=4096 >/dev/null 2>&1 &
>  	dd if=/dev/zero of=$SCRATCH_MNT/goo count=400 bs=4096 >/dev/null 2>&1 &
>  	dd if=/dev/zero of=$SCRATCH_MNT/moo count=800 bs=4096 >/dev/null 2>&1 &
> 

