Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996ACC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 17:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiCVRMb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbiCVRMa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 13:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C2DA8B6DD
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647969061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Va0Dq3RhmRvg5wvK+x10zGtoh3P1wp4tCh8wB6ewh+s=;
        b=AECtV4w/3y9qkl0Nw8FwYvaVFdhBFDxBqgm6HE2u19lKg7lOkY+sssxMFL5WveDSyf6RFi
        DE64Sn0q2G5Y72CBAAQ3P2Odi84PAKobNE2kJ7vo6AidyDfNaA+CG0lQL4nv96NkIBEn2h
        p2IiwRpHQSAAItXQpYQ5ysiebZci+FY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-e39iHTheMUCQHuuRW5k-mw-1; Tue, 22 Mar 2022 13:10:59 -0400
X-MC-Unique: e39iHTheMUCQHuuRW5k-mw-1
Received: by mail-pl1-f200.google.com with SMTP id j6-20020a170902c08600b0015442fe6256so2750226pld.23
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 10:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Va0Dq3RhmRvg5wvK+x10zGtoh3P1wp4tCh8wB6ewh+s=;
        b=PyCr2LfqXFLhWU09Gy1yWpDXJIYZXe6ArZK067kC88Ee0N1vHjK10ZANioyeUwwHlm
         YOjTiR08qaIpSn4lkUlFvFkI5245+aBj/t28bZKwNHjKQGWqFFOuyEIzHe2TEo+uMOrz
         3Ma97eE6bZ+cfyM3o6CE4aVmPSVpRJ1HjDxfArS5sPJ/N2UWWurSWN3xMDcZ1zHYNsvG
         pgedRCbd4H50FtsoHPzIFntJcVOULer+AEDhRTT5NbArTkQOxJ+YKHWMzUTiY2SLWXC7
         lpJ/0eMBvx8kc7JTJWyPQEjvSxR+STmyeffUKo58JXKgANdUnGUlDaZK+5ZKIlrBc5V9
         /K3Q==
X-Gm-Message-State: AOAM530Z/mBCyCUUPRnQe3mtBPQUS0i8Qbn6qdNugwZoIJKdxy+tiQkN
        ru0LO9iOb+e9XyRdAuIxYy1EVR8db5isFKdMjeZFw8asW6GWofjKNS9sNStsc2ZhgV7QQSFSmZD
        BqpOIGsG2c9WGBq2JMQ==
X-Received: by 2002:a17:902:e9d3:b0:154:6dd6:2521 with SMTP id 19-20020a170902e9d300b001546dd62521mr8606864plk.59.1647969058618;
        Tue, 22 Mar 2022 10:10:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz00LVUEtW2QHPaAgKVLuaQWnSywutniN80Y9WpFF2eXVp9ulLhGe94H0Tf1y8VXkilAfJrtg==
X-Received: by 2002:a17:902:e9d3:b0:154:6dd6:2521 with SMTP id 19-20020a170902e9d300b001546dd62521mr8606835plk.59.1647969058289;
        Tue, 22 Mar 2022 10:10:58 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l18-20020a056a00141200b004f75395b2cesm23611569pfu.150.2022.03.22.10.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:10:57 -0700 (PDT)
Date:   Wed, 23 Mar 2022 01:10:53 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org,
        roman.penyaev@profitbricks.com
Subject: Re: [PATCH 1/2] xfstests: replace hexdump with od command
Message-ID: <20220322171053.wjqtazuhhkpezzyy@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org,
        roman.penyaev@profitbricks.com
References: <20220321110341.1323882-1-zlang@redhat.com>
 <20220321110341.1323882-2-zlang@redhat.com>
 <20220322052259.GC1609613@dread.disaster.area>
 <20220322122015.7zd3qgdvvhmefa2y@zlang-mailbox>
 <20220322155405.GL8200@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322155405.GL8200@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 22, 2022 at 08:54:05AM -0700, Darrick J. Wong wrote:
> On Tue, Mar 22, 2022 at 08:20:15PM +0800, Zorro Lang wrote:
> > On Tue, Mar 22, 2022 at 04:22:59PM +1100, Dave Chinner wrote:
> > > On Mon, Mar 21, 2022 at 07:03:40PM +0800, Zorro Lang wrote:
> > > > The "od" is one of the most fundamental commands in GNU/Linux and
> > > > most Unix-like systems. So we nearly always can count on it, don't
> > > > need to check if it's installed.
> > > > 
> > > > The "hexdump" isn't such fundamental as "od", some systems don't
> > > > install it by default. And as "od" nearly can replace all functions
> > > > of "hexdump", so let's use an unified command "od" to do the hexdump
> > > > job in fstests cases.
> > > > 
> > > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > 
> > > Looks good.
> > > 
> > > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > > 
> > > > ---
> > > > 
> > > > Hi,
> > > > 
> > > > As Dave and Darrick suggested, I did this change, I've tested most of cases,
> > > > except f2fs/001 and ceph/002, but I think they're good. And I used "od"
> > > > command directly in generic/404 and generic/042 for their special reason.
> > > 
> > > That generic/404 usage is ... strange. Why record md5sums of the
> > > encoded hexdump output of the file when you can just run md5sum on
> > > the file directly and get the same information?  i.e.
> > > 
> > > > diff --git a/tests/generic/404 b/tests/generic/404
> > > > index f1e8b0a8..939692eb 100755
> > > > --- a/tests/generic/404
> > > > +++ b/tests/generic/404
> > > > @@ -110,7 +110,7 @@ for (( block=3; block<=500; block++ )); do
> > > >  	# or blocks are in correct order, this commit:
> > > >  	#   2b3864b32403 ("ext4: do not polute the extents cache while shifting extents")
> > > >  	#
> > > > -	md5=`hexdump -e '16/1 "%_p" "\n"' $testfile | md5sum`
> > > > +	md5=`od -An -c $testfile | md5sum`
> > > >  	printf "#%d %s\n" "$block" "$md5"
> > > 
> > > Why isn't this just:
> > > 
> > > -	md5=`hexdump -e '16/1 "%_p" "\n"' $testfile | md5sum`
> > > -	printf "#%d %s\n" "$block" "$md5"
> > > +	echo -n "#$block "
> > > +	md5sum $testfile | _filter_test_dir
> > 
> > Yes, I thought about that too, but I can't be sure about it, so tried to keep
> > the logic of original code. If the original author doesn't have some special
> > reason, I'd like to change it as this way (cc roman.penyaev@profitbricks.com).
> > 
> > And for the generic/042:
> > -       if hexdump -v -e '/1 "%02X "' $file | grep -q "CD"; then
> > +       if od -An -tx1 -v $file | grep -q "CD"; then
> > 
> > I don't know what that "-v" option is needed (cc Darrick). I thought it might just
> > waste the time of grep running ?
> 
> Probably.  I probably put that in there for debugging purposes and then
> frogot to take it out.

Thanks Darrick, I'll remove it in V2 patch.

I tried to ask roman.penyaev@profitbricks.com, but that email can't be reached. So
I'll change g/404 as we talked.

> 
> --D
> 
> > > 
> > > Seperate patch, perhaps?
> > 
> > Sure, if no one object that, I'll change them in separated patch.
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Cheers,
> > > 
> > > Dave.
> > > -- 
> > > Dave Chinner
> > > david@fromorbit.com
> > > 
> > 
> 

