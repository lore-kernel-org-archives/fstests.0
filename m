Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD85FC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 08:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347404AbiETIyz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 04:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347096AbiETIyz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 04:54:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3776E63505
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 01:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653036893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cQ830DGbYXNPxKs6xuvs2Ms12/yOHlIqDyLeC/KiGpE=;
        b=AwqgrFHojlahs1P0VtGgj84nHjMjEmirjiywvsQKJ0avASEbasKf4h1ReleRTj5s/p+LdI
        XRbgTMuM89yGZ0+Pe4sMZihEiis0oqadj5rg4cRkl1CzbmkdTNW2TYUmMcxNRwT5bWEx0O
        Zpz7WTjgN/PNiT6PAC+rGYKWgQ5VIZU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-miofRWd3OAy_MkgF05ToAA-1; Fri, 20 May 2022 04:54:51 -0400
X-MC-Unique: miofRWd3OAy_MkgF05ToAA-1
Received: by mail-qk1-f200.google.com with SMTP id c84-20020a379a57000000b0069fcf83c373so6007431qke.20
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 01:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cQ830DGbYXNPxKs6xuvs2Ms12/yOHlIqDyLeC/KiGpE=;
        b=cmmlW7hpcvB9O8nRaFS+oPFRN8o3RGAwo6fwhJrbFDk2ltXcyCL8WyH7wy2Mm+/tkL
         nLr3ebCT3Ic7ua7YysSvvukiKx84xdh2Ce2+Yq7Z3tKgTdDxb5pcuBEyjSY45/D3RKkW
         as4o6YbGhadQArWkDHw2i5HEs85h7Z1DcvbooLE5XZmtSyJ7oGIEgpxa/rV3hKeKRU9B
         wesEZtlHL/kjsvnsCbbu/EeLkpYNT7qylsO5P1BVed78KMj+oxJ5sLtoeSJiC76WR3/t
         ZpxSDDMThZpEG7qZ6/hIQcmLFX7FxHtt7Zz4qV4UVZwY3vbWjddyb+SKdsBdgsLEYDQ9
         Ftrg==
X-Gm-Message-State: AOAM533FBhhJTstx61kSDpU5BKIMvO4CwUqsXt6RtlIC3YkX29JNwK70
        CvBXgQiZ5p4Q32qtdhMC+ws+Rnlpdx2BbpRoszpdRiwTpkFZkm2qQuw3bdtXTw/GhI+0h7x7hK8
        wk15CnkuFKq/uqVDeWQ==
X-Received: by 2002:a05:620a:29ce:b0:6a0:2338:2fbe with SMTP id s14-20020a05620a29ce00b006a023382fbemr5711535qkp.315.1653036891177;
        Fri, 20 May 2022 01:54:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPmDtoIFMv/PnoqQs6onFgVe9ia+e3d/xzmYQguvrBBI6L38Kqce094aSLW00VNj4R8jE5/w==
X-Received: by 2002:a05:620a:29ce:b0:6a0:2338:2fbe with SMTP id s14-20020a05620a29ce00b006a023382fbemr5711530qkp.315.1653036890862;
        Fri, 20 May 2022 01:54:50 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s65-20020ae9de44000000b006a2f129425asm2516702qkf.130.2022.05.20.01.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 01:54:50 -0700 (PDT)
Date:   Fri, 20 May 2022 16:54:45 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 04/12] fstests: fix group list generation for whacky test
 names
Message-ID: <20220520085445.mil6iwc5mltbmss3@zlang-mailbox>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517070111.1381936-5-david@fromorbit.com>
 <20220520083647.s22yb2aearmviffi@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520083647.s22yb2aearmviffi@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 04:36:47PM +0800, Zorro Lang wrote:
> On Tue, May 17, 2022 at 05:01:03PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Darrick noticed that tests/xfs/191-input-validation didn't get
> > generated properly. Fix the regex to handle this.
> > 
> > $ grep -I -R "^_begin_fstest" tests/xfs | \
> >   sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' |grep 191
> > tests/xfs/191-input-validation:_begin_fstest auto quick mkfs realtime
> > $
> > $ grep -I -R "^_begin_fstest" tests/xfs | \
> >   sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/ ' |grep 191
> > 191 auto quick mkfs realtime
> > $
> > 
> > Use the regexes for matching test names defined in common/test_names
> > rather than trying to open code it.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> 
> Hi Dave,
> 
> After testing, looks like this patch brings in a regression issue, it causes
> case number aren't sorted in group.list, then the xfstests/new program can't
> get a right new case number which is unused. For example:

Oh, this issue isn't from this patch, it's from 441606d2 ("fstests: faster group
file creation"). Hmm... I saw your used "sort -u" in that patch, I'm going to
look into what's wrong with that.

Thanks,
Zorro

> 
> # make
> # ./new generic
> Next test id is 019
> Append a name to the ID? Test name will be 019-$name. y,[n]: ^C
> # ls tests/generic/019
> tests/generic/019
> 
> Then comparing the tests/generic/group.list with old generic/group.list, found
> lots of difference, due to the number in new group.list isn't sorted from
> small to big (I haven't gotten chance to check if there're missing number).
> 
> Thanks,
> Zorro
> 
> >  tools/mkgroupfile | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> > index 24435898..414cb538 100755
> > --- a/tools/mkgroupfile
> > +++ b/tools/mkgroupfile
> > @@ -19,6 +19,8 @@ if [ ! -x ../../check ]; then
> >  	exit 1
> >  fi
> >  
> > +. ../../common/test_names
> > +
> >  cleanup()
> >  {
> >  	rm -f $new_groups.check
> > @@ -60,7 +62,8 @@ ENDL
> >  
> >  	# Aggregate the groups each test belongs to for the group file
> >  	grep -I -R "^_begin_fstest" $test_dir/ | \
> > -		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
> > +		sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" \
> > +		>> $new_groups
> >  
> >  	# Create the list of unique groups for existence checking
> >  	grep -I -R "^_begin_fstest" $test_dir/ | \
> > -- 
> > 2.35.1
> > 

