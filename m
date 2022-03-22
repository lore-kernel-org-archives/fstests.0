Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AA5C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 12:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiCVMbj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiCVMbi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 08:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F9FA6D867
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647952210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q4fyTMt+/hnFdg3QhE8O9mOg9d9S2TtFp5FYsUNQZTs=;
        b=a7AboP4Rw30eLR+RBbIX8DhGsK9kOIJB6WLqRVd8brKCdS3/xYVhev6kT2hyG9V/QdbMiM
        aN3pcbs5HJw/ARAzIZRV3mBLH4nRyqjG9V5O9LYkSmllQU4vx4IWK3sz6ApbIsJfNVx3Td
        b9Hgw8Q73T4Q5NwXbB6p+bfFo0Ollk0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-Qqpp086KO0izfS3Q__gdjA-1; Tue, 22 Mar 2022 08:30:09 -0400
X-MC-Unique: Qqpp086KO0izfS3Q__gdjA-1
Received: by mail-qv1-f69.google.com with SMTP id r2-20020a056214068200b00440e24889e6so11527790qvz.23
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 05:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Q4fyTMt+/hnFdg3QhE8O9mOg9d9S2TtFp5FYsUNQZTs=;
        b=bSMBXs91tVBK8GcztZ4wDOLLZsV6v2lD1r9Q0TI5r26ididPdRKF6agAUNut6S7BBI
         ONi8JtfNfnimcO0P14u7YH2PpW4jn6E4KYycNuGtoMkP3vfPE3nSQUneELaoj2r1wiDN
         0UTG0XuurXtKYAD1qaL+oIuzL5tDJYxgsmY6dfB6x9SPty9f9FGufXoE4CGd5Fagq8Bl
         ncbf4KD9PBaWWxL93Fw4UfgNr6lbYFpMdNpAksiSewtrJNy/G1eX6qgobBPVrShZhiiW
         4ApcSqKDzcawW9ykplRUIGbjgqUOy4FQwJ8AEhQvp1wkSwgopfS/kmgkGy45D5WsNwSG
         DdOQ==
X-Gm-Message-State: AOAM533Y+QVfrlzE2chLN9WT6Szhe9+WQsa3Ohs4wQ+OAivnGPKnJ/5E
        D91z5YSQM4jDdHNeHgbOC+exoY8uJKYg/QhyWM6uFfhweEevRe3cl39rS/Y8ePi2TB4eFn8ZWC8
        MtZ/BCVzaY+OF5hZ7DA==
X-Received: by 2002:ac8:5fcf:0:b0:2e1:ebd9:3e38 with SMTP id k15-20020ac85fcf000000b002e1ebd93e38mr19760732qta.149.1647952208545;
        Tue, 22 Mar 2022 05:30:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9qPPkKeJMz1xeRUDKkJWJkcVtINL7tzfXcsFe325ulKtGLmRGvtx7wujWCrOaBXKc6vWlHA==
X-Received: by 2002:ac8:5fcf:0:b0:2e1:ebd9:3e38 with SMTP id k15-20020ac85fcf000000b002e1ebd93e38mr19760710qta.149.1647952208270;
        Tue, 22 Mar 2022 05:30:08 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 84-20020a370957000000b0067e4c1c8889sm7005287qkj.80.2022.03.22.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:30:07 -0700 (PDT)
Date:   Tue, 22 Mar 2022 20:30:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 2/2] fstests: test dirty pipe vulnerability issue of
 CVE-2022-0847
Message-ID: <20220322123002.3azabmqxrfoz27bx@zlang-mailbox>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        fstests@vger.kernel.org, djwong@kernel.org
References: <20220321110341.1323882-1-zlang@redhat.com>
 <20220321110341.1323882-3-zlang@redhat.com>
 <20220322053555.GD1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322053555.GD1609613@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 22, 2022 at 04:35:55PM +1100, Dave Chinner wrote:
> On Mon, Mar 21, 2022 at 07:03:41PM +0800, Zorro Lang wrote:
> > diff --git a/tests/generic/999 b/tests/generic/999
> > new file mode 100755
> > index 00000000..2488e455
> > --- /dev/null
> > +++ b/tests/generic/999
> > @@ -0,0 +1,54 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 999
> > +#
> > +# Test for the Dirty Pipe vulnerability (CVE-2022-0847) caused by an
> > +# uninitialized  "pipe_buffer.flags" variable, which fixed by:
> > +#   9d2231c5d74e ("lib/iov_iter: initialize "flags" in new pipe_buffer")
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +	rm -f $TEST_DIR/testfile.$seq
> > +}
> 
> Just leave the test file lying around so this can use the default
> cleanup method. The test device is supposed to gather random
> cruft as tests run....

Got that, I'll keep this file, and turn to use default _cleanup.

> 
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_test
> > +_require_user
> > +_require_chmod
> > +_require_test_program "splice2pipe"
> > +
> > +localfile=$TEST_DIR/testfile.$seq
> 
> .... and remove the file here as part of test setup with:
> 
> rm -f $localfile

Just curious, I've used xfs_io "-t" option to truncate $localfile before testing:
$XFS_IO_PROG -f -t -c "pwrite 0 4k -S 0xff" $localfile

Can that instead of the "rm -f $localfile" ?

(As both patches need to change, I'd like to change the 1st patch's g/404 in next
version patch together, if no objection)

Thanks,
Zorro

> 
> Otherwise looks fine.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

