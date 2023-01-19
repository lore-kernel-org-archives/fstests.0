Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEDBC38142
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Jan 2023 05:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjASFKE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Jan 2023 00:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjASFJb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Jan 2023 00:09:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CAE1BF0
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2023 21:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674104654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5gYkUw3+Oj4dvZjgQviThFCTAor37COUP9w9mLMlqLs=;
        b=iGbE9+aYK0jEU2AGrlq+FnG+iGX0EGOBFqOTnq0wzOHKM19Pp7vnzQq0CBSn0kuPyycQTU
        ndQyz1vzwBp8zKvBRszrQw9qRu+dezMG+DSSH7ecCH60ov5xDbktUFVhXaH0+yOnGECXx/
        XsIyNCx5Ox1ydPr6x8I8PPQWjADM0os=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-82-MsIHl5KxN_ejZjr7-KN4Lg-1; Thu, 19 Jan 2023 00:04:13 -0500
X-MC-Unique: MsIHl5KxN_ejZjr7-KN4Lg-1
Received: by mail-pf1-f197.google.com with SMTP id v23-20020aa78097000000b005748c087db1so419031pff.2
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2023 21:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gYkUw3+Oj4dvZjgQviThFCTAor37COUP9w9mLMlqLs=;
        b=7JT/Vv8+8OOe2ajuLortfIxm7t/j0iIvnwB+v3gfSEtG6lSszrQtrJYBOzjOURWh5u
         a7ZbhwkMp1OaR0uU2Xfy+UbPdYjWyR2ch1dorrMFTzKi7y7NycZmj9CM/H/mn5jiR4dn
         GKg8g1fw7BCiPW+83iWL4FeR14RfAO5nHxm0HlvYa/6tI5ecrFfguGXWgPHFaTeXoMge
         RjGoXsLIeXEmZ7FLCxc6vEW80kxZtMch96zgeitv0hbd24Gn6qh/TC7g0eh22o2LpTsC
         YTCSwR+wKV495Ns2A0jTlp86Mn4gIxdugRSlMZF8PE62OE8BSZGol8Y83bf4etkRb5Iz
         rHPg==
X-Gm-Message-State: AFqh2kpK5qxN0Mt0He4X0sLDk8sbiTQoV9z67DbFBUIpuhuKrhuVGOpt
        7HrXrvXlolh4P3glq/UHW1sruK6CnyP4Gv/oVhqWwt5oxjx89P/MDcCrzNL2oFmhpeLbSF8FFwn
        p19HOIrjGxGFpQBAf/g==
X-Received: by 2002:a17:902:7c8d:b0:194:9c02:6ea1 with SMTP id y13-20020a1709027c8d00b001949c026ea1mr9987503pll.0.1674104651702;
        Wed, 18 Jan 2023 21:04:11 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtGGX3A1pewUAr8DyphHU09e15zgu3ZDH427MxcDeTcQ9Jv0dpKIkih8FRFU0uP69firlqTcw==
X-Received: by 2002:a17:902:7c8d:b0:194:9c02:6ea1 with SMTP id y13-20020a1709027c8d00b001949c026ea1mr9987485pll.0.1674104651295;
        Wed, 18 Jan 2023 21:04:11 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709027e4d00b0019312dd3f99sm23710042pln.176.2023.01.18.21.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:04:10 -0800 (PST)
Date:   Thu, 19 Jan 2023 13:04:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 4/4] populate: improve runtime of __populate_fill_fs
Message-ID: <20230119050406.fqtf55c737yc35ze@zlang-mailbox>
References: <167400103044.1915094.5935980986164675922.stgit@magnolia>
 <167400103096.1915094.8399897640768588035.stgit@magnolia>
 <20230118155403.pg7aq3gtcks2ptdz@zlang-mailbox>
 <Y8hG59tdunKmATSw@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8hG59tdunKmATSw@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 18, 2023 at 11:22:15AM -0800, Darrick J. Wong wrote:
> On Wed, Jan 18, 2023 at 11:54:03PM +0800, Zorro Lang wrote:
> > On Tue, Jan 17, 2023 at 04:44:33PM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Run the copy loop in parallel to reduce runtime.  If filling the
> > > populated fs is selected (which it isn't by default in xfs/349), this
> > > reduces the runtime from ~18s to ~15s, since it's only making enough
> > > copies to reduce the free space by 5%.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  common/populate |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > 
> > > diff --git a/common/populate b/common/populate
> > > index f34551d272..1c3c28463f 100644
> > > --- a/common/populate
> > > +++ b/common/populate
> > > @@ -151,8 +151,9 @@ __populate_fill_fs() {
> > >  	echo "FILL FS"
> > >  	echo "src_sz $SRC_SZ fs_sz $FS_SZ nr $NR"
> > >  	seq 2 "${NR}" | while read nr; do
> > > -		cp -pRdu "${dir}/test/1" "${dir}/test/${nr}"
> > > +		cp -pRdu "${dir}/test/1" "${dir}/test/${nr}" &
> > >  	done
> > > +	wait
> > 
> > I'm thinking about what'll happen if we do "Ctrl+c" on a running test which
> > is waiting for these cp operations.
> 
> Hmm.  In the context of fstests running on a system with systemd, we run
> each test within a systemd scope and kill the scope when the test script
> exits.  That will tear down unclaimed background processes, but it's not
> a hard and fast guarantee that everyone has systemd.
> 
> As for *general* bashisms, I guess the only solution is:
> 
> trap 'pkill -P $$' INT TERM QUIT EXIT
> 
> To kill all the children of the test script.  Maybe we want that?  But I
> hate wrapping my brain around bash child process management, so yuck.
> 
> I'll drop the parallel populate work, it's creating a lot of problems
> that I don't have time to solve while delivering only modest gains.

Yeah, that makes things become complex. So I think if above change can bring
in big performance improvement, we can do that (or use another way to do that,
e.g. an independent program which main process can deal with its children).
If the improvement is not obvious, I'd like not to bring in too many
multi-bash-processes in common helper. What do you think?

Thanks,
Zorro

> 
> --D
> 
> > >  }
> > >  
> > >  # For XFS, force on all the quota options if quota is enabled
> > > 
> > 
> 

