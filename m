Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6B7C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 05:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiEXFEs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 01:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiEXFEr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 01:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 184446B7ED
        for <fstests@vger.kernel.org>; Mon, 23 May 2022 22:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653368684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8KC1gJCDCLV/rqmaGdwmUqH8FwDftr/7TObykBGS1Vs=;
        b=CLS5T7RhWSQasQoYHRaOoInOlygaAJL63sFh4V0wnb6keDuhqNTEzjMZKBuXrRZyT1RFO6
        tiU2wPmWUxlTlZG8H8iM9VlQcW3oITC0mLSrI/Zvr4hEpSNtHZD6QgF0c738v5qf2KSrAT
        ujqtEnYGy37dfMnFbSBQ4GOuISKfpS0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-jlMXQi_XNfCAXOTHX2z9Eg-1; Tue, 24 May 2022 01:04:43 -0400
X-MC-Unique: jlMXQi_XNfCAXOTHX2z9Eg-1
Received: by mail-qv1-f70.google.com with SMTP id o99-20020a0c906c000000b00456332167ffso12497269qvo.13
        for <fstests@vger.kernel.org>; Mon, 23 May 2022 22:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8KC1gJCDCLV/rqmaGdwmUqH8FwDftr/7TObykBGS1Vs=;
        b=HLDe4ww+iVWedMkBBkdFFHOashgp86bT+3LsTI3yMC8i18+Yp15hdq+zHbXc2C6vPD
         +zMRbgePlia2BptC8Y3DRxqJqb3S4WhZRHt7LGZ2uFm4kEOTe8yAZLWgJV3kTeTQ2fMi
         cCZI6tQv8GL46XYeq7sgQAmlNYGxrnTaycM3qh6CKmBfLiEXJ9H4hzMfdJMA7gt9wbbc
         o7lkpdQUHoUufMdMY/WfanQnAGf7Ns+5A8aZP348efOdBOMWZY19TQiQlc9fnmW4vACZ
         MPKk548FEjUgLgfbcTrkfO0DSvyZmPuCqTDlqa/6KWvyAyaj2MAXBg61i+Wuv0TIUBEb
         2y9Q==
X-Gm-Message-State: AOAM533E9YiITVZNhzR0lDOfR8K014SpFEiEZNMecvQdphnSE4MidIqC
        FAKxFGHBDjWtOEciOsvgJOFjGBiNgEkDk2RDpy4rzWbajk+0wel9nzdsyJKxSkN1vv8RSJsfJJc
        4QnwGom0m2shvZc9J6g==
X-Received: by 2002:ad4:594b:0:b0:462:3a57:b789 with SMTP id eo11-20020ad4594b000000b004623a57b789mr6860118qvb.74.1653368682427;
        Mon, 23 May 2022 22:04:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQWsHAccG8gOE8VIubC0yKEQpOQTWzHAv5EwXumpUJPQ3qqid3oATtDcM9XUIt84lZTCCJQA==
X-Received: by 2002:ad4:594b:0:b0:462:3a57:b789 with SMTP id eo11-20020ad4594b000000b004623a57b789mr6860109qvb.74.1653368682200;
        Mon, 23 May 2022 22:04:42 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r65-20020ae9dd44000000b006a32bf19502sm5603880qkf.60.2022.05.23.22.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 22:04:41 -0700 (PDT)
Date:   Tue, 24 May 2022 13:04:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH] ceph/001: skip metrics check if no copyfrom mount option
 is used
Message-ID: <20220524050436.qe4kc7bacm6hp54d@zlang-mailbox>
References: <20220520105055.31520-1-lhenriques@suse.de>
 <20220524044507.m3drhwpn2orfp7my@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524044507.m3drhwpn2orfp7my@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 12:45:07PM +0800, Zorro Lang wrote:
> On Fri, May 20, 2022 at 11:50:55AM +0100, Luís Henriques wrote:
> > Checking the metrics is only valid if 'copyfrom' mount option is
> > explicitly set, otherwise the kernel won't be doing any remote object
> > copies.  Fix the logic to skip this metrics checking if 'copyfrom' isn't
> > used.
> > 
> > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > ---
> 
> The code logic looks good to me, but I'm not familiar with cephfs, so if there's
> not review points or objection from ceph-fs, I'll merge this patch this week.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> Thanks,
> Zorro
> 
> >  tests/ceph/001 | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tests/ceph/001 b/tests/ceph/001
> > index 7970ce352bab..2e6a5e6be2d6 100755
> > --- a/tests/ceph/001
> > +++ b/tests/ceph/001
> > @@ -86,11 +86,15 @@ check_copyfrom_metrics()
> >  	local copies=$4
> >  	local c1=$(get_copyfrom_total_copies)
> >  	local s1=$(get_copyfrom_total_size)
> > +	local hascopyfrom=$(_fs_options $TEST_DEV | grep "copyfrom")

Oh, I forgot to metion that:

I don't know what's the mount option output format at here, can't sure if
"grep -w" is needed, or need special pattern.

> >  	local sum
> >  
> >  	if [ ! -d $metrics_dir ]; then
> >  		return # skip metrics check if debugfs isn't mounted
> >  	fi
> > +	if [ -z $hascopyfrom ]; then

I think better to use quotes ("$hascopyfrom") at here.

> > +		return # ... or if we don't have copyfrom mount option
> > +	fi
> >  
> >  	sum=$(($c0+$copies))
> >  	if [ $sum -ne $c1 ]; then
> > 

