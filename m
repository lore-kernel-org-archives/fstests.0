Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D054C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 09:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347652AbiETJZ2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 05:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344866AbiETJZZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 05:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FA3025284
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653038723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1yRB3UthowaaONrIPAWFvF3Knie2QBzmQCNgSZuYOy0=;
        b=dH6jNp/bfX7myBhSITUiQjZlWqkiWMqVEegzj4ByOBhoImgpKQnHJXDi9MpKRMnt8TdxTL
        ffgtoGOeDrgqh5/Bz5AdE7EBDj1ly7JG6TY1TEsWgFy7OTeAz6vKfrQMWJIXwAi8FNg0K1
        8o1EqkloraQm6ps+ntaKgbhIwl7A1zA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-uOHvUDNDMIecLRScto2rQQ-1; Fri, 20 May 2022 05:25:22 -0400
X-MC-Unique: uOHvUDNDMIecLRScto2rQQ-1
Received: by mail-qv1-f70.google.com with SMTP id kl23-20020a056214519700b0046200065604so3061062qvb.19
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 02:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1yRB3UthowaaONrIPAWFvF3Knie2QBzmQCNgSZuYOy0=;
        b=qjkHUr51KgLe21tktI1+Mm+P1oF0WtN5FclpWh1wV3sTPcfvYqc+WYCmRVq8OYGtp6
         h376eTw2WEHZEhEzD4b3yUsMbSQUg79dTqSdNAKfMpbWIJAmMpTcLX/ivq45ywW3BHlB
         8VhTAezIeMUx8Fx0mPLqNn435jxL2IWequzwgxPklONiZp4o3di9+A8cuc8cPaR/dbGi
         P+FG2wD6FqXtD5qkai4nZm8Vq7D1JZn2K6rdvWE6y/PI5bCbn+Rpvhx4FWlcRCtd6JJd
         f3Lh98vsm0ASVBQ0+sWJ3kqQ1TegUCElVnyYQk568JURZ+JBL8Z+2NkZHVxoQK4UoMq9
         6cUA==
X-Gm-Message-State: AOAM530Upc9Et/yPtlbPp3YbilkM2U+Ab79N9fCjmHh2hbqGPKC7+Eyn
        4QbBRhtVL+hus06lcbH2AEBI0tLRUWFGeTyznxtuqdSrfo0y3DGIGaRTfYqcXizpy+uFBPQQa8F
        z/V4bBgJ8PuP5UrIztA==
X-Received: by 2002:a05:620a:2546:b0:680:f744:5bc6 with SMTP id s6-20020a05620a254600b00680f7445bc6mr5670441qko.113.1653038721772;
        Fri, 20 May 2022 02:25:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLiEphBLMtnMNhDBsNwOI/+WPJGeWn3709ArMiOrTJtxUiB6K4/euZ7cn+gtAvAb6kHpmnGg==
X-Received: by 2002:a05:620a:2546:b0:680:f744:5bc6 with SMTP id s6-20020a05620a254600b00680f7445bc6mr5670435qko.113.1653038721528;
        Fri, 20 May 2022 02:25:21 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u4-20020ae9d804000000b0069fc13ce224sm2801608qkf.85.2022.05.20.02.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 02:25:21 -0700 (PDT)
Date:   Fri, 20 May 2022 17:25:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 04/12] fstests: fix group list generation for whacky test
 names
Message-ID: <20220520092515.q5lyyujfnanrpcmx@zlang-mailbox>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517070111.1381936-5-david@fromorbit.com>
 <20220520083647.s22yb2aearmviffi@zlang-mailbox>
 <20220520085445.mil6iwc5mltbmss3@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520085445.mil6iwc5mltbmss3@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 04:54:45PM +0800, Zorro Lang wrote:
> On Fri, May 20, 2022 at 04:36:47PM +0800, Zorro Lang wrote:
> > On Tue, May 17, 2022 at 05:01:03PM +1000, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > Darrick noticed that tests/xfs/191-input-validation didn't get
> > > generated properly. Fix the regex to handle this.
> > > 
> > > $ grep -I -R "^_begin_fstest" tests/xfs | \
> > >   sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' |grep 191
> > > tests/xfs/191-input-validation:_begin_fstest auto quick mkfs realtime
> > > $
> > > $ grep -I -R "^_begin_fstest" tests/xfs | \
> > >   sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/ ' |grep 191
> > > 191 auto quick mkfs realtime
> > > $
> > > 
> > > Use the regexes for matching test names defined in common/test_names
> > > rather than trying to open code it.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > 
> > Hi Dave,
> > 
> > After testing, looks like this patch brings in a regression issue, it causes
> > case number aren't sorted in group.list, then the xfstests/new program can't
> > get a right new case number which is unused. For example:
> 
> Oh, this issue isn't from this patch, it's from 441606d2 ("fstests: faster group
> file creation"). Hmm... I saw your used "sort -u" in that patch, I'm going to
> look into what's wrong with that.
> 
> Thanks,
> Zorro
> 
> > 
> > # make
> > # ./new generic
> > Next test id is 019
> > Append a name to the ID? Test name will be 019-$name. y,[n]: ^C
> > # ls tests/generic/019
> > tests/generic/019
> > 
> > Then comparing the tests/generic/group.list with old generic/group.list, found
> > lots of difference, due to the number in new group.list isn't sorted from
> > small to big (I haven't gotten chance to check if there're missing number).
> > 
> > Thanks,
> > Zorro
> > 
> > >  tools/mkgroupfile | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> > > index 24435898..414cb538 100755
> > > --- a/tools/mkgroupfile
> > > +++ b/tools/mkgroupfile
> > > @@ -19,6 +19,8 @@ if [ ! -x ../../check ]; then
> > >  	exit 1
> > >  fi
> > >  
> > > +. ../../common/test_names
> > > +
> > >  cleanup()
> > >  {
> > >  	rm -f $new_groups.check
> > > @@ -60,7 +62,8 @@ ENDL
> > >  
> > >  	# Aggregate the groups each test belongs to for the group file
> > >  	grep -I -R "^_begin_fstest" $test_dir/ | \
> > > -		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
> > > +		sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" \
> > > +		>> $new_groups

I think add a "sort -ug" [1] will help to fix this problem. I'm wondering
why we use ">> $new_groups" at here, why an appending write is needed. I think
there's not a 'loop running' for this code, right? If there's, please correct
me, then the 'sort -ug' have to be moved to other place.

Thanks,
Zorro

[1]
-               sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" \
-               >> $new_groups
+               sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" | \
+               sort -ug > $new_groups

I'm wondering why we use

> > >  
> > >  	# Create the list of unique groups for existence checking
> > >  	grep -I -R "^_begin_fstest" $test_dir/ | \
> > > -- 
> > > 2.35.1
> > > 

