Return-Path: <SRS0=gdhN=AE=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E32C433E0
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Jun 2020 15:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B331420656
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Jun 2020 15:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsvO5suV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbgFWPaw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:30:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59627 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732821AbgFWPaw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Jun 2020 11:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592926250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6vJut7rs0HVzbPm/cPk8zfP3g4qGAW2hGdQEtidmPko=;
        b=PsvO5suVYK5LZxrzSfaZbHDSohhLU1/j0rcmrUg7V5pIMsNnm6LbnKiOtk9oNzjkimbLNG
        nZRhhI3tdsq7OVdF6BusIY5MPUBWvc9tP6Nmue2T2mllGg1QR3n5Kbj/JqIcnuqUl4h4EK
        3Sj9shRkLVy2BrGxkzWlPWxLgClNK/E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-1tci5YqxP3CKKs-r07JxfQ-1; Tue, 23 Jun 2020 11:30:48 -0400
X-MC-Unique: 1tci5YqxP3CKKs-r07JxfQ-1
Received: by mail-pl1-f200.google.com with SMTP id bh7so14314446plb.2
        for <fstests@vger.kernel.org>; Tue, 23 Jun 2020 08:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6vJut7rs0HVzbPm/cPk8zfP3g4qGAW2hGdQEtidmPko=;
        b=HSodojZdHz64zCFffxCAp0sya9SZfbMWE+zW/a9NY6Zh4FcM88rC67nqU2k4w/6dGS
         9PZLEHmWUp+KDmvw2AqjRAwBRoEWBDFK6XCtZQQ8iUgvizgHis1qBlm7T5FbZWHbmPuf
         7aO4E/zQoeAU0BKBL7W/lANu556QfPgUsuxBmNDGuVa7e+vZjW/nbZLr2aULsiHptjU8
         rKJhzNP9WC/1s17e371f1B0arX4YzFh8pnOXDDbiRws+eZlnasMzzLjcYjj0qQkA6r81
         z5ASjGe+Z+TpJnZFmy+tJcFvxL9JqJBx+YI7W/xC7uoNZMwplf9DkMuMIScxqQr+8s3B
         DY2Q==
X-Gm-Message-State: AOAM5323pw8Ik96mKM1B7UtTCLWLaARuK2ft3jFa8QxRMzIrXCDkZvIO
        kRdd8y0EjQj2S0ujx6xGf3JViu6ba3XXVACVD+d37l3U0cebkoJ2EHg6btkNRq9oxkH76Ahcw3r
        MyggzvAmQb70FNmlTAQ==
X-Received: by 2002:a17:90a:fe92:: with SMTP id co18mr24093479pjb.69.1592926247707;
        Tue, 23 Jun 2020 08:30:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAQYHLWM1JD9FZK+jHsBJQeBph4P5ksDh1ssy1/VCDmBBQUiVC4m9GpgXGh+dqymQrQj8piA==
X-Received: by 2002:a17:90a:fe92:: with SMTP id co18mr24093457pjb.69.1592926247488;
        Tue, 23 Jun 2020 08:30:47 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y22sm948950pjp.41.2020.06.23.08.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 08:30:47 -0700 (PDT)
Date:   Tue, 23 Jun 2020 23:30:37 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH v2] xfs: add test for CVE-2020-12655
Message-ID: <20200623153037.GB31326@xiangao.remote.csb>
References: <20200619134419.30705-1-hsiangkao@redhat.com>
 <20200623020447.5924-1-hsiangkao@redhat.com>
 <20200623152352.GA7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623152352.GA7600@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Darrick,

On Tue, Jun 23, 2020 at 08:23:52AM -0700, Darrick J. Wong wrote:

...

> > +
> > +	_scratch_unmount > /dev/null 2>&1
> > +	[ $mounted -eq 0 -o $hasmsg -eq 1 ] && return
> > +	_fail "potential broken kernel"
> 
> Could you print both variables in the error message so that it's easier
> to figure out where exactly we went wrong?

Okay, will fix in the next version (tomorrow, about to sleep...)

> 

...

> >  518 auto quick quota
> >  519 auto quick reflink
> > +520 auto quick reflink dangerous
> 
> Hmmm... I guess the fix has been out for a while, so it's less shocking
> to put a dangerous test in the auto group?

Okay, will update it (I'm backporting the fix to old old kernels...
and some you know....). Thanks for the review!

Thanks,
Gao Xiang

> 
> --D
> 
> > -- 
> > 2.18.1
> > 
> 

