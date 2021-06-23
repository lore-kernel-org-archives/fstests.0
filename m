Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C28C48BC2
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Jun 2021 21:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A28613AE
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Jun 2021 21:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWVeK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Jun 2021 17:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFWVeJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Jun 2021 17:34:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61DCC061574
        for <fstests@vger.kernel.org>; Wed, 23 Jun 2021 14:31:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i4so1832699plt.12
        for <fstests@vger.kernel.org>; Wed, 23 Jun 2021 14:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Eqe3mEyJlWBFZICDzXQiRD9Vh+ZYKTghcs1v9uhnUM=;
        b=FhEuolZy6C6IKw5LCC156heb+l1T4W1+OBfVyBen/h4PfFbwjSgXEVNFuOfB32pipU
         4YWnCYDoPgrSNCVR146RtvfMG6ImnVDEaeeRNokNjbEo106NrI/sdFWCXe47wlSBVzgO
         5LlDrz3WVbCYRwXiw7hto/GcB9E4D1OmmRjAcAyhws+gWhzWibhU0zfGvChBMSgj88zD
         6l3sIPINo8W6yJH/6Hk5parPRtkwwBOYYdtfvTQ5wWuA3GKVBId+Aigy6PMcGnLRre64
         zWM0xeaawS1X5xd8q9d1Qy/Q9WaIfA77JTQId8nWB81pT5En0T53d2QaFMiebOptBkja
         domQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Eqe3mEyJlWBFZICDzXQiRD9Vh+ZYKTghcs1v9uhnUM=;
        b=oZTrII4IdEDFZNGoXRa+6cvXKSyuESSWfAjIju/HGLwunNzZJKYLwWwouy/yBMbWms
         l8qt9QZhSnwdikiZlXa80Q+/Z8U/PTTDdXNZMOf906DIIoq1sAYnWP3x8ecm1ZqRshvA
         X/1W/rkRTcIn1tN3Xv0hIZsr4nhKC2IQpUkpoRX8YXe4qPs49Zeh8uLpk6wvyht5vq8L
         EWvXKctqVVu2PGZNm9k4guPtLK1Db1TybkZS3tTB+SspgJywwWLSLL0EQ+ItFfoah3Oe
         zEbE1RP10kuxVW05n52wjju7Pyd4C+fMkW2Fewr4PZdSJrSHKGqIiFpF87cWXkPFHdmL
         q+dA==
X-Gm-Message-State: AOAM531+cwbJNdVgLIOaV1hr5/IMlGoLpAoAxesjXVkFi6Cj6ISYKO2x
        YHLxIHD1ycK9hjyIkiHR5kM=
X-Google-Smtp-Source: ABdhPJxxH3UIiVhV2VW//n02j8xitG/y2YLChgBpLASSlDCElpqtEru94xC2dQzLi8pkrms+TsEYEg==
X-Received: by 2002:a17:903:18c:b029:125:b183:798f with SMTP id z12-20020a170903018cb0290125b183798fmr1337648plg.24.1624483911173;
        Wed, 23 Jun 2021 14:31:51 -0700 (PDT)
Received: from google.com ([2601:647:4701:18d0:92f0:7e82:7425:340f])
        by smtp.gmail.com with ESMTPSA id p17sm6354260pjg.54.2021.06.23.14.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 14:31:50 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:31:48 -0700
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/048: skip test of filename wipe if journal
 checkpoint is not supported
Message-ID: <YNOoRPFcde/L1gEP@google.com>
References: <20210621164851.1808923-1-tytso@mit.edu>
 <YNIphT6xiluxLrOm@google.com>
 <YNKWMO0dY0hrMhqb@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNKWMO0dY0hrMhqb@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 22, 2021 at 10:02:24PM -0400, Theodore Ts'o wrote:
> On Tue, Jun 22, 2021 at 11:18:45AM -0700, Leah Rumancik wrote:
> > > diff --git a/tests/ext4/048 b/tests/ext4/048
> > > index 51189618..35e6aa7f 100755
> > > --- a/tests/ext4/048
> > > +++ b/tests/ext4/048
> > > @@ -93,6 +93,14 @@ _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
> > >  # create scratch dir for testing
> > >  # create some files with no name a substr of another name so we can grep later
> > >  _scratch_mount >> $seqres.full 2>&1
> > > +
> > > +# Use the presence of the journal checkpoint ioctl as a proxy of filename
> > > +# wipe being supported
> > > +if test -x $here/src/checkpoint_journal && \
> > > +	! $here/src/checkpoint_journal $SCRATCH_MNT --dry-run ; then
> > > +    _notrun "filename wipe not supported"
> > > +fi
> > 
> > What if checkpoint_journal is not there? Should the test be
> > skipped in that case as well?
> 
> I went back and forth on that one.  In actual practice
> checkpoint_journal should always be built in a valid xfstests
> installation, so the case of it not existing should rarely if ever
> arise.  We don't actually _need_ checkpoint_journal to run the test;
> we're just using it as a hint as to whether the filename wipe feature
> is present.  So I decided to let the test run if we couldn't find it,
> on the theory that in the long run, all future kernels will have the
> feature.   But the case could be made in other direction....
> 
> 	       	   	      	 - Ted

Reviewed-by: Leah Rumancik <leah.rumancik@gmail.com>
