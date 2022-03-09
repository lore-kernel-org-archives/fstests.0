Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8183C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Mar 2022 03:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiCIDkr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Mar 2022 22:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiCIDkq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Mar 2022 22:40:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C094D36B7C
        for <fstests@vger.kernel.org>; Tue,  8 Mar 2022 19:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646797186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ao9cYWuoQIZn6fJuWZz2s1DRX4gV/PZT2lo3bsrxg9A=;
        b=gV+4aV/0/bnTiO8pb6vaJIlx+u9H82tE4udmW3VC4SIFsj9ucKIeTulDJY/NAeAupSjFWs
        Pp5XjtUq9pddi9GzOx7LVYeNTL4PwQ8kKiWjL0ne43XbdNOS879atg42/N0IcvbHVvMOo3
        2R2lsyNEYGxvX7YAiA8SLZkqDgK+NUk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-_2NQtvZQM22zpeDVfGmy3w-1; Tue, 08 Mar 2022 22:39:46 -0500
X-MC-Unique: _2NQtvZQM22zpeDVfGmy3w-1
Received: by mail-qk1-f197.google.com with SMTP id 12-20020a37090c000000b0067b32f93b90so686878qkj.16
        for <fstests@vger.kernel.org>; Tue, 08 Mar 2022 19:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Ao9cYWuoQIZn6fJuWZz2s1DRX4gV/PZT2lo3bsrxg9A=;
        b=lSuaP+2tOGHLd1Zflr13fwmRkvZuY8N+8R1THeJeSCsFbvFZ/ljNXp/E+MgXecdv+d
         Vcal2tiKQ6yhzghtip94Oyyd73bERzdHFSzpshwSFlPEBL5/D74Av1Cet3Pu8E+D/bQn
         wU11Uku2dj6voSM0ZqQndjRzkhf+Kc9eNYMXf6vwYhPXeVHjmNeDzkSgTIgBs8I0Oh1O
         pVaG6eUWWoax2HJ3ELZJ7MxZNrtyS8p1nf0T/jDNCuQ/jWmSJCyVxH8Yq0qq4DyYNa7M
         pRFqniJyzsRBYuw3REV++kskr02faBTx+CDWC5DdqHuIf+DumTVIH0UaHfO5eusCrXhh
         u+Pg==
X-Gm-Message-State: AOAM533Lfs387ksZRQK4TEiOKpVHfOy7a8nQfQUYz+Hgq5eaGe0nnL9k
        f9IuyGeI++FMKxYIb3LxPtbuMli/tUy1lTKB5X8D/zVMBcmpxTT6g1DYYw0PK7ijh6H8KoZ/a0x
        9mELolX1KukLyYALwoA==
X-Received: by 2002:a05:622a:120e:b0:2e0:5648:a0f7 with SMTP id y14-20020a05622a120e00b002e05648a0f7mr16513217qtx.586.1646797184944;
        Tue, 08 Mar 2022 19:39:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1PBdFklp5li2ICAEMOW6erMuOu36Pfco9Me5GpqLRbX53wLdHcvaGIdVv7Ntcf2dlhOj8CA==
X-Received: by 2002:a05:622a:120e:b0:2e0:5648:a0f7 with SMTP id y14-20020a05622a120e00b002e05648a0f7mr16513210qtx.586.1646797184694;
        Tue, 08 Mar 2022 19:39:44 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e18-20020a05620a12d200b0066393782c89sm448548qkl.64.2022.03.08.19.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 19:39:43 -0800 (PST)
Date:   Wed, 9 Mar 2022 11:39:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        max.kellermann@ionos.com
Subject: Re: [PATCH] fstests: test dirty pipe vulnerability issue of
 CVE-2022-0847
Message-ID: <20220309033936.y7pzdkmtwoh5jb3l@zlang-mailbox>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        max.kellermann@ionos.com
References: <20220308092248.786739-1-zlang@redhat.com>
 <20220308171429.GB117704@magnolia>
 <20220308190219.kohodxq4bndpduwk@zlang-mailbox>
 <20220308195501.GC117704@magnolia>
 <20220308224858.GS3927073@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308224858.GS3927073@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 09, 2022 at 09:48:58AM +1100, Dave Chinner wrote:
> On Tue, Mar 08, 2022 at 11:55:01AM -0800, Darrick J. Wong wrote:
> > On Wed, Mar 09, 2022 at 03:02:19AM +0800, Zorro Lang wrote:
> > > On Tue, Mar 08, 2022 at 09:14:29AM -0800, Darrick J. Wong wrote:
> > > > On Tue, Mar 08, 2022 at 05:22:48PM +0800, Zorro Lang wrote:
> > > > > +chmod 0644 $localfile
> > > > > +# Test privileged user (xfstests generally run with root)
> > > > > +echo "Test privileged user:"
> > > > > +$here/src/splice2pipe $localfile 1 "AAAAAAAABBBBBBBB"
> > > > > +# Part of 0xff will be overwritten if there's CVE-2022-0847 bug
> > > > > +hexdump -C $localfile
> > > > 
> > > > (I wonder offhand if fstests ought to be checking for the existence of
> > > > hexdump(1) since at least Debian only has it in bsdmainutils package,
> > > > but ... that's a separate question.)
> > > 
> > > Hmm... I never thought about that, due to the hexdump is in util-linux for
> > > rhel and fedora. That means it's nearly always be there. If Debian or some other
> > > system won't have it by default, we might say 'hexdump' is a necessary dependence
> > > to run fstests in doc :)
> > 
> > Yeah.  The fstests documentation don't list bsdmainutils as a required
> > package for Debian, so I think either we should update the documentation
> > or do a treewide change to make all the tests that use hexdump(1)
> > _require it.
> 
> I think it would be better to replace hexdump uses with 'od -x' as
> od is part of coreutils. Hence we can either replace all the calls
> to hexdump with direct calls to od -x, or add a simple wrapper like:
> 
> hexdump() {
> 	od -x $@
> }
> 
> with whatever the format specification needed is to output the same
> format as hexdump does...

You're right, "od -x" output foramt is same with "hexdump" [1]. But most
xfstests' cases use "hexdump -C", and output as golden image. I tried to make
od output as that format, but didn't find a proper way. (Feel free to tell me
if you know a better usage). So if we'd like to replace hexdump with od, we
need to change some cases' .out files. Do you think it's time to do this change
now? I can send another patch to do that.

Thanks,
Zorro


[1]
  # od -x  /mnt/test/testfile.676
  0000000 ffff ffff ffff ffff ffff ffff ffff ffff
  *
  0010000
  # hexdump /mnt/test/testfile.676
  0000000 ffff ffff ffff ffff ffff ffff ffff ffff
  *
  0001000



> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

