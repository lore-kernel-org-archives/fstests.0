Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F55C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 15:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiCVPyP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 11:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiCVPyP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 11:54:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9778C340D1
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 08:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A264B81D12
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 15:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7C7C340F0;
        Tue, 22 Mar 2022 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647964364;
        bh=m9i5d+NHz7u4HEdqxh+C7BykjUjDoERDgOHMZfATGGI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=MbvslNzs0gRaGjBuhRTw0+4VjcqkM+frkpilRzHbubDL7LGce8yldDyrfygvcm8xe
         /3d3SQw7SHbSkrMg/f84AQ34AVHJlpQUVUxWg86CVIB56WuaBVmwWVksMtnEdSYk44
         KQZEhAAFuxjYC2cj8Utj9xOFlUEHiKykXxHGwxcpqEfREjQ+QT2WHvBeMvIM2/VNfm
         6h97BfSp6g/a5LPVFuJ+5XgIMtg+tDzIuMHplMC5jzNpTnoCLa54o3ZkqYfXfu6ThK
         FWEHaTNlWz9XqRmp6cj4Gi6bBnQo25N5ZTQ2A3Fe7cbRgFhnCT6SHWMrOe/YNFLU1+
         SutgPuMPgB/Rw==
Date:   Tue, 22 Mar 2022 08:52:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org,
        zlang@redhat.com
Subject: Re: [PATCH 2/2] fstests: test dirty pipe vulnerability issue of
 CVE-2022-0847
Message-ID: <20220322155244.GK8200@magnolia>
References: <20220321110341.1323882-1-zlang@redhat.com>
 <20220321110341.1323882-3-zlang@redhat.com>
 <20220322053555.GD1609613@dread.disaster.area>
 <20220322123002.3azabmqxrfoz27bx@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322123002.3azabmqxrfoz27bx@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 22, 2022 at 08:30:02PM +0800, Zorro Lang wrote:
> On Tue, Mar 22, 2022 at 04:35:55PM +1100, Dave Chinner wrote:
> > On Mon, Mar 21, 2022 at 07:03:41PM +0800, Zorro Lang wrote:
> > > diff --git a/tests/generic/999 b/tests/generic/999
> > > new file mode 100755
> > > index 00000000..2488e455
> > > --- /dev/null
> > > +++ b/tests/generic/999
> > > @@ -0,0 +1,54 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2022 Red Hat, Inc.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. 999
> > > +#
> > > +# Test for the Dirty Pipe vulnerability (CVE-2022-0847) caused by an
> > > +# uninitialized  "pipe_buffer.flags" variable, which fixed by:
> > > +#   9d2231c5d74e ("lib/iov_iter: initialize "flags" in new pipe_buffer")
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +	rm -f $TEST_DIR/testfile.$seq
> > > +}
> > 
> > Just leave the test file lying around so this can use the default
> > cleanup method. The test device is supposed to gather random
> > cruft as tests run....
> 
> Got that, I'll keep this file, and turn to use default _cleanup.
> 
> > 
> > > +
> > > +# real QA test starts here
> > > +_supported_fs generic
> > > +_require_test
> > > +_require_user
> > > +_require_chmod
> > > +_require_test_program "splice2pipe"
> > > +
> > > +localfile=$TEST_DIR/testfile.$seq
> > 
> > .... and remove the file here as part of test setup with:
> > 
> > rm -f $localfile
> 
> Just curious, I've used xfs_io "-t" option to truncate $localfile before testing:
> $XFS_IO_PROG -f -t -c "pwrite 0 4k -S 0xff" $localfile
> 
> Can that instead of the "rm -f $localfile" ?

Open-and-truncate isn't safe here because some other (buggy) test might
run 'mkfifo $TEST_DIR/testfile.XXX' and now opening the pipe will hang
fstests.  It's ok for the scratch fs because you have to mkfs it, but as
Dave said, the test fs slowly accumulates cruft over time.

--D

> (As both patches need to change, I'd like to change the 1st patch's g/404 in next
> version patch together, if no objection)
> 
> Thanks,
> Zorro
> 
> > 
> > Otherwise looks fine.
> > 
> > Cheers,
> > 
> > Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> > 
> 
