Return-Path: <SRS0=IF6L=3L=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458ADC2D0DB
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jan 2020 10:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B612467C
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jan 2020 10:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g56XGVYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgAVKWJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:22:09 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38831 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAVKWJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jan 2020 05:22:09 -0500
Received: by mail-pj1-f68.google.com with SMTP id l35so3267985pje.3
        for <fstests@vger.kernel.org>; Wed, 22 Jan 2020 02:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BQlm9vbgmZQ5+gNMOvQxMnhKUqD2ZI5AC2jQwEmHOY8=;
        b=g56XGVYyKNM1pcbuOG//5i4fg1zyk3mOVkipeM5lbUq6fsdQ4uYip097vP3PYkHbgi
         NeAtzg6nJDRHOScRFP14AqntC7Wy5aPA27S68605NzSTNjiCGv0qYJM93w30JBftU2Mu
         l3BJTjq+/3Jw8l2bpxiUyh4xdHaoa6gF5wMl9kwZSZNRVKeJEDyBE+wVDxvqVbvqoivm
         7lv+9wcDrExVP3H1hLnyBHq9QfgEFFRVWWnRwDTBy1mauV5VI1vo3xEYprNeFTG35Vv3
         +HsNwOu6LgSlpGjiYXeqkyvNEELbhsWeON04A8dCjrAXDANlpzNIymfHJVIXr/7o9XLW
         CB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BQlm9vbgmZQ5+gNMOvQxMnhKUqD2ZI5AC2jQwEmHOY8=;
        b=DouE2zdJzniJfnFmxdXZ9NK3HGIhYU2MmPBVaMgzCd9x0wPvTDc9cyimisusAfUhxJ
         6Jd8JUVJ619X6MhuIsaVFVGDUCIwZRNMN2IxSzdXl5v8JMpYNsdPtwulLOBMgaVlYjqI
         Vyw9x6sZHdrXGT780WfvhFf2tRpy10zOvk6m5PsXq33+be3e0J80R+wFD+NNJamNnrwj
         2wngrB5LWgZr81Gs+hpmreZt6dpncmH+i5JcNnAJB4pRGtZcZc8e7dhEl9jeEgIQiXSp
         Ndj/YJz7F15Gpe7PLv5FV9fM88/vTpNVZCtujemHax/9ILdH0BumoJIubZB5Jd/5bLBe
         bOvA==
X-Gm-Message-State: APjAAAXy+zWFt74ivwivSgTgeqx6nx1rzpC0t8sXKOYqrrD1QxI9g9nt
        upazOboY880TB82fPt5XUIY=
X-Google-Smtp-Source: APXvYqw5GIi6pinPNzZyFh+t1WO0PD6L+H7mLFGDMp9CcevBDF/WDBMK15wsMNGA0gbDfhuXPuOw/g==
X-Received: by 2002:a17:90a:cb83:: with SMTP id a3mr2207734pju.80.1579688528774;
        Wed, 22 Jan 2020 02:22:08 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p24sm46089146pff.69.2020.01.22.02.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 02:22:08 -0800 (PST)
Date:   Wed, 22 Jan 2020 18:22:00 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic: require fibmap for testcases using filefrag
Message-ID: <20200122102200.suudkpzwjqj7m3u6@xzhoux.usersys.redhat.com>
References: <20200117083824.32450-1-jencce.kernel@gmail.com>
 <20200117084517.GA24082@infradead.org>
 <20200117100230.gcvnheoh3rzddhg2@xzhoux.usersys.redhat.com>
 <20200118004700.GD2149943@magnolia>
 <20200118093851.s3qynwkyi4ay2vqc@xzhoux.usersys.redhat.com>
 <20200119220252.GA9313@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119220252.GA9313@infradead.org>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jan 19, 2020 at 02:02:52PM -0800, Christoph Hellwig wrote:
> On Sat, Jan 18, 2020 at 05:38:51PM +0800, Murphy Zhou wrote:
> > > But do those tests require filefrag -B??
> > 
> > Not really. But filefrag will fall back to use fibmap.
> 
> But that means it requires either FIEMAP or FIBMAP, and your patch
> will cause regressions for file systems only implementing FIEMAP.
> So the fix isn't to ask for FIBMAP, but to implement FIEMAP in
> any file system missing that support.

Hmm, you are right :-)
