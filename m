Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA57C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 17:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbiCVROr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbiCVROq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 13:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DBE41C13E
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647969197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8k2ZbDPH9buP2CiwomhLGNkL6dxq4Y/gjyDiwLuA6k=;
        b=hgyBno1GyouwXaelzXLBltFjjkDc6oL1dguhH8ochcCx89ql+PCOjLUjPyjKe8367zdnD0
        cJoMQxrH6hr6cT16fz1g2Hg/TM4MlRkN7QUdwnz7fguurfh4JnWqSTH7J4ZcnHjOb1wihg
        2Y5uUzc/VokfIdYs/4JGi5teKUGky7M=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-vcVgynd2NZ2NUK2RJMZPrw-1; Tue, 22 Mar 2022 13:13:15 -0400
X-MC-Unique: vcVgynd2NZ2NUK2RJMZPrw-1
Received: by mail-pg1-f198.google.com with SMTP id g9-20020a63be49000000b0038204e481caso8365572pgo.5
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 10:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=z8k2ZbDPH9buP2CiwomhLGNkL6dxq4Y/gjyDiwLuA6k=;
        b=y0xx/nMsfzi+48YRGGGfiIhhO7L0y8JCvZ+SXCSo+k0Vzlbwulj23sdV356nktttql
         xuzWBhXbQPY8IxsnyLG+9JhSbYhaI/HkS6nKq/wkrx5NGpG5szlAOesU7FacrjWHPq0E
         qP/1N06R2K0CeF6PukcQG/ceUNgolIpy5wp8M1Ura9PfpbVqm2NdYEYUfZK2y+imMBC9
         IrZbIoKR+Fred5kCIXXYPkvPsu6Wl9AIEAskf6zfQfN/YBE4J5LJHW5IC3NB1PnqbV0c
         hQJ2sRv2gPWSAluTAq/q3Em7l8VFhI9HaM6xMAS6udrVRhcP+quPVjMORwlsmw537J6Y
         +WWQ==
X-Gm-Message-State: AOAM531chM0zP5hzuGbzFYnL0azVjyqRDS8N5DsCdR83hKHmfgO4zkzV
        NTS7rDDqVLX70hrnX/88KmrLulsOHNNiHDj3nBsuA0pk8I0YQA02C98kkm4IRmTB94xqQt7x7ij
        f/fQN4O8A4S4ivsCabQ==
X-Received: by 2002:a17:90a:ee94:b0:1c6:4580:1e5 with SMTP id i20-20020a17090aee9400b001c6458001e5mr6246414pjz.47.1647969194651;
        Tue, 22 Mar 2022 10:13:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoh9kd8rIKgKAnRK+eUTwsc4M/zgXPriYp7DCAdro47qOt4NoGt4uUdUuyW43Gi/9cXE831A==
X-Received: by 2002:a17:90a:ee94:b0:1c6:4580:1e5 with SMTP id i20-20020a17090aee9400b001c6458001e5mr6246384pjz.47.1647969194319;
        Tue, 22 Mar 2022 10:13:14 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f7ab5a44ebsm25975951pfv.18.2022.03.22.10.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:13:13 -0700 (PDT)
Date:   Wed, 23 Mar 2022 01:13:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fstests: test dirty pipe vulnerability issue of
 CVE-2022-0847
Message-ID: <20220322171309.hyptb5dbk764zfad@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
References: <20220321110341.1323882-1-zlang@redhat.com>
 <20220321110341.1323882-3-zlang@redhat.com>
 <20220322053555.GD1609613@dread.disaster.area>
 <20220322123002.3azabmqxrfoz27bx@zlang-mailbox>
 <20220322155244.GK8200@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322155244.GK8200@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 22, 2022 at 08:52:44AM -0700, Darrick J. Wong wrote:
> On Tue, Mar 22, 2022 at 08:30:02PM +0800, Zorro Lang wrote:
> > On Tue, Mar 22, 2022 at 04:35:55PM +1100, Dave Chinner wrote:
> > > On Mon, Mar 21, 2022 at 07:03:41PM +0800, Zorro Lang wrote:
> > > > diff --git a/tests/generic/999 b/tests/generic/999
> > > > new file mode 100755
> > > > index 00000000..2488e455
> > > > --- /dev/null
> > > > +++ b/tests/generic/999
> > > > @@ -0,0 +1,54 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) 2022 Red Hat, Inc.  All Rights Reserved.
> > > > +#
> > > > +# FS QA Test No. 999
> > > > +#
> > > > +# Test for the Dirty Pipe vulnerability (CVE-2022-0847) caused by an
> > > > +# uninitialized  "pipe_buffer.flags" variable, which fixed by:
> > > > +#   9d2231c5d74e ("lib/iov_iter: initialize "flags" in new pipe_buffer")
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick
> > > > +
> > > > +_cleanup()
> > > > +{
> > > > +	cd /
> > > > +	rm -f $tmp.*
> > > > +	rm -f $TEST_DIR/testfile.$seq
> > > > +}
> > > 
> > > Just leave the test file lying around so this can use the default
> > > cleanup method. The test device is supposed to gather random
> > > cruft as tests run....
> > 
> > Got that, I'll keep this file, and turn to use default _cleanup.
> > 
> > > 
> > > > +
> > > > +# real QA test starts here
> > > > +_supported_fs generic
> > > > +_require_test
> > > > +_require_user
> > > > +_require_chmod
> > > > +_require_test_program "splice2pipe"
> > > > +
> > > > +localfile=$TEST_DIR/testfile.$seq
> > > 
> > > .... and remove the file here as part of test setup with:
> > > 
> > > rm -f $localfile
> > 
> > Just curious, I've used xfs_io "-t" option to truncate $localfile before testing:
> > $XFS_IO_PROG -f -t -c "pwrite 0 4k -S 0xff" $localfile
> > 
> > Can that instead of the "rm -f $localfile" ?
> 
> Open-and-truncate isn't safe here because some other (buggy) test might
> run 'mkfifo $TEST_DIR/testfile.XXX' and now opening the pipe will hang
> fstests.  It's ok for the scratch fs because you have to mkfs it, but as
> Dave said, the test fs slowly accumulates cruft over time.

Make sense, Thanks! I'll change that.

Thanks,
Zorro

> 
> --D
> 
> > (As both patches need to change, I'd like to change the 1st patch's g/404 in next
> > version patch together, if no objection)
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Otherwise looks fine.
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

