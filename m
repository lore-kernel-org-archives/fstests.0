Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C23C4332F
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Mar 2022 06:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiCIGCd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Mar 2022 01:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiCIGCc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Mar 2022 01:02:32 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26D5E14FBE2
        for <fstests@vger.kernel.org>; Tue,  8 Mar 2022 22:01:34 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 69887530EED;
        Wed,  9 Mar 2022 17:01:33 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nRpO8-003HeV-QY; Wed, 09 Mar 2022 17:01:32 +1100
Date:   Wed, 9 Mar 2022 17:01:32 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        max.kellermann@ionos.com
Subject: Re: [PATCH] fstests: test dirty pipe vulnerability issue of
 CVE-2022-0847
Message-ID: <20220309060132.GX3927073@dread.disaster.area>
References: <20220308092248.786739-1-zlang@redhat.com>
 <20220308171429.GB117704@magnolia>
 <20220308190219.kohodxq4bndpduwk@zlang-mailbox>
 <20220308195501.GC117704@magnolia>
 <20220308224858.GS3927073@dread.disaster.area>
 <20220309033936.y7pzdkmtwoh5jb3l@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309033936.y7pzdkmtwoh5jb3l@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=622842bd
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=893dRJi3-CjuSeFlPxsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 09, 2022 at 11:39:36AM +0800, Zorro Lang wrote:
> On Wed, Mar 09, 2022 at 09:48:58AM +1100, Dave Chinner wrote:
> > On Tue, Mar 08, 2022 at 11:55:01AM -0800, Darrick J. Wong wrote:
> > > On Wed, Mar 09, 2022 at 03:02:19AM +0800, Zorro Lang wrote:
> > > > On Tue, Mar 08, 2022 at 09:14:29AM -0800, Darrick J. Wong wrote:
> > > > > On Tue, Mar 08, 2022 at 05:22:48PM +0800, Zorro Lang wrote:
> > > > > > +chmod 0644 $localfile
> > > > > > +# Test privileged user (xfstests generally run with root)
> > > > > > +echo "Test privileged user:"
> > > > > > +$here/src/splice2pipe $localfile 1 "AAAAAAAABBBBBBBB"
> > > > > > +# Part of 0xff will be overwritten if there's CVE-2022-0847 bug
> > > > > > +hexdump -C $localfile
> > > > > 
> > > > > (I wonder offhand if fstests ought to be checking for the existence of
> > > > > hexdump(1) since at least Debian only has it in bsdmainutils package,
> > > > > but ... that's a separate question.)
> > > > 
> > > > Hmm... I never thought about that, due to the hexdump is in util-linux for
> > > > rhel and fedora. That means it's nearly always be there. If Debian or some other
> > > > system won't have it by default, we might say 'hexdump' is a necessary dependence
> > > > to run fstests in doc :)
> > > 
> > > Yeah.  The fstests documentation don't list bsdmainutils as a required
> > > package for Debian, so I think either we should update the documentation
> > > or do a treewide change to make all the tests that use hexdump(1)
> > > _require it.
> > 
> > I think it would be better to replace hexdump uses with 'od -x' as
> > od is part of coreutils. Hence we can either replace all the calls
> > to hexdump with direct calls to od -x, or add a simple wrapper like:
> > 
> > hexdump() {
> > 	od -x $@
> > }
> > 
> > with whatever the format specification needed is to output the same
> > format as hexdump does...
> 
> You're right, "od -x" output foramt is same with "hexdump" [1]. But most
> xfstests' cases use "hexdump -C", and output as golden image. I tried to make
> od output as that format, but didn't find a proper way. (Feel free to tell me
> if you know a better usage).

$ hexdump -C foo
00000000  73 61 64 6c 66 6b 6a 61  73 64 6c 66 6b 6a 75 69  |sadlfkjasdlfkjui|
00000010  79 72 75 69 79 6a 68 76  6b 76 6e 68 6b 6a 68 64  |yruiyjhvkvnhkjhd|
00000020  66 67 75 69 79 72 74 0a                           |fguiyrt.|
00000028
$ od  -Ax -t x1z -v foo
000000 73 61 64 6c 66 6b 6a 61 73 64 6c 66 6b 6a 75 69  >sadlfkjasdlfkjui<
000010 79 72 75 69 79 6a 68 76 6b 76 6e 68 6b 6a 68 64  >yruiyjhvkvnhkjhd<
000020 66 67 75 69 79 72 74 0a                          >fguiyrt.<
000028

Now, this is still not quite a perfect match - there's whitespace difference
and the char output at the end uses ">....<" delimiters rather than "|...|".
Hence I think that output file changes will be needed, but otherwise the
information being dropped in the output files is identical.

That said, the complexity of the 'od' command line means we really
need _hexdump() wrapper function would be a good idea. Maybe also:

hexdump()
{
	_fail "Use _hexdump(), please!"
}

might also be useful in preventing hexdump usage getting back into
fstests....

> So if we'd like to replace hexdump with od, we
> need to change some cases' .out files. Do you think it's time to do this change
> now? I can send another patch to do that.

When you've got time a new patch to do this would be great!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
