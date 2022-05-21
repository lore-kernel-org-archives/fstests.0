Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD509C433FE
	for <linux-fstests@archiver.kernel.org>; Sat, 21 May 2022 00:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346094AbiEUA1V (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 20:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354210AbiEUA1S (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 20:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EAC45D670
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 17:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653092835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HvGcDCMvh/8nqMABN9EGSXFyxOb3uhxCDTJLFyFOgQM=;
        b=QR0OkVtX1JuZ6eahICVpbRzvlAcl+3D17fXiXZfTgjxJob8Povd5taDPrd8btLhZ63Zm2l
        yI3Wk4B20sSkDQ1klgdMtTBriqPubDw8FnMFmqna9YW6WAtezwprviJ59TyW5qeWjdmTis
        2F62RASjrespXShjEWY7kjXMIxwHVlM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-i-zHtP-HNlSd09PtMfsO2g-1; Fri, 20 May 2022 20:27:14 -0400
X-MC-Unique: i-zHtP-HNlSd09PtMfsO2g-1
Received: by mail-qk1-f199.google.com with SMTP id o13-20020a05620a0d4d00b0069f47054e58so7521642qkl.13
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 17:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HvGcDCMvh/8nqMABN9EGSXFyxOb3uhxCDTJLFyFOgQM=;
        b=Ofr+SOit6r7bahxgtRDqYI6vuZUhi8L4OUctH8PKcr3CgjA+ERZvz5bVKJlcHOw9eD
         VKfvLI1IoTiuyFCLnN2YGC0Ix8SL4o+q7MGG5BSys3ITdvYmC4qUys0kEONr5Yexl09P
         MizbF+whwDRKNXCx3A7d/6Lamk90AQYi/ztIztO+T7JiDW58AC/j4zkeIy2xoP6rfWUB
         12/Q6oNrKATKvKZnaAqSgFDcPtRNxPUIQ5zxOyvcUTRneI/PMsQE8fUq94cIUDn+3Czs
         VvhVUszU2uuWRER8htPlRLu1z1yVaG1J1YCaoZsDbr72nLCKF6by+dDqXPNqhC8NatPU
         EDdA==
X-Gm-Message-State: AOAM531532SWjkkWwoXHocvuWFrq65m2Mk4sjb/0dHZhnDzaUHJRgIvb
        jbT9q5rcImpz+jQC4Uj9XYgNet+qo3c2UT3SaFRP/WhqLeQ63lPTadxL6RvDesyZ8WQfrXwOwNv
        RpDaq6oyfFyxEzfgNAA==
X-Received: by 2002:ac8:7dcb:0:b0:2f3:eb31:1e33 with SMTP id c11-20020ac87dcb000000b002f3eb311e33mr9574699qte.598.1653092833318;
        Fri, 20 May 2022 17:27:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyMreKMrJXJZZ4BfrjeSd70SJqPV/Lco7qkb3Sv67IMxymQMbUiWg529cDbGo0j1sTYlBEKQ==
X-Received: by 2002:ac8:7dcb:0:b0:2f3:eb31:1e33 with SMTP id c11-20020ac87dcb000000b002f3eb311e33mr9574690qte.598.1653092833022;
        Fri, 20 May 2022 17:27:13 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 131-20020a370989000000b0069fe1fc72e7sm547595qkj.90.2022.05.20.17.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 17:27:12 -0700 (PDT)
Date:   Sat, 21 May 2022 08:27:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 04/12] fstests: fix group list generation for whacky test
 names
Message-ID: <20220521002706.v43vkd7mc4cy76s6@zlang-mailbox>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517070111.1381936-5-david@fromorbit.com>
 <20220520083647.s22yb2aearmviffi@zlang-mailbox>
 <20220520085445.mil6iwc5mltbmss3@zlang-mailbox>
 <20220520092515.q5lyyujfnanrpcmx@zlang-mailbox>
 <YofAbrh79yb2dmWs@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YofAbrh79yb2dmWs@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 09:23:10AM -0700, Darrick J. Wong wrote:
> On Fri, May 20, 2022 at 05:25:15PM +0800, Zorro Lang wrote:
> > On Fri, May 20, 2022 at 04:54:45PM +0800, Zorro Lang wrote:
> > > On Fri, May 20, 2022 at 04:36:47PM +0800, Zorro Lang wrote:
> > > > On Tue, May 17, 2022 at 05:01:03PM +1000, Dave Chinner wrote:
> > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > 
> > > > > Darrick noticed that tests/xfs/191-input-validation didn't get
> > > > > generated properly. Fix the regex to handle this.
> > > > > 
> > > > > $ grep -I -R "^_begin_fstest" tests/xfs | \
> > > > >   sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' |grep 191
> > > > > tests/xfs/191-input-validation:_begin_fstest auto quick mkfs realtime
> > > > > $
> > > > > $ grep -I -R "^_begin_fstest" tests/xfs | \
> > > > >   sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/ ' |grep 191
> > > > > 191 auto quick mkfs realtime
> > > > > $
> > > > > 
> > > > > Use the regexes for matching test names defined in common/test_names
> > > > > rather than trying to open code it.
> > > > > 
> > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > > ---
> > > > 
> > > > Hi Dave,
> > > > 
> > > > After testing, looks like this patch brings in a regression issue, it causes
> > > > case number aren't sorted in group.list, then the xfstests/new program can't
> > > > get a right new case number which is unused. For example:
> > > 
> > > Oh, this issue isn't from this patch, it's from 441606d2 ("fstests: faster group
> > > file creation"). Hmm... I saw your used "sort -u" in that patch, I'm going to
> > > look into what's wrong with that.
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > > > 
> > > > # make
> > > > # ./new generic
> > > > Next test id is 019
> > > > Append a name to the ID? Test name will be 019-$name. y,[n]: ^C
> > > > # ls tests/generic/019
> > > > tests/generic/019
> > > > 
> > > > Then comparing the tests/generic/group.list with old generic/group.list, found
> > > > lots of difference, due to the number in new group.list isn't sorted from
> > > > small to big (I haven't gotten chance to check if there're missing number).
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > >  tools/mkgroupfile | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> > > > > index 24435898..414cb538 100755
> > > > > --- a/tools/mkgroupfile
> > > > > +++ b/tools/mkgroupfile
> > > > > @@ -19,6 +19,8 @@ if [ ! -x ../../check ]; then
> > > > >  	exit 1
> > > > >  fi
> > > > >  
> > > > > +. ../../common/test_names
> > > > > +
> > > > >  cleanup()
> > > > >  {
> > > > >  	rm -f $new_groups.check
> > > > > @@ -60,7 +62,8 @@ ENDL
> > > > >  
> > > > >  	# Aggregate the groups each test belongs to for the group file
> > > > >  	grep -I -R "^_begin_fstest" $test_dir/ | \
> > > > > -		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
> > > > > +		sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" \
> > > > > +		>> $new_groups
> > 
> > I think add a "sort -ug" [1] will help to fix this problem.
> 
> Yes please, it's much easier for us humans to index the file if it's
> already sorted numerically.
> 
> > I'm wondering
> > why we use ">> $new_groups" at here, why an appending write is needed. I think
> > there's not a 'loop running' for this code, right? If there's, please correct
> > me, then the 'sort -ug' have to be moved to other place.
> 
> The function writes a header into the group list file warning readers
> that it's an autogenerated file.

Oh, you're right, there's a comment as a header, so we should change as below:

-               sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" \
-               >> $new_groups
+               sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" | \
+               sort -ug >> $new_groups

Hi Dave, I'd like to fix this issue in this week. If you'd like to fix it
in this patch today, I'll wait half day. Or as it's a separated issue, I
can write another patch to get review, then merge with this patchset together.
Until now, I've merged below patches from this patchset:

38015b3d fstests: remove xfs deprecated test
59f840bf xfs/191: remove broken test
1de1ff66 xfs/148: fix failure from bad shortform size assumptions
df84ba04 xfs/148: make test debuggable
24ac437f xfs/348: golden output is not correct
e3a4d0e8 xfs/122: add attribute log formats to test output.
e121de4a fstests: filter quota warnings

Thanks,
Zorro

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > [1]
> > -               sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" \
> > -               >> $new_groups
> > +               sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" | \
> > +               sort -ug > $new_groups
> > 
> > I'm wondering why we use
> > 
> > > > >  
> > > > >  	# Create the list of unique groups for existence checking
> > > > >  	grep -I -R "^_begin_fstest" $test_dir/ | \
> > > > > -- 
> > > > > 2.35.1
> > > > > 
> > 
> 

