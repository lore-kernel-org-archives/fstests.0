Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF841C77B78
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 14:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbjDZOwq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240623AbjDZOwp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 10:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E350C30FC
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682520717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1SVFf8hCs819YX7OdfdUGVpt1QAK5va1OLcqdojzPDc=;
        b=MMIyCOdmN405G7bXUF1PLty5aaw8z5dXNJ4w9+yTJ6Rt1aPHW3yHb3mmM7jVCVsKNwpWvz
        hhT2KyB0Nf37gigqNMb9ZeS6UCN3eYMs8fbdbKLNjKQOfScrJawg0x7RsASAOa6mll5oM2
        KIDs+yCZF3bFekOEtvCFeoVXIljrTRs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-O5a4aB3IPpyS8dvoWdqYXA-1; Wed, 26 Apr 2023 10:51:55 -0400
X-MC-Unique: O5a4aB3IPpyS8dvoWdqYXA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-63f17b06d3fso4261044b3a.1
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520714; x=1685112714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SVFf8hCs819YX7OdfdUGVpt1QAK5va1OLcqdojzPDc=;
        b=VDsbP+hWDeEuzEYna2JmN4KtzmK5ij+5IdvsQmeYElLnjRiG4LR8Ekch5Y5s1YuJV2
         u4dm9inbnq8NkVs20RouHcOBMhbgB8RNKPY3PGebldFTGuC+Cw+2YVK2UsxJNKXH/Nzj
         1pk0+DrI8UGsrMmlpfwf+IwZfVOMwgLvPmd1ANRKGIAxHZDwYxvU9blxVuHNRBzXDSHW
         dFVOOLTuDCycBgcDvER0p6fzDfqJqc0p6g1bR2KmEJaC5iEHkmlOuFK7oj7rqfIEAxXN
         j5kujMv1s3yKOluZnHnj734qSZvS3vNwt2Xpu0J/DYOt49YNDgvFfujtDE65uANemeu9
         JKEw==
X-Gm-Message-State: AAQBX9f2gyNM19BNKptnH85jS/ogdht4FOQv2TVToGxXT7SHhCYlwrSw
        yivbW+m6HZlAjLTS/+bB74cSNNFpYYNQgtRlxYSxThNngD/LolTI3ZiufnbxZIx/9whT8HDSxgI
        viJsN7mRRTtqJ6x4rcA==
X-Received: by 2002:a05:6a20:a5a8:b0:ef:3e60:3f46 with SMTP id bc40-20020a056a20a5a800b000ef3e603f46mr22050815pzb.31.1682520714538;
        Wed, 26 Apr 2023 07:51:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350a2FlKXrXI2U9cqPhQpc+2vt3j6pvzucazc3tRwaXtXmF7uMOWGWKucqCg0f0KJ1cRGJ5xBYA==
X-Received: by 2002:a05:6a20:a5a8:b0:ef:3e60:3f46 with SMTP id bc40-20020a056a20a5a800b000ef3e603f46mr22050796pzb.31.1682520714224;
        Wed, 26 Apr 2023 07:51:54 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c194-20020a624ecb000000b0062dba4e4706sm11215951pfb.191.2023.04.26.07.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:51:53 -0700 (PDT)
Date:   Wed, 26 Apr 2023 22:51:49 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 5/6] generic/531: Check for O_TMPFILE
Message-ID: <20230426145149.mjsuugpgusqr6oj2@zlang-mailbox>
References: <20230424141042.450535-1-dhowells@redhat.com>
 <20230424141042.450535-6-dhowells@redhat.com>
 <20230426144931.uxapfrnh6adcwevd@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426144931.uxapfrnh6adcwevd@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 26, 2023 at 10:49:31PM +0800, Zorro Lang wrote:
> On Mon, Apr 24, 2023 at 03:10:41PM +0100, David Howells wrote:
> > Make generic/531 check that the filesystem under test supports O_TMPFILE
> > before attempting to test it.
> > 
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: linux-afs@lists.infradead.org
> > ---
> >  tests/generic/531 | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/generic/531 b/tests/generic/531
> > index 5e84ca97..e5f3dddd 100755
> > --- a/tests/generic/531
> > +++ b/tests/generic/531
> > @@ -20,6 +20,7 @@ testfile=$TEST_DIR/$seq.txt
> >  # real QA test starts here
> >  _supported_fs generic
> >  _require_scratch
> > +_require_xfs_io_command "-T"
> 
> Make sense,
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Oh, generic/530 is similar with 531, why only 531 need this one?

> 
> >  _require_test_program "t_open_tmpfiles"
> >  
> >  _scratch_mkfs >> $seqres.full 2>&1
> > 

